--가상테이블로 실제 용량이 존재하지 않는다.
--조인등 복잡한 쿼리의 단순화 작업을 위해 주로 사용된다.

--sqlplus sys/1234 as sysdba
--grant create view to 사용자명
--exit

create view v_emp_copy as select * from emp;

select * from v_emp_copy;

--테이블명이 길어지더라도 어떤 용도의 테이블인지 알 수 있게 명확하게 적는게 좋다.
--급여를 많이 받는 순으로 정리되어 있는 뷰
create view v_emp_sal_desc as 
select b.* from(
select rownum rn,a.* from(
select empno,ename,job,sal from emp order by sal desc
) a ) b;

select * from v_emp_sal_desc where rn >=6 and rn <= 10;

update v_emp_sal_desc set sal = 6000 where ename='KING';--view테이블은 가상으로 존재하기 때문에 실행이 안됨

--부서명 RESEARCH와 같은 부서에서 근무하는 직원들의 목록을 뷰테이블 처리하기.
create view v_research as
select d.deptno,d.dname,e.empno,e.ename 
from emp e,dept d 
where e.deptno=d.deptno and dname='RESEARCH';