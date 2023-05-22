CREATE TABLE sports ( code NUMBER, name VARCHAR2(10) );

INSERT INTO sports (code,name) VALUES(101,'绵备');
INSERT INTO sports (code,name) VALUES(102,'具备');
INSERT INTO sports (code,name) VALUES(103,'硅备');

SELECT * FROM sports;
SELECT code,name from sports;

UPDATE sports SET name='丑备' WHERE code='101';

DELETE FROM sports WHERE code='101';

DELETE FROM sports;

rollback;

CREATE TABLE flowerInfo ( code VARCHAR2(10), name VARCHAR2(20),
                          color VARCHAR2(20), price NUMBER);

INSERT INTO flowerinfo (code,name,color,price) VALUES(101,'rose','red',500);
INSERT INTO flowerinfo (code,name,color,price) VALUES(102,'rose','yellow',3000);
INSERT INTO flowerinfo (code,name,color,price) VALUES(103,'herb','grren',2500);

SELECT * FROM flowerinfo;
SELECT name FROM flowerinfo;
SELECT name,price FROM flowerinfo;

SELECT * FROM flowerinfo WHERE name='rose';
SELECT * FROM flowerinfo WHERE price >= 1000;
SELECT * FROM flowerinfo WHERE price < 1000;
SELECT * FROM flowerinfo WHERE name='rose' and color='yellow';
SELECT * FROM flowerinfo WHERE price >= 1000 and price <=2000;

UPDATE flowerinfo SET color='pink' WHERE code='102';

DELETE FROM flowerinfo WHERE code='103';


