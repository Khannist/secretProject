create table user_dt (
    userId nvarchar2(100) PRIMARY KEY,
    userPw NVARCHAR2(100),
    name NVARCHAR2(100)  
);

commit;

select * from user_dt;

insert into user_dt
VALUES('A','1234','에이');
insert into user_dt
VALUES('B','1234','비');
insert into user_dt
VALUES('C','1234','씨');
insert into user_dt
VALUES('D','1234','디');
insert into user_dt
VALUES('E','1234','이');

create table friend_dt (
    mainId nvarchar2(100),
    subId nvarchar2(100),
    CONSTRAINT fk_main FOREIGN KEY(mainId) REFERENCES user_dt(userId),
    CONSTRAINT fk_sub FOREIGN KEY(subId) REFERENCES user_dt(userId)
);

drop table freind_dt;

commit;

select * from friend_dt;

insert into friend_dt
VALUES('A','B');
insert into friend_dt
VALUES('B','A');
insert into friend_dt
VALUES('A','C');
insert into friend_dt
VALUES('C','A');
insert into friend_dt
VALUES('A','E');
insert into friend_dt
VALUES('E','A');
insert into friend_dt
VALUES('D','E');
insert into friend_dt
VALUES('E','D');
insert into friend_dt
VALUES('C','B');
insert into friend_dt
VALUES('B','C');

select subId from friend_dt where mainId = 'E';


-----------------------------------서버기록---------------------------------------------
CREATE TABLE Channel_dt (
    channelCode NVARCHAR2(28) PRIMARY KEY,
    channelName NVARCHAR2(255)
);
select * from Channel_dt;
select * from ChannelHasUser_dt ORDER BY channelList DESC;

CREATE TABLE ChannelHasUser_dt (
    channelList nvarchar2(255),
    channelCode NVARCHAR2(28),
    userId NVARCHAR2(100),
    channelName nvarchar2(255),
    CONSTRAINT fk_channelcode FOREIGN KEY(channelCode) REFERENCES Channel_dt(channelCode),
    CONSTRAINT fk_channelHasUser FOREIGN KEY(userId) REFERENCES user_dt(userId)
);

commit;

delete from channel_dt;
delete from ChannelHasUser_dt;

SELECT * FROM ChannelHasUser_dt
 		WHERE  userId = 'A'
 		ORDER BY length(channelList) ASC,channelList ASC;

drop table Channel_dt;
drop table ChannelHasUser_dt;
-----------------------------------채팅룸기록---------------------------------------------
CREATE TABLE roomChannel (
    roomCode NVARCHAR2(28) PRIMARY KEY,
    roomName NVARCHAR2(255),
    channelCode NVARCHAR2(28)
);
commit;
-- 룸코드를 가지고 있는 유저 테이블
CREATE TABLE roomUser_dt (
    roomList nvarchar2(255),
    userId nvarchar2(100),
    roomName NVARCHAR2(255),
    roomCode nvarchar2(28),
    channelCode NVARCHAR2(28),
    CONSTRAINT fk_userIdRoomChannerl FOREIGN KEY(userId) REFERENCES user_dt(userId),
    CONSTRAINT fk_roomCdeRoomChannel FOREIGN KEY(roomCode) REFERENCES roomChannel(roomCode),
    CONSTRAINT fk_channelcodeHasRoom FOREIGN KEY(channelCode) REFERENCES Channel_dt(channelCode)
);

drop table roomChannel;
drop table roomUser_dt;
-----------------------------------채팅기록---------------------------------------------


CREATE TABLE chat_dt (
    roomCode NVARCHAR2(28),
    userId NVARCHAR2(100),
    channelCode NVARCHAR2(28),
    chatData clob,
    chatDate TIMESTAMP
);
commit;

drop table chat_dt;















