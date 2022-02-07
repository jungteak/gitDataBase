create table test(
name varchar2(20),
age number
);

select * from test;

create table test2(
name varchar2(20),
age number
);

--권한을 받았기 때문에 검색 가능
select * from c##scott.temp;
insert into c##scott.temp values ('test1','test2');

SELECT * FROM USER_SYS_PRIVS;

SELECT * FROM USER_ROLE_PRIVS;





































