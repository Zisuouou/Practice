-- 인덱스(INDEX)
-- > 데이터를 빠르게 찾을 수 있도록 도와주는 도구
-- > 실무에서는 현실적으로 인덱스없이 데이터베이스 운영이 불가

-- 인덱스의 개념
-- > 책의 색인 또는 찾아보기와 유사한 개념
-- -- 예) 책의 내용 중 찾아보고 싶은 내용이 있다면 책의 제일 뒤에 수록되어 있는 색인을 열어보고 원하는 단어를 찾아서 해당 페이지를 빠르게 확인할 수 있음
-- > 색인이 없는 책이라면 책을 첫 페이지부터 열심히 넘겨가며 확인하는 수밖에 없음

-- 지금까지 사용한 테이블들은 인덱스를 고려하지 않았는데, 이는 색인이 없는 책과 마찬가지로 테이블을 사용한 것임
-- > 인덱스가 없었음에도 지금까지 문제가 되지 않았던 이유는 데이터의 양이 적었기 때문
-- > 실무에서 운영하는 테이블에서는 인덱스의 사용 여부에 따라 성능 차이가 날 수 있고, 대용량의 테이블일 경우에는 그 차이가 더욱 커짐

-- 인덱스의 문제점
-- > 인덱스를 제대로 이해하지 못하고 남용하면 문제가 될 수 있음
-- -- 예) 색인에 만들지 않아도 될 단어들이 쓸데없이 쌓여있으면 책의 두께만 두꺼워지고 색인을 사용하더라도 색인을 사용하지 않을 때보다 더 오래 걸릴 수 있음
-- > 실무에서도 필요 없는 인덱스 때문에 데이터베이스의 용량만 늘어나고 속도가 더 느려질 수 있음
-- -- 데이터베이스에 인덱스를 생성해 놓더라도 mysql이 인덱스를 사용하는 것과 전체 테이블을 검색하는 것 중에 더 빠른 방법을 판단해서 사용함
-- -- 사용하지 않는 인덱스를 만들면 쓸데없이 공간낭비만 하게 됨

-- 인덱스의 장점
-- > 인덱스를 적절하게 생성하고 인덱스를 사용하는 SQL을 만든다면 기존보다 아주 빠른 응답속도를 얻을 수 있음
-- > 컴퓨터 입장에서는 적은 처리량으로 요청한 결과를 빨리 얻을 수 있으니 여유가 생기고 추가로 더 많은 일을 할 수 있게 됨
-- -- 결과적으로 전체 시스템 성능이 향상됨

-- 인덱스의 단점
-- > 인덱스도 공간을 차지하는 데이터이기 때문에 데이터베이스 안에 추가적인 공간이 필요함
-- > 처음 인덱스를 만드는 데 시간이 오래 걸릴 수 있음
-- > SELECT가 아닌 데이터의 변경작업이 자주 일어나면 오히려 성능이 나빠질 수 있음

-- 자동으로 생성되는 인덱스
-- > 인덱스는 테이블의 컬럼 단위에 생성되며, 하나의 열에는 하나의 인덱스를 생성할 수 있음
-- -- 하나의 열에 여러 개의 인덱스를 생성하거나 여러 개의 열을 묶어서 하나의 인덱스를 생성하는 것이 가능은 하지만 매우 드문 경우임
-- > 테이블에서 기본키를 지정하면 자동으로 클러스터형 인덱스를 생성
-- -- 클러스터형 인덱스(Clustered Index) : 사전처럼 책의 내용이 이미 정렬되어 있는 것
-- > 기본키는 테이블에 하나만 지정할 수 있으므로 클러스터형 인덱스는 테이블에 한 개만 만들 수 있음
CREATE TABLE table1(
	col1	INT PRIMARY KEY,
	col2	INT,
	col3	INT
);

-- 테이블의 인덱스 확인
SHOW INDEX FROM table1;
-- > key_name : 'primary'는 기본키로 설정해서 자동으로 생성된 인덱스' 라는 의미(클러스터형 인덱스)
-- > column_name : 해당 컬럼에 인덱스가 만들어져 있다는 뜻
-- > Non_unique : 중복이 허용된다 라는 뜻. 0이면 중복이 허용되지 않고, 1이면 중복이 허용됨

-- 고유 인덱스(Unique index)
-- > 인덱스의 값이 중복되지 않는다는 의미. 반대 의미로 단순 인덱스(Non-Unique Index)가 있음
-- > 기본키(Primary Key)나 고유키(Unique)로 지정하면 값이 중복되지 않으므로 고유 인덱스가 생성됨
-- > 고유키도 인덱스가 자동으로 생성되며, 고유키로 생성되는 인덱스는 보조 인덱스
-- -- 보조 인덱스(Secondary Index) : 책의 색인과 같이 단어를 찾고 단어의 주소를 찾아야 실제 내용이 있는 형태
CREATE TABLE table2(
	col1	INT PRIMARY KEY,
	col2	INT UNIQUE,
	col3	INT UNIQUE
);
SHOW INDEX FROM table2;
-- Key_name에 열 이름이 쓰여진 것은 보조 인덱스
-- 고유키도 중복을 허용하지 않기 때문에 Non_unique 가 0
-- 고유키를 여러 개 지정할 수 있듯이 보조 인덱스도 여러 개 만들 수 있음

-- 클러스터형 인덱스의 특징
-- > 기본키로 지정하면 자동으로 생성됨
-- > 테이블에 1개만 생성됨
-- > 어떤 열을 기본키로 지정해서 클러스터형 인덱스가 생성되면 그 열을 기준으로 자동 정렬됨
DROP TABLE IF EXISTS buy, member;
CREATE TABLE member
( mem_id	CHAR(8),
  mem_name	VARCHAR(10),
  mem_number INT,
  addr		 CHAR(2)
 );
 
INSERT INTO member VALUES('TWC', '트와이스', 9, '서울');
INSERT INTO member VALUES('BLK', '블랙핑크', 4, '경남');
INSERT INTO member VALUES('WMN', '여자친구', 6, '경기');
INSERT INTO member VALUES('OMY', '오마이걸', 7, '서울');
SELECT * FROM member;
-- 입력한 순서 그대로 조회 되었음

-- 위의 데이터에 기본키를 설정
ALTER TABLE member 
	ADD CONSTRAINT
	PRIMARY KEY(mem_id);
	
SELECT * FROM member;
-- > 기본키를 설정하면 mem_id를 기준으로 정렬 순서가 바뀜
-- -- mem_id열을 기본키로 설정하면서 mem_id열에 클러스터형 인덱스가 생성되어 mem_id열을 기준으로 정렬된 것

-- mem_id의 Primary Key를 제거하고 mem_name열을 Primary Key로 지정
ALTER TABLE member DROP PRIMARY KEY; -- 기본키 제거
ALTER TABLE member
	ADD CONSTRAINT
	PRIMARY KEY(mem_name);
	
SELECT * FROM member;
-- > mem_name열에 클러스터형 인덱스가 생성되었기 때문에 mem_name열을 기준으로 다시 정렬됨

-- 데이터를 추가로 입력하면 기준에 맞춰 자동 정렬
INSERT INTO member VALUES('GRL', '소녀시대', 8, '서울');
SELECT * FROM member;

-- -- 대용량의 데이터가 있는 상태에서 기본키를 변경하면 시간이 엄청 오래 걸릴 수 있음
-- -- 위의 예제에서 회원 이름을 기본키로 설정하는 것은 실제로는 위험할 수 있음. 회원 이름은 중복될 수 있기 때문에
 
-- 보조 인덱스의 특징
-- > 테이블에 여러 개 설정할 수 있음
-- -- 고유키를 여러 개 지정할 수 있는 것과 마찬가지
-- > 책에 색인을 만든다고 해서 책의 본문이 변경되는 것은 아닌것처럼 보조 인덱스를 만든다고 해서 데이터의 순서나 내용이 바뀌지는 않음
DROP TABLE IF EXISTS buy, member;
CREATE TABLE member
( mem_id	CHAR(8),
  mem_name	VARCHAR(10),
  mem_number INT,
  addr		 CHAR(2)
 );
 
INSERT INTO member VALUES('TWC', '트와이스', 9, '서울');
INSERT INTO member VALUES('BLK', '블랙핑크', 4, '경남');
INSERT INTO member VALUES('WMN', '여자친구', 6, '경기');
INSERT INTO member VALUES('OMY', '오마이걸', 7, '서울');
SELECT * FROM member;

-- mem_id를 고유키로 설정하기
ALTER TABLE member
	ADD CONSTRAINT
	UNIQUE (mem_id);
SELECT * FROM member;
-- > 데이터의 순서에는 변화가 없음
-- -- 즉, 보조 인덱스를 생성하더라도 데이터의 순서는 변경되지 않고 별도의 인덱스를 만드는 것

-- mem_name열에 추가로 고유키 지정
ALTER TABLE member
	ADD CONSTRAINT
	UNIQUE (mem_name);
SELECT * FROM member;
-- > 데이터의 내용과 순서는 그대로이며, mem_id열과 mem_name열에 모두 보조 인덱스가 생성된 상태임

INSERT INTO member VALUES('GRL', '소녀시대', 8, '서울');
SELECT * FROM member;
-- > 새로운 내용이 추가되면 제일 뒤에 추가됨

-- 인덱스의 내부 작동 원리
-- > 인덱스가 늘 좋은 것은 아니므로 인덱스의 내부 작동 원리를 이해하고 인덱스를 사용해야 할 경우와 사용하지 말아야 할 경우를 정확히 판단하는 것이 중요

-- 균형 트리의 개념
-- > 균형 트리 구조에서 데이터가 저장되는 공간을 노드(node)라고 함
-- > 루트 노드(root node) : 노드의 가장 상위 노드
-- > 리프 노드(leaf node) : 제일 마지막에 존재하는 노드
-- > 데이터가 적으면 2단계부터 데이터가 많아지면 3단계나 그 이상도 만들어질 수 있음
-- > 루트 노드와 리프 노드의 중간에 끼인 노드들은 중간 노드(internal node)라고 부름

-- MYSQL에서는 노드를 페이지(page)라고 부름
-- > 페이지는 최소한의 저장 단위로, 16kbyte 크기를 가짐
-- -- 데이터를 1건만 입력해도 1개의 페이지(16kbyte)가 필요
-- > 균형 트리는 데이터를 검색할 때 (SELECT 구문을 사용할 때) 뛰어난 성능을 발휘함

-- 균형 트리의 페이지 분할
-- > 인덱스는 균형 트리로 구성되어 있으므로 인덱스를 만들면 SELECT의 속도를 향상시킬 수 있음
-- > 하지만 인덱스를 구성하면 데이터 변경 작업(INSERT, UPDATE, DELETE) 시 성능이 나빠짐
-- -- 특히, INSERT 작업이 일어날 때 더 느리게 입력될 수 있음
-- -- > 페이지 분할 작업이 발생하기 때문
-- -- > 페이지 분할 : 새로운 페이지를 준비해서 데이터를 나누는 작업

-- 보조 인덱스가 생성되어도 입력한 것과 순서가 동일함
-- > 보조 인덱스는 데이터페이지를 건드리지 않음
-- > 대신 별도의 공간에 보조 인덱스를 생성

-- 1. 인덱스 페이지의 리프 페이지에 인덱스로 구성한 열을 정렬
-- 2. 실제 데이터가 있는 위치를 준비
-- > 데이터의 위치는 페이지의 번호 + #위치 로 기록됨