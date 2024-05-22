-- 1. buy테이블에서 amount가 4 이상인 모든 열 데이터 조회하기
SELECT *
FROM buy
WHERE amount >= 4;

-- 2. buy 테이블에서 prod_name이 지갑 또는 청바지에 해당하는 모든 열 데이터 조회하기
SELECT *
FROM buy
WHERE prod_name IN ('지갑', '청바지');

-- 1. member 테이블에서 회원들을 평균 키의 오름차순으로 조회하기
SELECT *
FROM member
ORDER BY mem_name, height ASC;

-- 2. member 테이블에서 5번째 회원부터 2명 조회하기
SELECT *
FROM member
ORDER BY mem_name
LIMIT 2;

-- 3. member 테이블의 phone1을 중복 없이 조회하기
SELECT DISTINCT phone1
FROM member;

-- 4. 동물 보호소에 들어온 모든 동물의 정보를 animal_id의 오름차순으로 조회하기
-- 조회할 열 : animal_id, animal_type, datetime, intake_condition, name, sex_upon_intake
SELECT animal_id, animal_type, datetime, intake_condition, name, sex_upon_intake
FROM aac_intakes ai
ORDER BY animal_id ASC;

-- 5. 동물 보호소에 들어온 동물 중 intake_condition이 sick인 동물의 데이터를 animal_id의 오름차순으로 조회하기
-- 조회할 열 : animal_id, intake_condition, name
SELECT animal_id, intake_condition, name
FROM aac_intakes ai
WHERE intake_condition = 'sick'
ORDER BY animal_id ASC;

-- 6. 동물 보호소에 들어온 모든 동물의 데이터를 이름의 내림차순으로 조회하는 SQL문 작성하기
-- 이름이 같은 동물 중에서는 최근에 동물 보호소에 들어온 동물을 먼저 보여주기
-- 조회할 열 : animal_id, datetime, name
SELECT animal_id, datetime, name
FROM aac_intakes ai 
ORDER BY name DESC, datetime DESC;

-- 7. 동물 보호소에 가장 먼저 들어온 동물의 데이터 조회하기
-- 조회할 열 : name, datetime
SELECT name, datetime
FROM aac_intakes ai 
ORDER BY datetime ASC
LIMIT 1;

-- 8. 동물 보호소에 들어온 동물의 이름이 총 몇 종류 있는지 조회하기
-- 이 때, 이름이 ""인 경우는 집계하지 않음
SELECT COUNT(DISTINCT name)
FROM aac_intakes ai
WHERE name != "";

-- 9. 동물 보호소에 들어온 동물 종(animal_type) 별로 각각 몇 마리인지 조회하기
-- 이 때, 고양이가 개보다 먼저 등장하도록 정렬하기
-- 조회할 열 : animal_type, cnt(마리 수)
SELECT animal_type, COUNT(animal_type) cnt
FROM aac_intakes ai
GROUP BY animal_type
ORDER BY animal_type ASC;

-- 10. 동물 보호소에 들어온 동물 이름 중 두 번 이상 쓰인 이름과 해당 이름이 쓰인 횟수를 조회하기
-- 이 때, 이름이 ""인 동물과 이름이 *로 시작하는 동물은 집계에서 제외하며, 이름의 오름차순으로 조회하기
-- 조회할 열 : name, cnt(이름이 쓰인 횟수)
SELECT name, COUNT(name) cnt
FROM aac_intakes ai 
WHERE name != "" AND name NOT LIKE ('*%')
GROUP BY name
HAVING COUNT(name) >= 2
ORDER BY name ASC;

-- 11. 구매 기록이 없는 회원을 포함한 전체 회원의 구매 기록 출력
SELECT m.mem_id, m.mem_name, b.prod_name, m.addr
FROM buy b
	LEFT OUTER JOIN member m
	ON m.mem_id = b.mem_id
ORDER BY m.mem_id ASC;

-- 12. 회원 가입만 하고 한 번도 구매한 적이 없는 회원의 목록 추출
SELECT DISTINCT m.mem_id, b.prod_name, m.mem_name, m.addr
FROM member m
	LEFT OUTER JOIN buy b 
	ON m.mem_id = b.mem_id
WHERE b.prod_name is NULL
ORDER BY m.mem_id ASC;
	
-- 13. 한 번이라도 구매 기록이 있는 회원들 리스트 출력하기
-- 중복없이 회원ID, 주소를 조회
SELECT DISTINCT m.mem_id, m.addr
FROM member m
	INNER JOIN buy b
	ON m.mem_id = b.mem_id;
	
-- 14. 천재지변으로 인해 데이터가 유실되었음.
-- (outcomes)입양을 간 기록은 있는데, (WHERE)보호소에 들어온(intakes) (NULL)기록이 없는 (ON)동물의 id와 이름을 (ORDER BY)id의 오름차순으로 조회하기
-- 조회할 열 : animal_id, name, outcomes의 datetime, intakes의 datetime
SELECT outs.animal_id, outs.name, outs.datetime, ints.datetime
FROM aac_outcomes outs
	LEFT OUTER JOIN aac_intakes ints
	ON ints.animal_id = outs.animal_id 
WHERE ints.datetime is NULL
ORDER BY outs.animal_id ASC;

-- 15. 관리자의 실수로 일부 동물이 나간 날짜가 잘못 입력되었음.
-- (intakes)(WHERE)보호시작일(datetime)보다 (outcomes)나간 날짜(datetime)가 더 빠른 동물//의 (ON)아이디와 이름을 조회하는 SQL문 작성하기
-- 단, (ORDER BY)보호시작일(datetime)이 빠른 순으로 조회해야 함
-- 조회할 열 : animal_id, name, outcomes의 datetime, intakes의 datetime
SELECT ints.animal_id, ints.name, outs.datetime outs, ints.datetime ints
FROM aac_intakes ints
	INNER JOIN aac_outcomes outs
	ON ints.animal_id = outs.animal_id
WHERE ints.datetime > outs.datetime
ORDER BY ints.datetime ASC;

 -- 시험문제
-- 동물 보호소 데이터에서 보호소에 들어온 기록(INTS)은 있는데 아직 보호소를 나간 기록은 없는 동물(OUTS) 중, 
-- 가장 오래 보호소에 있었던(age_upon_intake) 동물 3마리(LIMIT)의 이름(name)과 보호 시작일을 조회하는 SQL문을 작성하시오
-- (WHERE)이때 이름이 “”인 경우와 이름이 * 로 시작하는 경우는 제외하고, 보호 시작일의 (ORDER BY)오름차순으로 조회하시오
SELECT ints.name, ints.datetime ints, outs.datetime outs
FROM aac_intakes ints
	LEFT OUTER JOIN aac_outcomes outs
	ON ints.name = outs.name
WHERE ints.name != "" AND ints.name NOT LIKE ('*%')
ORDER BY ints.datetime ASC
LIMIT 3;

-- 동물 보호소 데이터에서 보호소에 들어올 때의 성별과 보호소를 나갈 때의 성별이 달라진 동물의 데이터를 조회하시오
-- 조회할 열 : animal_id, animal_type, name, sex_upon_intake, sex_upon_outcome
-- 정렬 순서 : animal_id 의 오름차순
SELECT ints.animal_id, ints.animal_type, ints.name, ints.sex_upon_intake, outs.sex_upon_outcome
FROM aac_intakes ints
	LEFT OUTER JOIN aac_outcomes outs
	ON ints.animal_type = outs.animal_type
WHERE outs.sex_upon_outcome not like ints.sex_upon_intake
ORDER BY animal_id ASC;



