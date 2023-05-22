--트랜잭션
--작업그룹
--여러개 발생 가능
--커밋과 커밋 사이를 말함
--insert,update,delete
-- commit,  rollback,savepoint
--(작업종료),(작업취소),(작업위치)

CREATE table subject ( title VARCHAR2(100), price number);

INSERT INTO subject VALUES( 'java',10000);

select * from subject;

COMMIT; -- hardware에 적용

INSERT INTO subject VALUES( 'jsp',30000); -- 메모리에 적용
INSERT INTO subject VALUES( 'html',15000);
ROLLBACK; -- commit명령후의 상태만 취소 가능

INSERT INTO subject VALUES( 'jsp',30000);
INSERT INTO subject VALUES( 'html',15000);
COMMIT;
ROLLBACK; -- commit명령후의 rollback이라 소용없음.

DELETE FROM subject WHERE title='jsp';

CREATE TABLE abc( userid VARCHAR2(100) );
ROLLBACK;--create는 트랜잭션이랑 관계없음

--savepoint
select * from subject;
INSERT INTO subject VALUES( 'a1',1000);
SAVEPOINT sp1;
INSERT INTO subject VALUES( 'a2',2000);
SAVEPOINT sp2;
ROLLBACK to sp1; --sp1시점후의 실행문 rollback

ALTER TABLE subject MODIFY title VARCHAR2(200); --컬럼 타입 변경

ALTER TABLE subject add name VARCHAR2(50);--name 컬럼 추가

ALTER TABLE subject DROP COLUMN name; --name 컬럼 삭제
                                --old   &  new  
ALTER TABLE subject RENAME COLUMN price to price100 --컬럼 이름 변경

TRUNCATE TABLE subject;-- 테이블 초기화(전체 데이터 삭제됨)

DROP TABLE subject;--subject 테이블 삭제.(롤백안됨)


