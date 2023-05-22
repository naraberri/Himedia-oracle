CREATE TABLE bookInfo ( code VARCHAR2(20), title VARCHAR2(50),
                        country VARCHAR2(30) );

INSERT INTO bookinfo (code,title,country) VALUES ('j02','jsp',' ');
INSERT INTO bookinfo (code,title) VALUES ('j03','oracle');
INSERT INTO bookinfo (code,title,country) VALUES ('j04','mysql','usa');
INSERT INTO bookinfo (code) VALUES ('j05');
INSERT INTO bookinfo VALUES ('j06','linux','korea');

--count 함수
--(null) 컬럼 초기화가 안된상태(내용이 없는거랑 구조물이 없는 차이)
SELECT COUNT(*) FROM bookinfo; --5
SELECT COUNT(code) FROM bookinfo; --5
SELECT COUNT(title) FROM bookinfo; --4
SELECT COUNT(country) FROM bookinfo; --3

--풀어보기
SELECT * FROM bookinfo WHERE title='linux'; -- 1
SELECT * FROM bookinfo WHERE country=' '; --2
SELECT * FROM bookinfo WHERE country is null; --3
SELECT * FROM bookinfo WHERE country is NOT null and NOT country=' '; --4
UPDATE bookinfo SET country='korea' WHERE code='j02'; --5
UPDATE bookinfo SET country='korea' WHERE country is null; --6

drop table bookInfo;