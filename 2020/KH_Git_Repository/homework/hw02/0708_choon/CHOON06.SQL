-- 문제6
-- 춘 기술대학교는 총장을 제외하고 모든 교수들이 소속학과를 가지고 있다.
-- 춘 기술대학교 총장의 이름을 알아낼 수 있는 SQL문장을 작성하시오.

--1. TB_PROFESSOR 에 누가 있는지 확인
SELECT *
FROM TB_PROFESSOR;

--2. DEPARTMENT_NO는 학과번호인데
-- 총장은 소속학과를 갖고 있지 않으므로, 학과번호를 가지고 있지 않다.
-- 즉, 학과번호가 NULL이다.
SELECT PROFESSOR_NAME
FROM TB_PROFESSOR
WHERE DEPARTMENT_NO IS NULL;

-- ANSWER
SELECT PROFESSOR_NAME
FROM TB_PROFESSOR
WHERE DEPARTMENT_NO IS NULL;
