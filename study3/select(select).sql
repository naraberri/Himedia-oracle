--풀어보기
--(1) 2000년 이후 입사한 사원의 사원번호,사원명,입사일(0000-00-00) 출력
select empno,ename,to_char(hiredate,'yyyy-mm-dd') from emp where to_char(hiredate,'YYYY') >= 2000;

--(2)SMITH의 부서명을 출력한다.
select deptno from emp where ename=upper('smith'); --20
select dname from dept where deptno=20;
select ( select  dname from dept where deptno=emp.deptno) as 부서명 from emp where ename=upper('smith');

--(3)전체 출력 사원번호,사원명,부서명을 출력한다.
select empno,ename, (select dname from dept where deptno=emp.deptno)as dname from emp;

--(4)SMITH와 같은 부서 사람들을 출력한다.
select * from emp where deptno=(select deptno from emp where ename=upper('smith'));
--select * from emp where deptno=(select deptno from emp where ename='SMITH' and rownum=1);
--일단 오류를 피하기 위해 rownum을 많이 씀

--(5)SMITH가 속해 있는 부서의 평균 급여를 출력한다.
select round(avg(sal),2) as 평균급여 from emp where deptno=(select deptno from emp where ename=upper('smith') and rownum=1);

--(6)SMITH보다 급여를 많이 받는 직원들을 출력한다.
select empno,ename,sal,deptno from emp where sal > (select sal from emp where ename=upper('smith') and rownum=1) order by sal desc;

--(7)전체 평균 급여보다 많이 받는 직원들을 출력한다.
select empno,ename,sal,deptno,(select round(avg(sal),2) from emp)as 평균급여 from emp where sal > (select avg(sal) from emp) order by sal desc;
select empno,ename,sal,deptno,avg(sal) over() from emp where sal > (select avg(sal) from emp) order by sal desc;
--over() 단일함수를 같이 출력시켜줌. 낮은버전에선 지원되지않음.

--(8)급여를 가장 많이 받는 사원의 정보(사원번호,사원명,급여)를 출력한다
select empno,ename,sal from emp where sal = (select max(sal) from emp where ename!='KING');