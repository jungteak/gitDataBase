--select 컬럼명|* 
--from 테이블 
--where 조건 
--group by 컬럼명 
--having 그룹조건
--order by 컬럼명 asc|desc;
--
--insert into 테이블명 (컬럼명,컬럼명...) values (값,값.....)
--
--desc 테이블명; -- 테이블의 컬럼 순서 확인
--insert into 테이블명 values(값,값,값.....);
--
--update 테이블명 set 컬럼명 = 수정값, 컬럼명 = 수정값 where 조건;
--
--delete from 테이블명 where 조건;

--pl/sql
--%rowtype을 사용할 때 begin절에서 select 컬럼명 into 변수명 from 테이블명 into 절을 사용해야 하고
--into절은 select문 가장 마지막에 실행된다.
--pl/sql문 사용하기 위해 on 해줘야함 / sql developer 켤 때마다 설정 해 줘야 함
set serveroutput on;

DECLARE
    v_dept_row dept%rowtype;
BEGIN
    select deptno, dname, loc 
       into v_dept_row 
    from dept where deptno = 40;
    DBMS_OUTPUT.PUT_LINE('부서번호 : '|| v_dept_row.deptno);
    DBMS_OUTPUT.PUT_LINE('부서명 : '|| v_dept_row.dname);
    DBMS_OUTPUT.PUT_LINE('근무지 : '|| v_dept_row.loc); 
END;
/

--조건 제어문
--if 조건문
--if-then / if-then-else / if-then-elseif

--if 조건식 then 수행 명령어;
--else 수행 명령어;
--end if;

--if 조건식 then 수행 명령어;
--elsif 조건식 수행 명령어;
--else 수행 명령어
--end if;

--홀수 짝수 판단

declare
    v_num number := 8;    
begin
    if mod(v_num,2) = 1 then dbms_output.put_line(v_num||'은 홀수입니다.');
    else dbms_output.put_line(v_num||'은 짝수입니다.');
    end if;
end;
/

DECLARE
   V_SCORE NUMBER := 87;
BEGIN
   IF V_SCORE >= 90 THEN
      DBMS_OUTPUT.PUT_LINE('A학점');
   ELSIF V_SCORE >= 80 THEN
      DBMS_OUTPUT.PUT_LINE('B학점');
   ELSIF V_SCORE >= 70 THEN
      DBMS_OUTPUT.PUT_LINE('C학점');
   ELSIF V_SCORE >= 60 THEN
      DBMS_OUTPUT.PUT_LINE('D학점');
   ELSE
      DBMS_OUTPUT.PUT_LINE('F학점');
   END IF;
END;
/

--반복 제어문
--기본 loop
--while loop
--for loop
--cusor for loop

--반복 수행 제어
--exit
--exit when
--continue/contunue-when >> 잘 안써서 안배움

--loop 반복수행작업 
--end loop;
--exit 즉시 반복 종료
--exit when 종료 조건식 사용

--while 조건식 loop 반복수행작업; 
--end loop;

--loop
declare 
    v_cnt number := 1;
    v_str varchar2(10) := null;
begin
    loop 
    v_str := v_str||'*'; 
    v_cnt := v_cnt + 1;
    dbms_output.put_line(v_str);
    exit when v_cnt > 5;
    end loop;
end;
/
--while loop
declare 
    v_cnt number := 1;
    v_str varchar2(10) := null;
begin
    while v_cnt <= 5 loop 
    v_str := v_str||'*'; 
    v_cnt := v_cnt + 1;
    dbms_output.put_line(v_str);
    end loop;
end;
/

--for i in 시작 값 .. 종료 값 loop 반복 수행 작업;
--end loop;
--for i in reverse ~~~  >> 위의 for문과 반대로 결과를 출력함 ex) 01234 >> 43210 이렇게
begin
    for i in reverse 0..4 loop
    dbms_output.put_line(i);
    end loop;
end;
/

DECLARE
VDEPT DEPT%ROWTYPE; BEGIN
DBMS_OUTPUT.PUT_LINE('부서번호 / 부서명 / 지역명'); 
DBMS_OUTPUT.PUT_LINE('--------------------------'); -- 변수 CNT는 1부터 1씩 증가하다가 4에 도달하면 반복문에서 벗어난다.
FOR CNT IN 1..4 LOOP
SELECT * INTO VDEPT FROM DEPT WHERE DEPTNO=10*CNT;
DBMS_OUTPUT.PUT_LINE(VDEPT.DEPTNO || ' / ' || VDEPT.DNAME  || ' / ' || VDEPT.LOC); 
END LOOP; END;
/


--레코드와 컬렉션

--레코드 >> 자료형이 다른 데이터들을 하나의 변수에 저장
--type 레코드 이름 is record(
--    변수이름 자료형 not null := 값 또는 값이 도출되는 표현식 or default
--)

declare
    type rec_dept is record(
        dname dept.dname%type,
        loc dept.loc%type
    );
    dept_r rec_dept; -- 이렇게 사용
begin
    dept_r.dname := 'DATABASE';
    dept_r.loc := 'SEOUL';
    dbms_output.put_line(dept_r.dname);
    dbms_output.put_line(dept_r.loc);
end;
/

create table dept_record as select * from dept;
select * from dept_record;

declare
    type rec_dept is record(
        dname dept.dname%type,
        loc dept.loc%type
    );
    dept_r rec_dept; -- 이렇게 사용
begin
    select dname,loc into dept_r from dept_record where deptno = 10;
    dbms_output.put_line(dept_r.dname);
    dbms_output.put_line(dept_r.loc);
end;
/

--record 활용한 insert
declare
    type rec_dept is record(
        deptno number(2) := 99,
        dname dept.dname%type,
        loc dept.loc%type
    );
    dept_r rec_dept; -- 이렇게 사용
begin
    dept_r.dname := '개발1';
    dept_r.loc := '제주';
    
    insert into dept_record values dept_r;
    
end;
/

select * from dept_record;

--record를 활용한 update
declare
    type rec_dept is record(
        deptno number(2) := 99,
        dname dept.dname%type,
        loc dept.loc%type
    );
    dept_r rec_dept; -- 이렇게 사용
begin
    dept_r.deptno := 50;
    dept_r.dname := 'DB관리';
    dept_r.loc := '전주';
    update dept_record set row = dept_r where deptno = 99; 
    --이렇게 row 사용한 update는 변수를 사용할 수 있는 pl/sql문 안에서만 사용 할 수 있다
end;
/

select * from dept_record;

--중첩 레코드 (레코드 안에 레코드)

DECLARE
   TYPE REC_DEPT IS RECORD(
      deptno DEPT.DEPTNO%TYPE,
      dname DEPT.DNAME%TYPE,
      loc DEPT.LOC%TYPE
   );
   TYPE REC_EMP IS RECORD(
      empno EMP.EMPNO%TYPE,
      ename EMP.ENAME%TYPE,
      dinfo REC_DEPT --중첩레코드
   );
   emp_rec REC_EMP;
BEGIN
   SELECT E.EMPNO, E.ENAME, D.DEPTNO, D.DNAME, D.LOC
     INTO emp_rec.empno, emp_rec.ename,
          emp_rec.dinfo.deptno,
          emp_rec.dinfo.dname,
          emp_rec.dinfo.loc
     FROM EMP E, DEPT D
    WHERE E.DEPTNO = D.DEPTNO
 AND E.EMPNO = 7788;

   DBMS_OUTPUT.PUT_LINE('EMPNO : ' || emp_rec.empno);
   DBMS_OUTPUT.PUT_LINE('ENAME : ' || emp_rec.ename);
   DBMS_OUTPUT.PUT_LINE('DEPTNO : ' || emp_rec.dinfo.deptno);
   DBMS_OUTPUT.PUT_LINE('DNAME : ' || emp_rec.dinfo.dname);
   DBMS_OUTPUT.PUT_LINE('LOC : ' || emp_rec.dinfo.loc);
END;
/


--컬렉션

declare
    type itab_ex is table of varchar2(20)
    index by pls_integer;
    text_arr itab_ex;
begin
    text_arr(1) := 'frist';
    text_arr(2) := 'second';
    text_arr(3) := 'third';
    text_arr(4) := 'fourth';
    
    for i in 1..4 loop dbms_output.put_line(text_arr(i));
    end loop;
end;
/

DECLARE
   TYPE ITAB_DEPT IS TABLE OF DEPT%ROWTYPE
      INDEX BY PLS_INTEGER;
   dept_arr ITAB_DEPT;
   idx PLS_INTEGER := 0;

BEGIN
   FOR i IN(SELECT * FROM DEPT) LOOP
      idx := idx + 1;
      dept_arr(idx).deptno := i.DEPTNO;
      dept_arr(idx).dname := i.DNAME;
      dept_arr(idx).loc := i.LOC;

      DBMS_OUTPUT.PUT_LINE(
      dept_arr(idx).deptno || ' : ' ||
      dept_arr(idx).dname || ' : ' ||
      dept_arr(idx).loc);
   END LOOP;
END;
/

--컬렉션 함수들
DECLARE
   TYPE ITAB_EX IS TABLE OF VARCHAR2(20)
      INDEX BY PLS_INTEGER;

   text_arr ITAB_EX;

BEGIN
   text_arr(1) := '1st data';
   text_arr(2) := '2nd data';
   text_arr(3) := '3rd data';
   text_arr(50) := '50th data';
--4~49번 데이터 값은 없다...
   DBMS_OUTPUT.PUT_LINE('text_arr.COUNT : ' || text_arr.COUNT);
   DBMS_OUTPUT.PUT_LINE('text_arr.FIRST : ' || text_arr.FIRST);
   DBMS_OUTPUT.PUT_LINE('text_arr.LAST : ' || text_arr.LAST);
   
   DBMS_OUTPUT.PUT_LINE('text_arr.PRIOR(50) : ' || text_arr.PRIOR(50));
   DBMS_OUTPUT.PUT_LINE('text_arr.NEXT(50) : ' || text_arr.NEXT(50));
END;
/


--커서
--sql문을 실행 했을 때 해당 sql문 처리 정보 저장
--select문의 결과 행 별로 특정 작업 수행

--명시적 커서 선언
--declare
--cursor 커서이름 is sql문; >> 커서 선언
--begin
--open 커서이름; >> 커서 열기
--fetch 커서이름 into 변수 >>커서로부터 읽어온 데이터 사용
--close 커서이름;  >> 커서 닫기
--end;

--묵시적 커서
--sql%notfound
--sql%found
--sql%rowcount
--sql%isopen


--명시적 커서 선언
DECLARE
   -- 커서 데이터를 입력할 변수 선언
   V_DEPT_ROW DEPT%ROWTYPE;

   -- 명시적 커서 선언(Declaration)
   CURSOR c1 IS
      SELECT DEPTNO, DNAME, LOC
        FROM DEPT;

BEGIN
   -- 커서 열기(Open)
   OPEN c1;

   LOOP
      -- 커서로부터 읽어온 데이터 사용(Fetch)
      FETCH c1 INTO V_DEPT_ROW;

      -- 커서의 모든 행을 읽어오기 위해 %NOTFOUND 속성 지정
      EXIT WHEN c1%NOTFOUND;
      
 DBMS_OUTPUT.PUT_LINE('DEPTNO : ' || V_DEPT_ROW.DEPTNO
                        || ', DNAME : ' || V_DEPT_ROW.DNAME
                        || ', LOC : ' || V_DEPT_ROW.LOC);
   END LOOP;

   -- 커서 닫기(Close)
   CLOSE c1;

END;
/

--묵시적 커서 사용
declare
    cursor c1 is select * from emp;
begin
    for c1_rec in c1 loop 
    dbms_output.put_line('사원번호 : '||c1_rec.empno||' 사원이름 : '||c1_rec.ename);
    end loop;
end;
/

--예외 처리
declare
    v_wrong number;
begin
    select dname into v_wrong from dept where deptno = 10;
    DBMS_OUTPUT.PUT_LINE('예외가 발생하면 다음 문장은 실행되지 않습니다');
    --예외 발생 이 후 다음 문장은 실행되지 않는다
    exception
        when value_error then  DBMS_OUTPUT.PUT_LINE('예외 처리 : 수치 또는 값 오류 발생');
end;
/


--이름없는 예외 사용 예시) ora-06052
DECLARE
    v_wrong number;
    number_format EXCEPTION;
    PRAGMA EXCEPTION_INIT(number_format, -6502);
BEGIN
  select dname into v_wrong from dept where deptno = 10; 
  DBMS_OUTPUT.PUT_LINE('예외가 발생하면 다음 문장은 실행되지 않습니다');
EXCEPTION
    when number_format then
        DBMS_OUTPUT.PUT_LINE('예외 처리 : 수치 또는 값 오류 발생');
END;
/

--별 다른 조치 없이 종료
DECLARE
   v_wrong NUMBER;
BEGIN
   SELECT DNAME INTO v_wrong
     FROM DEPT
    WHERE DEPTNO = 10;

   DBMS_OUTPUT.PUT_LINE('예외가 발생하면 다음 문장은 실행되지 않습니다');

EXCEPTION
   WHEN OTHERS THEN
      DBMS_OUTPUT.PUT_LINE('예외 처리 : 사전 정의 외 오류 발생');
      DBMS_OUTPUT.PUT_LINE('SQLCODE : ' || TO_CHAR(SQLCODE));
      DBMS_OUTPUT.PUT_LINE('SQLERRM : ' || SQLERRM);
END;
/

--저장 서브프로그램
--저장 프로시저 / 저장 함수 / 패키지 / 트리거

--프로시저
--파라미터 >> 전달 받는 값
--파라미터를 사용하지 않는 프로시저 (전달받는 값이 없는 프로시저)
--create [or replace] procedure 프로시저 이름
-- is || as 선언부
--begin 실행부
--exception 예외처리부
--end [프로시저 이름];

create or replace procedure pro_noparam
is  v_empno number(4) := 7788;
    v_ename varchar2(10);
begin v_ename := 'SCOTT';
        dbms_output.put_line('v_empno : '||v_empno);
        dbms_output.put_line('v_ename : '||v_ename);
end;
/

--파라미터는 excute명령어로 사용한다 >> exec로 줄여서도 사용가능
exec pro_noparam;
execute pro_noparam;

SELECT * FROM USER_SOURCE WHERE NAME = 'PRO_NOPARAM';

--프로시저 삭제는 drop
drop procedure pro_noparam;


--파라미터를 사용하는 프로시저
--create [or replace] procedure 프로시저 이름
--[(파라미터 이름1 [modes] 자료형 [ := or default 기본값],
--[(파라미터 이름n [modes] 자료형 [ := or default 기본값]
--)]
-- is || as 선언부
--begin 실행부
--exception 예외처리부
--end [프로시저 이름];

--modes >> in(기본값),out,inout 3가지

create or replace procedure pro_param_in
(   p1 in number,
    p2 number,
    p3 number := 3,
    p4 number default 4
)
is begin
    dbms_output.put_line('p1 : '|| p1);
    dbms_output.put_line('p2 : '|| p2);
    dbms_output.put_line('p3 : '|| p3);
    dbms_output.put_line('p4 : '|| p4);
end;
/

execute pro_param_in(1,2,9,8);

execute pro_param_in(1,2);--매개변수에 따로 입력안하면 기본값이 출력 되네요... ㅎ

execute pro_param_in(1);--매개변수에 입력 안되고 기본값 설정도 안 되어 있으면 오류납니다

execute pro_param_in(p2 => 30, p1 => 40); --이렇게 매개변수를 명시해서 순서 다르게 매개변수 값을 입력 할 수 있다.

--사원번호 입력시 사원의 정보 출력하는 프로시저
create or replace procedure empinfo(
    v_empno in emp.empno%type)
is 
    v_emp emp%rowtype;
begin
    select * into v_emp from emp where empno = v_empno;
    dbms_output.put_line('사원번호 : '||v_emp.empno);
    dbms_output.put_line('사원이름 : '||v_emp.ename);
    dbms_output.put_line('사원직책 : '||v_emp.job);
    dbms_output.put_line('부서번호 : '||v_emp.deptno);
exception when no_data_found then
    dbms_output.put_line(v_empno ||' : 해당 사원 없음');
end;
/

execute empinfo(7788);

--부서번호 입력시 해당 부서의 사원번호와 이름을 출력
create or replace procedure empinfo_1(
    v_deptno emp.deptno%type)
is
    v_emp emp%rowtype;
    cursor c1 is select * from emp where deptno = v_deptno;
begin
    dbms_output.put_line('사원번호 / 사원이름');
    dbms_output.put_line('---------------');
    for v_emp in c1 loop
        dbms_output.put_line(v_emp.empno||' / '||v_emp.ename);
    end loop;
end;
/

execute empinfo_1(30);

--out 사용법
--사원번호 in 받고 ename , sal 출력 >> out은 실제로 출력 해 주는 것이 아닌 다른 변수에 저장 해 두는 용도!
CREATE OR REPLACE PROCEDURE pro_param_out
(
   in_empno IN EMP.EMPNO%TYPE,
   out_ename OUT EMP.ENAME%TYPE,
   out_sal OUT EMP.SAL%TYPE
)
IS

BEGIN
   SELECT ENAME, SAL INTO out_ename, out_sal
     FROM EMP
    WHERE EMPNO = in_empno;
END pro_param_out;
/

DECLARE
   v_ename EMP.ENAME%TYPE;
   v_sal EMP.SAL%TYPE;
BEGIN
   pro_param_out(7788, v_ename, v_sal);
   DBMS_OUTPUT.PUT_LINE('ENAME : ' || v_ename);
   DBMS_OUTPUT.PUT_LINE('SAL : ' || v_sal);
END;
/

--inout mode 사용법
--숫자를 입력받아 2배의 값을 반환하는 예제
CREATE OR REPLACE PROCEDURE pro_param_inout
(
   inout_no IN OUT NUMBER
)
IS

BEGIN
   inout_no := inout_no * 2;
END pro_param_inout;
/
DECLARE
   no NUMBER;
BEGIN
   no := 5;
   pro_param_inout(no);
   DBMS_OUTPUT.PUT_LINE('no : ' || no);
END;
/

--함수
--create [or replace] function 함수이름
--[(  파라미터 이름1 [in] 자료형1,
--    파라미터 이름n [in] 자료형n,
--)]
--return 자료형
--is | as 선언부
--begin  실행부
--return (반환 값);
--exception 예외처리부
--end [함수이름];

create or replace function func_tax(
    pay number )
return number
is tax number := 0.05;
begin return round(pay * tax);
end;
/
--함수는 일반 select문에서도 사용 가능
select func_tax(3000) from dual;
select empno,ename,sal,func_tax(sal) from emp;

DECLARE
   tax NUMBER;
BEGIN
   tax := func_tax(3000);
   DBMS_OUTPUT.PUT_LINE('tax : ' || tax);
END;
/

--부서번호를 입력하면 부서의 이름을 반환하는 함수 생성
create or replace function func01(
    in_deptno dept.deptno%type
)
return dept.dname%type --varchar2 로 써도 됨
is 
out_dname dept.dname%type;
begin
select dname into out_dname from dept where deptno = in_deptno;
return out_dname;
end;
/

select empno,ename,func01(deptno) 부서명 from emp;



--패키지 >> 자바에서 인터페이스와 비슷하다~
--여러 개의 펑션과 프로시저를 묶어둠 // 보통 사용하지 않는다 그래서 몰라도 됨
CREATE OR REPLACE PACKAGE pkg_example
IS
   spec_no NUMBER := 10;
   FUNCTION func_aftertax(sal NUMBER) RETURN NUMBER;
   PROCEDURE pro_emp(in_empno IN EMP.EMPNO%TYPE);
   PROCEDURE pro_dept(in_deptno IN DEPT.DEPTNO%TYPE);
END;
/

CREATE OR REPLACE PACKAGE BODY pkg_example
IS
   body_no NUMBER := 10;

   FUNCTION func_aftertax(sal NUMBER) RETURN NUMBER
      IS
         tax NUMBER := 0.05;
      BEGIN
         RETURN (ROUND(sal - (sal * tax)));
   END func_aftertax;
PROCEDURE pro_emp(in_empno IN EMP.EMPNO%TYPE)
      IS
         out_ename EMP.ENAME%TYPE;
         out_sal EMP.SAL%TYPE;
      BEGIN
         SELECT ENAME, SAL INTO out_ename, out_sal
           FROM EMP
          WHERE EMPNO = in_empno;

         DBMS_OUTPUT.PUT_LINE('ENAME : ' || out_ename);
         DBMS_OUTPUT.PUT_LINE('SAL : ' || out_sal);
   END pro_emp;
PROCEDURE pro_dept(in_deptno IN DEPT.DEPTNO%TYPE)
   IS
      out_dname DEPT.DNAME%TYPE;
      out_loc DEPT.LOC%TYPE;
   BEGIN
      SELECT DNAME, LOC INTO out_dname, out_loc
        FROM DEPT
       WHERE DEPTNO = in_deptno;

      DBMS_OUTPUT.PUT_LINE('DNAME : ' || out_dname);
      DBMS_OUTPUT.PUT_LINE('LOC : ' || out_loc);
   END pro_dept;
END;
/



--트리거 ☆★
--이벤트 발생시 (insert,update,delete)  자동 실행될 기능 정의

--create [or replace] trigger 트리거이름
--before | after
--insert | update | delete on 테이블 이름
--referencing old as old | new as new >> old나 new 앞에 :이 붙어있어야한다.
--for each row when 조건식
--follows 트리거이름2, 트리거이름n ...
--enable | disable
--
--declare 선언부
--begin 실행부
--exception 예외 처리부
--end;

create table emp01(
    empno number(4) primary key,
    ename varchar2(20),
    job varchar2(20)
);

create or replace trigger trg01
after insert on emp01
begin
    dbms_output.put_line('신입사원이 입사했습니다');
end;
/

insert into emp01 values(1,'JAVAKIM','프로그래머');

create table sal01(
    salno number(4) primary key,
    sal number(7,2),
    empno number(4) references emp01(empno)
);

create sequence seq_sal01;

create or replace trigger trg02
after insert on emp01
for each row 
begin 
insert into sal01 values(seq_sal01.nextval, 100, :new.empno); 
end;
/

insert into emp01 values (2,'oraclekim','디자이너');
insert into emp01 values (3,'sunkim','개발자');

select * from emp01;
select * from sal01;

create or replace trigger trg03
after delete on emp01
for each row
begin
    delete from sal01 where empno = : old.empno;
end;
/

delete from emp01 where empno = 2;

--trigger 연습
CREATE TABLE product(
code CHAR(6) PRIMARY KEY,
name VARCHAR2(12) NOT NULL,
company  VARCHAR2(12),
price number,
quantity number DEFAULT 0
 );
 
CREATE TABLE warehousing(
no number PRIMARY KEY,
code  CHAR(6) REFERENCES product(code),
w_date date DEFAULT sysdate,
w_quantity number,
unit_cost number,
w_price number
);

INSERT INTO product(code, name, company, price) VALUES('A00001','세탁기', 'LG', 500); 
INSERT INTO product(code, name, company, price) VALUES('A00002','컴퓨터', 'LG', 700);
INSERT INTO product(code, name, company, price) VALUES('A00003','냉장고', '삼성', 600);

CREATE TRIGGER TRG_01
AFTER INSERT ON warehousing
FOR EACH ROW
BEGIN
UPDATE product
SET quantity = quantity + :NEW.w_quantity
WHERE code = :NEW.code;
END;
/

INSERT INTO warehousing(no,code,w_quantity,unit_cost,w_price) 
VALUES(1, 'A00001', 5, 320, 1600);
SELECT * FROM warehousing;
SELECT * FROM product;

 INSERT INTO warehousing(no, code, w_quantity, unit_cost, w_price) 
 VALUES(2, 'A00002', 10, 680, 6800);
 SELECT * FROM warehousing;
 SELECT * FROM product;
 INSERT INTO warehousing(no, code, w_quantity, unit_cost, w_price) 
 VALUES(3, 'A00003', 10, 220, 2200);
 SELECT * FROM warehousing;
 SELECT * FROM product;
 
CREATE TRIGGER TRG02
 AFTER UPDATE ON warehousing
 FOR EACH ROW
 BEGIN
 UPDATE product
 SET quantity = quantity + (-:old.w_quantity+:new.w_quantity) 
 WHERE code = :new.code;
 END;
/

UPDATE warehousing SET w_quantity=8, w_price=2200
 WHERE no=3;
 SELECT * FROM warehousing ORDER BY no;
select * from product;

CREATE TRIGGER TRG03
 AFTER DELETE ON warehousing
 FOR EACH ROW
 BEGIN
 UPDATE product
 SET quantity = quantity - :old.w_quantity WHERE code = :old.code;
 END;
 /

DELETE from warehousing WHERE no = 3;
 SELECT * FROM warehousing ORDER BY no;
 SELECT * FROM product;






















































































































































