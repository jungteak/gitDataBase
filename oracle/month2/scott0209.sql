create table doctor (
doc_id number(10) primary key,
major_treat varchar2(25) not null,
doc_name varchar2(20) not null,
doc_gen char(1) not null,
doc_phone varchar2(15),
doc_email varchar2(50) unique,
doc_position varchar2(20) not null
);

create table nurse(
nur_id number(10) primary key,
major_job varchar2(25) not null,
nur_name varchar2(20) not null,
nur_gen char(1) not null,
nur_phone varchar2(15),
nur_email varchar2(50) unique,
nur_position varchar2(20) not null
);

create table patinets(
pat_id number(10) primary key,
nur_id number(10) REFERENCES nurse(nur_id),
doc_id number(10) references doctor(doc_id),
pat_name varchar2(20) not null,
pat_gen char(1) not null,
pat_jumin varchar2(14) not null,
pat_addr varchar2(100) not null,
pat_phone varchar2(15),
pat_email varchar2(50) unique,
pat_job varchar2(20) not null
);

create table treatments(
treat_id number(15) not null,
pat_id number(10) not null,
doc_id number(10) not null,
treat_contents varchar2(1000) not null,
treat_date date not null
);

alter table Treatments add primary key(treat_id,pat_id,doc_id);
alter table Treatments add foreign key(pat_id) references Patinets(pat_id);
alter table Treatments add foreign key(doc_id) references Doctor(doc_id);

create table charts(
char_id varchar2(20) not null,
treat_id number(20) not null,
pat_id number(10) not null,
doc_id number(10) not null,
nur_id number(10) references nurse(nur_id),
chart_contents varchar2(1000) not null
);

alter table Charts add primary key(char_id,treat_id,pat_id,doc_id);
alter table Charts add foreign key(treat_id,pat_id,doc_id) references Treatments(treat_id,pat_id,doc_id);

insert into doctor values(080312,'�Ҿư�','������','M','010-3333-1340','itj@han.com','����');
insert into doctor values(000601,'����','�ȼ���','M','010-4422-0987','ask@han.com','����');
insert into doctor values(001208,'�ܰ�','�����','M','010-3311-1133','kmj@han.com','����');
insert into doctor values(020403,'�Ǻΰ�','���¼�','M','010-9999-7894','lts@han.com','����');
insert into doctor values(050900,'�Ҿư�','�迬��','F','010-9635-7412','kim@han.com','������');
insert into doctor values(050101,'����','������','M','010-7532-9512','cha@han.com','������');
insert into doctor values(062019,'�Ǻΰ�','ȫ�浿','F','010-7541-6523','hong@han.com','������');
insert into doctor values(070576,'�Ǻΰ�','������','F','010-9678-5468','jjh@han.com','������');
insert into doctor values(080543,'��缱��','���缮','M','010-1122-5566','yjs@han.com','����');
insert into doctor values(091001,'�ܰ�','�Ѽ���','F','010-9802-9899','hsh@han.com','������');

insert into nurses values(050302,'�Ҿư�','������','F','010-5333-1340','key@han.com','����ȣ��');


--5
update doctor set major_treat = '�Ҿư�' where doc_name = 'ȫ�浿';
delete from nurse where nur_name = '������';

--6
select * from doctor where major_treat = '�Ҿư�';
select * from patinets where doc_id = (select doc_id from doctor where doc_name = 'ȫ�浿');
select * from patinets where pat_id = (select pat_id from treatments where to_char(treat_date,'yyyy/mm') = '2019/12');
select * from nurse where nur_id like '05%';


desc goodsinfo;
select * from goodsinfo;
select * from nurse;





