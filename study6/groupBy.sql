--부서별 평균급여 출력
select (select round(avg(sal),2) from emp where deptno='10')as"10 avg",
         (select round(avg(sal),2) from emp where deptno='20')as"20 avg",
         (select round(avg(sal),2) from emp where deptno='30')as"30 avg",
         (select round(avg(sal),2) from emp where deptno='40')as"40 avg"
from
    dual;

--부서별 평균급여 출력(group by사용)
select deptno,round(avg(sal),2) from emp
    group by deptno
        order by deptno;
        
--부서번호,최고급여,최저급여를 부서별 출력
select deptno,max(sal),min(sal) from emp 
    group by deptno 
        order by deptno;
        
--부서번호,최고급여,최저급여를 부서별 출력(최저급여가 1000이상인 데이터)
select deptno,max(sal),min(sal) from emp 
    group by deptno
        having min(sal) >=1000;
        
--직무별 평균 급여 출력
select job,to_char(round(avg(sal)),'999,999') from emp
    group by job;
    
--직무별 최고 급여 출력
select job,max(sal) from emp
    group by job
        order by max(sal) desc;
        
--부서별 부서번호와 평균급여(평균급여가 2000 이상인 부서)
select deptno,round(avg(sal)) from emp
    group by deptno
        having avg(sal) >=2000;
        
--각 부서별 평균 연봉을 구하고 그 중에서 평균 연봉이 가장 적은 부서의 평균연봉보다 적게받는 직원들의 직원번호,급여 출력
select empno,ename,sal from emp
    where
        sal<(select min(round(avg(sal))) salAvg from emp
        group by deptno);

--풀어보기
--부서별 사원수 조회
select deptno,count(deptno) from emp
    group by deptno
        order by deptno desc;
        
--아래 처럼 출력
select 
deptno,
count(deptno) as 사원수,
round(avg(sal)) as 급여평균,
sum(sal) as 급여합계 
from emp
    group by deptno
        order by deptno desc;
        
--사원수가 5명이 넘는 부서와 사원수 조회
select d.dname,count(e.deptno) as 사원수 from dept d,emp e
    where d.deptno = e.deptno
        group by d.dname
            having count(e.deptno) > 5;