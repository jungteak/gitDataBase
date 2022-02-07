--��/VIEW (���� ���̺� / SELECT���� ������ ��ü)
--

--�� ���� ���� �ֱ�
--SQLPLUS SYSTEM/��й�ȣ
--GRANT CREATE VIEW TO ���� �� ����; 

--OR REPLACE�� ���� �ʼ��� ����
--CREATE [OR REPLACE] [FORCE | NOFORCE] VIEW �� �̸� (�� �̸�1, �� �̸�2....)
--AS (������ SELECT��)
--[WITH CHECK OPTION [CONSTRAINT ��������]]
--[WITH READ ONLY [CONSTRAINT ��������]];

--USER-VIEW >> ������ ��ųʸ� Ȯ��

--DROP >> �� ����

--20�� �μ��� �ִ� �� ����
CREATE VIEW vw_emp20 AS (SELECT EMPNO, ENAME,JOB,DEPTNO FROM EMP WHERE DEPTNO = 20);
SELECT * FROM USER_VIEWS;
SELECT * FROM VW_EMP20;

INSERT INTO VW_EMP20 VALUES (8000, 'JAVAKIM','SALESMAN',20);
SELECT * FROM EMP;
DELETE FROM VW_EMP20 WHERE EMPNO = 8000;

COMMIT;

--�μ��� �޿� �Ѿ�, ��� ���ϴ� �۾�
CREATE OR REPLACE VIEW VIEW_SAL AS SELECT DEPTNO,SUM(SAL) �Ѿ�, TRUNC(AVG(SAL)) ��� FROM EMP GROUP BY DEPTNO;
SELECT * FROM VIEW_SAL ORDER BY DEPTNO;

--�����ȣ,�����,�޿�,�μ���ȣ,�μ���,�ٹ����� ����ϴ� ��
CREATE OR REPLACE VIEW VW_EMP_DEPT 
AS SELECT EMPNO,ENAME,SAL,DEPTNO,DNAME,LOC FROM EMP NATURAL JOIN DEPT;
SELECT * FROM VW_EMP_DEPT ORDER BY EMPNO;

--WITH CHECK/READ �ɼ�
CREATE OR REPLACE VIEW VW_CHK20
AS SELECT EMPNO, ENAME, SAL , COMM , DEPTNO FROM EMP WHERE DEPTNO = 20 WITH CHECK OPTION;
--�� ������ �������� ������ Į�� ���� �������� ���ϵ��� �ϴ� ��
SELECT * FROM VW_CHK20;
--�Ʒ�ó�� DEPTNO�� ������ �� ����
UPDATE VW_CHK20 SET DEPTNO = 10 WHERE SAL >= 3000;

--�б� ���� ��
CREATE OR REPLACE VIEW VW_READ30
AS SELECT EMPNO, ENAME, SAL , COMM , DEPTNO FROM EMP WHERE DEPTNO = 30 WITH READ ONLY;

SELECT * FROM VW_READ30;
--WITH READ ONLY�� ������ �б� ���� �信���� SELECT �̿��� �۾��� ���� �� �� ����
UPDATE VW_READ30 SET COMM = 1000;

SELECT ROWNUM, E.* FROM EMP E;
--�̷��� ����ϸ� �޿����� �����ȣ�� ���� �� ����!
SELECT ROWNUM, E.* FROM EMP E ORDER BY SAL DESC;
--�̷��� ���� ������ �� �����ȣ�� �ٿ��� �޿����� �����ȣ�� ���� �� �ִ�
SELECT ROWNUM, E.* FROM (SELECT * FROM EMP E ORDER BY SAL DESC) E;
--���� ����� ������ ���� �����ϰ� ����ϴ� ���
WITH E AS (SELECT * FROM EMP E ORDER BY SAL DESC)
SELECT ROWNUM,E.* FROM E WHERE ROWNUM <= 3;

--1. ��� ��ȣ�� ������ �μ���� �μ��� ��ġ�� ����ϴ� ��(VIEW_LOC)�� �ۼ��ϼ���.
CREATE VIEW VIEW_LOC AS SELECT EMPNO,ENAME,DNAME,LOC FROM EMP NATURAL JOIN DEPT;
SELECT * FROM VIEW_LOC;
--2. 30�� �μ� �Ҽ� ����� �̸��� �Ի��ϰ� �μ����� ����ϴ� ��(VIEW_DEPT30)�� �ۼ��ϼ���.
CREATE VIEW VIEW_DEPT30 AS SELECT ENAME,HIREDATE,DNAME FROM EMP NATURAL JOIN DEPT WHERE DEPTNO = 30;
SELECT * FROM VIEW_DEPT30;
--3. �μ��� �ִ� �޿� ������ ������ ��(VIEW_DEPT_MAXSAL)�� �����ϼ���.
CREATE VIEW VIEW_DEPT_MAXSAL AS SELECT DEPTNO,MAX(SAL) �ִ�޿� FROM EMP GROUP BY DEPTNO ORDER BY DEPTNO;
SELECT * FROM VIEW_DEPT_MAXSAL;
--4. �޿��� ���� �޴� ������� 5�� ����ϴ� ��(VIEW_SAL_TOP5)�� �ۼ��ϼ���.
CREATE OR REPLACE VIEW VIEW_SAL_TOP5 
AS SELECT ROWNUM ����, E.* FROM (SELECT * FROM EMP E ORDER BY SAL DESC) E WHERE ROWNUM < 6;
SELECT * FROM VIEW_SAL_TOP5;
--5.�޿��� ���� �޴� ������� 6~10����� ���
CREATE OR REPLACE VIEW VIEW_SAL_TOP5 
AS select E.*
from
(select rownum r, E.*
from 
(select * from  emp order by sal desc) E) E
where r >= 6 and r <= 10;


--QUIZ3
--�������� ����
--1
CREATE TABLE SUBJECT(
    NO NUMBER NOT NULL,
    S_NUM VARCHAR2(10),
    S_NAME VARCHAR2(30) NOT NULL,
    PRIMARY KEY(S_NUM), UNIQUE(NO)
);

create sequence SQ_SJ;

INSERT INTO SUBJECT VALUES (SQ_SJ.NEXTVAL , '01' , '��ǻ���а�'); 
INSERT INTO SUBJECT VALUES (SQ_SJ.NEXTVAL , '02' , '�����а�'); 
INSERT INTO SUBJECT VALUES (SQ_SJ.NEXTVAL , '03' , '�Ź�����а�'); 
INSERT INTO SUBJECT VALUES (SQ_SJ.NEXTVAL , '04' , '���ͳݺ���Ͻ���'); 
INSERT INTO SUBJECT VALUES (SQ_SJ.NEXTVAL , '05' , '����濵��');

SELECT * FROM SUBJECT;

--2
CREATE TABLE STUDENT(
    NO NUMBER NOT NULL,
    SD_NUM VARCHAR2(30),
    SD_NAME VARCHAR2(15) NOT NULL,
    SD_ID VARCHAR2(30) NOT NULL,
    S_NUM VARCHAR2(10) NOT NULL,
    SD_ADDRESS VARCHAR2(50) NOT NULL,
    SD_DATE DATE DEFAULT SYSDATE,
    UNIQUE(NO), PRIMARY KEY(SD_NUM),UNIQUE(SD_ID),
    FOREIGN KEY (S_NUM) REFERENCES SUBJECT(S_NUM)
);

create sequence SQ_SD;

INSERT INTO STUDENT(NO,SD_NUM,SD_NAME,SD_ID,S_NUM,SD_ADDRESS) 
VALUES (SQ_SD.NEXTVAL,'06010001','������','JAVAJSP','01','����� ���빮�� â����');
INSERT INTO STUDENT VALUES (SQ_SD.NEXTVAL,'95010002','�����','JDBCMANIA','01','����� ���ʱ� ���絿',SYSDATE);
INSERT INTO STUDENT VALUES (SQ_SD.NEXTVAL,'98040001','������','ONJI','04','�λ걤���� �ؿ�뱸 �ݼ۵�',SYSDATE);
INSERT INTO STUDENT VALUES (SQ_SD.NEXTVAL,'02050001','������','WATER','05','���������� �߱� ���ൿ',SYSDATE);
INSERT INTO STUDENT VALUES (SQ_SD.NEXTVAL,'94040002','�ְ��','NOVEL','04','��⵵ ������ ��ȱ� �̸�',SYSDATE);
INSERT INTO STUDENT VALUES (SQ_SD.NEXTVAL,'08020001','������','KOREA','02','����� ���ϱ� �̾Ƶ�',SYSDATE);

SELECT * FROM STUDENT;

--3
CREATE TABLE LESSON(
    NO NUMBER NOT NULL,
    L_NUM VARCHAR(10),
    L_NAME VARCHAR(30) NOT NULL,
    UNIQUE(NO), PRIMARY KEY(L_NUM)
);

create sequence SQ_LS;

INSERT INTO LESSON VALUES (SQ_LS.NEXTVAL,'K','����');
INSERT INTO LESSON VALUES (SQ_LS.NEXTVAL,'M','����');
INSERT INTO LESSON VALUES (SQ_LS.NEXTVAL,'E','����');
INSERT INTO LESSON VALUES (SQ_LS.NEXTVAL,'H','����');
INSERT INTO LESSON VALUES (SQ_LS.NEXTVAL,'P','���α׷���');
INSERT INTO LESSON VALUES (SQ_LS.NEXTVAL,'D','������ ���̽�');
INSERT INTO LESSON VALUES (SQ_LS.NEXTVAL,'ED','�������̷�');

SELECT * FROM LESSON;

--4
CREATE TABLE TRAINEE(
     NO NUMBER,
     SD_NUM VARCHAR2(30) NOT NULL,
     L_NUM VARCHAR(10) NOT NULL,
     T_SECTION VARCHAR(20) NOT NULL CHECK(T_SECTION IN ('CULTURE','MAJOR','MINOR')),
     T_DATE DATE DEFAULT SYSDATE,
     PRIMARY KEY(NO),
     FOREIGN KEY (SD_NUM) REFERENCES STUDENT(SD_NUM),
     FOREIGN KEY (L_NUM) REFERENCES LESSON(L_NUM)
);

create sequence SQ_TN;

INSERT INTO TRAINEE(NO,SD_NUM,L_NUM,T_SECTION)
VALUES(SQ_TN.NEXTVAL,'06010001','K','CULTURE');
INSERT INTO TRAINEE(NO,SD_NUM,L_NUM,T_SECTION)
VALUES(SQ_TN.NEXTVAL,'06010001','P','MAJOR');

SELECT * FROM TRAINEE;

--synonym
--emp �տ� c##scott�� ����������� ���� �����̹Ƿ� ���� ����
create synonym e for emp;
select * from e;
--synonym ����
drop synonym e;

create table temp(
    col1 varchar2(20),
    col2 varchar2(20)
);

--temp ���̺��� �˻��� �� �ִ� ������ orclstudy�� �ش�.
grant select on temp to c##orclstudy;
grant insert on temp to c##orclstudy;
-->> grant insert,select on temp ~~~ �̷��� �ѹ��� ���� ���� �ִ� �͵� ����!
select * from temp;

revoke select, insert on temp from c##orclstudy;

--pl/sql ��

set serveroutput on;

begin
    dbms_output.put_line('hello world!!');
end;
/

declare
    v_empno number(4) := 7788;
    v_ename varchar2(10);
begin
    v_ename := 'SCOTT';
    dbms_output.put_line('v_empno : '||v_empno);
    dbms_output.put_line('v_ename : '||v_ename);
end;
/

declare
    v_deptno number(2) default 10;
begin
    v_deptno := 20; -- �̷��� ���� ���ϸ� �⺻ ���� 10�� ����
    dbms_output.put_line('v_deptno : '||v_deptno);
end;
/

declare
    v_deptno dept.deptno%type;
begin
    v_deptno := 50;
    dbms_output.put_line('v_deptno : '||v_deptno);
end;
/

declare
    v_dept_row dept%rowtype;
begin
    select * into v_dept_row from dept where deptno = 40;
    dbms_output.put_line('�μ���ȣ : '||v_dept_row.deptno);
    dbms_output.put_line('�μ��� : '||v_dept_row.dname);
    dbms_output.put_line('�ٹ��� : '||v_dept_row.loc);
end;
/




































































