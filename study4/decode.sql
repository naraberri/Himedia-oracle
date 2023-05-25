--조건함수 decode()
--특정 컬럼 필드 값의 비교값을 나열하여 치환하는 함수
--decode(컬럼명,비교값1,치환값1,비교값2,치환값2,..........)

--부서테이블에서 부서번호,부서명,부서명 출력
select 
    deptno,
    dname,
    decode(deptno,10,'회계',20,'조사',30,'영업',40,'기획') dname2
from dept;

--사원의 급여를 출력한다.(조건: 사원테이블에서 부서번호가 10인 사원만 급여에서 1.1 인상한다.)
select
    ename,
    sal,
    deptno,
    decode(deptno,10,sal*1.1) 인상급여
from emp;

--풀어보기1
--부서번호 10인 사원은 급여에서 1.1 20인 사원은 1.2 다른부서는 1.3을 인상하여 출력한다.
select
empno 사원번호,
sal 급여,
decode(deptno,10,sal*1.1,20,sal*1.2,30,sal*1.3,40,sal*1.3) 인상급여
from emp;

--풀어보기2
--emp 테이블에서 아래와 같이 설정하여 출력한다.
--job => ANALYST:분석가,CLERK:점원,MANAGER:관리자,SALESMAN:영업사원,PRESIDENT:사장님
select 
e1.*,decode(e2.job,'ANALYST','분석가','CLERK','점원','MANAGER','관리자','SALESMAN','영업사원','PRESIDENT','사장님') 직책
from emp e1,emp e2 
where e1.ename = e2.ename order by e1.sal desc;

--풀어보기3
--사원급여가 2000보다 많으면 상, 그렇지 않으면 하
select 
e.*,decode(s.grade,1,'하',2,'하',3,'하',4,'상',5,'상') 등급 
from emp e,salgrade s 
where e.sal between s.losal and s.hisal order by e.sal desc;

--풀어보기4
--job: ANALYST:sal*1.10,CLERK:sal*1.15,MANAGER:sal*1.20
select 
ename,sal,nvl(decode(job,'ANALYST',sal*1.10,'CLERK',sal*1.15,'MANAGER',sal*1.20),0) 인상급여 
from emp;

--풀어보기5
--1월~6월까지 년도와 상관없이 해당 월에 입사한 사람 수를 출력하시오.
select count(decode(to_char(hiredate,'mm'),01,1,02,1,03,1,04,1,05,1,06,1)) 입사인원 from emp where to_char(hiredate,'mm')<=6;
