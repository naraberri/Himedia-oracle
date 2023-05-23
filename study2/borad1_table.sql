create table board1 (
 unq number not null primary key,--primary key 절대 중복되면 안되는 값
 title varchar2(100) not null,
 pass varchar2(100) not null,
 name varchar2(30),
 content varchar2(4000),
 rdate timestamp,
 hit number
);

alter table board1 modify hit number default '0';

insert into board1(unq,title,pass,name,content,rdate) values(1,'oracle수업',1234,'홍길동','냉무1',sysdate);
insert into board1(unq,title,pass,name,content,rdate) values(2,'java수업',1234,'김철수','냉무2',sysdate);
insert into board1(unq,title,pass,name,content,rdate) values(3,'html수업',1234,'나뭇잎','냉무3',sysdate);

commit;
--풀어보기

-- 1번문제 unq 1번의 제목,이름,내용을 출력한다.
select title,name,content from board1 where unq='1';

-- 2번문제 이름이 "김철수" 되어 있는 데이터를 출력한다.
select * from board1 where name='김철수';

-- 3번문제 번호,제목,이름을 아래의 형식으로 출력한다.
--     title
-- -----
-- 1:oracle수업:홍길동
select unq||':'||title||':'||name as title from board1;

-- 4번 문제 제목과 내용의 길이를 목록 출력한다.
-- oracle수업(4)
-- java수업(5)
-- html수업(5)
select title||'('||length(content)||')' as title from board1;

-- 5번문제 조회수를 모두 1000으로 변경한다.
update board1 set hit=1000;

-- 6번문제 2번의 조회수를 1500, 3번의 조회수를 2000으로 각각 .
update board1 set hit=1500 where unq='2';
update board1 set hit=2000 where unq='3';

commit;

-- 7번문제 최신글 순으로 출력한다.
select * from board1 order by rdate desc;

-- 8번문제 조회수 많은 순으로 출력한다.
select * from board1 order by hit desc;

-- 9번문제. 제목에서 "java"라는 단어가 들어가 있는 데이터 출력.
--like검색 -->  '%' : 문자열 , '.' : 문자한개(반드시)
--'%java%' : java 앞뒤로 어떤 문자열이 와도 좋다.
--'java%'    : java라는 단어로 시작하는 문자열.
--'.body%' : body라는 단어 앞에 문자한개가 반드시 있어야 하고 뒤에 어떠한 문자열이 와도 좋다
select * from board1 where title like '%java%';

-- 10번문제 unq3번의 조회수를 +100
update board1 set hit=hit+100 where unq='3';