package com.web.server.room.vo;

import java.sql.Clob;
import java.sql.Timestamp;

import lombok.Data;

@Data
public class Chat {
	private String channelCode;
	private String name; 
	private String roomCode;
	private String userId;
	
	private String chatData;
	private Timestamp chatDate;
}
