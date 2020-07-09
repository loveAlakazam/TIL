
-- 문제2. 춘 기술대학교의 교수중 이름이 세글자가 아닌 교수가 한명이 있다고한다.
-- 그 교수의 이름과 주민번호를 화면에 출력하는 sql문을 만들어라.
SELECT PROFESSOR_NAME, PROFESSOR_SSN
FROM TB_PROFESSOR
WHERE LENGTH(PROFESSOR_NAME)!=3;
