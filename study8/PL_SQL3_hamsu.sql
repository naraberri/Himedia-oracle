--함수
/* pl/sql 블록에는 적어도 한 개의 return문이 있어야한다.
    pl/sql block은 함수가 수행 할 내용을 정의한 몸체부분이다.
    replace는 존재 할 경우 새로 만들겠다는 뜻
*/ 

insert into emp(empno,ename,job)
values((select max(empno)+1 from emp),'HTML1','HTML');

--매개변수의 합계를 구한다.
create or replace function fn_mysum
                            (v_num1 in number,v_num2 in number)
return number
is  --declare
    v_sum number;
begin
    v_sum :=v_num1+v_num2;
    return v_sum;
end;
/

select fn_mysum(10,20) as 결과값 from dual;

--부서번호를 입력받아 해당 부서의 급여 합계를 구하는 함수
create function fn_dept_sal_sum
            (v_deptno in number)
return number
is
    v_sum number;
begin
    select sum(sal) into v_sum from emp
    where deptno=v_deptno;
    return v_sum;
end;
/

select fn_dept_sal_sum(10) as 급여합계 from dual;

--풀어보기
--사원번호를 입력받아 급여+커미션을 리턴하는 함수 작성
--null값은 0으로 처리하여 계산
create or replace function fn_emp_sal_comm_sum
                (v_empno in number)
return number
is
    v_sal number :=0;
begin
    select nvl(sal,0)+nvl(comm,0) into v_sal from emp
    where empno = v_empno;
    return v_sal;
end;
/

select fn_emp_sal_comm_sum(7876) from dual;

--직원명을 입력받아 부서명을 검색하는 함수를 작성
create function fn_dept_name
                (v_ename in varchar2 )
return varchar2
is
    v_deptno number;
    v_dname varchar2(50);
begin
    select e.deptno,d.dname into v_deptno,v_dname from emp e,dept d
    where e.ename = v_ename and d.deptno = v_deptno;
    return v_dname;
end;
/

/*
create or replace function fn_dept_name
                (v_ename emp.ename%type )
return varchar2
is
    v_deptno number;
    v_dname dept.dname%type;
begin
    select deptno into v_deptno from emp
    where ename = v_ename;
    select dname into v_dname from dept
    where deptno = v_deptno;
    return v_dname;
end;
*/


select fn_dept_name('WARD') from dual;

--예제
--직원명을 입력받아 부서번호,부서명,위치 정보를 리턴하는 함수를 작성
create function fn_dept_info
                (v_name in varchar2)
return varchar2
is
    v_no number;
    v_dnm varchar2(50);
    v_loc dept.loc%type;
    datas varchar2(100);
begin
    select deptno into v_no from emp where ename=upper(v_name);
    select dname,loc into v_dnm,v_loc from dept where deptno = v_no;
    datas := v_no||','||v_dnm||','||v_loc;
return datas;
end;
/

select fn_dept_info('WARD') from dual;

--emp 테이블의 전체 데이터 개수와 총 페이지 개수를 리턴한다.
create or replace function fn_empCnt1(no number)
return varchar2
is
    tCnt number;
    tPage number;
    returnVal varchar2(100);
begin
    select count(*) into tCnt from emp;
    select ceil(tCnt/no) into tPage from dual;
    returnVal := tCnt||'/'||tPage;
return returnVal;
end;
/

create function fn_empPageCnt
                (unit number)
return varchar2
is
    tCnt number;
    tPage number;
    str varchar2(100);
begin
    select count(*) into tCnt from emp;
    select ceil(tCnt/unit) into tPage from dual;
end;
/

--풀어보기
--사원번호를 입력 받아 입사년차를 얻는다.
--select fn_periodYear(7788) from emp;

create function fn_periodYear
                (v_empno in number)
return varchar2
is
    v_hiredate number;
begin
    select 
       to_char(sysdate,'yyyy') - to_char(hiredate,'yyyy') into v_hiredate
    from emp where empno = v_empno;
return v_hiredate||'년';
end;
/

select fn_periodYear(7900) from dual;

--해당 직원의 매니저 이름 출력
--select fn_mgrName(7788) from emp;

create function fn_mgrName
                (v_empno in number)
return varchar2
is
    v_ename1 emp.ename%type;
    v_ename2 emp.ename%type;
    v_mgr emp.mgr%type;
    returnVal varchar2(100);
begin
    select ename,mgr into v_ename1,v_mgr from emp where empno=v_empno;
    select ename into v_ename2 from emp where empno=v_mgr;
    
    returnVal := v_ename1||'의 담당 매니저는 '||v_ename2||'입니다';
return returnVal;
end;
/

/*
select (select ename from emp where empno = e.mgr) as mgr_name from emp e where empno='7788';
*/
/*
select e2.ename from emp e1, emp e2 where e1.mgr = e2.empno and e1.empno='7788';
*/
select fn_mgrName() from dual;