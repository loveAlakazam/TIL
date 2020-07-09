-- 문제3. 춘 기술 대학교의 남자 교수들의 이름과 나이를 출력하는 sql문장을 작성
-- 단, 이때 나이가 적은 사람에서 많은 사람 순서로 화면에 출력되도록 하시오.
-- 단, 교수중 2000년 이후 출생자는 없으며
-- 출력 헤더는 "교수이름", "나이"로 한다.
-- 나이는 '만'으로 계산한다.

-- 교수의 생년월일을 구하고, 2000년 이후 출생자는 존재하지 않으므로,
-- TO_DATE옵션에서 형식에서 'YYMMDD'가 아닌 'RRMMDD'로 한다.
SELECT TO_DATE(SUBSTR(PROFESSOR_SSN,1,6),'RRMMDD') "생년월일"
FROM TB_PROFESSOR;

-- MONTH_BETWEEN을 이용하여 현재 나이를 구한다.
-- 교수의 생년월일: TO_DATE(SUBSTR(PROFESSOR_SSN,1,6),'RRMMDD')
-- 교수나이-소수: MONTH_BETWEEN(현재날짜, 교수의 생년월일)/12
-- 나이를 정수로 나타내기 => FLOOR(교수나이-소수)
-- 음수로 나타내지 않게 한다.=> ABS(교수나이-정수)
SELECT  PROFESSOR_NAME "교수이름",
        ABS(FLOOR(MONTHS_BETWEEN( SYSDATE, TO_DATE(SUBSTR(PROFESSOR_SSN,1,6), 'RRMMDD'))/12)) "나이"
FROM TB_PROFESSOR
ORDER BY 나이; --나이 오름차순 정렬
