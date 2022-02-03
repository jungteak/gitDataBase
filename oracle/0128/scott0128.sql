--self join > 하나의 테이블을 두개처럼 사용해 조인 / 별칭을 잘 사용하는 것이 중요!
--사원의 사번, 이름과 상사의 사원번호, 이름을 출력하세요
select e.empno 사원번호,e.ename 사원이름, m.empno 상사번호,m.ename 상사이름  from emp e, emp m where e.mgr = m.empno;

--outer join
select dept.deptno, ename, dname from emp, dept where emp.deptno(+) = dept.deptno;

select * from emp full outer join dept on emp.deptno = dept.deptno;

--급여가 2000 초과인 사원 들의 부서정보, 사원정보를 출력 (부서번호, 부서명, 사원번호, 사원이름,급여)
select deptno 부서번호 ,d.dname 부서명,e.empno 사원번호,e.ename 사원이름, e.sal 급여 
from emp e inner join dept d using (deptno) where e.sal > 2000;
--각 부서별 부서번호,부서명,평균급여,최대급여,최소급여,사원 수 출력
select deptno 부서번호,d.dname 부서명,round(avg(sal)) 평균급여,max(sal) 최대급여,min(sal) 최소급여,count(*) 사원수  
from emp e inner join dept d using (deptno) group by deptno,d.dname;
--모든 부서정보와 사원정보를 부서번호, 사원이름 순으로 정렬 시켜서 출력(부서번호,부서명,사원번호,사원이름,직급,급여)
select d.deptno 부서번호, d.dname 부서명, e.empno 사원번호, e.ename 사원이름, e.job 직급, e.sal 급여 
from emp e full outer join dept d on e.deptno = d.deptno 
order by d.deptno,e.ename;

--모든 부서정보, 사원정보, 급여 등급, 직속 상관 정보를 부서번호, 사원번호 순서대로 정렬해서 출력하세요 (부서번호, 부서명, 사원번호, 사원명, 급여,상사번호, 급여등급, 상사이름)
select d.deptno 부서번호, d.dname 부서명, e.sal 급여, e.mgr 상사번호, m.ename 상사이름, s.grade 급여등급
from emp e,dept d, salgrade s, emp m 
where e.deptno(+) = d.deptno and e.sal between s.losal(+) and s.hisal(+) and e.mgr = m.empno(+) 
order by d.deptno,e.empno;

select d.deptno 부서번호, d.dname 부서명, e.sal 급여, e.mgr 상사번호, m.ename 상사이름, s.grade 급여등급
from emp e right outer join dept d
    on e.deptno = d.deptno
    left outer join salgrade s
    on e.sal between s.losal and s.hisal
    left outer join emp m
    on e.mgr = m.empno
order by d.deptno, e.empno;    

--서브쿼리
--'scott'의 부서명 출력
select dname from dept where deptno = (select deptno from emp where ename = 'SCOTT');

--'smith'와 같은 부서에서 근무하는 사원의 정보 출력
select * from emp where deptno = (select deptno from emp where ename = 'SMITH') and ename <> 'SMITH';

--'NEW YORK'에서 근무하는 사원들의 이름 출력
select ename from emp where  deptno = (select deptno from dept where loc = 'NEW YORK');

--급여를 3000이상 받는 사원이 소속된 부서와 동일한 부서에서 근무하는 사원 출력(이름,급여,부서번호)
select ename , sal , deptno from emp where deptno in (select distinct deptno from emp where sal >= 3000) order by deptno;

-- 30번 부서 소속 사원 중 급여를 제일 많이 받는 사원보다 더 많은 급여를 받는 사람의 이름,급여 출력
select ename,sal from emp where sal > (select max(sal) from emp where deptno = 30);
--모든 조건을 만족해야만 참이 나오는 all
select ename,sal from emp where sal > all(select sal from emp where deptno = 30);
--하나라도 참이면 참이 나오는 any,some
select ename,sal from emp where sal > any(select sal from emp where deptno = 30);

 -- 테이블 형태만 가져올 때 이런 식으로 사용
select * from emp where 1=0;
-- exists 서브쿼리 결과가 존재할 경우 true
select * from emp where exists (select *from dept where deptno = 50);
select * from emp where exists (select *from dept where deptno = 10);

--다중열 서브쿼리
--부서별로 최고 급여와 부서번호 출력 
select * from emp where (deptno,sal) in (select deptno,max(sal) from emp group by deptno) order by deptno;

--from절에 붙이는 서브쿼리 / from절 뒤의 서브쿼리에서만 데이터를 가져옴
select d.deptno, ename from (select * from emp where deptno = 10) e10, dept d where e10.deptno = d.deptno;
-- dept d 를 (select * from dept) d 로도 표현 가능
--with 절
with e20 as (select * from emp where deptno = 20), d as (select * from dept) 
select e20.deptno, e20.empno, ename,dname,loc 
from e20,d where e20.deptno = d.deptno;

-- rownum : 가상번호 / 정렬된 상태에서 레코드의 일부분을 꺼내오는 경우 사용
-- ex) 급여를 가장 많이 받는 3명의 정보를 출력하세요
select e.*,rownum rank from ( select * from emp order by sal desc) e where rownum <= 3;
--연봉순위 4-6등 출력 / rownum은 1부터만 꺼내올 수 있다
--그래서 이렇게 써야함! 기억해두기~★★★★★★★★★★★★★★
select * from (select e.* ,rownum r from (select * from emp order by sal desc) e) where r >= 4 and r <=6;

--select 절에 사용하는 서브쿼리
select empno,ename,job,sal,
(select grade from salgrade s where e.sal between s.losal and s.hisal) grade,
(select dname from dept d where e.deptno = d.deptno) dname 
from emp e;

--1. 전체 사원 중 'ALLEN'과 같은 직책인 사원들의 사원정보, 부서정보를 출력하세요 
-- (직책/사원번호/이름/급여/부서번호/부서이름)
select job 직책, empno 부서번호, ename 이름, sal 급여, deptno 부서번호,(select dname from dept d where e.deptno = d.deptno) 부서이름 
from emp e where e.job = (select job from emp m where ename = 'ALLEN') and ename <> 'ALLEN';

--2. 전체 사원의 평균 급여보다 높은 급여를 받는 사원들의 정보를 출력하세요
--(사원번호, 사원이름, 부서이름, 입사일, 근무지, 급여, 급여등급)
select empno 사원번호 ,ename 사원이름,
(select dname from dept d where e.deptno = d.deptno) 부서이름,
hiredate 입사일,(select loc from dept d where e.deptno = d.deptno) 근무지,sal 급여,
(select grade from salgrade s where e.sal between s.losal and s.hisal)  급여등급
from emp e where e.sal > (select avg(sal) from emp);

--3. 10번 부서에 근무하는 사원 중 30번 부서에는 존재하지 않는 직책을 가진 사원들의 정보를 출력하세요
--(사원번호, 사원이름, 직책, 부서번호, 부서명, 근무지) 
 select e.empno 사원번호,e.ename 사원이름 ,e.job 직책 ,e.deptno 부서번호,
(select dname from dept d where e.deptno = d.deptno) 부서이름, 
(select loc from dept d where e.deptno = d.deptno) 근무지
from (select * from emp where deptno = 10) e 
where e.job <> all (select job from emp where deptno = 30);

--4. 직책이 SALESMAN인 사람들의 최고 급여보다 높은 급여를 받는 사원들의 정보를 출력하세요
--(사원번호, 사원이름, 급여, 급여 등급)	
select empno 사원번호,ename 사원이름 ,sal 급여,
(select grade from salgrade s where e.sal between s.losal and s.hisal) 급여등급 
from emp e 
where e.sal > (select max(sal) from emp where job = 'SALESMAN');

--강사님이 작성한 코드

--1. 전체 사원 중 'ALLEN'과 같은 직책인 사원들의 
--사원정보, 부서정보를 출력하세요 
--(직책, 사원번호, 이름, 급여, 부서번호, 부서이름)				
select job, empno, ename, sal, deptno, dname				
from emp natural join dept                
where job = (select job from emp where ename = 'ALLEN' ) ;

--2. 전체 사원의 평균 급여보다 높은 급여를 받는 사원들의 정보를 
--출력하세요
--(사원번호, 사원이름, 부서이름, 입사일, 근무지, 급여, 급여등급)
select e.empno, e.ename, d.dname, e.hiredate, d.loc, e.sal, s.grade
from emp e, dept d, salgrade s
where e.deptno = d.deptno AND e.sal between s.losal and s.hisal
and sal > (select avg(sal) from emp) 
order by e.sal desc, e.empno;

--3. 10번 부서에 근무하는 사원 중 30번 부서에는 존재하지 
--않는 직책을 가진 사원들의 정보를 출력하세요
--(사원번호, 사원이름, 직책, 부서번호, 부서명, 근무지) 				
select empno, ename, job, deptno, dname, loc
from emp natural join dept 
where deptno = 10 and job NOT IN
(select distinct job from emp where deptno = 30);

--4. 직책이 SALESMAN인 사람들의 최고 급여보다 
--높은 급여를 받는 사원들의 정보를 출력하세요
--(사원번호, 사원이름, 급여, 급여 등급)	
select empno, ename, sal, grade
from emp e, salgrade s
where e.sal between s.losal and s.hisal
and sal > (select max(sal) from emp where job='SALESMAN');

select empno, ename, sal, grade
from emp e, salgrade s
where e.sal between s.losal and s.hisal
and sal > ALL
(select distinct sal from emp  where job='SALESMAN');

--where절 서브쿼리 : 제일 먼저 실행
--from절 서브쿼리 : 제일 안에 있는 서브쿼리부터 실행
--select절 서브쿼리 : from, where 절 뒤에 실행 (가장 나중!)













