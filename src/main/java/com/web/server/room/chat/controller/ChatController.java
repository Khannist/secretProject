package com.web.server.room.chat.controller;

import java.io.IOException;
import java.util.ArrayList;
import java.util.Collection;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;

import javax.servlet.http.HttpServletResponse;

import org.apache.commons.lang3.RandomStringUtils;
import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.servlet.ModelAndView;

import com.google.gson.Gson;
import com.web.server.room.vo.Channel;
import com.web.server.room.vo.Chat;
import com.web.server.room.vo.Room;

@RestController
public class ChatController {

	@Autowired
	private SqlSession ss;
	
	/**
	 * 방 생성하기
	 * @param params
	 * @return
	 */
	@RequestMapping("/createRoom")
	public @ResponseBody ModelAndView createRoom(Room room){
		ModelAndView mav = new ModelAndView();
		String roomName = room.getRoomName();
		if(roomName != null && !roomName.trim().equals("")) {
			String roomCode = "";
			Boolean flag = true;
			while(flag) {
				roomCode = RandomStringUtils.randomAlphanumeric(8);
				String tempCode = ss.selectOne("ChatMapper.checkSameRoomCode", roomCode);
				if(tempCode == null) {
					flag = false;
				}
			}
			room.setRoomCode(roomCode);
			ss.insert("ChatMapper.insertChatRoom", room);
			List<Room> roomList = ss.selectList("ChatMapper.checkSameRoomList", room);
			int num = 0;
			if(roomList.toString().length() > 0) {
				for(Room tempListnum : roomList) {
					int tnum = Integer.parseInt(tempListnum.getRoomList().substring(room.getChannelCode().toString().length()+1));
					if(tnum == num) {
						num++;
					}else {
						break;						
					}
				}				
			}
			room.setRoomList(room.getChannelCode()+"_"+num);
			System.out.println();
			System.out.println();
			ss.insert("ChatMapper.AddChatRoom", room);
			mav.addObject("room", room);
			
		}
		mav.setViewName("forward:/getRoom");
		return mav;
		
		
	}

	/**
	 * 방 정보가져오기
	 * @param params
	 * @return
	 */
	@RequestMapping("/getRoom")
	public @ResponseBody void getRoom(HttpServletResponse res, Room room) throws Exception{
		Gson gson = new Gson();
		Map<String, Object> data = new HashMap<String, Object>();
		List<Room> list = ss.selectList("ChatMapper.getChatRoom", room);
		// channel_dt 테이블 조회후 채널이름 데이터 가져와서 서버이름에 삽입
		if(list.size() > 0) {
			data.put("list", list);
		}
		res.getWriter().print(gson.toJson(data));
	}
	/**
	 * 채팅방
	 * @return
	 */
	@RequestMapping("/moveChating")
	public void chating(HttpServletResponse res,Room room)throws Exception {
		Gson gson = new Gson();
		Map<String, Object> data = new HashMap<String, Object>();
		String roomCode = room.getRoomCode();
		List<Room> roomList = ss.selectList("ChatMapper.getChatRoom", room);
		List<Room> new_list = roomList.stream().filter(o->o.getRoomCode().equals(roomCode)).collect(Collectors.toList());
		if(new_list != null && new_list.size() > 0) {
			
			data.put("channelCode", room.getChannelCode());
			data.put("roomCode", room.getRoomCode());
		}
		data.put("userId", room.getUserId());
		res.getWriter().print(gson.toJson(data));
		
	}

	/*
	 * 룸체크
	 * 
	 */
	@RequestMapping("/checkRoom")
	public void checkRoom(HttpServletResponse res,Room room)throws Exception{
		Gson gson = new Gson();
		Map<String, Object> data = new HashMap<String, Object>();
		String msg = "yes";
		List<Room> list = ss.selectList("ChatMapper.getChatRoom", room);
		if(list.size() > 0) {
			msg = "no";
		}
		data.put("msg", msg);
		res.getWriter().print(gson.toJson(data));
	}

	/*
	 * 채널 생성
	 * 
	 */
	@RequestMapping("/createChannel")
	public @ResponseBody ModelAndView createChannel(Channel chn){
		ModelAndView mav = new ModelAndView();
		
		if(chn.getChannelName() != null && !chn.getChannelName().trim().equals("")) {
			String channelCode = "";
			
			//동일한 코드가 있는지 계속 반복
			Boolean flag = true;
			while(flag) {
				channelCode = RandomStringUtils.randomAlphanumeric(8);
				String tempCode = ss.selectOne("ChatMapper.checkSameChannelCode", channelCode);
				if(tempCode == null) {
					flag = false;			
				}
			}
			
			chn.setChannelCode(channelCode);
			
			ss.insert("ChatMapper.createChatChannel", chn);
			List<Channel> chnList = ss.selectList("ChatMapper.checkSameChannelList", chn);
			
			// 채널 리스트 순서 로직
			int num = 0;
			if(chnList.toString().length() > 0) {
				for(Channel tempListnum : chnList) {
					int tnum = Integer.parseInt(tempListnum.getChannelList().substring(chn.getUserId().toString().length()+1));
					if(tnum == num) {
						num++;
					}else {
						break;						
					}
				}				
			}
			chn.setChannelList(chn.getUserId()+"_"+num);
			ss.insert("ChatMapper.AddChatChannel", chn);
			mav.addObject("chn", chn);
		
		}
		mav.setViewName("forward:getChannel");
		return mav;
	}
	
	
	/**
	 * 채널 정보가져오기
	 * @param params
	 * @return
	 */
	@RequestMapping("/getChannel")
	public @ResponseBody void getChannel(HttpServletResponse res,Channel chn) throws Exception{
		Gson gson = new Gson();
		Map<String, Object> data = new HashMap<String, Object>();
		List<Channel> list = ss.selectList("ChatMapper.getChatChannel", chn);
		if(list.size() > 0) {
			data.put("list", list);
		}
		res.getWriter().print(gson.toJson(data));
	}
	/**
	 * 채팅방
	 * @return
	 */
	@RequestMapping("/moveRoom")
	public void moveRoom(HttpServletResponse res, Channel chn,@RequestParam HashMap<Object, Object> params)throws Exception {
		Gson gson = new Gson();
		Map<String, Object> data = new HashMap<String, Object>();
		System.out.println("호");
		int roomNumber = Integer.parseInt((String) params.get("roomNumber"));
		System.out.println("roomnum = " + roomNumber);
		String channelCode = chn.getChannelCode();
		
		List<Channel> chnList = ss.selectList("ChatMapper.getChatChannel", chn.getUserId());
		List<Channel> new_list = chnList.stream().filter(o->o.getChannelCode().equals(channelCode)).collect(Collectors.toList());
		if(new_list != null && new_list.size() > 0) {
			data.put("channelName", chn.getChannelName());
			data.put("channelCode", chn.getChannelCode());
			data.put("roomNumber", roomNumber);
		}else {
			data.put("userId", chn.getUserId());
			
		}
		
		System.out.println();
		System.out.println();
		System.out.println("data = " + data);
		System.out.println();
		res.getWriter().print(gson.toJson(data));
	}
	
	
	
	/*
	 * @RequestMapping("/moveRoom") public ModelAndView moveRoom(Channel chn) {
	 * ModelAndView mv = new ModelAndView(); System.out.println("userid = " +
	 * chn.getUserId()); String channelCode = chn.getChannelCode(); List<Channel>
	 * chnList = ss.selectList("ChatMapper.checkSameChannelList", chn.getUserId());
	 * List<Channel> new_list =
	 * chnList.stream().filter(o->o.getChannelCode()==channelCode).collect(
	 * Collectors.toList()); if(new_list != null && new_list.size() > 0) {
	 * mv.addObject("channelName", chn.getChannelName());
	 * mv.addObject("channelCode", chn.getChannelCode());
	 * System.out.println("모델뷰 = " + mv); mv.setViewName("room/room"); }else {
	 * mv.addObject("userId", chn.getUserId());
	 * mv.setViewName("forward:/serverPage"); } return mv; }
	 */
	
	@RequestMapping("/getChat")
	public @ResponseBody void getChat(HttpServletResponse res, Chat chat) throws Exception{
		Gson gson = new Gson();
		Map<String, Object> data = new HashMap<String, Object>();
		System.out.println("1");
		System.out.println("chat = " + chat);
		List<Chat> list = ss.selectList("ChatMapper.getChat", chat);
		System.out.println("1-2");
		if(list.size() > 0) {
			data.put("list", list);
		}
		
		System.out.println("Json 값 = " + gson.toJson(data));
		res.getWriter().print(gson.toJson(data));
	}
	
	
	
	
}

	
