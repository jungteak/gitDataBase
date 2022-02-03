/*���̺� ���� create!
create table ���̺��(
    �÷��� ������Ÿ�� [��������],
    �÷��� ������Ÿ�� [��������],
    .....
    �÷��� ������Ÿ�� [��������]
    ��������
);

���ڷ� ����
1~30�ڱ��� ����
�ѱ� �����ϳ� �������� (�ڹ�,���̽� ������ ���� �� �� ����)
Ư����ȣ _.$,# ���� ������ X �Ұ���
Ű���嵵 ��� �Ұ� ���̺�� �ߺ� �Ұ�*/

--�����ȣ,�����,�޿� 3���� �÷����� ������ emp01 ���̺��� �����Ͻÿ�.
create table emp01(
empno number,
ename varchar2(40),
sal number
);

--�����ϴ� drop
drop table emp01; -- ���̺� ����  >> ���������� �̵�
drop table emp01 purge; -- ���̺� ���� >> ���� ���� (���� �Ұ���)

--create���� ���̺� �����ϴ� as select
--���������� ������ �� ��! >> ���Ŀ� alter ������ �߰��ϴ��� �ؾ���
create table emp02
as
select * from emp;

select * from emp02;

--�Ϻθ� ���� select ���� where ���
create table emp03
as select * from emp where deptno = 30;

select * from emp03;

--�� ������ ���� / ������ �׻� false�� ���ǽ� ���!
create table emp04
as select * from emp where 1 = 0;

select * from emp04;

--�Ϻε����͸� select�� ��������~~ 
create table emp05
as select empno,ename,deptno from emp;

select * from emp05;

--���̺� ���� alter
--���̺� �� �߰� �ϴ� add
alter table emp01 add(job varchar2(10));
desc emp01;

--�� �ڷ��� �����ϴ� modify

--�ش� Į���� �ڷᰡ ���� ���
--������ Ÿ�� ���� ����
--ũ�� ���� ����

-- �ش� Į���� �ڷᰡ �ִ� ���
--������ Ÿ�� ���� �Ұ���
--ũ�⸦ �ø� ���� ������ ���� ���� ����
--null ���� ����� ���¿��� not null ���������� �� �� ����.

alter table emp01 modify(job varchar2(30));
desc emp01;

--���̺� �� �̸� �����ϴ� rename
alter table emp01 rename column empno to empnum;
desc emp01;

--�÷����� drop
alter table emp01 drop column job;
desc emp01;

--rename ���̺� �� �����ϱ� 
--rename �������̺�� to ���������̺��;

--emp05 >> emp06 ���� ���̺�� �����ϱ�
rename emp05 to emp06;
select * from emp06;

--���̺��� ��ü �����͸� �����ϴ� truncate // ddl ���̾ rollback �Ұ��� (���� �Ұ���)
select count(*) from emp02;
truncate table emp02;
select count(*) from emp02;

--�������� �� �θ����̺��� ���� �Ұ��� >> �ڽ� ���̺� ������ ������ �����ϴ�

--�������� 5����
--not null
--unique
--primary key
--foreigen key
--check

create table emp00(
    empno number(4) not null,
    ename varchar(10) not null,
    job varchar2(9),
    deptno number(2)
);
--�ι� �����ص� �� ���� �ƴϸ� �ߺ��� ����!
insert into emp00 values (7499,'ALLEN','SALESMAN',30);
select * from emp00;

create table emp000(
    empno number(4) unique,
    ename varchar(10) not null,
    job varchar2(9),
    deptno number(2)
);

--����ũ ���������� �ߺ��� �Ұ��� / null ���� �������
insert into emp000 values (7499,'ALLEN','SALESMAN',30);
insert into emp000 values (7499,'JAMES','SALESMAN',30);
select * from emp000;

--�������� Ȯ���ϴ� ��
select * from user_cons_columns where table_name = 'EMP000';

--�������� Ȯ���ϴ� ��� 2
SELECT CONSTRAINT_NAME, CONSTRAINT_TYPE, TABLE_NAME
FROM USER_CONSTRAINTS WHERE TABLE_NAME='EMP000';

--�������ǿ� �̸� �ٿ��� Ȯ���ϱ�
create table table_nn2(
    login_id varchar2(20) constraint TBLNN2_id_nn not null ,
    login_pw varchar2(20) constraint TBLNN2_pw_nn not null,
    tel varchar2(20)
);

SELECT CONSTRAINT_NAME, CONSTRAINT_TYPE, TABLE_NAME
FROM USER_CONSTRAINTS WHERE TABLE_NAME='TABLE_NN2';

--�������� �߰��ϱ�
alter table table_nn2 modify (tel not null);
--�������� �����ϱ�
alter table table_nn2 drop constraint TBLNN2_id_nn;
desc table_nn2;


create table emp004(
    empno number(4) primary key,
    ename varchar(10) not null,
    job varchar2(9),
    deptno number(2)
);

insert into emp004 values (7499,'ALLEN','SALESMAN',30);

--�ܺ�Ű
create table dept_fk(
    
    deptno number(2),
    dname varchar2(14),
    loc varchar2(13),
    CONSTRAINT dept_fk_deptno_pk primary key(deptno)

);

desc dept_fk;

SELECT CONSTRAINT_NAME, CONSTRAINT_TYPE, TABLE_NAME
FROM USER_CONSTRAINTS WHERE TABLE_NAME='DEPT_FK';

create table emp_fk(
    empno number(4) primary key,
    ename varchar2(10),
    job varchar2(10),
    deptno number(2),
    FOREIGN KEY (deptno) REFERENCES dept_fk(deptno)
    --deptno number(2) REFERENCES dept_fk(deptno) /�̷��� �ᵵ �ȴ�
);

insert into dept_fk values (10,'����','����');
insert into dept_fk values (20,'����2','����');
insert into emp_fk values (7788,'SCOTT','TESTER',10);
select * from dept_fk;
select * from emp_fk;
select * from dept_fk natural join emp_fk;

create table emp_fk_sn(
    empno number(4) primary key,
    ename varchar2(10),
    job varchar2(10),
    deptno number(2),
    FOREIGN KEY (deptno) REFERENCES dept_fk(deptno) on delete cascade
    --deptno number(2) REFERENCES dept_fk(deptno) /�̷��� �ᵵ �ȴ�
);

insert into emp_fk_sn values(7788,'SCOTT','TESTER',10);
insert into emp_fk_sn values(7700,'ORACLE','TESTER',10);
insert into emp_fk_sn values(7800,'JAVA','TESTER',10);
insert into emp_fk_sn values(8000,'ORAJAVA','TESTER',20);

delete from dept_fk where deptno = 10;
select * from emp_fk_sn;

drop table emp_fk_cas;

create table emp_fk_sn(
    empno number(4) primary key,
    ename varchar2(10),
    job varchar2(10),
    deptno number(2),
    FOREIGN KEY (deptno) REFERENCES dept_fk(deptno) on delete set null
    --deptno number(2) REFERENCES dept_fk(deptno) /�̷��� �ᵵ �ȴ�
);

delete from dept_fk where deptno = 20;

--�������� check ���ǿ� �ش��ؾ��� ������ ���� �� ���� 
create table tbl_chk(
    id varchar(20) CONSTRAINT tbl_chk_id_pk primary key,
    pw varchar(20) CONSTRAINT tbl_chk_pw_pk check(length(pw)>3),
    gender char(1) check(gender in ('M','F'))
);

insert into tbl_chk values ('test1','1234','M');
select * from tbl_chk;
insert into tbl_chk values('test2','1111','F');











































