--Ʈ�����
--�۾��׷�
--������ �߻� ����
--Ŀ�԰� Ŀ�� ���̸� ����
--insert,update,delete
-- commit,  rollback,savepoint
--(�۾�����),(�۾����),(�۾���ġ)

CREATE table subject ( title VARCHAR2(100), price number);

INSERT INTO subject VALUES( 'java',10000);

select * from subject;

COMMIT; -- hardware�� ����

INSERT INTO subject VALUES( 'jsp',30000); -- �޸𸮿� ����
INSERT INTO subject VALUES( 'html',15000);
ROLLBACK; -- commit������� ���¸� ��� ����

INSERT INTO subject VALUES( 'jsp',30000);
INSERT INTO subject VALUES( 'html',15000);
COMMIT;
ROLLBACK; -- commit������� rollback�̶� �ҿ����.

DELETE FROM subject WHERE title='jsp';

CREATE TABLE abc( userid VARCHAR2(100) );
ROLLBACK;--create�� Ʈ������̶� �������

--savepoint
select * from subject;
INSERT INTO subject VALUES( 'a1',1000);
SAVEPOINT sp1;
INSERT INTO subject VALUES( 'a2',2000);
SAVEPOINT sp2;
ROLLBACK to sp1; --sp1�������� ���๮ rollback

ALTER TABLE subject MODIFY title VARCHAR2(200); --�÷� Ÿ�� ����

ALTER TABLE subject add name VARCHAR2(50);--name �÷� �߰�

ALTER TABLE subject DROP COLUMN name; --name �÷� ����
                                --old   &  new  
ALTER TABLE subject RENAME COLUMN price to price100 --�÷� �̸� ����

TRUNCATE TABLE subject;-- ���̺� �ʱ�ȭ(��ü ������ ������)

DROP TABLE subject;--subject ���̺� ����.(�ѹ�ȵ�)


