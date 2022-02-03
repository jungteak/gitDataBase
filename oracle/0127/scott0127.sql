--�������� ���Ŀ��� null ���� ���� ���߿� �������� ���Ŀ����� ���� ����!
select comm from emp order by comm desc;

--������� ä��� �е�
select lpad('DATABASE',20,'$') from dual;
select rpad('DATABASE',20,'$') from dual;
select RPAD(substr(ename,1,2),length(ename),'*') �̸� from emp;

--Ư�����ڸ� �����ϴ� trim leading ���� traliling ������ both ���� ���� �׳ɾ��� both�� ���� ���� ����
SELECT TRIM(LEADING FROM '  ABCD  ') LT,
LENGTH(TRIM(LEADING FROM '  ABCD  ')) LT_LEN, TRIM(TRAILING FROM '  ABCD  ') RT,
LENGTH(TRIM(TRAILING FROM '  ABCD  ')) RT_LEN, TRIM(BOTH FROM '  ABCD  ') BOTH1, LENGTH(TRIM(BOTH FROM '  ABCD  ')) BOTH1, TRIM('  ABCD  ') BOTHT2,
LENGTH(TRIM('  ABCD  ')) BOTHLEN2 FROM DUAL;

--round(���,[ǥ���� �ڸ���]) ǥ���� �ڸ��� ǥ����ϸ� 0���� ó��!
select round(35.12,1),round(35.155,1),round(35.125),round(35.12,-1),round(135.12,-2) from dual;
--�����Լ� trunc
select trunc(12.345,2),trunc(12.345),trunc(12.345,-1) from dual;
--mod ������
select mod(34,2),mod(34,5),mod(34,7) from dual;

--sysdate ���� ��¥ �ð� ������
select sysdate ����, sysdate -1 ����, sysdate +1 ���� from dual;

select round(sysdate - hiredate) �ٹ��ϼ� from emp; 
 
 --��� �� ��� add_months
 --�� ��¥�� ���� �� ��� months_between
 --�Ի��Ͽ��� 10�ֳ��� �Ǵ� ��¥�� ����ϼ���
 select empno,ename,hiredate,add_months(hiredate,120) work10year from emp;
 
 select sysdate,hiredate,round(months_between(sysdate,hiredate)) from emp;
 
 --���� ������ ��¥�� �˷��ִ� �Լ� /�ݿ���/��
 select sysdate, next_day(sysdate,'��') from dual;
 
 --����� ã������ ��� �ٲ������
 alter session set nls_language = american;
 select sysdate, next_day(sysdate,'friday') from dual;
 --�ٽ��ѱ� ��alter session set nls_language = korean;
  --�̷��� ���ڷε� �� �� ���� 1(��)~7(��)
 select sysdate, next_day(sysdate,6) from dual;
   
   --���� ������ ��¥ �̴�  last_day
 select sysdate, last_day(sysdate) from dual;
   
   --round ���˸� �����ؼ� ����!
 select hiredate, round(hiredate,'MONTH') from emp where deptno = 10;
 select hiredate, trunc(hiredate,'MONTH') from emp where deptno = 10;  

--to_char ��¥>����   
   --�Ի��� ��� (���ϱ���) dy day
select to_char(hiredate,'yyyy/mon/dd dy') from emp where deptno = 20;
--��,��,�ʱ��� ��������   
select sysdate, to_char(sysdate,'yyyy/mm/dd, hh24:mi,ss') from dual;
--to_char ����>���� L�� ���� ȭ����� ǥ��
select ename, sal, to_char(sal,'L999,999') from emp where deptno = 10;
select ename, sal, to_char(sal,'$999,999') from emp where deptno = 10;

--���ڿ��� ������ ���Ŀ� ���� ���ڷ� �ٲٴ� to_number
-- select '10,000' + '20,000' from dual;  ������
select to_number('10,000','99,999') + to_number('20,000','99,999') from dual; 

--19821209�� �Ի��� ��� ���� ���
select * from emp where hiredate = to_date(19821209,'yyyymmdd');

--�� �� ��ĥ�� �������� ��¥ ���
select round(sysdate - to_date('2022/01/01','yyyy/mm/dd')) from dual;

--null ó���ϴ� nvl,nvl2
--�������ϱ� sal*12+comm
select ename,sal*12+comm ����, sal*12+nvl(comm,0) ����2 from emp; --comm �� ���̸� ���Ѱ��� �� ����;; > nvl�� ó��!
select ename,nvl2(comm,sal*12+comm,sal*12) from emp;

--��� ����� �ڽ��� ���(manager)�� �ִ�. ������ emp ���̺� �����ϰ� ����� ���� ���ڵ尡 �ִµ�
--�� ����� mgr Į������ null�̴�. �� ����� ����ϵ� mgr Į�� ���� null��� ceo�� ���!
select empno,ename,nvl(to_char(mgr),'ceo') from emp where mgr is null;
select empno,ename,nvl2(mgr,to_char(mgr),'ceo') from emp where mgr is null;

--decode(��(ǥ����),���ǽ�1,���1,���ǽ�2,���2,...,�⺻���) �⺻����� ���� �Ƚᵵ ��!(���ǽ� �� �ƴ� �� ������ ���)
select ename,deptno,decode(deptno,10,'ACCOUNTING',20,'RESEARCH',30,'SALES',40,'OPERATIONS') dname from emp;

-/*case when ����1 then ���1
            when ����2 then ���2
            when ����n then ���n
            else ���
            end */
select ename,deptno,case when deptno = 10 then 'ACCOUNTING'
            when deptno = 20 then 'RESEARCH'
            when deptno = 30 then 'SALES'
            when deptno = 40 then 'OPERATION'
            END dname
            from emp;

--���޿� ���� �޿��� �λ��ϵ��� ����(�����ȣ,�����,����,�޿�,�λ�� �޿�(up sal))
--������ 'analyst'�� ����� 5%, 'salesman'�� ����� 10%, 'manager'�� ����� 15%, 'clerk'�� ����� 20%�λ�!
select empno,ename,job,sal,case when job = 'ANALYST' then sal*1.05
            when job = 'SALESMAN' then sal*1.1
            when job = 'MANAGER' then sal*1.15
            when job = 'CLERK' then sal*1.2
            else sal end upsal
            from emp order by upsal;

--�հ踦 ���ϴ� �Լ� sum
select to_char(sum(sal),'$999,999') total from emp;
select round(avg(sal)) from emp;
select min(sal) �����޿�, max(sal) �ִ�޿� from emp;
select count(*) from emp; --��ü ���ڵ� ���� ���ϱ�
select sum(comm) from emp;
select avg(comm) from emp;
select count(comm) from emp;
--select sum(sal),sal from emp; �׷��Լ��� �׷��� ������ �Ǵ� į���� �׷��Լ��ϰ� ����ؾ� �Ѵ�.

--group by �÷��� / �ش� �÷��� ������ �ִ� ���� ���� ���ڵ峢�� �ϳ��� �׷����� ��������.
--�÷��� �׷��Լ��ϰ� ����ؾ� �Ѵ�.
select sum(sal),round(avg(sal)) from emp group by deptno;

--���� �μ����� ��� ���� Ŀ�̼��� �޴� ��� �� ���
select deptno,count(*) "�μ��� ��� ��",count(comm) as "Ŀ�̼� �޴� ��� ��" from emp group by deptno order by deptno;
--�μ����� ���� �ֱٿ� �Ի��� ����� �Ի��� ���
select deptno,max(hiredate) from emp group by deptno order by deptno;

select deptno,job,avg(sal) from emp group by deptno,job  order by deptno;

--having �׷����� 
--�ݵ�� group by �ڿ� �;� �Ѵ�.
--�׷� ���ǿ��� �׷��Լ��� ����Ѵ�.
select deptno,job,avg(sal) from emp group by deptno,job having avg(sal) > 2000 order by deptno;

SELECT DEPTNO, JOB, AVG(SAL) FROM EMP WHERE SAL >= 2000 GROUP BY DEPTNO, JOB ORDER BY DEPTNO, JOB;


select deptno, job, count(*),max(sal),sum(sal),avg(sal) from emp group by deptno,job order by deptno,job;
--������ �հ� ���ִ� rollup
select deptno, job, count(*),max(sal),sum(sal),avg(sal) from emp group by rollup(deptno,job) order by deptno,job;
--������ �հ� cube 
select deptno, job, count(*),max(sal),sum(sal),avg(sal) from emp group by cube(deptno,job) order by deptno,job;

--listagg ex
select deptno,ename from emp group by deptno,ename;
--ename�� ,�� ������ ǥ�� �� ���� �޴� ������
SELECT DEPTNO, LISTAGG(ENAME, ', ') WITHIN GROUP(ORDER BY SAL DESC) AS ENAMES FROM EMP GROUP BY DEPTNO;

--rank , dense_rank
SELECT ENAME 
     , SAL 
     , RANK() OVER (ORDER BY SAL DESC)       RANK 
     , DENSE_RANK() OVER (ORDER BY SAL DESC) DENSE_RANK 
  FROM EMP 
 ORDER BY SAL DESC;

--2.���� ��å�� ����� 3�� �̻��� ��å�� �ο� �� ���
select job ��å,count(*) �ο� from emp group by job having count(*) >= 3;
--3.�Ի�⵵�� �������� �μ����� �� �� �Ի��ߴ��� ���
select to_char(hiredate,'yyyy') �Ի�⵵,deptno �μ�,count(*) �ο��� from emp group by to_char(hiredate,'yyyy'),deptno;
--4.�߰������� �޴� ����� ���� �ʴ� ��� �� ���
select nvl2(comm,'o','x') �߰�����,count(*) �ο� from emp group by nvl2(comm,'o','x');

--join
select * from emp,dept order by empno; --ũ�ν�����
select * from emp,dept where emp.deptno = dept.deptno; --equi join : �÷��� ���� ���� ��� ����
select * from emp e, dept d where e.deptno = d.deptno; 

select * from salgrade;
select * from emp;
select e.empno,e.ename,s.grade from salgrade s, emp e where e.sal between s.losal and s.hisal;

--20�� �μ� ����� ���, �̸�, �μ����� ����ϼ���
select e.empno ���, e.ename �̸�, d.dname �μ���,e.deptno �μ���ȣ from emp e, dept d where e.deptno = d.deptno and e.deptno = 20;

-- inner join
select * from emp e inner join dept d on e.deptno = d.deptno;
-- inner join using ���
select * from emp e inner join dept d using (deptno);
--natural join
select * from emp e natural join dept d;



