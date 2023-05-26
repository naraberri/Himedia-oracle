--CONSTRAINTS(제약조건)
--컬럼에 대한 속성을 정의하는것이며 데이터 무결성을 보장하기 위한 용도로 사용된다.
--테이블이나 속성에 부적절한 데이터가 들어오는것을 사전에 차단하도록 규칙을 정하는것
--제약조건은 컬럼의 속성처럼 사용하지만 엄연히 데이터베이스의 객체이므로 고유의이름(제약조건 명)을 지정해주어야함
--사용자가 지정하지 않는 경우 oracle이 자동으로 부여해준다

--constraint 별칭도 중복허용 안됨
create table memberTest(
unq number not null,
id varchar2(30) not null,
pwd varchar2(100) not null,
name varchar2(30),
gender char(1),
rdate timestamp,
constraint mm_gender_ck check( gender in('M','F') ),    --성별은 M,F 두값만 인정.다른 값은 허용하면 안됨
constraint mm_unq_pk primary key(unq),                      --중복 null값 허용안됨.테이블에서 한개만 사용가능
constraint mm_id_un unique(id)                                   -- 중복값 허용안됨. null값은 허용
);


create sequence memberTest_seq
increment by 1
start with 1
maxvalue 99999;

insert into memberTest(unq,id,pwd,name,gender,rdate)
values(memberTest_seq.nextval,'test1','1234','홍길동','M',sysdate);

insert into memberTest(unq,id,pwd,name,gender,rdate)
values(memberTest_seq.nextval,'test2','5678','멍멍이','F',sysdate);

--컬럼에서 바로 제약조건 걸기
create table memberTest2(
unq number not null primary key,
id varchar2(30) not null unique,
pwd varchar2(100) not null,
name varchar2(30),
gender char(1) check( gender in('M','F')),
rdate timestamp
);

create table memberTest101(
unq number     primary key,
id varchar2(30) unique,
pwd varchar2(100) not null,
name varchar2(30) unique,
gender char(1) default 'M' check( gender in('M','F')),
rdate timestamp
);

create table memberTest102(
id varchar2(30) not null, --primary key(id,name)는 불가. 사용할려면 constraint으로 써야함
pwd varchar2(100) not null,
name varchar2(30) not null,
gender char(1),
rdate timestamp,
constraint mm_gender_ck1 check( gender in('M','F') ),
constraint mm_id_pk1 primary key(id,name) -- 대상컬럼중 하나의 값만 틀려도 허용함. 완전히 똑같다면 오류.(and연산)
);

insert into memberTest102(id,pwd,name,gender,rdate)
values('test1','1234','멍멍이','M',sysdate);

insert into memberTest102(id,pwd,name,gender,rdate)
values('test2','1234','야옹이','F',sysdate);

insert into memberTest102(id,pwd,name,gender,rdate)
values('test3','5678','야옹이','F',sysdate);

insert into memberTest102(id,pwd,name,gender,rdate)
values('test3','5678','야옹이','F',sysdate);

insert into memberTest102(id,pwd,name,gender,rdate)
values('test3','5678','토순이','F',sysdate);

comment on table memberTest is '회원테이블';
comment on column memberTest.unq is '고유번호';
comment on column memberTest.id is '아이디';

select * from user_col_comments where table_name='MEMBERTEST'; --컬럼 comments확인
select * from user_tab_comments where table_name='MEMBERTEST'; --테이블 comments확인