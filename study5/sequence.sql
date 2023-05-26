create sequence h_member2_unq_seq
increment by 1 --증감값
start with 1 --시작값
maxvalue 9999; --최대값

--기본 정보 테이블
create table h_member2 (
unq number not null primary key,
userid   varchar2(20)  not null,
pass     varchar2(100) not null,
name     varchar2(20)  not null,
birthday date,
phone    varchar2(20)
);

insert into h_member2(unq,userid,pass,name,birthday,phone)
values(h_member2_unq_seq.nextval,'hong','1234','홍길동','2010-04-23','');
insert into h_member2(unq,userid,pass,name,birthday,phone)
values(h_member2_unq_seq.nextval,'tiger','1111','호돌이','2010-11-11','010-5555-7777');
insert into h_member2(unq,userid,pass,name,birthday,phone)
values(h_member2_unq_seq.nextval,'linux','qwer','토발즈','2010-08-17','010-2222-1234');
insert into h_member2(unq,userid,pass,name,birthday,phone)
values(h_member2_unq_seq.nextval,'java','1212','고릴라','2010-01-02','010-1111-7777');

select h_member2_unq_seq.currval from dual;--현재 마지막 시퀀스 번호
select h_member2_unq_seq.nextval from dual;--다음에 올 시퀀스 번호

delete from h_member2 where unq='2';-- 2번을 삭제하고 새로운 데이터를 넣어도 2번에 들어가지 않는다.



create sequence nboard_seq
increment by 1
start with 1
maxvalue 99999999;

create table nboard (
unq number not null primary key,
title varchar2(100) not null,
name varchar2(20)
);

--select 시퀀스명.currval from dual; 현재 시퀀스 값
--select 시퀀스명.nextval from dual; 다음 시퀀스 값

select nboard_seq.currval from dual;
select nboard_seq.nextval from dual;

insert into nboard values(nboard_seq.nextval,'aaaaa','bbbbb'); 
--위에서 nboard_seq.nextval 한번 실행해서 2번부터 들어감
--고유의 값을 활용하기 위한거라 1번부터 들어가지 않아도 특별한 문제는 없음
select * from nboard;