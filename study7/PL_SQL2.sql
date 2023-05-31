set serveroutput on;

-- loop문
declare
    cnt number := 1;
begin
    loop
        dbms_output.put_line(cnt);
        cnt := cnt+1;
        exit when cnt > 10;
    end loop;
end;
/

--for문 (..이 범위표현)(차감할때는 in reverse 1..10)
declare
begin
    for i in reverse 1..10
    loop
        dbms_output.put_line(i);
    end loop;
end;
/

--구구단 출력(for)
declare
    v_cnt number :=&n;
begin
    for i in 1..9
    loop
        dbms_output.put_line(v_cnt||'*'||i||'='||v_cnt*i);
    end loop;
end;
/

--전체구구단 출력
declare

begin
    for i in 1..9 loop
        for j in 2..9 loop
            dbms_output.put_line(i||'*'||j||'='||j*i);
            dbms_output.put_line(' ');
        end loop;
    dbms_output.put_line('');
    end loop;
end;
/

--1~10출력(while)
declare
    v_cnt number :=1;
begin
    while v_cnt <= 10 loop
        dbms_output.put_line(v_cnt);
        v_cnt := v_cnt+1;
    end loop;
end;
/

--풀어보기
--외부데이터로 사원번호를 받아 emp 테이블에서 아래 내용 출력
--사원번호:7788 사원명:TOM 급여:780
declare
        v_empno number := &empno;
        v_ename varchar2(100);
        v_sal number;
        v_cnt number :=0;
begin
    select count(*) into v_cnt from emp
        where empno = v_empno;
    if v_cnt = 0 then
        dbms_output.put_line('존재하지 않는 직원입니다');
    else
        select empno,ename,sal into v_empno,v_ename,v_sal from emp
        where empno = v_empno;
        dbms_output.put_line('사원번호:'||v_empno||' 사원명:'||v_ename||' 급여:'||v_sal);
    end if;
end;
/

--dept 테이블에 데이터 입력하기(부서번호/부서명/부서위치를 외부데이터 받기)
--부서번호와 부서명의 중복방지
declare
    v_deptno dept.deptno%type := &p_deptno;
    v_dname dept.dname%type := '&p_dname';
    v_loc dept.loc%type := '&p_loc';
    v_cnt number :=0;
begin
    select count(deptno) into v_cnt from dept
        where deptno = v_deptno or dname = v_dname;
    if v_cnt = 0 then
        insert into dept(deptno,dname,loc) values(p_deptno,p_dname,p_loc);
        dbms_output.put_line('입력되었습니다');
    else
        dbms_output.put_line('이미 있는 부서번호 입니다');
        end if;
end;
/

--dept 테이블에 데이터 수정하기(부서번호/부서명/부서위치를 외부데이터 받기)
--부서번호 존재유무 / 부서명의 중복방지
declare
    v_deptno dept.deptno%type := &p_deptno;
    v_dname dept.dname%type := '&p_dname';
    v_loc dept.loc%type := '&p_loc';
    v_cnt number :=0;
begin
    select count(deptno) into v_cnt from dept
        where deptno = v_deptno or dname = v_dname;
    if v_cnt = 0 then
        dbms_output.put_line('없는 번호입니다');
    else
        update dept set dname = v_dname,loc = v_loc where deptno = v_deptno;
        dbms_output.put_line('업데이트 완료되었습니다');
        end if;
end;
/

--emp테이블에 관련 부서의 직원이 존재하면 삭제 불가
/* 외부에서 삭제할 부서번호 받음
    dept테이블에 부서번호의 존재유무체크 (존재하지 않을 경우 메세지 - 존재하지 않는 부서 번호입니다.)
    emp테이블에 소속직원의 존재유무 체크 (존재할 시 메세지 - 삭제할 수 없습니다.소속 직원이 존재합니다.)
    삭제처리함
*/
declare
    v_deptno dept.deptno%type := &deptno;
    v_cnt number :=0;
begin
    select count(deptno) into v_cnt from dept
        where deptno = v_deptno;
        
    if v_cnt = 0 then
        dbms_output.put_line('존재하지 않는 부서 번호입니다');
    else
        select count(ename) into v_cnt from emp
        where deptno = v_deptno;
        if v_cnt > 0 then
            dbms_output.put_line('삭제할 수 없습니다.소속 직원이 존재합니다.');
        else
            delete from dept where deptno =  v_deptno;
            dbms_output.put_line('삭제 완료되었습니다.');
        end if;
    end if;
end;
/

--테이블의 code라는 컬럼에 1씩 증가시켜서 값을 넣기
--create table test80 (code varchar2(5)); --loop사용
create table test80 (code varchar2(5));

declare
    cnt number :=1;
begin
    loop
        insert into test80 values ('a'||cnt);
        cnt := cnt+1;
        exit when cnt > 10;
    end loop;
end;
/
select * from test80;

--1~100까지의 누적합계
--for i loop 형식
declare
    hap number :=0;
begin
    for i in 1..100
    loop
        hap := hap+ i;
    end loop;
    dbms_output.put_line(hap);
end;
/

--급여인상 (매개변수로 사원번호 입력) 프로그램 만들기
--0~1000은 +100, 1001~2000은 +110, 2001~3000은 +120 그 이상은 없음
declare
    v_empno emp.empno%type := &empno;
    v_cnt number;
    v_sal1 emp.sal%type;
    v_sal2 emp.sal%type :=0;
begin
    select count(*) into v_cnt from emp
        where empno = v_empno;
    if v_cnt = 0 then
        dbms_output.put_line(v_empno||'는 없는 번호입니다.');
    else
        select sal into v_sal1 from emp where empno = v_empno;
        if v_sal1 <=1000 then
            v_sal2 := v_sal1+100;
        elsif v_sal1 between 1001 and  2000 then
            v_sal2 := v_sal1+110;
        elsif v_sal1 between 2001 and  3000 then
            v_sal2 := v_sal1+120;
        else
             v_sal2 := v_sal1;        
        end if;
        update emp set sal=v_sal2 where empno = v_empno;
    end if;
end;
/

declare
    v_empno emp.empno%type := &empno;
    v_cnt number;
    v_sal1 emp.sal%type;
    v_sal2 emp.sal%type :=0;
begin
    select count(*) into v_cnt from emp
        where empno = v_empno;
    if v_cnt = 0 then
        dbms_output.put_line(v_empno||'는 없는 번호입니다.');
    else
        select sal into v_sal1 from emp where empno = v_empno;
        case when v_sal1 <=1000 then
            v_sal2 := v_sal1+100;
        when v_sal1 between 1001 and  2000 then
            v_sal2 := v_sal1+110;
        when v_sal1 between 2001 and  3000 then
            v_sal2 := v_sal1+120;
        else
            v_sal2 := v_sal1;
        end case;
        update emp set sal=v_sal2 where empno = v_empno;
    end if;
end;
/