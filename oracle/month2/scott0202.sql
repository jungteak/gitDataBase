--����1
--1
select empno �����ȣ, ename �̸�, sal ���� from emp where deptno = 10;
--2
select ename �̸�, hiredate �Ի���, deptno �μ���ȣ from emp where empno = 7369;
--3
select * from emp where ename = 'ALLEN';
--4
select ename �̸�,deptno �μ���ȣ,sal ���� from emp where hiredate = '83/1/12';
--5
select * from emp where not job = 'MANAGER';
--6
select * from emp where hiredate >= '81/4/2';
--7
select ename �̸�,sal �޿�, deptno �μ���ȣ from emp where sal >= 800;
--8
select * from emp where not empno between 7654 and 7782;
--9
select sal*2 ���޿� from emp where sal <= 2000;

--����2
--1
select ename �̸�, sal �޿�, sal*0.2 ���ʽ��ݾ� from emp;
--2
select ename �̸�, sal �޿�, sal*0.15 ������ from emp where sal >= 2000;
--3
select ename �̸�, sal �޿�, round(sal/12/5) �ð����ӱ� from emp where deptno = 20;
--4
select * from emp where hiredate between '81/4/2' and '82/12/9';
--5
select ename �̸�, job ����, sal �޿� from emp where sal between 1600+1 and 3000-1;
--6
select * from emp where job in ('MANAGER','SALESMAN') order by deptno,sal desc;
--7
select * from emp where not deptno in (20,30);
--8
select * from emp where hiredate between '81/1/1' and '81/12/31';
select * from emp where to_char(hiredate,'yy') = 81;
--9
select * from emp where ename like 'S___T';

--����3
--1
select * from emp where substr(hiredate,1,2) = '81';
select * from emp where to_char(hiredate,'yy') = '81';
--2
select * from emp where substr(ename,1,1) = 'S' and substr(ename,-1,1) = 'T';
--3
select substr('tester@naver.com',instr('tester@naver.com','@')+1) from dual;
--4
select regexp_count((lower(trim('.'from 'WELCOME TO ORACLEJAVA.'))),'e') e���� from dual;
select length(lower(trim('.'from 'WELCOME TO ORACLEJAVA.')))
-length(replace(lower(trim('.'from 'WELCOME TO ORACLEJAVA.')),'e')) e���� from dual;


--5
select deptno �μ���ȣ, ename �̸�, hiredate �Ի���,sysdate ������, 
trunc(sysdate - hiredate) �ٹ��ϼ�, trunc((sysdate - hiredate)/365) �ٹ����,
trunc(months_between(sysdate,hiredate)) �ٹ�������, 
trunc(trunc(sysdate - hiredate)/7) �ٹ��ּ�  from emp;

--����4
--1
select ename �̸�, to_char(hiredate,'yy')||'�� '||to_char(hiredate,'mm')||'�� '||to_char(hiredate,'dd')||'��' �Ի��� from emp;
select ename �̸�, to_char(hiredate,'yyyy"��" mm"��" dd"��"') from emp;
--2
select ename �̸�, hiredate �Ի���, 
decode(to_char(hiredate,'mm'),'07','�Ϲݱ�','08','�Ϲݱ�','09','�Ϲݱ�','10','�Ϲݱ�','11','�Ϲݱ�','12','�Ϲݱ�','��ݱ�') ���Ϲݱ� 
from emp;
--3
select ename �̸�, hiredate  �Ի���, 
case when to_number(to_char(hiredate,'mm')) < 6 then '��ݱ�' else '�Ϲݱ�' end ���Ϲݱ� 
from emp;
--4
select max(sal)-min(sal) �޿��� from emp;
--5
select count(dname) from dept;
--6
select job,count(job),sum(length(ename)) from emp group by job having count(job) > 2;

--����5
--1
select ename �̸�, dname �μ���, sal �޿� from emp natural join dept where ename like '%M%';
--2
select ename �̸�, sal �޿� from emp where sal < (select sal from emp where ename = 'SCOTT') - 1000;
--3
select ename �̸�, sal �޿� from emp where sal < (select min(sal) from emp where job = 'SALESMAN');
--4
select ename �̸�, sal �޿� from emp where sal > (select round(avg(sal)) from emp where deptno = (select deptno from emp where ename = 'WARD'));
--5
select dname �μ���, ename �̸�, sal �޿� from emp natural join dept where sal = (select min(sal) from emp where ename like '%K%'); 
