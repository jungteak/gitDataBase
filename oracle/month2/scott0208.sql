--select �÷���|* 
--from ���̺� 
--where ���� 
--group by �÷��� 
--having �׷�����
--order by �÷��� asc|desc;
--
--insert into ���̺�� (�÷���,�÷���...) values (��,��.....)
--
--desc ���̺��; -- ���̺��� �÷� ���� Ȯ��
--insert into ���̺�� values(��,��,��.....);
--
--update ���̺�� set �÷��� = ������, �÷��� = ������ where ����;
--
--delete from ���̺�� where ����;

--pl/sql
--%rowtype�� ����� �� begin������ select �÷��� into ������ from ���̺�� into ���� ����ؾ� �ϰ�
--into���� select�� ���� �������� ����ȴ�.
--pl/sql�� ����ϱ� ���� on ������� / sql developer �� ������ ���� �� ��� ��
set serveroutput on;

DECLARE
    v_dept_row dept%rowtype;
BEGIN
    select deptno, dname, loc 
       into v_dept_row 
    from dept where deptno = 40;
    DBMS_OUTPUT.PUT_LINE('�μ���ȣ : '|| v_dept_row.deptno);
    DBMS_OUTPUT.PUT_LINE('�μ��� : '|| v_dept_row.dname);
    DBMS_OUTPUT.PUT_LINE('�ٹ��� : '|| v_dept_row.loc); 
END;
/

--���� ���
--if ���ǹ�
--if-then / if-then-else / if-then-elseif

--if ���ǽ� then ���� ��ɾ�;
--else ���� ��ɾ�;
--end if;

--if ���ǽ� then ���� ��ɾ�;
--elsif ���ǽ� ���� ��ɾ�;
--else ���� ��ɾ�
--end if;

--Ȧ�� ¦�� �Ǵ�

declare
    v_num number := 8;    
begin
    if mod(v_num,2) = 1 then dbms_output.put_line(v_num||'�� Ȧ���Դϴ�.');
    else dbms_output.put_line(v_num||'�� ¦���Դϴ�.');
    end if;
end;
/

DECLARE
   V_SCORE NUMBER := 87;
BEGIN
   IF V_SCORE >= 90 THEN
      DBMS_OUTPUT.PUT_LINE('A����');
   ELSIF V_SCORE >= 80 THEN
      DBMS_OUTPUT.PUT_LINE('B����');
   ELSIF V_SCORE >= 70 THEN
      DBMS_OUTPUT.PUT_LINE('C����');
   ELSIF V_SCORE >= 60 THEN
      DBMS_OUTPUT.PUT_LINE('D����');
   ELSE
      DBMS_OUTPUT.PUT_LINE('F����');
   END IF;
END;
/

--�ݺ� ���
--�⺻ loop
--while loop
--for loop
--cusor for loop

--�ݺ� ���� ����
--exit
--exit when
--continue/contunue-when >> �� �ȽἭ �ȹ��

--loop �ݺ������۾� 
--end loop;
--exit ��� �ݺ� ����
--exit when ���� ���ǽ� ���

--while ���ǽ� loop �ݺ������۾�; 
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

--for i in ���� �� .. ���� �� loop �ݺ� ���� �۾�;
--end loop;
--for i in reverse ~~~  >> ���� for���� �ݴ�� ����� ����� ex) 01234 >> 43210 �̷���
begin
    for i in reverse 0..4 loop
    dbms_output.put_line(i);
    end loop;
end;
/

DECLARE
VDEPT DEPT%ROWTYPE; BEGIN
DBMS_OUTPUT.PUT_LINE('�μ���ȣ / �μ��� / ������'); 
DBMS_OUTPUT.PUT_LINE('--------------------------'); -- ���� CNT�� 1���� 1�� �����ϴٰ� 4�� �����ϸ� �ݺ������� �����.
FOR CNT IN 1..4 LOOP
SELECT * INTO VDEPT FROM DEPT WHERE DEPTNO=10*CNT;
DBMS_OUTPUT.PUT_LINE(VDEPT.DEPTNO || ' / ' || VDEPT.DNAME  || ' / ' || VDEPT.LOC); 
END LOOP; END;
/


--���ڵ�� �÷���

--���ڵ� >> �ڷ����� �ٸ� �����͵��� �ϳ��� ������ ����
--type ���ڵ� �̸� is record(
--    �����̸� �ڷ��� not null := �� �Ǵ� ���� ����Ǵ� ǥ���� or default
--)

declare
    type rec_dept is record(
        dname dept.dname%type,
        loc dept.loc%type
    );
    dept_r rec_dept; -- �̷��� ���
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
    dept_r rec_dept; -- �̷��� ���
begin
    select dname,loc into dept_r from dept_record where deptno = 10;
    dbms_output.put_line(dept_r.dname);
    dbms_output.put_line(dept_r.loc);
end;
/

--record Ȱ���� insert
declare
    type rec_dept is record(
        deptno number(2) := 99,
        dname dept.dname%type,
        loc dept.loc%type
    );
    dept_r rec_dept; -- �̷��� ���
begin
    dept_r.dname := '����1';
    dept_r.loc := '����';
    
    insert into dept_record values dept_r;
    
end;
/

select * from dept_record;

--record�� Ȱ���� update
declare
    type rec_dept is record(
        deptno number(2) := 99,
        dname dept.dname%type,
        loc dept.loc%type
    );
    dept_r rec_dept; -- �̷��� ���
begin
    dept_r.deptno := 50;
    dept_r.dname := 'DB����';
    dept_r.loc := '����';
    update dept_record set row = dept_r where deptno = 99; 
    --�̷��� row ����� update�� ������ ����� �� �ִ� pl/sql�� �ȿ����� ��� �� �� �ִ�
end;
/

select * from dept_record;

--��ø ���ڵ� (���ڵ� �ȿ� ���ڵ�)

DECLARE
   TYPE REC_DEPT IS RECORD(
      deptno DEPT.DEPTNO%TYPE,
      dname DEPT.DNAME%TYPE,
      loc DEPT.LOC%TYPE
   );
   TYPE REC_EMP IS RECORD(
      empno EMP.EMPNO%TYPE,
      ename EMP.ENAME%TYPE,
      dinfo REC_DEPT --��ø���ڵ�
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


--�÷���

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

--�÷��� �Լ���
DECLARE
   TYPE ITAB_EX IS TABLE OF VARCHAR2(20)
      INDEX BY PLS_INTEGER;

   text_arr ITAB_EX;

BEGIN
   text_arr(1) := '1st data';
   text_arr(2) := '2nd data';
   text_arr(3) := '3rd data';
   text_arr(50) := '50th data';
--4~49�� ������ ���� ����...
   DBMS_OUTPUT.PUT_LINE('text_arr.COUNT : ' || text_arr.COUNT);
   DBMS_OUTPUT.PUT_LINE('text_arr.FIRST : ' || text_arr.FIRST);
   DBMS_OUTPUT.PUT_LINE('text_arr.LAST : ' || text_arr.LAST);
   
   DBMS_OUTPUT.PUT_LINE('text_arr.PRIOR(50) : ' || text_arr.PRIOR(50));
   DBMS_OUTPUT.PUT_LINE('text_arr.NEXT(50) : ' || text_arr.NEXT(50));
END;
/


--Ŀ��
--sql���� ���� ���� �� �ش� sql�� ó�� ���� ����
--select���� ��� �� ���� Ư�� �۾� ����

--����� Ŀ�� ����
--declare
--cursor Ŀ���̸� is sql��; >> Ŀ�� ����
--begin
--open Ŀ���̸�; >> Ŀ�� ����
--fetch Ŀ���̸� into ���� >>Ŀ���κ��� �о�� ������ ���
--close Ŀ���̸�;  >> Ŀ�� �ݱ�
--end;

--������ Ŀ��
--sql%notfound
--sql%found
--sql%rowcount
--sql%isopen


--����� Ŀ�� ����
DECLARE
   -- Ŀ�� �����͸� �Է��� ���� ����
   V_DEPT_ROW DEPT%ROWTYPE;

   -- ����� Ŀ�� ����(Declaration)
   CURSOR c1 IS
      SELECT DEPTNO, DNAME, LOC
        FROM DEPT;

BEGIN
   -- Ŀ�� ����(Open)
   OPEN c1;

   LOOP
      -- Ŀ���κ��� �о�� ������ ���(Fetch)
      FETCH c1 INTO V_DEPT_ROW;

      -- Ŀ���� ��� ���� �о���� ���� %NOTFOUND �Ӽ� ����
      EXIT WHEN c1%NOTFOUND;
      
 DBMS_OUTPUT.PUT_LINE('DEPTNO : ' || V_DEPT_ROW.DEPTNO
                        || ', DNAME : ' || V_DEPT_ROW.DNAME
                        || ', LOC : ' || V_DEPT_ROW.LOC);
   END LOOP;

   -- Ŀ�� �ݱ�(Close)
   CLOSE c1;

END;
/

--������ Ŀ�� ���
declare
    cursor c1 is select * from emp;
begin
    for c1_rec in c1 loop 
    dbms_output.put_line('�����ȣ : '||c1_rec.empno||' ����̸� : '||c1_rec.ename);
    end loop;
end;
/

--���� ó��
declare
    v_wrong number;
begin
    select dname into v_wrong from dept where deptno = 10;
    DBMS_OUTPUT.PUT_LINE('���ܰ� �߻��ϸ� ���� ������ ������� �ʽ��ϴ�');
    --���� �߻� �� �� ���� ������ ������� �ʴ´�
    exception
        when value_error then  DBMS_OUTPUT.PUT_LINE('���� ó�� : ��ġ �Ǵ� �� ���� �߻�');
end;
/


--�̸����� ���� ��� ����) ora-06052
DECLARE
    v_wrong number;
    number_format EXCEPTION;
    PRAGMA EXCEPTION_INIT(number_format, -6502);
BEGIN
  select dname into v_wrong from dept where deptno = 10; 
  DBMS_OUTPUT.PUT_LINE('���ܰ� �߻��ϸ� ���� ������ ������� �ʽ��ϴ�');
EXCEPTION
    when number_format then
        DBMS_OUTPUT.PUT_LINE('���� ó�� : ��ġ �Ǵ� �� ���� �߻�');
END;
/

--�� �ٸ� ��ġ ���� ����
DECLARE
   v_wrong NUMBER;
BEGIN
   SELECT DNAME INTO v_wrong
     FROM DEPT
    WHERE DEPTNO = 10;

   DBMS_OUTPUT.PUT_LINE('���ܰ� �߻��ϸ� ���� ������ ������� �ʽ��ϴ�');

EXCEPTION
   WHEN OTHERS THEN
      DBMS_OUTPUT.PUT_LINE('���� ó�� : ���� ���� �� ���� �߻�');
      DBMS_OUTPUT.PUT_LINE('SQLCODE : ' || TO_CHAR(SQLCODE));
      DBMS_OUTPUT.PUT_LINE('SQLERRM : ' || SQLERRM);
END;
/

--���� �������α׷�
--���� ���ν��� / ���� �Լ� / ��Ű�� / Ʈ����

--���ν���
--�Ķ���� >> ���� �޴� ��
--�Ķ���͸� ������� �ʴ� ���ν��� (���޹޴� ���� ���� ���ν���)
--create [or replace] procedure ���ν��� �̸�
-- is || as �����
--begin �����
--exception ����ó����
--end [���ν��� �̸�];

create or replace procedure pro_noparam
is  v_empno number(4) := 7788;
    v_ename varchar2(10);
begin v_ename := 'SCOTT';
        dbms_output.put_line('v_empno : '||v_empno);
        dbms_output.put_line('v_ename : '||v_ename);
end;
/

--�Ķ���ʹ� excute��ɾ�� ����Ѵ� >> exec�� �ٿ����� ��밡��
exec pro_noparam;
execute pro_noparam;

SELECT * FROM USER_SOURCE WHERE NAME = 'PRO_NOPARAM';

--���ν��� ������ drop
drop procedure pro_noparam;


--�Ķ���͸� ����ϴ� ���ν���
--create [or replace] procedure ���ν��� �̸�
--[(�Ķ���� �̸�1 [modes] �ڷ��� [ := or default �⺻��],
--[(�Ķ���� �̸�n [modes] �ڷ��� [ := or default �⺻��]
--)]
-- is || as �����
--begin �����
--exception ����ó����
--end [���ν��� �̸�];

--modes >> in(�⺻��),out,inout 3����

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

execute pro_param_in(1,2);--�Ű������� ���� �Է¾��ϸ� �⺻���� ��� �ǳ׿�... ��

execute pro_param_in(1);--�Ű������� �Է� �ȵǰ� �⺻�� ������ �� �Ǿ� ������ �������ϴ�

execute pro_param_in(p2 => 30, p1 => 40); --�̷��� �Ű������� ����ؼ� ���� �ٸ��� �Ű����� ���� �Է� �� �� �ִ�.

--�����ȣ �Է½� ����� ���� ����ϴ� ���ν���
create or replace procedure empinfo(
    v_empno in emp.empno%type)
is 
    v_emp emp%rowtype;
begin
    select * into v_emp from emp where empno = v_empno;
    dbms_output.put_line('�����ȣ : '||v_emp.empno);
    dbms_output.put_line('����̸� : '||v_emp.ename);
    dbms_output.put_line('�����å : '||v_emp.job);
    dbms_output.put_line('�μ���ȣ : '||v_emp.deptno);
exception when no_data_found then
    dbms_output.put_line(v_empno ||' : �ش� ��� ����');
end;
/

execute empinfo(7788);

--�μ���ȣ �Է½� �ش� �μ��� �����ȣ�� �̸��� ���
create or replace procedure empinfo_1(
    v_deptno emp.deptno%type)
is
    v_emp emp%rowtype;
    cursor c1 is select * from emp where deptno = v_deptno;
begin
    dbms_output.put_line('�����ȣ / ����̸�');
    dbms_output.put_line('---------------');
    for v_emp in c1 loop
        dbms_output.put_line(v_emp.empno||' / '||v_emp.ename);
    end loop;
end;
/

execute empinfo_1(30);

--out ����
--�����ȣ in �ް� ename , sal ��� >> out�� ������ ��� �� �ִ� ���� �ƴ� �ٸ� ������ ���� �� �δ� �뵵!
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

--inout mode ����
--���ڸ� �Է¹޾� 2���� ���� ��ȯ�ϴ� ����
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

--�Լ�
--create [or replace] function �Լ��̸�
--[(  �Ķ���� �̸�1 [in] �ڷ���1,
--    �Ķ���� �̸�n [in] �ڷ���n,
--)]
--return �ڷ���
--is | as �����
--begin  �����
--return (��ȯ ��);
--exception ����ó����
--end [�Լ��̸�];

create or replace function func_tax(
    pay number )
return number
is tax number := 0.05;
begin return round(pay * tax);
end;
/
--�Լ��� �Ϲ� select�������� ��� ����
select func_tax(3000) from dual;
select empno,ename,sal,func_tax(sal) from emp;

DECLARE
   tax NUMBER;
BEGIN
   tax := func_tax(3000);
   DBMS_OUTPUT.PUT_LINE('tax : ' || tax);
END;
/

--�μ���ȣ�� �Է��ϸ� �μ��� �̸��� ��ȯ�ϴ� �Լ� ����
create or replace function func01(
    in_deptno dept.deptno%type
)
return dept.dname%type --varchar2 �� �ᵵ ��
is 
out_dname dept.dname%type;
begin
select dname into out_dname from dept where deptno = in_deptno;
return out_dname;
end;
/

select empno,ename,func01(deptno) �μ��� from emp;



--��Ű�� >> �ڹٿ��� �������̽��� ����ϴ�~
--���� ���� ��ǰ� ���ν����� ����� // ���� ������� �ʴ´� �׷��� ���� ��
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



--Ʈ���� �١�
--�̺�Ʈ �߻��� (insert,update,delete)  �ڵ� ����� ��� ����

--create [or replace] trigger Ʈ�����̸�
--before | after
--insert | update | delete on ���̺� �̸�
--referencing old as old | new as new >> old�� new �տ� :�� �پ��־���Ѵ�.
--for each row when ���ǽ�
--follows Ʈ�����̸�2, Ʈ�����̸�n ...
--enable | disable
--
--declare �����
--begin �����
--exception ���� ó����
--end;

create table emp01(
    empno number(4) primary key,
    ename varchar2(20),
    job varchar2(20)
);

create or replace trigger trg01
after insert on emp01
begin
    dbms_output.put_line('���Ի���� �Ի��߽��ϴ�');
end;
/

insert into emp01 values(1,'JAVAKIM','���α׷���');

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

insert into emp01 values (2,'oraclekim','�����̳�');
insert into emp01 values (3,'sunkim','������');

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

--trigger ����
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

INSERT INTO product(code, name, company, price) VALUES('A00001','��Ź��', 'LG', 500); 
INSERT INTO product(code, name, company, price) VALUES('A00002','��ǻ��', 'LG', 700);
INSERT INTO product(code, name, company, price) VALUES('A00003','�����', '�Ｚ', 600);

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






















































































































































