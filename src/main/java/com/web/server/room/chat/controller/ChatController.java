package com.web.server.room.chat.controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;

import javax.servlet.http.HttpServletResponse;

import org.apache.commons.lang3.RandomStringUtils;
import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.servlet.ModelAndView;

import com.google.gson.Gson;
import com.web.server.room.vo.Channel;
import com.web.server.room.vo.Room;

@RestController
public class ChatController {
	
	List<Room> roomList = new ArrayList<Room>();
	List<Channel> chnList = new ArrayList<Channel>();
	static int roomNumber = 0;
	
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
	public @ResponseBody List<Room> createRoom(@RequestParam HashMap<Object, Object> params){
		String roomName = (String) params.get("roomName");
		String userId = (String) params.get("userId");
		if(roomName != null && !roomName.trim().equals("")) {
			Room room = new Room();
			String roomCode = RandomStringUtils.randomAlphanumeric(8);
			System.out.println(roomCode);
			
			room.setRoomCode(roomCode);
			room.setRoomNumber(++roomNumber);
			room.setRoomName(roomName);
			room.setUserId(userId);
			roomList.add(room);
			ss.insert("ChatMapper.insertChatRoom", room);
			ss.insert("AddChatRoom", room);
			
			System.out.println("방생성 = " + roomList);
		}
		return roomList;
	}
	/*
	 * 채널 생성
	 * 
	 */
	@RequestMapping("/createChannel")
	public @ResponseBody List<Channel> createChannel(@RequestParam HashMap<Object, Object> params){
		String channelName = (String) params.get("channelName");
		String userId = (String) params.get("userId");
		if(channelName != null && !channelName.trim().equals("")) {
			Channel chn = new Channel();
			String channelCode = "";
			
			//동일한 코드가 있는지 계속 반복
			Boolean flag = true;
			while(flag) {
				channelCode = RandomStringUtils.randomAlphanumeric(8);
				System.out.println("channelCode = " + channelCode);
				String tempCode = ss.selectOne("ChatMapper.checkSameChannelCode", channelCode);
				System.out.println("tempCode = " + tempCode);
				if(tempCode == null) {
					flag = false;			
				}
			}
			
			
			
			chn.setChannelCode(channelCode);
			chn.setChannelName(channelName);
			chn.setUserId(userId);
			
			int a = ss.insert("ChatMapper.createChatChannel", chn);
			System.out.println("채널생성 = " + a);
			System.out.println("채널생성후 채널코드 = " + chn.getChannelCode());
			a = ss.insert("ChatMapper.AddChatChannel", chn);
			System.out.println("채널생성2 = " + a);
			
			System.out.println("채널생성 = " + chnList);
		}
		return chnList;
	}
	
	/**
	 * 방 정보가져오기
	 * @param params
	 * @return
	 */
	@RequestMapping("/getRoom")
	public @ResponseBody ModelAndView getRoom(@RequestParam HashMap<Object, Object> params){
		ModelAndView mav = new ModelAndView();
		String userId = (String) params.get("userId");
		// 서버 값을 받아와 서버값으로 채팅방 리스트 나열
		String channelCode = (String) params.get("channelCode");
		Room room = new Room();
		
		room.setUserId(userId);
		room.setChannelCode(channelCode);
		List<Room> list = ss.selectList("ChatMapper.getChatChannel", room);
		
		mav.addObject("list", list);
		
		
		
		System.out.println("겟룸 = " + roomList);
		return mav;
	}
	
	/**
	 * 채널 정보가져오기
	 * @param params
	 * @return
	 */
	@RequestMapping("/getChannel")
	public @ResponseBody void getChannel(HttpServletResponse res,@RequestParam HashMap<Object, Object> params) throws Exception{
		Gson gson = new Gson();
		Map<String, Object> data = new HashMap<String, Object>();
		
		String userId = (String) params.get("userId");
		Channel chn = new Channel();
		System.out.println("채널 유저아이디 = " + userId);
		
		chn.setUserId(userId.trim());
		System.out.println("채널 리스트 생성전");
		
		List<Channel> list = ss.selectList("ChatMapper.getChatChannel", chn);
		
		System.out.println("채널 리스트생성 = " + list);
		System.out.println("채널 리스트길이 = " + list.size());
		
		if(list.size() > 0) {
			data.put("list", list);
			System.out.println("리스트 오브젝트 추가");
		}
		
		System.out.println("겟채널 = " + chnList);
		System.out.println("모델뷰 값 = " + gson.toJson(data));
		res.getWriter().print(gson.toJson(data));
	}
	
	/**
	 * 채팅방
	 * @return
	 */
	@RequestMapping("/moveChating")
	public ModelAndView chating(@RequestParam HashMap<Object, Object> params) {
		ModelAndView mv = new ModelAndView();
		String roomCode =((String) params.get("roomCode"));
		
		List<Room> new_list = roomList.stream().filter(o->o.getRoomCode()==roomCode).collect(Collectors.toList());
		if(new_list != null && new_list.size() > 0) {
			mv.addObject("roomName", params.get("roomName"));
			mv.addObject("roomCode", params.get("roomCode"));
			System.out.println("모델뷰 = " + mv);
			mv.setViewName("chat/chat");
		}else {
			mv.setViewName("room/room");
		}
		return mv;
	}
}
