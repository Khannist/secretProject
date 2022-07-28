package com.web.server.room.vo;

import lombok.Data;

@Data
public class Room {
	private int roomNumber;
	private String roomCode;
	private String roomName;
	private String userId;
	private String channelCode;
}
