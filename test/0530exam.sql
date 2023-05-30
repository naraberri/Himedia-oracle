--도서정보 명세서  테이블 생성
create table BOOK_TBL(
B_NO number not null,
B_NAME varchar2(50) not null,
B_COVERIMG varchar2(20),
B_DATE date,
B_PRICE number,
B_PUBLISHER varchar2(50),
B_INFO varchar2(2000),
constraint bt_bno_pk primary key(B_NO),
constraint bt_bname_un unique(B_NAME)
);

comment on table BOOK_TBL is '도서정보 명세서  테이블';
comment on column BOOK_TBL.B_NO is '도서번호';
comment on column BOOK_TBL.B_NAME is '도서명';
comment on column BOOK_TBL.B_COVERIMG is '표지';
comment on column BOOK_TBL.B_DATE is '출판일자';
comment on column BOOK_TBL.B_PRICE is '금액';
comment on column BOOK_TBL.B_PUBLISHER is '출판사';
comment on column BOOK_TBL.B_INFO is '도서소개';

--도서번호용 시퀀스
create sequence book_tbl_seq
increment by 1
start with 101
maxvalue 99999;

--도서정보 명세서 데이터입력
insert into 
book_tbl(b_no,b_name,b_coverimg,b_date,b_price,b_publisher,b_info)
values
(book_tbl_seq.nextval,'리눅스시작','101.png','22/01/01','24000','영진','운영체제와 네트워크');
insert into 
book_tbl(b_no,b_name,b_coverimg,b_date,b_price,b_publisher,b_info)
values
(book_tbl_seq.nextval,'자바초급','102.png','21/03/03','20000','시공사','프로그래밍 시작하기');
insert into 
book_tbl(b_no,b_name,b_coverimg,b_date,b_price,b_publisher,b_info)
values
(book_tbl_seq.nextval,'자바고급','103.png','22/08/20','30000','시공사','데이터베이스 연동');
insert into 
book_tbl(b_no,b_name,b_coverimg,b_date,b_price,b_publisher,b_info)
values
(book_tbl_seq.nextval,'오라클박사','104.png','23/02/02','32000','하움','테이블과 제약조건');
insert into 
book_tbl(b_no,b_name,b_coverimg,b_date,b_price,b_publisher,b_info)
values
(book_tbl_seq.nextval,'JAVASCRIPT','105.png','22/02/12','15000','다산북스','기초에서 계산기');

--대여정보 명세서 테이블 생성
create table RENT_TBL(
R_NO number not null,
B_NO number not null,
R_PRICE number default 0 not null,
R_DATE date not null,
R_STATUS char(1) default 0 not null,
constraint rent_tbl_fk foreign key(B_NO) references  book_tbl(B_NO),
constraint rt_rno_pk primary key(R_NO),
constraint rt_rstatus_ck check( R_STATUS in('0','1') ) --( 0또는1, 대여중(1) )
);

comment on table RENT_TBL is '대여정보 명세서 테이블';
comment on column RENT_TBL.R_NO is '대여번호';
comment on column RENT_TBL.B_NO is '도서번호';
comment on column RENT_TBL.R_PRICE is '대여금액';
comment on column RENT_TBL.R_DATE is '대여일자';
comment on column RENT_TBL.R_STATUS is '반납여부';

--대여번호용 시퀀스
create sequence rent_tbl_seq
increment by 1
start with 10001
maxvalue 99999;

--대여정보 명세서 데이터 입력
insert into
rent_tbl(r_no,b_no,r_price,r_date,r_status)
values
(rent_tbl_seq.nextval,'101','2400','23/05/20','0');
insert into
rent_tbl(r_no,b_no,r_price,r_date,r_status)
values
(rent_tbl_seq.nextval,'102','2000','23/05/20','0');
insert into
rent_tbl(r_no,b_no,r_price,r_date,r_status)
values
(rent_tbl_seq.nextval,'101','2400','23/05/21','0');
insert into
rent_tbl(r_no,b_no,r_price,r_date,r_status)
values
(rent_tbl_seq.nextval,'101','2400','23/05/22','0');
insert into
rent_tbl(r_no,b_no,r_price,r_date,r_status)
values
(rent_tbl_seq.nextval,'103','3000','23/05/22','1');
insert into
rent_tbl(r_no,b_no,r_price,r_date,r_status)
values
(rent_tbl_seq.nextval,'104','3500','23/05/22','1');
insert into
rent_tbl(r_no,b_no,r_price,r_date,r_status)
values
(rent_tbl_seq.nextval,'102','2000','23/05/25','1');

--commit
commit;

--문항6번 풀이
--(1) 도서정보 출력 - 전체출력 (전체 컬럼명 대신 “*” 사용가능)
select * from BOOK_TBL;

--(2) 도서정보 출력 - “네트워크”라는 내용이 있는 도서를 검색해서 책이름,책가격,출판사를 출력한다.
select 
b_name as 책이름,
b_price as 책가격,
b_publisher as 출판사
from BOOK_TBL 
where 
b_info like '%네트워크%';

--(3) 도서정보 출력 - 가장 가격이 비싼 책의 정보를 출력한다. ( 책번호, 책이름, 가격 )
select a.* from( 
    select 
        b_no as 책번호,
        b_name as 책이름,
        b_price as 가격 
    from BOOK_TBL order by b_price desc) a 
where rownum = 1;

--(4) 대여정보 출력 - 3개의 레코드(행)만 출력
select a.* from( 
    select * from RENT_TBL ) a 
where rownum <= 3;

--(5) 대여정보 출력 - 대여번호, 금액, 날짜, 반납여부   ( 반납여부는 “반납완료” 또는 “대여 중”으로 표기)
select 
r_no as 대여번호,
r_price as 금액,
r_date as 날짜,
decode(r_status,'0','반납완료','1','대여 중') as 반납여부 
from RENT_TBL;

--(6) 대여정보 출력 - 대여번호, 책번호, 책이름, 가격, 대여일 ( 가격은 3자리 콤마표현, 대여일은 0000-00-00으로 표현 )
select 
rt.r_no as 대여번호,
bt.b_no as 책번호,
bt.b_name as 책이름,
to_char(rt.r_price,'FM999,999,999')||'원' as 가격,
to_char(rt.r_date,'yyyy-mm-dd') as 대여일 
from BOOK_TBL bt,RENT_TBL rt
where bt.b_no = rt.b_no;

--(7) 대여가 한건도 없는 책 정보 출력 ( 책번호, 책이름, 출판사 ) 
select 
bt.b_no as 책번호,
bt.b_name as 책이름,
bt.b_publisher as 출판사
from BOOK_TBL bt left outer join RENT_TBL rt on bt.b_no = rt.b_no
where rt.b_no is null;

--(8) 도서번호 101을 110으로 변경하는 쿼리를 만들고 실행 시의 결과를 간단히 작성한다.
update BOOK_TBL set b_no='110' where b_no='101';
--RENT_TBL의 b_no가 자식값이므로 인해 무결성 제약조건 위배 오류. 실행안됨

--(9) 2023년05월22일에 대여된 목록 중에 시공사의 책이 있는지 출력한다.
--책이름, 출판사 , 대여일(0000-00-00)
select 
bt.b_name as 책이름,
bt.b_publisher as 출판사,
to_char(rt.r_date,'yyyy-mm-dd') as 대여일 
from BOOK_TBL bt,RENT_TBL rt
where to_char(rt.r_date,'yyyy-mm-dd') = '2023-05-22' and 
         rt.r_status = '1' and
         b_publisher like '%시공사%' and         
         bt.b_no = rt.b_no;

--(10) 도서정보 테이블과 대여정보 테이블의 구조를 확인 하는 명령을 각각 실행하고 커밋을 실행한다. 
desc BOOK_TBL;
desc RENT_TBL;
commit;