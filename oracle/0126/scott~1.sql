--dept�� ��ü ������ ���
select  *  from dept;
--dept ���̺����� �� dnam�� loc ���
select dname,loc from dept;
--emp���̺��� �����ȣ, ����̸�, ���� ���
select empno,ename,job from emp;
--��Ī �ٿ��� ����ϱ� ! as �ٿ��� �ǰ� sql������ as �Ⱥٿ��� ��! (���̺��� ���� ����!)
--��Ī �� ��� ����� �� ��ҹ��� �����ϰų� ���� ǥ���Ϸ��� "" �ȿ� �������!
--""���ϸ� ����ǥ�� �ȵǰ�  ���� �� �빮�� ó�� �� 
select empno as "EmployeeNum",ename ����̸�,job ���� from emp;

--ȸ�� �� ���� ���
select job from emp;
--�ߺ����� distinct ���� �� �Բ� ���� �� ���� ������ ������
--������ ��� �࿡�� �ߺ��Ǵ� �͸� �����ϱ� ����!
select distinct job,deptno from emp;

--Ư�� ���ڵ常 ��������! where
--��� �� 10�� �μ� ���
select * from emp where deptno = 10;
--��� �� �޿��� 2000�̸��� �Ǵ� ����� �̸�,�޿� ���
select ename,sal from emp where sal < 2000;
--�̸��� scott�� ��� ã��
select * from emp where ename = 'SCOTT';
--82�� ���Ŀ� �Ի��� ����� �̸��� �Ի��� ��� 82/1/1�� ����
select ename, hiredate from emp where hiredate >= '1982/01/01';

--��� ��ȣ, �̸�, �޿��� �����ȣ ������� ����ϼ���
select empno,ename,sal from emp order by empno;
--��� ��ȣ, �̸� �޿��� �޿��� ���� ������� ����ϼ���
select empno,ename,sal from emp order by sal desc;
--����� �����ȣ, �̸�, �μ���ȣ�� �μ���ȣ��� , �����ȣ ������� �����ϼ���
select empno, ename, deptno from emp order by deptno, empno;
--����� �����ȣ, �̸�, �μ���ȣ�� �μ���ȣ�������� , �����ȣ�������� ������� �����ϼ���
select empno, ename, deptno from emp order by deptno desc, empno;
--�Ի����� ���� �ֱ��� ������ ��� �̸� �Ի��� ���
select empno,ename,hiredate hire from emp order by hire desc ;

--�μ���ȣ�� 10���̰� ������ MANAGER�� ����� �̸��� �μ���ȣ, ���� ���
select ename,deptno,job from emp where deptno = 10 and job = 'MANAGER';
--�μ���ȣ�� 10���̰ų� ������ MANAGER�� ��� �̸��� �μ���ȣ, ���� ���
select ename,deptno,job from emp where deptno = 10 or job = 'MANAGER';
--�����ȣ�� 7844�̰ų� 7654�̰ų� 7521�� ����� �����ȣ�� �̸� ���
select empno,ename from emp where empno in (7844,7654,7521);
--�޿��� 1000���� 3000���̿� �ִ� ����� �̸��� �޿� ���
select ename,sal from emp where sal between 1000 and 3000;

--1983�⵵�� �Ի��� ����� �̸�, �Ի����� �Ի��� ������ �����ؼ� ����ϼ���
select ename,hiredate 
from emp 
where hiredate 
between '81/1/1' and '81/12/31' 
order by hiredate;

--�̸��� k�� �����ϴ� ����� ���,�̸�
select empno,ename from emp where ename like 'K%';
--�̸��� n���� ������ ����� ���,�̸�
select empno,ename from emp where ename like '%N';
--�̸��� s�� ���� ����� ���,�̸�
select empno,ename from emp where ename like '%S%';
--�̸��� A�� ���� ����� ���,�̸�
select empno,ename from emp where ename not like '%A%';
--���ϵ�ī�� ���� ����ϴ� ���� = �� ����.
select empno,ename from emp where ename like 'SCOTT';

select 100+NULL from dual;

--Ŀ�̼��� ���� �ʴ� ����� �����ȣ, �̸�, Ŀ�̼�, �μ���ȣ ���
select empno,ename,comm,deptno from emp where comm is null;
--null�� is null is not null�� �� / ���� ���� ������ �����ڷ� ���� �� ����!

--���� ��簡 ���� ����� �̸��� ����, ����� ���
select ename, job, mgr from emp where mgr is null;

--���տ�����
--10�� �μ� ������� �����ȣ, �̸�, �޿�, �μ���ȣ ���
select empno, ename, sal, deptno from emp where deptno = 10
union
select empno, ename, sal, deptno from emp where deptno = 20;
--20�� �μ� ������� �����ȣ, �̸�, �޿�, �μ���ȣ ���
--���� �����̸� �ߺ����� / �ߺ����� ���Ϸ��� union all ��� (�� �Ⱦ�)

select empno,ename, deptno from emp
minus
select empno, ename, deptno from emp where deptno = 30;

--��� �̸��� s�� ������ �����͸� ��� ����ϼ���
select * from emp where ename like '%S';
--30�� �μ����� �ٹ��ϰ� �ִ� ����߿� ��å�� SALESMAN�� ����� ��ȣ,�̸�,��å,�޿�,�μ���ȣ�� ����ϼ���
select empno,ename,job,sal,deptno from emp where job = 'SALESMAN' and deptno = 30;
--20��, 30�� �μ����� �ٹ��ϰ� �ִ� ��� �� �޿��� 2000�ʰ��� ����� ��ȣ,�̸�,�޿�,�μ���ȣ�� ����ϼ���
-- ���տ����� ��� x
select empno,ename,sal,deptno from emp where deptno in (20,30) and sal > 2000;
--���տ����ڻ��
select empno,ename,sal,deptno from emp where deptno = 20 and sal > 2000
union
select empno,ename,sal,deptno from emp where deptno = 30 and sal > 2000;
--�޿��� 2000�̻� 300������ ��� �����͸� ��� ����Ͻÿ�
select * from emp where not sal between 2000 and 3000 order by sal;
--��� �̸��� E�� ���ԵǾ� �ִ� 30�� �μ� ��� �� �޿��� 1000~2000���̰� �ƴ� ����� ��ȣ,�̸�,�޿�,�μ���ȣ�� ����ϼ���
select empno,ename,sal,deptno from emp where ename like '%E%' and deptno = 30 and not sal between 1000 and 2000;
--Ŀ�̼��� �������� �ʰ� ����ڰ� �ְ� ��å�� 'MANAGER','CLERK'�� ����� ������ ��� ����ϼ���.
select * from emp where comm is null and mgr is not null and job in ('MANAGER','CLERK');

-- �ҹ��ڷ� ��ȯ ���ִ� �Լ� lower
select 'DataBase', lower ('DataBase') from dual;
--�빮�� upper
select 'DataBase', upper ('DataBase') from dual;
--������̺��� �μ���ȣ�� 10���� ������� ��� �ҹ��ڷ� ��ȯ
select ename , lower (ename) from emp where deptno = 10;
--������ �Ŵ����� ��� �˻� ���� �� �� �빮�� Ȥ�� �� �� �ҹ��ڷ� ��ȯ�ؼ� �˻���!
select ename , job from emp where upper(job) = upper('manager');

select INITCAP ('DATA BASE PROGRAM') from dual;

--�̸��� 'Smith'�� ����� ���� ���
select * from emp where  initcap(ename) = 'Smith';

--�̸��� a�� �ִ� ����� ��� ����
select * from emp where ename like upper('%a%');

--���ڿ� �ΰ��� �����ִ� �Լ� concat (mysql���� ���� ���!)
select concat ('Data','Base') from dual;
--||�� ���ϱ� (����Ŭ������ ��밡�� ��)
select 'Data'||'Base' from dual;
select ename||'�� �����ȣ�� '||empno||'�Դϴ�' from emp;

--���ڼ� �˾��ִ� length
select length('data'), length('������') from dual;

--substr Ex
select 'DataBase', substr('DataBase',1,4), substr('DataBase',5),
substr('DataBase',-1,1),substr('DataBase',-4,4) from dual;
--substrȰ���Ͽ� �Ի�⵵�� 81�⵵�� ��� �˾Ƴ���
select ename,hiredate , substr(hiredate,1,2) year from emp where substr(hiredate,1,2) = 81;

--�̸��� k�� ������ ������ ���� ��� (like ���� substr ���)
select * from emp where substr(ename,-1,1) = 'K';

--���°�ڸ��� �ִ��� �˷��� (������ ������ ���� ó�� �� ã����) / �� �ڿ��� ã������ a,3 �̷��� ������ġ�� �ڿ����� �������
--���� ���ڿ� ã���� 0 ����
select instr('DataBase','a') from dual;

--�̸��� �ι�° �ڸ��� 'A'�� ����� �̸� ���
select ename from emp where instr(ename,'A') = 2;

--�ٲ��ִ� replace / �ٲ� ���� �������ϸ� ������ ������!
select '010-1111-2222',replace('010-1111-2222','-',' ') from dual;
select '010-1111-2222',replace('010-1111-2222','-') from dual;





