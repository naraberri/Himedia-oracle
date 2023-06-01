--풀어보기
create table emp101 
        as select empno,ename,job from emp where 1=2;
        
create table emp102 
        as select empno,ename,job from emp;

-- 기본 1001부터 시작해서 하나씩 증가(max 사용)
insert into emp101 (empno,ename,job) values ((select nvl(max(empno),1000)+1 from emp101),v_ename,MANAGER);

-- 기본 1001부터 시작해서 하나씩 증가(시퀀스 사용)

create sequence emp102_empno_seq
increment by 1 --증감값
start with 1001 --시작값
maxvalue 99999;

insert into emp102 (empno,ename,job) values (emp102_empno_seq.nextval,v_ename,MANAGER);

--sm1001,sm1002 goods테이블에 자동으로 넣기 (사용자 함수사용)
create table goods (code varchar2(20),name varchar2(20) );

create or replace function fn_goods_code1

return varchar2
is
    v_code varchar2(20);
    v_cnt number;
begin
    select count(*) into v_cnt from goods;
    if v_cnt = 0 then
        v_code := 'sm'||1001;
    else
        v_code := 'sm'||(1001+v_cnt);
    end if;
    return v_code;
end;
/
/*
create or replace function fn_goods_code1

return varchar2
is
    v_code1 varchar2(20);
    v_code2 varchar2(20);
begin
    select nvl(max(code),'sm1000') into v_code1 from goods;
    
    select substr(v_code1,3)+1 into v_code1 from dual;
    v_code2 := 'sm'||v_code1;
    
    return v_code2;
end;
*/

insert into goods values( fn_goods_code1(),'dress');

--sm0001,sm0002 goods테이블에 자동으로 넣기 (사용자 함수사용)
create table goods2 (code varchar2(20),name varchar2(20) );
create or replace function fn_goods_code2

return varchar2
is
    v_code varchar2(20);
    v_cnt number;
begin
    select count(*) into v_cnt from goods2;
    if v_cnt = 0 then
        v_code := 'sm'||lpad(1,4,0);
    else
        v_code := 'sm'||lpad(1+v_cnt,4,0);
    end if;
    return v_code;
end;
/

create or replace function fn_goods_code4

return varchar2
is
    v_code1 varchar2(20);
    v_code2 varchar2(20);
begin
    select nvl(max(code),'sm0000') into v_code1 from goods2;
    
    select lpad(substr(v_code1,3)+1,6,0) into v_code1 from dual;
    v_code2 := 'sm'||v_code1;
    
    return v_code2;
end;
/

insert into goods2 values( fn_goods_code4(),'dress');