create table student(
userid varchar2(20) not null, --ũ�� ����
username char(10) not null, --ũ�� ����(�������� ����.
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

--Alias(���Ÿ��Ʋ ����)
select username as �̸�,userid as ���̵� from student;

--Order by(������/���� ����)
--��������
select * from student order by age desc;
--��������
select * from student order by age asc;

--Distinct(������ �ߺ� ����)
select age from student;
select distinct(age) from student; --���ϰ��� ���

--Ǯ���1

--1�г���� �̸��� ����Ͻÿ�
select username from student where grade='1';
--15�� �̻� �̸��� ���̸� ����Ͻÿ�
select username,age from student where age >= 15;
--������ ��ϵǾ����� ���� �������� ���̵� ���� ����Ͻÿ�(null��)
select userid from student where gender is null;

--Ǯ���2

--���̵� st101�� st102�� �̸�,����,�г��� ����Ͻÿ�
select username,age,grade from student where userid='st101' or userid='st102';
--15�� �̻��� ���л��鸸 ��ü ����Ͻÿ�
select * from student where age >= 15 and gender='F';
--2�г� ���л����� ���̵�� �̸����� ����Ͻÿ�
select userid,username from student where grade='2';
--�����л����� ��տ����� ����Ͻÿ� (���� �� 0�� ��� ����)
select avg(age) from student where gender='M' and age > 0;
--���л����� ���ɼ����� ������ ������ �Ͻÿ�
select * from student order by age asc;

savepoint sp1;

--Ǯ���3

--���̵� st105�� ������ 14���� �����Ѵ�
update student set age=14 where userid='st105';
--���̵� st107�� ������ 15���� �����Ѵ�
update student set age=15 where userid='st107';
--�г��� ��� �ִ� ���� �Ʒ��� ���� �������� �����͸� ä���
-- ����14��:1 , 15��:2 , 16��:3
update student set grade=1 where grade is null and age = 14;
update student set grade=2 where grade is null and age = 15;
--������ ����ִ� �������� ���� ��� ���� ó���Ѵ�
update student set gender='M' where gender is null;

rollback sp1;