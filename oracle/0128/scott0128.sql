--self join > �ϳ��� ���̺��� �ΰ�ó�� ����� ���� / ��Ī�� �� ����ϴ� ���� �߿�!
--����� ���, �̸��� ����� �����ȣ, �̸��� ����ϼ���
select e.empno �����ȣ,e.ename ����̸�, m.empno ����ȣ,m.ename ����̸�  from emp e, emp m where e.mgr = m.empno;

--outer join
select dept.deptno, ename, dname from emp, dept where emp.deptno(+) = dept.deptno;

select * from emp full outer join dept on emp.deptno = dept.deptno;

--�޿��� 2000 �ʰ��� ��� ���� �μ�����, ��������� ��� (�μ���ȣ, �μ���, �����ȣ, ����̸�,�޿�)
select deptno �μ���ȣ ,d.dname �μ���,e.empno �����ȣ,e.ename ����̸�, e.sal �޿� 
from emp e inner join dept d using (deptno) where e.sal > 2000;
--�� �μ��� �μ���ȣ,�μ���,��ձ޿�,�ִ�޿�,�ּұ޿�,��� �� ���
select deptno �μ���ȣ,d.dname �μ���,round(avg(sal)) ��ձ޿�,max(sal) �ִ�޿�,min(sal) �ּұ޿�,count(*) �����  
from emp e inner join dept d using (deptno) group by deptno,d.dname;
--��� �μ������� ��������� �μ���ȣ, ����̸� ������ ���� ���Ѽ� ���(�μ���ȣ,�μ���,�����ȣ,����̸�,����,�޿�)
select d.deptno �μ���ȣ, d.dname �μ���, e.empno �����ȣ, e.ename ����̸�, e.job ����, e.sal �޿� 
from emp e full outer join dept d on e.deptno = d.deptno 
order by d.deptno,e.ename;

--��� �μ�����, �������, �޿� ���, ���� ��� ������ �μ���ȣ, �����ȣ ������� �����ؼ� ����ϼ��� (�μ���ȣ, �μ���, �����ȣ, �����, �޿�,����ȣ, �޿����, ����̸�)
select d.deptno �μ���ȣ, d.dname �μ���, e.sal �޿�, e.mgr ����ȣ, m.ename ����̸�, s.grade �޿����
from emp e,dept d, salgrade s, emp m 
where e.deptno(+) = d.deptno and e.sal between s.losal(+) and s.hisal(+) and e.mgr = m.empno(+) 
order by d.deptno,e.empno;

select d.deptno �μ���ȣ, d.dname �μ���, e.sal �޿�, e.mgr ����ȣ, m.ename ����̸�, s.grade �޿����
from emp e right outer join dept d
    on e.deptno = d.deptno
    left outer join salgrade s
    on e.sal between s.losal and s.hisal
    left outer join emp m
    on e.mgr = m.empno
order by d.deptno, e.empno;    

--��������
--'scott'�� �μ��� ���
select dname from dept where deptno = (select deptno from emp where ename = 'SCOTT');

--'smith'�� ���� �μ����� �ٹ��ϴ� ����� ���� ���
select * from emp where deptno = (select deptno from emp where ename = 'SMITH') and ename <> 'SMITH';

--'NEW YORK'���� �ٹ��ϴ� ������� �̸� ���
select ename from emp where  deptno = (select deptno from dept where loc = 'NEW YORK');

--�޿��� 3000�̻� �޴� ����� �Ҽӵ� �μ��� ������ �μ����� �ٹ��ϴ� ��� ���(�̸�,�޿�,�μ���ȣ)
select ename , sal , deptno from emp where deptno in (select distinct deptno from emp where sal >= 3000) order by deptno;

-- 30�� �μ� �Ҽ� ��� �� �޿��� ���� ���� �޴� ������� �� ���� �޿��� �޴� ����� �̸�,�޿� ���
select ename,sal from emp where sal > (select max(sal) from emp where deptno = 30);
--��� ������ �����ؾ߸� ���� ������ all
select ename,sal from emp where sal > all(select sal from emp where deptno = 30);
--�ϳ��� ���̸� ���� ������ any,some
select ename,sal from emp where sal > any(select sal from emp where deptno = 30);

 -- ���̺� ���¸� ������ �� �̷� ������ ���
select * from emp where 1=0;
-- exists �������� ����� ������ ��� true
select * from emp where exists (select *from dept where deptno = 50);
select * from emp where exists (select *from dept where deptno = 10);

--���߿� ��������
--�μ����� �ְ� �޿��� �μ���ȣ ��� 
select * from emp where (deptno,sal) in (select deptno,max(sal) from emp group by deptno) order by deptno;

--from���� ���̴� �������� / from�� ���� �������������� �����͸� ������
select d.deptno, ename from (select * from emp where deptno = 10) e10, dept d where e10.deptno = d.deptno;
-- dept d �� (select * from dept) d �ε� ǥ�� ����
--with ��
with e20 as (select * from emp where deptno = 20), d as (select * from dept) 
select e20.deptno, e20.empno, ename,dname,loc 
from e20,d where e20.deptno = d.deptno;

-- rownum : �����ȣ / ���ĵ� ���¿��� ���ڵ��� �Ϻκ��� �������� ��� ���
-- ex) �޿��� ���� ���� �޴� 3���� ������ ����ϼ���
select e.*,rownum rank from ( select * from emp order by sal desc) e where rownum <= 3;
--�������� 4-6�� ��� / rownum�� 1���͸� ������ �� �ִ�
--�׷��� �̷��� �����! ����صα�~�ڡڡڡڡڡڡڡڡڡڡڡڡڡ�
select * from (select e.* ,rownum r from (select * from emp order by sal desc) e) where r >= 4 and r <=6;

--select ���� ����ϴ� ��������
select empno,ename,job,sal,
(select grade from salgrade s where e.sal between s.losal and s.hisal) grade,
(select dname from dept d where e.deptno = d.deptno) dname 
from emp e;

--1. ��ü ��� �� 'ALLEN'�� ���� ��å�� ������� �������, �μ������� ����ϼ��� 
-- (��å/�����ȣ/�̸�/�޿�/�μ���ȣ/�μ��̸�)
select job ��å, empno �μ���ȣ, ename �̸�, sal �޿�, deptno �μ���ȣ,(select dname from dept d where e.deptno = d.deptno) �μ��̸� 
from emp e where e.job = (select job from emp m where ename = 'ALLEN') and ename <> 'ALLEN';

--2. ��ü ����� ��� �޿����� ���� �޿��� �޴� ������� ������ ����ϼ���
--(�����ȣ, ����̸�, �μ��̸�, �Ի���, �ٹ���, �޿�, �޿����)
select empno �����ȣ ,ename ����̸�,
(select dname from dept d where e.deptno = d.deptno) �μ��̸�,
hiredate �Ի���,(select loc from dept d where e.deptno = d.deptno) �ٹ���,sal �޿�,
(select grade from salgrade s where e.sal between s.losal and s.hisal)  �޿����
from emp e where e.sal > (select avg(sal) from emp);

--3. 10�� �μ��� �ٹ��ϴ� ��� �� 30�� �μ����� �������� �ʴ� ��å�� ���� ������� ������ ����ϼ���
--(�����ȣ, ����̸�, ��å, �μ���ȣ, �μ���, �ٹ���) 
 select e.empno �����ȣ,e.ename ����̸� ,e.job ��å ,e.deptno �μ���ȣ,
(select dname from dept d where e.deptno = d.deptno) �μ��̸�, 
(select loc from dept d where e.deptno = d.deptno) �ٹ���
from (select * from emp where deptno = 10) e 
where e.job <> all (select job from emp where deptno = 30);

--4. ��å�� SALESMAN�� ������� �ְ� �޿����� ���� �޿��� �޴� ������� ������ ����ϼ���
--(�����ȣ, ����̸�, �޿�, �޿� ���)	
select empno �����ȣ,ename ����̸� ,sal �޿�,
(select grade from salgrade s where e.sal between s.losal and s.hisal) �޿���� 
from emp e 
where e.sal > (select max(sal) from emp where job = 'SALESMAN');

--������� �ۼ��� �ڵ�

--1. ��ü ��� �� 'ALLEN'�� ���� ��å�� ������� 
--�������, �μ������� ����ϼ��� 
--(��å, �����ȣ, �̸�, �޿�, �μ���ȣ, �μ��̸�)				
select job, empno, ename, sal, deptno, dname				
from emp natural join dept                
where job = (select job from emp where ename = 'ALLEN' ) ;

--2. ��ü ����� ��� �޿����� ���� �޿��� �޴� ������� ������ 
--����ϼ���
--(�����ȣ, ����̸�, �μ��̸�, �Ի���, �ٹ���, �޿�, �޿����)
select e.empno, e.ename, d.dname, e.hiredate, d.loc, e.sal, s.grade
from emp e, dept d, salgrade s
where e.deptno = d.deptno AND e.sal between s.losal and s.hisal
and sal > (select avg(sal) from emp) 
order by e.sal desc, e.empno;

--3. 10�� �μ��� �ٹ��ϴ� ��� �� 30�� �μ����� �������� 
--�ʴ� ��å�� ���� ������� ������ ����ϼ���
--(�����ȣ, ����̸�, ��å, �μ���ȣ, �μ���, �ٹ���) 				
select empno, ename, job, deptno, dname, loc
from emp natural join dept 
where deptno = 10 and job NOT IN
(select distinct job from emp where deptno = 30);

--4. ��å�� SALESMAN�� ������� �ְ� �޿����� 
--���� �޿��� �޴� ������� ������ ����ϼ���
--(�����ȣ, ����̸�, �޿�, �޿� ���)	
select empno, ename, sal, grade
from emp e, salgrade s
where e.sal between s.losal and s.hisal
and sal > (select max(sal) from emp where job='SALESMAN');

select empno, ename, sal, grade
from emp e, salgrade s
where e.sal between s.losal and s.hisal
and sal > ALL
(select distinct sal from emp  where job='SALESMAN');

--where�� �������� : ���� ���� ����
--from�� �������� : ���� �ȿ� �ִ� ������������ ����
--select�� �������� : from, where �� �ڿ� ���� (���� ����!)













