--null 값 함수 -nvl(),nvl2()

--실행 컬럼 필드 값이 null인 경우만 처리
--형식 : nvl(필드값,세팅값) null 값인 경우 세팅된 값을 리턴한다.

select ename,mgr from emp;
select ename,nvl(mgr,0) mgr from emp;--세팅값이 0
select ename,sal,sal+nvl(comm,0) sal2 from emp;--추가급여(comm)가 null인 데이터는 sal+0

--실행 컬럼 필드 값이 null인 경우의 처리와 null이 아닌 경우의 처리 두가지 경우를 둠
--형식 : nvl(필드값,처리1,처리2) 처리1:null 값이 아닌 경우,처리2:null 값인 경우
select empno,comm,nvl2(comm,comm+100,0) comm2 from emp; --추가급여(comm) 데이터가 있는경우 +100 아니면 +0