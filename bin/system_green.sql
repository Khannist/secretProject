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




-----------------------------------채팅룸기록---------------------------------------------
CREATE TABLE roomChannel (
    roomCode NVARCHAR2(28) PRIMARY KEY,
    roomName NVARCHAR2(255)
);
commit;
-- 룸코드를 가지고 있는 유저 테이블
CREATE TABLE roomUser_dt (
    userId nvarchar2(100),
    roomCode nvarchar2(28),
    CONSTRAINT fk_userIdRoomChannerl FOREIGN KEY(userId) REFERENCES user_dt(userId),
    CONSTRAINT fk_roomCdeRoomChannel FOREIGN KEY(roomCode) REFERENCES roomChannel(roomCode)
);


-----------------------------------채팅기록---------------------------------------------


CREATE TABLE chat_dt (
    roomCode NVARCHAR2(28),
    userId NVARCHAR2(100),
    chatData clob,
    chatDate TIMESTAMP  
);
commit;















