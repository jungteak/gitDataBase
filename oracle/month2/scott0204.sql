--레코드 추가(insert) / 수정(update) / 삭제(delete)

--insert >> 레코드 추가 / 무조건 한 줄의 레코드가 생긴다.
--insert into 테이블명 (컬럼명1,컬럼명2....컬럼명n) values (컬럼명1 데이터, 컬럼명2 데이터....컬럼명n 데이터);
--insert into 테이블명 values (값1,값2...값n); >> 테이블 모든 칼럼에 값을 저장한다. 값의 갯수는 컬럼의 갯수와 일치해야한다.

--dept 테이블을 복제한 dept_temp 테이블 생성
create table dept_temp as select * from dept; --제약조건은 복제되지 않는당
select * from dept_temp;

--컬럼 지정해서 데이터 넣기
insert into dept_temp (deptno,dname,loc) values (50,'DATABASE','SEOUL');
--컬럼명을 지정하지 않으면 테이블 생성할 때 선언한 순서로 입력
insert into dept_temp values (60,'RandD','JEJU');

--delete로 특정 레코드 삭제하기
delete from dept_temp where deptno = 60;

--set escape on; >> 'R\&D' / 앞의 문장 실행 후 역슬래쉬와 의미 있는 문자열을 함께 쓰면 일반 문자열로 사용할 수 있다

--null 값의 명시적 표시 >> null / ''(빈문자열)
insert into dept_temp values (80,'PT', null);
insert into dept_temp values (90,'MARKETING','');
select * from dept_temp;

--null 값의 암시적 표시 >> 명시하지 않은 컬럼은 null 값이 저장된다.
insert into dept_temp(deptno, dname) values (11,'MANEGEMENT');

--emp 테이블의 스키마만 복사한 emp_temp 테이블 생성
create table emp_temp as select * from emp where 1 = 0;
select * from emp_temp;

--사원번호 1000 / 이름 홍길동 / 직책 president / 상사 없음 / 입사일 오늘 / 급여 5000 / 커미션 1000 / 부서 10
insert into emp_temp values (1000,'홍길동','PRESIDENT',null,sysdate,5000,1000,10);
--사원번호 1111 / 이름 홍서아 / 직책 MANEGER / 상사 1000 / 입사일 2020/02/04 / 급여 4000 / 커미션 없음 / 부서 20
insert into emp_temp values (1111,'홍서아','MANAGER',1000,'2022/02/04',4000,null,20);
--사원번호 2111 / 이름 홍도윤 / 직책 MANAGER / 상사 1000 / 입사일 2022/02/04 / 급여 4000 / 커미션 없음 / 부서 20
insert into emp_temp values (2111,'홍도윤','MANAGER',1000,'2022-02-04',4000,null,20);
--사원번호 3111 / 이름 홍서준 / 직책 MANEGER / 상사 1000 / 04/02/2222 / 급여 4000 / 커미션 없음 / 부서 30
insert into emp_temp values (3111,'홍서준','MANAGER',1000,to_date('04/02/2022','dd/mm/yyyy'),4000,null,30);
--이상하게 날짜값 입력시 to_date로 처리 해 줄 수 있다

--날짜 데이터 추가
-- 년/월/일 or 년-월-일
-- to_date 함수 사용
-- sysdate 사용

--기본 값을 정하는 default >> 저장 값이 없을 경우 기본 값을 지정
create table tbl_default(
    id varchar2(20) primary key,
    pw varchar2(20) default '1234'
);
insert into tbl_default values ('test_id',null);
insert into tbl_default (id) values ('test_id2');

select * from tbl_default; 
-- null 값을 명시하면 null 값이 들어감 아니면 기본 값이 들어감
--컬럼을 명시하지 않은 경우 default 값이 지정됨

--서브쿼리 사용하여 한 번에 여러 데이터 추가하기
--values 절은 생략
--데이터가 추가되는 열 개수와 서브쿼리 열 개수가 일치해야 한다
--데이터가 추가되는 테이블의 자료형과 서브쿼리 자료형이 일치해야 한다.

--급여 등급이 1급인 사원의 정보를 emp_temp 테이블에 저장하세요
insert into emp_temp (empno,ename,job,mgr,hiredate,sal,comm,deptno) 
select empno,ename,job,mgr,hiredate,sal,comm,deptno 
from emp e , salgrade s where e.sal between s.losal and s.hisal and s.grade = 1;

select * from emp_temp; 

--수정(update)
--update 테이블명 set 컬럼명 = 수정할 값, ... , 컬럼명 = 수정할 값 where 조건식
--where절을 생략하면 모든 레코드 값이 바뀌기 때문에 where절을 사용해 원하는 레코드 값만 바꿔줘야 한다

select sal*2 from emp; --실제 테이블에 저장된 데이터는 변하지 않는다

select * from dept_temp;

update dept_temp set loc = 'HOME' where loc is null;

--40번 부서의 부서명을 'PROJECTTEAM', 근무지를 'JEJU'로 변경
update dept_temp set dname = 'PROJECTTEAM', loc = 'JEJU' where deptno = 40;

--emp_temp 테이블의 사원 중 급여가 2500이하인 사원들의 커미션을 50으로 변경
update emp_temp set comm = 50 where sal <= 2500;
select * from emp_temp;

--컬럼개수와 꺼내올 데이터 갯수가 일치해야함
UPDATE DEPT_TEMP
   SET (DNAME, LOC) = (SELECT DNAME, LOC
                         FROM DEPT
                        WHERE DEPTNO = 40)
 WHERE DEPTNO = 40;
 
 --이렇게 써도 되는데 위에가 더 좋음!
 UPDATE DEPT_TEMP
   SET DNAME = (SELECT DNAME
                  FROM DEPT
                 WHERE DEPTNO = 40),
       LOC = (SELECT LOC
                FROM DEPT
               WHERE DEPTNO = 40)
 WHERE DEPTNO = 40;

-- 삭제 (delete)
-- delete from 테이블명 [where 조건식]
-- where 절을 생략하면 모든 레코드가 다 삭제된다. (복원 가능)
-- truncate table 테이블명; 모든 레코드 다 삭제 (복원 불가능)

--job이 MANAGER인 사원의 정보 삭제
delete from emp_temp where job = 'MANAGER';
select * from emp_temp;
--delete 에서 서브쿼리 사용
DELETE FROM EMP_TEMP
 WHERE EMPNO IN (SELECT E.EMPNO
                   FROM EMP_TEMP E, SALGRADE S
                  WHERE E.SAL BETWEEN S.LOSAL AND S.HISAL
                    AND S.GRADE = 1
                    AND DEPTNO = 30);
                    
                    
--퀴즈1

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

--퀴즈2
create table members(
    no number(3),
    name varchar2(20),
    userid varchar2(15),
    password varchar2(15),
    age number(3),
    email varchar2(40),
    address varchar2(50)
);

insert into members values (1,'유재석','you','1234',47,'you@naver.com','서울시 서초구 방배2동');
insert into members values (2,'모모','momo','abcd',null,'momo@daum.net','경기도 성남시 태평3동');
insert into members values (3,'박길동','park','test01',32,'narae@google.com','인천시 연수구 청학동');
insert into members values (4,'토르','thor','ok005',36,null,'서울시 중랑구 상봉동 99');
insert into members values (5,'박명수','park2','sky3',49,'great4@apple.com','서울시 마포구 망원동');
insert into members values (6,'유세호','you2','apple',32,'bjae@daum.net','');
insert into members values (7,'스타크','stark','rich',54,'tony@start.com','대전시 유성구 구성동');

select * from members;

update members set email = 'thor2@naver.com' where name = '토르';

update members set address = '경기도 용인시 기흥동' where userid = 'you2';

delete from members where no = 7;

update members set age = 21 where userid = 'momo';

select * from members where age between 30 and 39;

select * from members where address like '%서울시%';

select * from members where email like '%daum%';

select * from members order by name;

select * from members order by age desc,name;

--트랜잭션
--하나의 작업 (최소 단위)
--insert/update/delete 문을 묶어둠
--트랜잭션이 실행 중 >> 임시 파일로 미리 실행
--문제 없음 >> commit (db에 영구 저장)
--문제(error) 발생 >> rollback; -> 실행한 내용 전부 취소(트랜잭션 시작 시점으로 돌아감)
--트랜잭션 시작 시점 : 마지막 commit을 한 시점

--auto commit
-- 1. ddl,dcl문이 수행된 경우 (create, alter, drop..)
-- 2. 연결이 정상적으로 종료 된 경우

-- 정전이 발생했거나 컴퓨터 다운시 자동으로 rollback 된다.

create table dept_tcl as select * from dept;
select * from dept_tcl;

-- 40번 부서의 근무지를 JEJU로 변경
update dept_tcl set loc = 'JEJU' where deptno =40;
-- 부서명이 'RESERCH'인 부서 삭제
delete from dept_tcl where dname = 'RESEARCH';
--select 문으로 확인 후 작업취소
select * from dept_tcl;
rollback;

-- 여러 경로로 접속 >> 각각의 세션이 생성(트랜잭션)
-- 트랜잭션이 실행 중인 테이블은 락이 걸린다
-- 트랜잭션이 끝나기 전까지 다른 트랜잭션은 해당 테이블에 접근할 수 없다
-- select 는 가능하나 insert/update/delete 는 할 수 없다.

--트랜잭션특징 4가지 JAVA 16번 PPT

-- index >> 더 빠른 검색이 가능하게 함
-- 변경이 많은 테이블은 안 만드는게 좋다
select * from user_indexes;

select * from user_ind_columns;

select * from emp where empno = 7788;
select * from emp where ename = 'SCOTT';

create index ind_emp_sal on emp(sal);

select * from emp where sal = 3000;
-- index 삭제
drop index ind_emp_sal;


--시퀀스 (번호 생성기) // 중복값을 피하기 위해서 사용
--create squence 시퀀스 이름
--[increment by n] 증가값
--[start with n] 시작값
--[maxvalue n | nomaxvalue] 최대값
--[minvalue n | nominvalue] 최소값
--[cycle | nocycle] 
--[cache n | nocache]

-- 확인하는 법
-- 시퀀스명.currval : 현재 시퀀스 번호
-- 시퀀스명.nextval : 증가된 값

create table dept_seq_test as select * from dept where 1 = 0;
select * from dept_seq_test;
--시퀀스 생성
create sequence seq_deptno 
increment by 10 start with 10
maxvalue 90 
minvalue 0
nocycle cache 2;

select * from user_sequences;

insert into dept_seq_test values(seq_deptno.nextval,'DATABASE','SEOUL');
select * from dept_seq_test;
select seq_deptno.currval from dual;
-- 시퀀스 수정하는 alter
alter sequence seq_deptno increment by 3 maxvalue 99 cycle;
-- 시퀀스 삭제하는 drop
drop sequence seq_deptno;























































































