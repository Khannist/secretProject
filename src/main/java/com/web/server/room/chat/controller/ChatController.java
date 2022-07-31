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
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.servlet.ModelAndView;

import com.google.gson.Gson;
import com.web.server.room.vo.Channel;
import com.web.server.room.vo.Room;

@RestController
public class ChatController {

	@Autowired
	private SqlSession ss;

	
	@RequestMapping("/chat")
	public ModelAndView chat() {
		ModelAndView mav = new ModelAndView();
		mav.setViewName("chat/chat");
		return mav;
	}
	

	/**
	 * 방 페이지
	 * @return
	 */
	@RequestMapping("/room")
	public ModelAndView room(Room room) {
		ModelAndView mv = new ModelAndView();
		mv.addObject("userId", room.getUserId());
		mv.addObject("channelCode", room.getChannelCode());
		mv.setViewName("room/room");
		return mv;
	}
	
	/**
	 * 방 생성하기
	 * @param params
	 * @return
	 */
	@RequestMapping("/createRoom")
	public @ResponseBody ModelAndView createRoom(Room room){
		ModelAndView mav = new ModelAndView();
		String roomName = room.getRoomName();
		System.out.println("1");
		if(roomName != null && !roomName.trim().equals("")) {
			String roomCode = "";
			Boolean flag = true;
			while(flag) {
				roomCode = RandomStringUtils.randomAlphanumeric(8);
				System.out.println("roomCode = " + roomCode);
				String tempCode = ss.selectOne("ChatMapper.checkSameRoomCode", roomCode);
				System.out.println("tempCode = " + tempCode);
				if(tempCode == null) {
					flag = false;
				}
			}
			
			System.out.println("2");
			
			
			System.out.println(roomCode);
			room.setRoomCode(roomCode);
			System.out.println("getRoomCode = " + room.getRoomCode());
			System.out.println("getRoomName = " + room.getRoomName());
			System.out.println("getChannelCode = " + room.getChannelCode());
			ss.insert("ChatMapper.insertChatRoom", room);
			List<Room> roomList = ss.selectList("ChatMapper.checkSameRoomList", room);
			int num = 0;
			if(roomList.toString().length() > 0) {
				for(Room tempListnum : roomList) {
					int tnum = Integer.parseInt(tempListnum.getRoomList().substring(room.getUserId().toString().length()+1));
					if(tnum == num) {
						num++;
					}else {
						break;						
					}
				}				
			}
			System.out.println("3");
			room.setRoomList(room.getUserId()+"_"+num);
			ss.insert("ChatMapper.AddChatRoom", room);
			mav.addObject("room", room);
			System.out.println("4");
			
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
		System.out.println("1-1");
		Map<String, Object> data = new HashMap<String, Object>();
		List<Room> list = ss.selectList("ChatMapper.getChatRoom", room);
		System.out.println("1-2");
		if(list.size() > 0) {
			data.put("list", list);
		}
		
		System.out.println("Json 값 = " + gson.toJson(data));
		res.getWriter().print(gson.toJson(data));
	}
	/**
	 * 채팅방
	 * @return
	 */
	@RequestMapping("/moveChating")
	public ModelAndView chating(Room room) {
		ModelAndView mv = new ModelAndView();
		String roomCode = room.getRoomCode();
		List<Room> roomList = ss.selectList("ChatMapper.checkSameRoomList", room.getUserId());
		List<Room> new_list = roomList.stream().filter(o->o.getRoomCode()==roomCode).collect(Collectors.toList());
		if(new_list != null && new_list.size() > 0) {
			mv.addObject("roomName", room.getRoomName());
			mv.addObject("roomCode", room.getRoomCode());
			System.out.println("모델뷰 = " + mv);
			mv.setViewName("chat/chat");
		}else {
			mv.setViewName("room/room");
		}
		return mv;
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
		
		System.out.println("Json 값 = " + gson.toJson(data));
		res.getWriter().print(gson.toJson(data));
	}
	/**
	 * 채팅방
	 * @return
	 */
	@RequestMapping("/moveRoom")
	public void moveRoom(HttpServletResponse res, Channel chn)throws Exception {
		Gson gson = new Gson();
		Map<String, Object> data = new HashMap<String, Object>();
		System.out.println("userid = " + chn.getUserId());
		String channelCode = chn.getChannelCode();
		System.out.println("channelCode = " + channelCode);
		List<Channel> chnList = ss.selectList("ChatMapper.getChatChannel", chn.getUserId());
		List<Channel> new_list = chnList.stream().filter(o->o.getChannelCode().equals(channelCode)).collect(Collectors.toList());
		System.out.println("chnList = " + chnList);
		System.out.println("chnList[0] = " + chnList.get(0));
		System.out.println("chnList[0] = " + chnList.get(0).getChannelCode());
		System.out.println("new_list = " + new_list);
		if(new_list != null && new_list.size() > 0) {
			data.put("channelName", chn.getChannelName());
			data.put("channelCode", chn.getChannelCode());
		}else {
			data.put("userId", chn.getUserId());
		}
		
		System.out.println("데이타 = " + data);
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
	
	
	
	
	
	
}

	
