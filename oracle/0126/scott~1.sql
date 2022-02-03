--dept의 전체 데이터 출력
select  *  from dept;
--dept 테이블의의 행 dnam과 loc 출력
select dname,loc from dept;
--emp테이블에서 사원번호, 사원이름, 직급 출력
select empno,ename,job from emp;
--별칭 붙여서 사용하기 ! as 붙여도 되고 sql에서는 as 안붙여도 됨! (테이블에도 적용 가능!)
--별칭 중 영어를 사용할 때 대소문자 구분하거나 공백 표시하려면 "" 안에 적어야함!
--""안하면 공백표시 안되고  전부 다 대문자 처리 됨 
select empno as "EmployeeNum",ename 사원이름,job 직급 from emp;

--회사 내 직급 출력
select job from emp;
--중복제거 distinct 여러 행 함께 적용 할 수록 변별력 떨어짐
--선택한 모든 행에서 중복되는 것만 제거하기 때문!
select distinct job,deptno from emp;

--특정 레코드만 가져오기! where
--사원 중 10번 부서 출력
select * from emp where deptno = 10;
--사원 중 급여가 2000미만이 되는 사원의 이름,급여 출력
select ename,sal from emp where sal < 2000;
--이름이 scott인 사람 찾기
select * from emp where ename = 'SCOTT';
--82년 이후에 입사한 사원의 이름과 입사일 출력 82/1/1도 가능
select ename, hiredate from emp where hiredate >= '1982/01/01';

--사원 번호, 이름, 급여를 사원번호 순서대로 출력하세요
select empno,ename,sal from emp order by empno;
--사원 번호, 이름 급여를 급여가 높은 순서대로 출력하세요
select empno,ename,sal from emp order by sal desc;
--사원의 사원번호, 이름, 부서번호를 부서번호대로 , 사원번호 순서대로 정렬하세요
select empno, ename, deptno from emp order by deptno, empno;
--사원의 사원번호, 이름, 부서번호를 부서번호내림차순 , 사원번호오름차순 순서대로 정렬하세요
select empno, ename, deptno from emp order by deptno desc, empno;
--입사일이 가장 최근인 순으로 사번 이름 입사일 출력
select empno,ename,hiredate hire from emp order by hire desc ;

--부서번호가 10번이고 직급이 MANAGER인 사원의 이름과 부서번호, 직급 출력
select ename,deptno,job from emp where deptno = 10 and job = 'MANAGER';
--부서번호가 10번이거나 직급이 MANAGER인 사원 이름과 부서번호, 직급 출력
select ename,deptno,job from emp where deptno = 10 or job = 'MANAGER';
--사원번호가 7844이거나 7654이거나 7521인 사원의 사원번호와 이름 출력
select empno,ename from emp where empno in (7844,7654,7521);
--급여가 1000에서 3000사이에 있는 사원의 이름과 급여 출력
select ename,sal from emp where sal between 1000 and 3000;

--1983년도에 입사한 사원의 이름, 입사일을 입사일 순으로 정렬해서 출력하세요
select ename,hiredate 
from emp 
where hiredate 
between '81/1/1' and '81/12/31' 
order by hiredate;

--이름이 k로 시작하는 사원의 사번,이름
select empno,ename from emp where ename like 'K%';
--이름이 n으로 끝나는 사원의 사번,이름
select empno,ename from emp where ename like '%N';
--이름에 s가 들어가는 사원의 사번,이름
select empno,ename from emp where ename like '%S%';
--이름에 A가 없는 사원의 사번,이름
select empno,ename from emp where ename not like '%A%';
--와일드카드 없이 사용하는 것은 = 와 같다.
select empno,ename from emp where ename like 'SCOTT';

select 100+NULL from dual;

--커미션을 받지 않는 사원의 사원번호, 이름, 커미션, 부서번호 출력
select empno,ename,comm,deptno from emp where comm is null;
--null은 is null is not null로 비교 / 값이 없기 때문에 연산자로 비교할 수 없따!

--직속 상사가 없는 사원의 이름과 직급, 상사사번 출력
select ename, job, mgr from emp where mgr is null;

--집합연산자
--10번 부서 사원들의 사원번호, 이름, 급여, 부서번호 출력
select empno, ename, sal, deptno from emp where deptno = 10
union
select empno, ename, sal, deptno from emp where deptno = 20;
--20번 부서 사원들의 사원번호, 이름, 급여, 부서번호 출력
--같은 조건이면 중복제거 / 중복제거 안하려면 union all 사용 (잘 안씀)

select empno,ename, deptno from emp
minus
select empno, ename, deptno from emp where deptno = 30;

--사원 이름이 s로 끝나는 데이터를 모두 출력하세요
select * from emp where ename like '%S';
--30번 부서에서 근무하고 있는 사원중에 직책이 SALESMAN인 사원의 번호,이름,직책,급여,부서번호를 출력하세요
select empno,ename,job,sal,deptno from emp where job = 'SALESMAN' and deptno = 30;
--20번, 30번 부서에서 근무하고 있는 사원 중 급여가 2000초과인 사원의 번호,이름,급여,부서번호를 출력하세요
-- 집합연산자 사용 x
select empno,ename,sal,deptno from emp where deptno in (20,30) and sal > 2000;
--집합연산자사용
select empno,ename,sal,deptno from emp where deptno = 20 and sal > 2000
union
select empno,ename,sal,deptno from emp where deptno = 30 and sal > 2000;
--급여가 2000이상 300이하의 사원 데이터를 모두 출력하시오
select * from emp where not sal between 2000 and 3000 order by sal;
--사원 이름에 E가 포함되어 있는 30번 부서 사원 중 급여가 1000~2000사이가 아닌 사원의 번호,이름,급여,부서번호를 출력하세요
select empno,ename,sal,deptno from emp where ename like '%E%' and deptno = 30 and not sal between 1000 and 2000;
--커미션이 존재하지 않고 상급자가 있고 직책이 'MANAGER','CLERK'인 사원의 정보를 모두 출력하세요.
select * from emp where comm is null and mgr is not null and job in ('MANAGER','CLERK');

-- 소문자로 변환 해주는 함수 lower
select 'DataBase', lower ('DataBase') from dual;
--대문자 upper
select 'DataBase', upper ('DataBase') from dual;
--사원테이블에서 부서번호가 10번인 사원명을 모두 소문자로 변환
select ename , lower (ename) from emp where deptno = 10;
--직급이 매니저인 사원 검색 보통 둘 다 대문자 혹은 둘 다 소문자로 변환해서 검색함!
select ename , job from emp where upper(job) = upper('manager');

select INITCAP ('DATA BASE PROGRAM') from dual;

--이름이 'Smith'인 사람의 정보 출력
select * from emp where  initcap(ename) = 'Smith';

--이름에 a가 있는 사원의 모든 정보
select * from emp where ename like upper('%a%');

--문자열 두개를 합쳐주는 함수 concat (mysql에서 많이 사용!)
select concat ('Data','Base') from dual;
--||도 더하기 (오라클에서만 사용가능 ㅎ)
select 'Data'||'Base' from dual;
select ename||'의 사원번호는 '||empno||'입니다' from emp;

--글자수 알아주는 length
select length('data'), length('데이터') from dual;

--substr Ex
select 'DataBase', substr('DataBase',1,4), substr('DataBase',5),
substr('DataBase',-1,1),substr('DataBase',-4,4) from dual;
--substr활용하여 입사년도가 81년도인 사람 알아내기
select ename,hiredate , substr(hiredate,1,2) year from emp where substr(hiredate,1,2) = 81;

--이름이 k로 끝나는 직원의 정보 출력 (like 말고 substr 사용)
select * from emp where substr(ename,-1,1) = 'K';

--몇번째자리에 있는지 알랴줌 (여러개 있으면 가장 처음 것 찾아줌) / 더 뒤에거 찾으려면 a,3 이렇게 시작위치를 뒤에부터 해줘야함
--없는 문자열 찾으면 0 나옴
select instr('DataBase','a') from dual;

--이름의 두번째 자리가 'A'인 사원의 이름 출력
select ename from emp where instr(ename,'A') = 2;

--바꿔주는 replace / 바꿀 문자 지정안하면 데이터 지워짐!
select '010-1111-2222',replace('010-1111-2222','-',' ') from dual;
select '010-1111-2222',replace('010-1111-2222','-') from dual;





