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

--풀어보기1
select username from student where grade='1'; --1번문제
select username,age from student where age >= 15; --2번문제
select userid from student where gender is null; --3번문제

--풀어보기2
select username,age,grade from student where userid='st101' or userid='st102'; --1번문제
select * from student where age >= 15 and gender='F'; --2번문제
select userid,username from student where grade='2'; --3번문제
select avg(age) from student where gender='M' and age > 0; --4번문제
select * from student order by age asc; --5번문제

savepoint sp1;

--풀어보기3
update student set age=14 where userid='st105'; --1번문제
update student set age=15 where userid='st107'; --2번문제
update student set grade=1 where grade is null and age = 14; --3번문제
update student set grade=2 where grade is null and age = 15; --3번문제
update student set gender='M' where gender is null; --4번문제

rollback sp1;