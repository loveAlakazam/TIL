--5. 춘 기술대학교의 재수생 입학자를 구하려고 한다.
-- 어떻게 찾아낼 것인가? 이때 19살에 입학하면 재수하지 않은 것으로 간주한다.
-- 입학일자 - 생년월일(주민번호)

-- 1) 학생의 생년월일을 날짜형식으로 구해보자.
--SUBSTR(STUDENT_SSN,1,6)=> 학생의 주민번호(STUDENT_SSN)에서 1~6번째에 해당하는 부분문자열 추출.
--TO_DATE(생년월일, 'RRMMDD')
SELECT TO_DATE(SUBSTR(STUDENT_SSN,1,6),'RRMMDD') 생년월일
FROM TB_STUDENT;

-- 2) 학생의 입학했을 때 당시의 나이를 구한다.
-- MONTHS_BETWEEN(ENTRANCE_DATE, 생년월일) => 소수점이 나온다.=> 월단위로 나타냄
-- 년단위로 나타낸다.
-- FLOOR()=> 소수점을 없앤다.
SELECT FLOOR(MONTHS_BETWEEN(ENTRANCE_DATE, TO_DATE(SUBSTR(STUDENT_SSN,1,6), 'RRMMDD'))/12)||'세' "입학 당시 나이"
FROM TB_STUDENT;

-- 3) 2)를 조건절로 나타낸다.
SELECT STUDENT_NO, STUDENT_NAME
FROM TB_STUDENT
WHERE FLOOR(MONTHS_BETWEEN(ENTRANCE_DATE, TO_DATE(SUBSTR(STUDENT_SSN,1,6),'RRMMDD'))/12)<20;
