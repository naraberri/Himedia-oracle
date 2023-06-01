--procedure는 내부적으로 실행할때 사용(return값이 없음)

set serveroutput on;

--사원번호를 입력받아 급여를 출력하는 프로시저
create or replace procedure procTest1
                (v_empno in number)
is
    v_sal number;
begin
    select sal into v_sal from emp
    where empno = v_empno;
    dbms_output.put_line( v_sal );
end;
/

--사원번호를 입력받아 급여를 5000으로 update처리
create or replace procedure proc_up_sal
        ( v_empno emp.empno%type,
          v_sal emp.sal%type)
is

begin
    update emp set sal=v_sal
    where empno = v_empno;
    dbms_output.put_line( '업데이트 완료' );
end;
/

--풀어보기
--사원번호를 입력받아 삭제 처리하는 프로시저 생성
create or replace procedure proc_del_empno
            ( v_empno emp.empno%type)
is
    v_cnt number := 0;
begin
    select count(*) into v_cnt from emp
    where empno = v_empno;
    
    if v_cnt=0 then
        dbms_output.put_line( v_empno||'는 존재하지 않는 사번입니다' );
    else
        delete from emp where empno = v_empno;
        dbms_output.put_line( v_empno||' ::삭제 완료' );
    end if;
end;
/

--부서 급여 업데이트 - 부서번호를 입력받아 아래의 내용으로  update처리
create or replace procedure proc_dept_up_sal
            (v_deptno emp.deptno%type)
is

begin
    update emp set sal = decode(v_deptno,10,sal*1.2,20,sal*1.3,30,sal*1.1,sal*1)
    where deptno = v_deptno;
    dbms_output.put_line( '업데이트 완료' );
end;
/

create or replace procedure proc_emp_sal_update
            (v_deptno emp.deptno%type)
is

begin
    if v_deptno = 10 then
        update emp set sal = sal*1.2
        where deptno = v_deptno;
    elsif v_deptno = 20 then
        update emp set sal = sal*1.3
        where deptno = v_deptno;
    elsif v_deptno = 30 then
        update emp set sal = sal*1.1
        where deptno = v_deptno;
    else
        dbms_output.put_line( '급여인상 부서가 아닙니다. 더 노력하세요.' );
    end if;
    dbms_output.put_line( v_deptno|| ':: 변경완료' );
end;
/
--부서테이블에 부서 추가 입력 처리
--같은 deptno가 있는지 체크(같은 부서번호가 존재합니다) 라는 메세지 출력
create or replace procedure proc_dept_insert
            (v_deptno in dept.deptno%type,
             v_dname in dept.dname%type,
             v_loc in dept.loc%type)
is
    v_cnt number;
begin
    select count(*) into v_cnt from dept
    where deptno=v_deptno;
    
    if v_cnt=0 then
        insert into dept(deptno,dname,loc)
        values(v_deptno,v_dname,v_loc);
        dbms_output.put_line( v_deptno||'가 저장 처리 되었습니다.' );
    else
        dbms_output.put_line( '이미 사용중인 부서번호입니다.' );
    end if;
end;
/

