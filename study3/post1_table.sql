--우편번호,시도,시구군,읍면동,리,섬,건물명

create table post1(
a1 varchar2(6),
a2 varchar2(50),
a3 varchar2(50),
a4 varchar2(50),
a5 varchar2(50),
a6 varchar2(50),
a7 varchar2(50)
);

alter table post1 modify a7 varchar2(100);

select count(*) from post1;

truncate table post1;

--풀어보기
--(1)테이블 전체 데이터(행기준)개수를 출력한다.
select count(*) from post1;

--(2)서울 지역의 데이터 개수를 출력한다.
select count(*) from post1 where a2 like '%서울%';

--(3)서울 지역의 데이터를 20개 출력한다.
select * from post1 where a2 like '%서울%' and rownum <=20;

--(4)서울 지역의 서초구를 출력한다.
select * from post1 where  a2 like '%서울%' and a3 like '%서초구%';

--(5)양재동을 검색하여 출력한다.
select * from post1 where a4 like '%양재%동%';

--(6)양재동이 무슨구에 속해있는지 '구' 이름만 출력한다.
select distinct(a3) from post1 where a4 like '%양재%동%';

--(7)달서구청을 검색하여 정확한 주소를 찾아 출력한다.
select * from post1 where a7 like '%달서구청%';

--(8)대구지역의 전체 '구' 이름만 출력한다.(단일 데이터로 출력,중복불허)
select distinct(a3) from post1 where a2 like '%대구%';

--(9)우편번호 : 306762를 검색하여 아래와 같이 똑같이 출력한다.
-- [306762] 대전광역시 대덕구 목상동 동원상수아파트
select '['||a1||']'||' '||a2||' '||a3||' '||a4||a5||a6||a7 as 주소 from post1 where a1='306762';

--(10)서울지역만 따로 추출하여 post_seoul 테이블을 생성한다
create table post_seoul as select * from post1 where a2 like '%서울%';
select count(*) from post1 where a2 like '%서울%';
select count(*) from post_seoul;
