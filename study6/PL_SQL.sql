--변수는 variable 이라는 명령어를 통해 선언하고 PL/SQL문에서는 : 과 함께 사용한다.

--변수를 이용한 출력
variable sal number;
declare   
    v_sal number :=3000;    
begin 
    :sal := v_sal/12;
end;
/
print sal;

--dbms 함수를 이용한 출력
--dbms 출력을 위한 처리
set serveroutput on;

declare
    v_sal number(8) := 3000;
    month_sal number(8);
begin
    month_sal := v_sal/12;
    dbms_output.put_line('내 급여는'||month_sal);
end;
/

--테이블타입 동기화
declare
    v_deptno dept.deptno%type;
    v_dname dept.dname%type;
begin
    select deptno,dname into v_deptno,v_dname
        from dept
            where loc='BOSTON';
    dbms_output.put_line( v_deptno||'->'||v_dname );
end;
/

--풀어보기1
--emp 테이블에서 부서번호 10인 데이터들의 평균 급여를 구하라.
declare
    v_avg number := 0;
begin
    select round(avg(sal)) into v_avg from emp
    where deptno = '10';
    dbms_output.put_line('10번 부서의 평균급여 : '||v_avg);
end;
/

--풀어보기2
--emp 테이블의 부서번호 10의 모든 comm 필드에 400 더하기 (단 null은 0으로 처리하여 연산)
declare
    v_comm emp.comm%type :=400;
begin
    update emp
        set comm = nvl(comm,0)+v_comm
    where deptno = 10;
end;
/

--select empno,comm from emp where deptno=10;
--rollback;

--외부데이터 입력
declare
    v_deptno dept.deptno%type := &dept_no;
    v_dname dept.dname%type;
begin
    select dname into v_dname
    from dept
    where deptno=v_deptno;
    dbms_output.put_line('부서명 : '||v_dname);
end;
/

--외부데이터 입력(if문 추가)
declare
    v_deptno dept.deptno%type := &dept_no;
    v_dname dept.dname%type;
    v_cnt number := 0;
begin
    select count(*) into v_cnt from dept
    where deptno = v_deptno;
    
    if v_cnt = 0 then
        dbms_output.put_line('없는 부서번호 입니다');
    else
        select dname into v_dname
        from dept
        where deptno=v_deptno;
        dbms_output.put_line('부서명 : '||v_dname);
    end if;
end;
/


