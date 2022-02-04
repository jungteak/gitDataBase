--���ڵ� �߰�(insert) / ����(update) / ����(delete)

--insert >> ���ڵ� �߰� / ������ �� ���� ���ڵ尡 �����.
--insert into ���̺�� (�÷���1,�÷���2....�÷���n) values (�÷���1 ������, �÷���2 ������....�÷���n ������);
--insert into ���̺�� values (��1,��2...��n); >> ���̺� ��� Į���� ���� �����Ѵ�. ���� ������ �÷��� ������ ��ġ�ؾ��Ѵ�.

--dept ���̺��� ������ dept_temp ���̺� ����
create table dept_temp as select * from dept; --���������� �������� �ʴ´�
select * from dept_temp;

--�÷� �����ؼ� ������ �ֱ�
insert into dept_temp (deptno,dname,loc) values (50,'DATABASE','SEOUL');
--�÷����� �������� ������ ���̺� ������ �� ������ ������ �Է�
insert into dept_temp values (60,'RandD','JEJU');

--delete�� Ư�� ���ڵ� �����ϱ�
delete from dept_temp where deptno = 60;

--set escape on; >> 'R\&D' / ���� ���� ���� �� ���������� �ǹ� �ִ� ���ڿ��� �Բ� ���� �Ϲ� ���ڿ��� ����� �� �ִ�

--null ���� ����� ǥ�� >> null / ''(���ڿ�)
insert into dept_temp values (80,'PT', null);
insert into dept_temp values (90,'MARKETING','');
select * from dept_temp;

--null ���� �Ͻ��� ǥ�� >> ������� ���� �÷��� null ���� ����ȴ�.
insert into dept_temp(deptno, dname) values (11,'MANEGEMENT');

--emp ���̺��� ��Ű���� ������ emp_temp ���̺� ����
create table emp_temp as select * from emp where 1 = 0;
select * from emp_temp;

--�����ȣ 1000 / �̸� ȫ�浿 / ��å president / ��� ���� / �Ի��� ���� / �޿� 5000 / Ŀ�̼� 1000 / �μ� 10
insert into emp_temp values (1000,'ȫ�浿','PRESIDENT',null,sysdate,5000,1000,10);
--�����ȣ 1111 / �̸� ȫ���� / ��å MANEGER / ��� 1000 / �Ի��� 2020/02/04 / �޿� 4000 / Ŀ�̼� ���� / �μ� 20
insert into emp_temp values (1111,'ȫ����','MANAGER',1000,'2022/02/04',4000,null,20);
--�����ȣ 2111 / �̸� ȫ���� / ��å MANAGER / ��� 1000 / �Ի��� 2022/02/04 / �޿� 4000 / Ŀ�̼� ���� / �μ� 20
insert into emp_temp values (2111,'ȫ����','MANAGER',1000,'2022-02-04',4000,null,20);
--�����ȣ 3111 / �̸� ȫ���� / ��å MANEGER / ��� 1000 / 04/02/2222 / �޿� 4000 / Ŀ�̼� ���� / �μ� 30
insert into emp_temp values (3111,'ȫ����','MANAGER',1000,to_date('04/02/2022','dd/mm/yyyy'),4000,null,30);
--�̻��ϰ� ��¥�� �Է½� to_date�� ó�� �� �� �� �ִ�

--��¥ ������ �߰�
-- ��/��/�� or ��-��-��
-- to_date �Լ� ���
-- sysdate ���

--�⺻ ���� ���ϴ� default >> ���� ���� ���� ��� �⺻ ���� ����
create table tbl_default(
    id varchar2(20) primary key,
    pw varchar2(20) default '1234'
);
insert into tbl_default values ('test_id',null);
insert into tbl_default (id) values ('test_id2');

select * from tbl_default; 
-- null ���� ����ϸ� null ���� �� �ƴϸ� �⺻ ���� ��
--�÷��� ������� ���� ��� default ���� ������

--�������� ����Ͽ� �� ���� ���� ������ �߰��ϱ�
--values ���� ����
--�����Ͱ� �߰��Ǵ� �� ������ �������� �� ������ ��ġ�ؾ� �Ѵ�
--�����Ͱ� �߰��Ǵ� ���̺��� �ڷ����� �������� �ڷ����� ��ġ�ؾ� �Ѵ�.

--�޿� ����� 1���� ����� ������ emp_temp ���̺� �����ϼ���
insert into emp_temp (empno,ename,job,mgr,hiredate,sal,comm,deptno) 
select empno,ename,job,mgr,hiredate,sal,comm,deptno 
from emp e , salgrade s where e.sal between s.losal and s.hisal and s.grade = 1;

select * from emp_temp; 

--����(update)
--update ���̺�� set �÷��� = ������ ��, ... , �÷��� = ������ �� where ���ǽ�
--where���� �����ϸ� ��� ���ڵ� ���� �ٲ�� ������ where���� ����� ���ϴ� ���ڵ� ���� �ٲ���� �Ѵ�

select sal*2 from emp; --���� ���̺� ����� �����ʹ� ������ �ʴ´�

select * from dept_temp;

update dept_temp set loc = 'HOME' where loc is null;

--40�� �μ��� �μ����� 'PROJECTTEAM', �ٹ����� 'JEJU'�� ����
update dept_temp set dname = 'PROJECTTEAM', loc = 'JEJU' where deptno = 40;

--emp_temp ���̺��� ��� �� �޿��� 2500������ ������� Ŀ�̼��� 50���� ����
update emp_temp set comm = 50 where sal <= 2500;
select * from emp_temp;

--�÷������� ������ ������ ������ ��ġ�ؾ���
UPDATE DEPT_TEMP
   SET (DNAME, LOC) = (SELECT DNAME, LOC
                         FROM DEPT
                        WHERE DEPTNO = 40)
 WHERE DEPTNO = 40;
 
 --�̷��� �ᵵ �Ǵµ� ������ �� ����!
 UPDATE DEPT_TEMP
   SET DNAME = (SELECT DNAME
                  FROM DEPT
                 WHERE DEPTNO = 40),
       LOC = (SELECT LOC
                FROM DEPT
               WHERE DEPTNO = 40)
 WHERE DEPTNO = 40;

-- ���� (delete)
-- delete from ���̺�� [where ���ǽ�]
-- where ���� �����ϸ� ��� ���ڵ尡 �� �����ȴ�. (���� ����)
-- truncate table ���̺��; ��� ���ڵ� �� ���� (���� �Ұ���)

--job�� MANAGER�� ����� ���� ����
delete from emp_temp where job = 'MANAGER';
select * from emp_temp;
--delete ���� �������� ���
DELETE FROM EMP_TEMP
 WHERE EMPNO IN (SELECT E.EMPNO
                   FROM EMP_TEMP E, SALGRADE S
                  WHERE E.SAL BETWEEN S.LOSAL AND S.HISAL
                    AND S.GRADE = 1
                    AND DEPTNO = 30);
                    
                    
--����1

create table goodsInfo(
    num number(3),
    code varchar2(7),
    name varchar2(30),
    price number(10),
    maker varchar2(20)
);

insert into goodsInfo values(1,'A001','DigitalTV',520000,'Jeil');
insert into goodsInfo values(2,'A002','DVD',240000,'Jeil');
insert into goodsInfo values(3,'U101C','DSLR',830000,'Woosu');
insert into goodsInfo values(4,'U405D','Electronic Dictionary',160000,'Woosu');
insert into goodsInfo values(5,'H704','Microwave oven',90000,'Hana');
insert into goodsInfo values(6,'B307','Refrigerator',1500000,'Woosu');
insert into goodsInfo values(7,'M021R','Air Conditioner',1700000,'Woosu');
insert into goodsInfo values(8,'ZT809','Air Conditioner',1400000,'Jeil');

select * from goodsInfo;

update goodsInfo set name = 'Gas Range' where code = 'H704'; 
delete from goodsInfo where maker = 'Woosu';

--����2
create table members(
    no number(3),
    name varchar2(20),
    userid varchar2(15),
    password varchar2(15),
    age number(3),
    email varchar2(40),
    address varchar2(50)
);

insert into members values (1,'���缮','you','1234',47,'you@naver.com','����� ���ʱ� ���2��');
insert into members values (2,'���','momo','abcd',null,'momo@daum.net','��⵵ ������ ����3��');
insert into members values (3,'�ڱ浿','park','test01',32,'narae@google.com','��õ�� ������ û�е�');
insert into members values (4,'�丣','thor','ok005',36,null,'����� �߶��� ����� 99');
insert into members values (5,'�ڸ��','park2','sky3',49,'great4@apple.com','����� ������ ������');
insert into members values (6,'����ȣ','you2','apple',32,'bjae@daum.net','');
insert into members values (7,'��Ÿũ','stark','rich',54,'tony@start.com','������ ������ ������');

select * from members;

update members set email = 'thor2@naver.com' where name = '�丣';

update members set address = '��⵵ ���ν� ���ﵿ' where userid = 'you2';

delete from members where no = 7;

update members set age = 21 where userid = 'momo';

select * from members where age between 30 and 39;

select * from members where address like '%�����%';

select * from members where email like '%daum%';

select * from members order by name;

select * from members order by age desc,name;

--Ʈ�����
--�ϳ��� �۾� (�ּ� ����)
--insert/update/delete ���� �����
--Ʈ������� ���� �� >> �ӽ� ���Ϸ� �̸� ����
--���� ���� >> commit (db�� ���� ����)
--����(error) �߻� >> rollback; -> ������ ���� ���� ���(Ʈ����� ���� �������� ���ư�)
--Ʈ����� ���� ���� : ������ commit�� �� ����

--auto commit
-- 1. ddl,dcl���� ����� ��� (create, alter, drop..)
-- 2. ������ ���������� ���� �� ���

-- ������ �߻��߰ų� ��ǻ�� �ٿ�� �ڵ����� rollback �ȴ�.

create table dept_tcl as select * from dept;
select * from dept_tcl;

-- 40�� �μ��� �ٹ����� JEJU�� ����
update dept_tcl set loc = 'JEJU' where deptno =40;
-- �μ����� 'RESERCH'�� �μ� ����
delete from dept_tcl where dname = 'RESEARCH';
--select ������ Ȯ�� �� �۾����
select * from dept_tcl;
rollback;

-- ���� ��η� ���� >> ������ ������ ����(Ʈ�����)
-- Ʈ������� ���� ���� ���̺��� ���� �ɸ���
-- Ʈ������� ������ ������ �ٸ� Ʈ������� �ش� ���̺� ������ �� ����
-- select �� �����ϳ� insert/update/delete �� �� �� ����.

--Ʈ�����Ư¡ 4���� JAVA 16�� PPT

-- index >> �� ���� �˻��� �����ϰ� ��
-- ������ ���� ���̺��� �� ����°� ����
select * from user_indexes;

select * from user_ind_columns;

select * from emp where empno = 7788;
select * from emp where ename = 'SCOTT';

create index ind_emp_sal on emp(sal);

select * from emp where sal = 3000;
-- index ����
drop index ind_emp_sal;


--������ (��ȣ ������) // �ߺ����� ���ϱ� ���ؼ� ���
--create squence ������ �̸�
--[increment by n] ������
--[start with n] ���۰�
--[maxvalue n | nomaxvalue] �ִ밪
--[minvalue n | nominvalue] �ּҰ�
--[cycle | nocycle] 
--[cache n | nocache]

-- Ȯ���ϴ� ��
-- ��������.currval : ���� ������ ��ȣ
-- ��������.nextval : ������ ��

create table dept_seq_test as select * from dept where 1 = 0;
select * from dept_seq_test;
--������ ����
create sequence seq_deptno 
increment by 10 start with 10
maxvalue 90 
minvalue 0
nocycle cache 2;

select * from user_sequences;

insert into dept_seq_test values(seq_deptno.nextval,'DATABASE','SEOUL');
select * from dept_seq_test;
select seq_deptno.currval from dual;
-- ������ �����ϴ� alter
alter sequence seq_deptno increment by 3 maxvalue 99 cycle;
-- ������ �����ϴ� drop
drop sequence seq_deptno;























































































