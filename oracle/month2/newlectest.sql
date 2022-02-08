create table NOTICE(
ID number,
TITLE NVARCHAR2(100),
WRITER_ID NVARCHAR2(50),
CONTENT CLOB,
REGDATE TIMESTAMP,
HIT NUMBER,
FILES NVARCHAR2(1000)
);

CREATE TABLE CONTENT(
ID NUMBER,
CONTENT NVARCHAR2(2000),
REGDATE TIMESTAMP,
WRITER_ID NVARCHAR2(50),
NOTICE_ID NUMBER
);

CREATE TABLE ROLE(
ID VARCHAR2(50),
DISCRIPTION NVARCHAR2(500)
);

CREATE TABLE MEMBER_ROLE(
MEMBER_ID NVARCHAR2(50),
ROLE_ID VARCHAR2(50)
);

CREATE TABLE MEMBER(
ID NVARCHAR2(50),
PWD NVARCHAR2(50),
NAME NVARCHAR2(50),
GENDER NCHAR(2),
BIRTHDAY CHAR(10),
PHONE CHAR(13),
REGDATE DATE,
EMAIL VARCHAR2(200)
);

insert into notice values (256,'JDBC란 무엇인가?','newlec','aaa',sysdate,0,'');
insert into notice values (2,'JDBC2란 무엇인가?','newlec','aaa',sysdate,0,'');
insert into notice values (3,'JDBC3란 무엇인가?','newlec','aaa',sysdate,0,'');

update notice set hit = 10 where id = 3;

COMMIT;



























































