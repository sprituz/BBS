
CREATE TABLE POST
(
	PostID                NUMBER(38)  NOT NULL ,
	Title                 VARCHAR2(50)  NULL ,
	PostDate              DATE  NULL ,
	Content               VARCHAR2(2048)  NULL ,
	Available             NUMBER(38)  NULL ,
	ID                    VARCHAR2(20)  NOT NULL 
);



CREATE UNIQUE INDEX XPKPOST ON POST
(PostID  ASC);



ALTER TABLE POST
	ADD CONSTRAINT  XPKPOST PRIMARY KEY (PostID);



CREATE TABLE Reply
(
	Reply_date            DATE  NULL ,
	ReplyText             VARCHAR2(255)  NULL ,
	ID                    VARCHAR2(20)  NOT NULL ,
	PostID                NUMBER(38)  NOT NULL ,
	ReplyID               NUMBER(38)  NOT NULL 
);



CREATE UNIQUE INDEX XPKReply ON Reply
(ReplyID  ASC);



ALTER TABLE Reply
	ADD CONSTRAINT  XPKReply PRIMARY KEY (ReplyID);



CREATE TABLE TODO
(
	TodoID                NUMBER(38)  NOT NULL ,
	Description           VARCHAR2(255)  NULL ,
	isDone                VARCHAR2(20)  NULL ,
	TargetDate            DATE  NULL ,
	Title                 VARCHAR2(255)  NULL ,
	ID                    VARCHAR2(20)  NOT NULL 
);



CREATE UNIQUE INDEX XPKTODO ON TODO
(TodoID  ASC);



ALTER TABLE TODO
	ADD CONSTRAINT  XPKTODO PRIMARY KEY (TodoID);



CREATE TABLE USER_INFO
(
	ID                    VARCHAR2(20)  NOT NULL ,
	Password              VARCHAR2(20)  NULL ,
	Name                  VARCHAR2(20)  NULL ,
	Gender                VARCHAR2(20)  NULL ,
	Email                 VARCHAR2(50)  NULL 
);



CREATE UNIQUE INDEX XPKUSER_INFO ON USER_INFO
(ID  ASC);



ALTER TABLE USER_INFO
	ADD CONSTRAINT  XPKUSER_INFO PRIMARY KEY (ID);



ALTER TABLE POST
	ADD (CONSTRAINT  R_3 FOREIGN KEY (ID) REFERENCES USER_INFO(ID));



ALTER TABLE Reply
	ADD (CONSTRAINT  R_1 FOREIGN KEY (ID) REFERENCES USER_INFO(ID));



ALTER TABLE Reply
	ADD (CONSTRAINT  R_2 FOREIGN KEY (PostID) REFERENCES POST(PostID));



ALTER TABLE TODO
	ADD (CONSTRAINT  R_4 FOREIGN KEY (ID) REFERENCES USER_INFO(ID));

