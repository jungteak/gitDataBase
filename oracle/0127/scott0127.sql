--오름차순 정렬에서 null 값은 가장 나중에 내림차순 정렬에서는 가장 먼저!
select comm from emp order by comm desc;

--빈공간을 채우는 패딩
select lpad('DATABASE',20,'$') from dual;
select rpad('DATABASE',20,'$') from dual;
select RPAD(substr(ename,1,2),length(ename),'*') 이름 from emp;

--특정문자를 제거하는 trim leading 왼쪽 traliling 오른쪽 both 양쪽 제거 그냥쓰면 both와 같이 양쪽 제거
SELECT TRIM(LEADING FROM '  ABCD  ') LT,
LENGTH(TRIM(LEADING FROM '  ABCD  ')) LT_LEN, TRIM(TRAILING FROM '  ABCD  ') RT,
LENGTH(TRIM(TRAILING FROM '  ABCD  ')) RT_LEN, TRIM(BOTH FROM '  ABCD  ') BOTH1, LENGTH(TRIM(BOTH FROM '  ABCD  ')) BOTH1, TRIM('  ABCD  ') BOTHT2,
LENGTH(TRIM('  ABCD  ')) BOTHLEN2 FROM DUAL;

--round(대상,[표시할 자릿수]) 표시할 자릿수 표기안하면 0으로 처리!
select round(35.12,1),round(35.155,1),round(35.125),round(35.12,-1),round(135.12,-2) from dual;
--내림함수 trunc
select trunc(12.345,2),trunc(12.345),trunc(12.345,-1) from dual;
--mod 나머지
select mod(34,2),mod(34,5),mod(34,7) from dual;

--sysdate 현재 날짜 시간 가져옴
select sysdate 오늘, sysdate -1 어제, sysdate +1 내일 from dual;

select round(sysdate - hiredate) 근무일수 from emp; 
 
 --몇개월 후 계산 add_months
 --두 날짜간 개월 수 계산 months_between
 --입사일에서 10주년이 되는 날짜를 출력하세요
 select empno,ename,hiredate,add_months(hiredate,120) work10year from emp;
 
 select sysdate,hiredate,round(months_between(sysdate,hiredate)) from emp;
 
 --다음 요일의 날짜를 알려주는 함수 /금요일/금
 select sysdate, next_day(sysdate,'월') from dual;
 
 --영어로 찾으려면 언어 바꿔줘야함
 alter session set nls_language = american;
 select sysdate, next_day(sysdate,'friday') from dual;
 --다시한글 ㅎalter session set nls_language = korean;
  --이렇게 숫자로도 쓸 수 있음 1(일)~7(토)
 select sysdate, next_day(sysdate,6) from dual;
   
   --달의 마지막 날짜 뽑는  last_day
 select sysdate, last_day(sysdate) from dual;
   
   --round 포맷모델 참고해서 보기!
 select hiredate, round(hiredate,'MONTH') from emp where deptno = 10;
 select hiredate, trunc(hiredate,'MONTH') from emp where deptno = 10;  

--to_char 날짜>문자   
   --입사일 출력 (요일까지) dy day
select to_char(hiredate,'yyyy/mon/dd dy') from emp where deptno = 20;
--시,분,초까지 꺼내오기   
select sysdate, to_char(sysdate,'yyyy/mm/dd, hh24:mi,ss') from dual;
--to_char 숫자>문자 L은 지역 화폐단위 표시
select ename, sal, to_char(sal,'L999,999') from emp where deptno = 10;
select ename, sal, to_char(sal,'$999,999') from emp where deptno = 10;

--문자열을 지정한 형식에 맞춰 숫자로 바꾸는 to_number
-- select '10,000' + '20,000' from dual;  에러남
select to_number('10,000','99,999') + to_number('20,000','99,999') from dual; 

--19821209에 입사한 사원 정보 출력
select * from emp where hiredate = to_date(19821209,'yyyymmdd');

--올 해 며칠이 지났는지 날짜 계산
select round(sysdate - to_date('2022/01/01','yyyy/mm/dd')) from dual;

--null 처리하는 nvl,nvl2
--연봉구하기 sal*12+comm
select ename,sal*12+comm 연봉, sal*12+nvl(comm,0) 연봉2 from emp; --comm 이 널이면 곱한값이 널 나옴;; > nvl로 처리!
select ename,nvl2(comm,sal*12+comm,sal*12) from emp;

--모든 사원은 자신의 상관(manager)이 있다. 하지만 emp 테이블에 유일하게 상관이 없는 레코드가 있는데
--그 사원의 mgr 칼럼값이 null이다. 그 사원만 출력하되 mgr 칼럼 값이 null대신 ceo로 출력!
select empno,ename,nvl(to_char(mgr),'ceo') from emp where mgr is null;
select empno,ename,nvl2(mgr,to_char(mgr),'ceo') from emp where mgr is null;

--decode(값(표현식),조건식1,결과1,조건식2,결과2,...,기본결과) 기본결과는 따로 안써도 됨!(조건식 다 아닐 때 나오는 결과)
select ename,deptno,decode(deptno,10,'ACCOUNTING',20,'RESEARCH',30,'SALES',40,'OPERATIONS') dname from emp;

-/*case when 조건1 then 결과1
            when 조건2 then 결과2
            when 조건n then 결과n
            else 결과
            end */
select ename,deptno,case when deptno = 10 then 'ACCOUNTING'
            when deptno = 20 then 'RESEARCH'
            when deptno = 30 then 'SALES'
            when deptno = 40 then 'OPERATION'
            END dname
            from emp;

--직급에 따라 급여를 인상하도록 하자(사원번호,사원명,직급,급여,인상된 급여(up sal))
--직급이 'analyst'인 사원은 5%, 'salesman'인 사원은 10%, 'manager'인 사원은 15%, 'clerk'인 사원은 20%인상!
select empno,ename,job,sal,case when job = 'ANALYST' then sal*1.05
            when job = 'SALESMAN' then sal*1.1
            when job = 'MANAGER' then sal*1.15
            when job = 'CLERK' then sal*1.2
            else sal end upsal
            from emp order by upsal;

--합계를 더하는 함수 sum
select to_char(sum(sal),'$999,999') total from emp;
select round(avg(sal)) from emp;
select min(sal) 최저급여, max(sal) 최대급여 from emp;
select count(*) from emp; --전체 레코드 개수 구하기
select sum(comm) from emp;
select avg(comm) from emp;
select count(comm) from emp;
--select sum(sal),sal from emp; 그룹함수는 그룹의 조건이 되는 캄럼과 그룹함수하고만 사용해야 한다.

--group by 컬럼명 / 해당 컬럼이 가지고 있는 값이 같은 레코드끼리 하나의 그룹으로 묶여진다.
--컬럼과 그룹함수하고만 사용해야 한다.
select sum(sal),round(avg(sal)) from emp group by deptno;

--각각 부서별로 사원 수와 커미션을 받는 사원 수 출력
select deptno,count(*) "부서별 사원 수",count(comm) as "커미션 받는 사원 수" from emp group by deptno order by deptno;
--부서별로 가장 최근에 입사한 사원의 입사일 출력
select deptno,max(hiredate) from emp group by deptno order by deptno;

select deptno,job,avg(sal) from emp group by deptno,job  order by deptno;

--having 그룹조건 
--반드시 group by 뒤에 와야 한다.
--그룹 조건에는 그룹함수를 사용한다.
select deptno,job,avg(sal) from emp group by deptno,job having avg(sal) > 2000 order by deptno;

SELECT DEPTNO, JOB, AVG(SAL) FROM EMP WHERE SAL >= 2000 GROUP BY DEPTNO, JOB ORDER BY DEPTNO, JOB;


select deptno, job, count(*),max(sal),sum(sal),avg(sal) from emp group by deptno,job order by deptno,job;
--데이터 합계 해주는 rollup
select deptno, job, count(*),max(sal),sum(sal),avg(sal) from emp group by rollup(deptno,job) order by deptno,job;
--데이터 합계 cube 
select deptno, job, count(*),max(sal),sum(sal),avg(sal) from emp group by cube(deptno,job) order by deptno,job;

--listagg ex
select deptno,ename from emp group by deptno,ename;
--ename을 ,로 나눠서 표시 돈 많이 받는 순서로
SELECT DEPTNO, LISTAGG(ENAME, ', ') WITHIN GROUP(ORDER BY SAL DESC) AS ENAMES FROM EMP GROUP BY DEPTNO;

--rank , dense_rank
SELECT ENAME 
     , SAL 
     , RANK() OVER (ORDER BY SAL DESC)       RANK 
     , DENSE_RANK() OVER (ORDER BY SAL DESC) DENSE_RANK 
  FROM EMP 
 ORDER BY SAL DESC;

--2.같은 직책의 사원이 3명 이상인 직책과 인원 수 출력
select job 직책,count(*) 인원 from emp group by job having count(*) >= 3;
--3.입사년도를 기준으로 부서별로 몇 명 입사했는지 출력
select to_char(hiredate,'yyyy') 입사년도,deptno 부서,count(*) 인원수 from emp group by to_char(hiredate,'yyyy'),deptno;
--4.추가수당을 받는 사원과 받지 않는 사원 수 출력
select nvl2(comm,'o','x') 추가수당,count(*) 인원 from emp group by nvl2(comm,'o','x');

--join
select * from emp,dept order by empno; --크로스조인
select * from emp,dept where emp.deptno = dept.deptno; --equi join : 컬럼의 값이 같은 경우 조인
select * from emp e, dept d where e.deptno = d.deptno; 

select * from salgrade;
select * from emp;
select e.empno,e.ename,s.grade from salgrade s, emp e where e.sal between s.losal and s.hisal;

--20번 부서 사원의 사번, 이름, 부서명을 출력하세요
select e.empno 사번, e.ename 이름, d.dname 부서명,e.deptno 부서번호 from emp e, dept d where e.deptno = d.deptno and e.deptno = 20;

-- inner join
select * from emp e inner join dept d on e.deptno = d.deptno;
-- inner join using 사용
select * from emp e inner join dept d using (deptno);
--natural join
select * from emp e natural join dept d;



