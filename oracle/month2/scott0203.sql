/*테이블 생성 create!
create table 테이블명(
    컬럼명 데이터타입 [제약조건],
    컬럼명 데이터타입 [제약조건],
    .....
    컬럼명 데이터타입 [제약조건]
    제약조건
);

문자로 시작
1~30자까지 가능
한글 가능하나 쓰지말기 (자바,파이썬 연동시 오류 날 수 있음)
특수기호 _.$,# 가능 공백은 X 불가능
키워드도 사용 불가 테이블명 중복 불가*/

--사원번호,사원명,급여 3개의 컬럼으로 구성된 emp01 테이블을 생성하시오.
create table emp01(
empno number,
ename varchar2(40),
sal number
);

--삭제하는 drop
drop table emp01; -- 테이블 삭제  >> 휴지통으로 이동
drop table emp01 purge; -- 테이블 삭제 >> 완전 삭제 (복구 불가능)

--create에서 테이블 복사하는 as select
--제약조건은 복제가 안 됨! >> 이후에 alter 문으로 추가하던가 해야함
create table emp02
as
select * from emp;

select * from emp02;

--일부만 복사 select 문에 where 사용
create table emp03
as select * from emp where deptno = 30;

select * from emp03;

--열 구조만 복사 / 조건이 항상 false인 조건식 사용!
create table emp04
as select * from emp where 1 = 0;

select * from emp04;

--일부데이터만 select로 가져오기~~ 
create table emp05
as select empno,ename,deptno from emp;

select * from emp05;

--테이블 변경 alter
--테이블에 열 추가 하는 add
alter table emp01 add(job varchar2(10));
desc emp01;

--열 자료형 변경하는 modify

--해당 칼럼에 자료가 없는 경우
--데이터 타입 변경 가능
--크기 변경 가능

-- 해당 칼럼에 자료가 있는 경우
--데이터 타입 변경 불가능
--크기를 늘릴 수는 있지만 줄일 수는 없음
--null 값이 저장된 상태에서 not null 제약조건을 걸 수 없다.

alter table emp01 modify(job varchar2(30));
desc emp01;

--테이블 열 이름 변경하는 rename
alter table emp01 rename column empno to empnum;
desc emp01;

--컬럼삭제 drop
alter table emp01 drop column job;
desc emp01;

--rename 테이블 명 변경하기 
--rename 기존테이블명 to 변경할테이블명;

--emp05 >> emp06 으로 테이블명 변경하기
rename emp05 to emp06;
select * from emp06;

--테이블의 전체 데이터를 삭제하는 truncate // ddl 문이어서 rollback 불가능 (복원 불가능)
select count(*) from emp02;
truncate table emp02;
select count(*) from emp02;

--참조관계 중 부모테이블은 삭제 불가능 >> 자식 테이블 삭제후 삭제가 가능하다

--제약조건 5가지
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
--두번 실행해도 널 값만 아니면 중복은 가능!
insert into emp00 values (7499,'ALLEN','SALESMAN',30);
select * from emp00;

create table emp000(
    empno number(4) unique,
    ename varchar(10) not null,
    job varchar2(9),
    deptno number(2)
);

--유니크 제약조건은 중복값 불가능 / null 값은 상관없다
insert into emp000 values (7499,'ALLEN','SALESMAN',30);
insert into emp000 values (7499,'JAMES','SALESMAN',30);
select * from emp000;

--제약조건 확인하는 법
select * from user_cons_columns where table_name = 'EMP000';

--제약조건 확인하는 방법 2
SELECT CONSTRAINT_NAME, CONSTRAINT_TYPE, TABLE_NAME
FROM USER_CONSTRAINTS WHERE TABLE_NAME='EMP000';

--제약조건에 이름 붙여서 확인하기
create table table_nn2(
    login_id varchar2(20) constraint TBLNN2_id_nn not null ,
    login_pw varchar2(20) constraint TBLNN2_pw_nn not null,
    tel varchar2(20)
);

SELECT CONSTRAINT_NAME, CONSTRAINT_TYPE, TABLE_NAME
FROM USER_CONSTRAINTS WHERE TABLE_NAME='TABLE_NN2';

--제약조건 추가하기
alter table table_nn2 modify (tel not null);
--제약조건 제거하기
alter table table_nn2 drop constraint TBLNN2_id_nn;
desc table_nn2;


create table emp004(
    empno number(4) primary key,
    ename varchar(10) not null,
    job varchar2(9),
    deptno number(2)
);

insert into emp004 values (7499,'ALLEN','SALESMAN',30);

--외부키
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
    --deptno number(2) REFERENCES dept_fk(deptno) /이렇게 써도 된다
);

insert into dept_fk values (10,'개발','서울');
insert into dept_fk values (20,'개발2','제주');
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
    --deptno number(2) REFERENCES dept_fk(deptno) /이렇게 써도 된다
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
    --deptno number(2) REFERENCES dept_fk(deptno) /이렇게 써도 된다
);

delete from dept_fk where deptno = 20;

--제약조건 check 조건에 해당해야지 값으로 받을 수 있음 
create table tbl_chk(
    id varchar(20) CONSTRAINT tbl_chk_id_pk primary key,
    pw varchar(20) CONSTRAINT tbl_chk_pw_pk check(length(pw)>3),
    gender char(1) check(gender in ('M','F'))
);

insert into tbl_chk values ('test1','1234','M');
select * from tbl_chk;
insert into tbl_chk values('test2','1111','F');











































