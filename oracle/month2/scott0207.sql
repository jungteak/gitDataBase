--뷰/VIEW (가상 테이블 / SELECT문을 저장한 객체)
--

--뷰 생성 권한 주기
--SQLPLUS SYSTEM/비밀번호
--GRANT CREATE VIEW TO 권한 줄 계정; 

--OR REPLACE는 거의 필수로 들어간다
--CREATE [OR REPLACE] [FORCE | NOFORCE] VIEW 뷰 이름 (열 이름1, 열 이름2....)
--AS (저장할 SELECT문)
--[WITH CHECK OPTION [CONSTRAINT 제약조건]]
--[WITH READ ONLY [CONSTRAINT 제약조건]];

--USER-VIEW >> 데이터 딕셔너리 확인

--DROP >> 뷰 삭제

--20번 부서만 있는 뷰 생성
CREATE VIEW vw_emp20 AS (SELECT EMPNO, ENAME,JOB,DEPTNO FROM EMP WHERE DEPTNO = 20);
SELECT * FROM USER_VIEWS;
SELECT * FROM VW_EMP20;

INSERT INTO VW_EMP20 VALUES (8000, 'JAVAKIM','SALESMAN',20);
SELECT * FROM EMP;
DELETE FROM VW_EMP20 WHERE EMPNO = 8000;

COMMIT;

--부서별 급여 총액, 평균 구하는 작업
CREATE OR REPLACE VIEW VIEW_SAL AS SELECT DEPTNO,SUM(SAL) 총액, TRUNC(AVG(SAL)) 평균 FROM EMP GROUP BY DEPTNO;
SELECT * FROM VIEW_SAL ORDER BY DEPTNO;

--사원번호,사원명,급여,부서번호,부서명,근무지를 출력하는 뷰
CREATE OR REPLACE VIEW VW_EMP_DEPT 
AS SELECT EMPNO,ENAME,SAL,DEPTNO,DNAME,LOC FROM EMP NATURAL JOIN DEPT;
SELECT * FROM VW_EMP_DEPT ORDER BY EMPNO;

--WITH CHECK/READ 옵션
CREATE OR REPLACE VIEW VW_CHK20
AS SELECT EMPNO, ENAME, SAL , COMM , DEPTNO FROM EMP WHERE DEPTNO = 20 WITH CHECK OPTION;
--뷰 생성시 조건으로 지정한 칼럼 값을 변경하지 못하도록 하는 것
SELECT * FROM VW_CHK20;
--아래처럼 DEPTNO는 수정할 수 없다
UPDATE VW_CHK20 SET DEPTNO = 10 WHERE SAL >= 3000;

--읽기 전용 뷰
CREATE OR REPLACE VIEW VW_READ30
AS SELECT EMPNO, ENAME, SAL , COMM , DEPTNO FROM EMP WHERE DEPTNO = 30 WITH READ ONLY;

SELECT * FROM VW_READ30;
--WITH READ ONLY로 선언한 읽기 전용 뷰에서는 SELECT 이외의 작업을 수행 할 수 없다
UPDATE VW_READ30 SET COMM = 1000;

SELECT ROWNUM, E.* FROM EMP E;
--이렇게 사용하면 급여별로 가상번호를 붙일 수 없음!
SELECT ROWNUM, E.* FROM EMP E ORDER BY SAL DESC;
--이렇게 먼저 정렬한 후 가상번호를 붙여야 급여별로 가상번호를 붙일 수 있다
SELECT ROWNUM, E.* FROM (SELECT * FROM EMP E ORDER BY SAL DESC) E;
--위의 문장과 같은데 먼저 선언하고 사용하는 방법
WITH E AS (SELECT * FROM EMP E ORDER BY SAL DESC)
SELECT ROWNUM,E.* FROM E WHERE ROWNUM <= 3;

--1. 사원 번호와 사원명과 부서명과 부서의 위치를 출력하는 뷰(VIEW_LOC)를 작성하세요.
CREATE VIEW VIEW_LOC AS SELECT EMPNO,ENAME,DNAME,LOC FROM EMP NATURAL JOIN DEPT;
SELECT * FROM VIEW_LOC;
--2. 30번 부서 소속 사원의 이름과 입사일과 부서명을 출력하는 뷰(VIEW_DEPT30)를 작성하세요.
CREATE VIEW VIEW_DEPT30 AS SELECT ENAME,HIREDATE,DNAME FROM EMP NATURAL JOIN DEPT WHERE DEPTNO = 30;
SELECT * FROM VIEW_DEPT30;
--3. 부서별 최대 급여 정보를 가지는 뷰(VIEW_DEPT_MAXSAL)를 생성하세요.
CREATE VIEW VIEW_DEPT_MAXSAL AS SELECT DEPTNO,MAX(SAL) 최대급여 FROM EMP GROUP BY DEPTNO ORDER BY DEPTNO;
SELECT * FROM VIEW_DEPT_MAXSAL;
--4. 급여를 많이 받는 순서대로 5명만 출력하는 뷰(VIEW_SAL_TOP5)를 작성하세요.
CREATE OR REPLACE VIEW VIEW_SAL_TOP5 
AS SELECT ROWNUM 순위, E.* FROM (SELECT * FROM EMP E ORDER BY SAL DESC) E WHERE ROWNUM < 6;
SELECT * FROM VIEW_SAL_TOP5;
--5.급여를 많이 받는 순서대로 6~10등까지 출력
CREATE OR REPLACE VIEW VIEW_SAL_TOP5 
AS select E.*
from
(select rownum r, E.*
from 
(select * from  emp order by sal desc) E) E
where r >= 6 and r <= 10;


--QUIZ3
--제약조건 문제
--1
CREATE TABLE SUBJECT(
    NO NUMBER NOT NULL,
    S_NUM VARCHAR2(10),
    S_NAME VARCHAR2(30) NOT NULL,
    PRIMARY KEY(S_NUM), UNIQUE(NO)
);

create sequence SQ_SJ;

INSERT INTO SUBJECT VALUES (SQ_SJ.NEXTVAL , '01' , '컴퓨터학과'); 
INSERT INTO SUBJECT VALUES (SQ_SJ.NEXTVAL , '02' , '교육학과'); 
INSERT INTO SUBJECT VALUES (SQ_SJ.NEXTVAL , '03' , '신문방송학과'); 
INSERT INTO SUBJECT VALUES (SQ_SJ.NEXTVAL , '04' , '인터넷비즈니스과'); 
INSERT INTO SUBJECT VALUES (SQ_SJ.NEXTVAL , '05' , '기술경영과');

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
VALUES (SQ_SD.NEXTVAL,'06010001','김정수','JAVAJSP','01','서울시 서대문구 창전동');
INSERT INTO STUDENT VALUES (SQ_SD.NEXTVAL,'95010002','김수현','JDBCMANIA','01','서울시 서초구 양재동',SYSDATE);
INSERT INTO STUDENT VALUES (SQ_SD.NEXTVAL,'98040001','이지영','ONJI','04','부산광역시 해운대구 반송동',SYSDATE);
INSERT INTO STUDENT VALUES (SQ_SD.NEXTVAL,'02050001','조수영','WATER','05','대전광역시 중구 은행동',SYSDATE);
INSERT INTO STUDENT VALUES (SQ_SD.NEXTVAL,'94040002','최경란','NOVEL','04','경기도 수원시 장안구 이목동',SYSDATE);
INSERT INTO STUDENT VALUES (SQ_SD.NEXTVAL,'08020001','안익태','KOREA','02','서울시 강북구 미아동',SYSDATE);

SELECT * FROM STUDENT;

--3
CREATE TABLE LESSON(
    NO NUMBER NOT NULL,
    L_NUM VARCHAR(10),
    L_NAME VARCHAR(30) NOT NULL,
    UNIQUE(NO), PRIMARY KEY(L_NUM)
);

create sequence SQ_LS;

INSERT INTO LESSON VALUES (SQ_LS.NEXTVAL,'K','국어');
INSERT INTO LESSON VALUES (SQ_LS.NEXTVAL,'M','수학');
INSERT INTO LESSON VALUES (SQ_LS.NEXTVAL,'E','영어');
INSERT INTO LESSON VALUES (SQ_LS.NEXTVAL,'H','역사');
INSERT INTO LESSON VALUES (SQ_LS.NEXTVAL,'P','프로그래밍');
INSERT INTO LESSON VALUES (SQ_LS.NEXTVAL,'D','데이터 베이스');
INSERT INTO LESSON VALUES (SQ_LS.NEXTVAL,'ED','교육학이론');

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
--emp 앞에 c##scott을 적어야하지만 동일 계정이므로 생략 가능
create synonym e for emp;
select * from e;
--synonym 삭제
drop synonym e;

create table temp(
    col1 varchar2(20),
    col2 varchar2(20)
);

--temp 테이블을 검색할 수 있는 권한을 orclstudy에 준다.
grant select on temp to c##orclstudy;
grant insert on temp to c##orclstudy;
-->> grant insert,select on temp ~~~ 이렇게 한번에 여러 권한 주는 것도 가능!
select * from temp;

revoke select, insert on temp from c##orclstudy;

--pl/sql 문

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
    v_deptno := 20; -- 이렇게 설정 안하면 기본 값인 10이 나옴
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
    dbms_output.put_line('부서번호 : '||v_dept_row.deptno);
    dbms_output.put_line('부서명 : '||v_dept_row.dname);
    dbms_output.put_line('근무지 : '||v_dept_row.loc);
end;
/




































































