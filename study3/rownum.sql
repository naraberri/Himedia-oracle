--rownum실습
select empno,ename,job from emp;
select rownum,empno,ename,job from emp;
desc emp;
select rownum,deptno,dname from dept;
select rownum,empno,ename,job from emp where rownum < 6; --rownum이 6보다 작은것만 출력
-- rownum은 oracle 내장함수이기때문에 rownum을 쓰지 않아도 확인 할 수 있음
select empno,ename,job from emp where rownum < 6;


select rownum,empno,ename,job from emp where rownum >= 6; -- 출력안됨
--rownum은 1번이 생성된 다음 증하는 형식으로 출력을 한다.
--첫 출력 조건부터 조건에 맞지 않아 출력되지 않고 
--그 다음 출력물에 1번을 붙이려고해도 조건에 맞지 않아 출력이 되지 않으므로 모두 출력이 안된다.

select a.* from ( select rownum as rn,empno,ename,job from emp ) a;--from 뒤에는 테이블의 구조를 갖춘 데이터가 와도 됨
select a.* from ( select rownum as rn,empno,ename,job from emp ) a where rn >= 6;
--외부 select에서도 rownum을 쓸 수도 있음.
--내부 rownum은 컬럼으로 인식될 수도 있기때문에 alias를 쓰는게 좋음
select a.* from ( select rownum as rn,empno,ename,job from emp ) a where rn >= 3 and rn <=7;

-- order by 컬럼명 (asc 또는 desc) asc는 생략가능(기본값)
select empno,ename,job from emp order by empno asc;
select rownum,empno,ename,job from emp order by empno asc; --order by 이전에 이미 rownum은 적용된 상태
select a.* from(select empno,ename,job from emp order by empno asc) a;
select a.* from( 
    select rownum rn,b.* from ( --rownum 데이터도 테이블화
        select empno,ename,job from emp order by empno asc) b) a 
where rn >= 6 and rn <= 10;

--급여기준 1등 ~ 5등 , 6등 ~ 10등
select a.* from( 
    select rownum rn,b.* from ( --rownum 데이터도 테이블화
        select empno,ename,job,sal from emp order by sal desc) b) a;
--(1) 1등 ~ 5등 사원번호,사원이름,업무,급여
select a.* from( 
    select rownum rn,b.* from ( --rownum 데이터도 테이블화
        select empno,ename,job,sal from emp order by sal desc) b) a 
where rn between 1 and 5;
--(2) 6등 ~ 10등 사원번호,사원이름,업무,급여
select a.* from( 
    select rownum rn,b.* from ( --rownum 데이터도 테이블화
        select empno,ename,job,sal from emp order by sal desc) b) a 
where rn between 6 and 10; -- where rn >=6 and rn <=10이 sql에서 속도는 더 빠를 수 있다.

--in 함수
--(1) 부서번호 10번, 20번 직원들 출력
select empno,ename,deptno from emp where deptno='10' or deptno='20';
select empno,ename,deptno from emp where deptno in(10,20);
select empno,ename,deptno from emp where job='CLERK' or job='ANALYST';
select empno,ename,deptno from emp where job in('CLERK','ANALYST');
--or는 연산속도는 빠르나 프로그램과 연동해서 쓰긴 힘들다.
