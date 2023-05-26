--foreign key  references
--constraint 외래키 별칭 foreign key(컬럼명) references 외래테이블명(컬럼명)

create table student11(
userid varchar2(20) not null primary key,
name varchar2(20)
);

create table jumsu11(
userid varchar2(20) not null,
kor number default 0,
eng number default 0,
constraint jumsu11_fk foreign key(userid) references student11(userid)
);

create table jumsu12(
userid varchar2(20) not null,
kor number default 0,
eng number default 0,
constraint jumsu12_fk foreign key(userid) references student11(userid) on delete cascade
);

insert into student11 values('a1','홍길동');
insert into student11 values('a2','심청이');
insert into student11 values('a3','연놀부');

insert into jumsu11 values('a1',100,90);
insert into jumsu11 values('a2',90,70);
--insert into jumsu11 values('a5',88,68); --a5값의 데이터가 student11에 없으므로 무결성 제약조건 위배

update student11 set userid='a30' where userid='a3';
update student11 set userid='a20' where userid='a2'; --a2에 대한 자식값이 jumsu11에 있으므로 무결성 제약조건 위배

delete from student11 where userid='a30';
delete from student11 where userid='a1'; --a2에 대한 자식값이 jumsu11에 있으므로 무결성 제약조건 위배
delete from student11 where userid='a2'; --a2에 대한 자식값이 jumsu11에 있으므로 무결성 제약조건 

--제약조건 삭제
alter table jumsu11 drop constraint jumsu11_fk;
delete from student11 where userid='a1'; --제약조건이 삭제되었기 때문에 삭제 가능

--제약조건 추가/수정
alter table jumsu11 add constraint jumsu11_pk2 foreign key(userid) references student11(userid); -- a1을 삭제했기때문에 오류

insert into student11 values('a1','빙수네');

alter table jumsu11 add constraint jumsu11_pk2 foreign key(userid) references student11(userid);--a1에 대한 부모키가 생겼기때문에 생성 가능

delete from student11 where userid='a1'; --제약조건이 다시 생겼기때문에 삭제안됨

alter table jumsu11 drop constraint jumsu11_pk2;

--제약조건 cascade
--constraint jumsu12_fk foreign key(userid) references student11(userid) on delete cascade
insert into jumsu12 values('a1',100,90);
insert into jumsu12 values('a2',90,70);

delete from student11 where userid='a1'; -- student11 a1에 연결된 jumsu12의 a1도 같이 삭제됨


