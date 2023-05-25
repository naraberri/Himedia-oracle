create table student(
userid varchar2(20) not null, --크기 가변
username char(10) not null, --크기 고정(공간낭비 방지.
age number,
gender char(1), --M,F
grade char(1) --1,2,3
);

insert into student values('st101','Tom',15,'M','2');
insert into student values('st102','Jane',16,'F','3');
insert into student values('st103','Yakima',14,'M','1');
insert into student (userid,username,age,grade) values('st104','Yong',14,'1');
insert into student (userid,username,age,gender) values('st105','Minyo',0,'F');
insert into student (userid,username,age,grade) values('st106','Kang',15,'2');
insert into student (userid,username,age,gender) values('st107','Kim',0,'M');
insert into student values('st108','Miranda',15,'F','2');
commit;

--Alias(출력타이틀 변경)
select username as 이름,userid as 아이디 from student;

--Order by(순차적/역순 정렬)
--역순정렬
select * from student order by age desc;
--순차정렬
select * from student order by age asc;

--Distinct(데이터 중복 제거)
select age from student;
select distinct(age) from student; --단일값만 출력

--통계함수
select count(*) from student; --8
select sum(age) from student; --89
select avg(age) from student; --11.125
select min(age) from student; --0
select max(age) from student; --16

--풀어보기1

--1학년들의 이름을 출력하시오
select username from student where grade='1';
--15세 이상 이름과 나이를 출력하시오
select username,age from student where age >= 15;
--성별이 기록되어있지 않은 데이터의 아이디 값을 출력하시오(null값)
select userid from student where gender is null;

--풀어보기2

--아이디 st101과 st102의 이름,연령,학년을 출력하시오
select username,age,grade from student where userid='st101' or userid='st102';
--15세 이상의 여학생들만 전체 출력하시오
select * from student where age >= 15 and gender='F';
--2학년 남학생들의 아이디와 이름만을 출력하시오
select userid,username from student where grade='2' and gender='M';
--남자학생들의 평균연령을 출력하시오 (연령 값 0은 계산 제외)
select avg(age) from student where gender='M' and age > 0;
--남학생들을 연령순으로 순차적 정렬을 하시오
select * from student order by age asc;

savepoint sp1;

--풀어보기3

--아이디 st105의 연령을 14세로 대입한다
update student set age=14 where userid='st105';
--아이디 st107의 연령을 15세로 대입한다
update student set age=15 where userid='st107';
--학년이 비워 있는 곳에 아래와 같은 기준으로 데이터를 채운다
-- 연령14세:1 , 15세:2 , 16세:3
update student set grade=1 where grade is null and age = 14;
update student set grade=2 where grade is null and age = 15;
--성별이 비워있는 데이터의 값을 모두 남성 처리한다
update student set gender='M' where gender is null;

rollback sp1;