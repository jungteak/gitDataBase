--퀴즈1
--1
select empno 사원번호, ename 이름, sal 월급 from emp where deptno = 10;
--2
select ename 이름, hiredate 입사일, deptno 부서번호 from emp where empno = 7369;
--3
select * from emp where ename = 'ALLEN';
--4
select ename 이름,deptno 부서번호,sal 월급 from emp where hiredate = '83/1/12';
--5
select * from emp where not job = 'MANAGER';
--6
select * from emp where hiredate >= '81/4/2';
--7
select ename 이름,sal 급여, deptno 부서번호 from emp where sal >= 800;
--8
select * from emp where not empno between 7654 and 7782;
--9
select sal*2 새급여 from emp where sal <= 2000;

--퀴즈2
--1
select ename 이름, sal 급여, sal*0.2 보너스금액 from emp;
--2
select ename 이름, sal 급여, sal*0.15 경조비 from emp where sal >= 2000;
--3
select ename 이름, sal 급여, round(sal/12/5) 시간당임금 from emp where deptno = 20;
--4
select * from emp where hiredate between '81/4/2' and '82/12/9';
--5
select ename 이름, job 업무, sal 급여 from emp where sal between 1600+1 and 3000-1;
--6
select * from emp where job in ('MANAGER','SALESMAN') order by deptno,sal desc;
--7
select * from emp where not deptno in (20,30);
--8
select * from emp where hiredate between '81/1/1' and '81/12/31';
select * from emp where to_char(hiredate,'yy') = 81;
--9
select * from emp where ename like 'S___T';

--퀴즈3
--1
select * from emp where substr(hiredate,1,2) = '81';
select * from emp where to_char(hiredate,'yy') = '81';
--2
select * from emp where substr(ename,1,1) = 'S' and substr(ename,-1,1) = 'T';
--3
select substr('tester@naver.com',instr('tester@naver.com','@')+1) from dual;
--4
select regexp_count((lower(trim('.'from 'WELCOME TO ORACLEJAVA.'))),'e') e개수 from dual;
select length(lower(trim('.'from 'WELCOME TO ORACLEJAVA.')))
-length(replace(lower(trim('.'from 'WELCOME TO ORACLEJAVA.')),'e')) e개수 from dual;


--5
select deptno 부서번호, ename 이름, hiredate 입사일,sysdate 현재일, 
trunc(sysdate - hiredate) 근무일수, trunc((sysdate - hiredate)/365) 근무년수,
trunc(months_between(sysdate,hiredate)) 근무개월수, 
trunc(trunc(sysdate - hiredate)/7) 근무주수  from emp;

--퀴즈4
--1
select ename 이름, to_char(hiredate,'yy')||'년 '||to_char(hiredate,'mm')||'월 '||to_char(hiredate,'dd')||'일' 입사일 from emp;
select ename 이름, to_char(hiredate,'yyyy"년" mm"월" dd"일"') from emp;
--2
select ename 이름, hiredate 입사일, 
decode(to_char(hiredate,'mm'),'07','하반기','08','하반기','09','하반기','10','하반기','11','하반기','12','하반기','상반기') 상하반기 
from emp;
--3
select ename 이름, hiredate  입사일, 
case when to_number(to_char(hiredate,'mm')) < 6 then '상반기' else '하반기' end 상하반기 
from emp;
--4
select max(sal)-min(sal) 급여차 from emp;
--5
select count(dname) from dept;
--6
select job,count(job),sum(length(ename)) from emp group by job having count(job) > 2;

--퀴즈5
--1
select ename 이름, dname 부서명, sal 급여 from emp natural join dept where ename like '%M%';
--2
select ename 이름, sal 급여 from emp where sal < (select sal from emp where ename = 'SCOTT') - 1000;
--3
select ename 이름, sal 급여 from emp where sal < (select min(sal) from emp where job = 'SALESMAN');
--4
select ename 이름, sal 급여 from emp where sal > (select round(avg(sal)) from emp where deptno = (select deptno from emp where ename = 'WARD'));
--5
select dname 부서명, ename 이름, sal 급여 from emp natural join dept where sal = (select min(sal) from emp where ename like '%K%'); 
