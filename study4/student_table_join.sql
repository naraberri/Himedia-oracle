--기본 정보 테이블
create table h_member1 (
userid   varchar2(20)  not null primary key,
pass     varchar2(100) not null,
name     varchar2(20)  not null,
birthday date,        -- timestamp
phone    varchar2(20)
);

insert into h_member1(userid,pass,name,birthday,phone)
values('hong','1234','홍길동','2010-04-23','');
insert into h_member1(userid,pass,name,birthday,phone)
values('tiger','1111','호돌이','2010-11-11','010-5555-7777');
insert into h_member1(userid,pass,name,birthday,phone)
values('linux','qwer','토발즈','2010-08-17','010-2222-1234');
insert into h_member1(userid,pass,name,birthday,phone)
values('java','1212','고릴라','2010-01-02','010-1111-7777');

--점수 정보 테이블
create table h_score1 (
userid varchar2(20) not null primary key,
eng number default '0',
kor number default '0'
);

insert into h_score1(userid,eng,kor) 
values('hong','90','88');
insert into h_score1(userid,eng,kor) 
values('tiger','68','54');
insert into h_score1(userid,eng,kor) 
values('linux','98','62');

--학점 정보 테이블
create table h_grade1 (
 grade char(1),
 loscore number,  -- 정수 ,  number(6,2)
 hiscore number
);

insert into h_grade1(grade,loscore,hiscore) values('A','90','100');
insert into h_grade1(grade,loscore,hiscore) values('B','80','89');
insert into h_grade1(grade,loscore,hiscore) values('C','70','79');
insert into h_grade1(grade,loscore,hiscore) values('D','60','69');
insert into h_grade1(grade,loscore,hiscore) values('F','0','59');

--풀어보기
--(1)아이디,이름,영어점수,국어점수
select 
m.userid 아이디,
m.name 이름,
s.eng 영어점수,
s.kor 국어점수 
from h_member1 m,h_score1 s 
where m.userid = s.userid;

--(2)아이디,이름,영어점수,국어점수(조인되지 않은 데이터 출력)
select 
m.userid 아이디,
m.name 이름,
s.eng 영어점수,
s.kor 국어점수 
from h_member1 m,h_score1 s 
where m.userid = s.userid(+);

--(3)아이디,이름,총점,평균
select 
m.userid 아이디,
m.name 이름, (s.kor+s.eng) 합계,
(s.kor+s.eng)/2 평균 
from h_member1 m,h_score1 s 
where m.userid = s.userid;

--(4)아이디,이름,영어점수(학점)
select 
m.userid 아이디,
m.name 이름,
s.eng||'('||g.grade||')' 영어점수 
from h_member1 m,h_score1 s,h_grade1 g
where g.loscore <= s.eng and g.hiscore >= s.eng and m.userid = s.userid;

--서브쿼리 사용
select 
s.userid,
(select name from h_member1 where userid = s.userid) name,
s.eng,
g.grade 
from h_score1 s, h_grade1 g 
where s.eng between g.loscore and g.hiscore;

--(5)아이디,이름,국어점수(학점)
select 
m.userid 아이디,
m.name 이름,
s.kor||'('||g.grade||')' 국어점수 
from h_member1 m,h_score1 s,h_grade1 g
where g.loscore <= s.kor and g.hiscore >= s.kor and m.userid = s.userid;

--(6)아이디,이름,국어점수(학점),영어점수(학점)
select 
m.userid 아이디,
m.name 이름,
s.kor||'('||g1.grade||')' 국어점수,
s.eng||'('||g2.grade||')' 영어점수 
from h_member1 m,h_score1 s,h_grade1 g1,h_grade1 g2
where 
g1.loscore <= s.kor and g1.hiscore >= s.kor and 
g2.loscore <= s.eng and g2.hiscore >= s.eng and 
m.userid = s.userid;

--(7)아이디,이름,나이
select userid 아이디,name 이름,trunc(months_between(sysdate, birthday)/12) 나이 from h_member1;

-- to_char사용
select userid 아이디,name 이름,to_char(sysdate,'yyyy') - to_char(birthday,'yyyy') 나이 from h_member1;

--(8)총점합계 1등의 정보를 출력한다.(꼴등의 정보를 출력)
--순차정렬로 바꾸면 꼴등의 정보
select a.* from(
    select 
    m.userid 아이디,
    m.name 이름,
    (s.kor+s.eng) as 합계
    from h_member1 m,h_score1 s 
    where m.userid = s.userid order by 합계 desc) a where rownum = 1;

--(9)전화번호가 없는 데이터 출력
select * from h_member1 where phone is null;

--(10)회원이름 중 "홍"씨성을 검색한다
select * from h_member1 where name like '홍%';