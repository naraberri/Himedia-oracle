--Equi Join(등가 조인)
--(1)사원번호,사원이름,부서이름을 출력한다.
select e.empno as empno,
         e.ename as ename,
         d.dname as dname,
         e.deptno as deptno
from emp e , dept d 
where e.deptno = d.deptno; --join의 기본형태 as는 생략가능
       
--Non-equal Join(비 등가 조인)
--(1)사원명과 사원급여의 등급을 출력한다.
select e.ename ename,
         e.sal sal,
         s.grade ||'등급' grade
from emp e , salgrade s
where e.sal between s.losal and s.hisal order by s.grade desc;

--Outer Join
--(1)Equi Join의 결과를 통해 출력되지 않았던 데이터까지 모두 출력한다.
select e.empno as empno,
         e.ename as ename,
         d.dname as dname,
         e.deptno as deptno
from emp e , dept d 
where e.deptno(+) = d.deptno;
--emp테이블의 deptno40 값이 없어서 OPERATIONS은 출력이 안됨
--emp테이블의 deptno에 +가 되면서 dept의 40번까지 나오게됨

--Self Join
--(1)하나의 테이블에서 서로 연관이 있는 컬럼을 갖고 있을 때 가능
select a.ename ||'의 상사는 '||b.ename||'이다.' as 직속상사관계
from emp a , emp b
where a.mgr = b.empno;
