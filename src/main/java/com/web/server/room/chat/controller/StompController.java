package com.web.server.room.chat.controller;

import java.util.HashMap;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.messaging.handler.annotation.MessageMapping;
import org.springframework.messaging.handler.annotation.SendTo;
import org.springframework.messaging.simp.SimpMessagingTemplate;
import org.springframework.web.bind.annotation.RestController;

import com.web.server.room.vo.Chat;
import com.web.server.room.vo.Message;

@RestController
public class StompController {
	
	@Autowired
	private SimpMessagingTemplate smt;
	
	@MessageMapping("/chat")
	@SendTo("/topic/chat")
	public Message message(Message msg) throws Exception {
		return new Message(msg.getName(), msg.getMessage());
	}
	
	@MessageMapping("/user")
	public void user(Chat chat){
		System.out.println("스톰프 구현단");
		System.out.println("chat = " + chat);
		HashMap<String, Object> payload = new HashMap<>();
		payload.put("chat", chat);
		smt.convertAndSend("/topic/a", payload);
	}
 }
