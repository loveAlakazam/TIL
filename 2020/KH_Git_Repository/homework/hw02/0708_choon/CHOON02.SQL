-- 문제2 - 학과의 학과정원을 다음과 같은 형태로 화면에 출력한다.
-- 학과별 정원
-- --------------------------------
-- 국어국문학과의 정원은 20명 입니다.
-- 영어영문학과의 정원은 36명 입니다.
-- ...

-- 1. DEPARTMENT_NO 컬럼을 기준으로
-- 두개의 테이블을 내부조인 한다.
-- 2. 학과명 DEPARTMENT_NAME을 기준으로 (그룹화시켜) 각 학과에 따른 학생 수를 구한다.
-- 3. 학과명 DEPARTMENT_NAME을 기준으로 오름차순 정렬한다.
SELECT TB_DEPARTMENT.DEPARTMENT_NAME||'의 정원은 '|| COUNT(*) ||'명입니다.' AS "학과별 정원"
FROM  TB_STUDENT, TB_DEPARTMENT
WHERE TB_DEPARTMENT.DEPARTMENT_NO= TB_STUDENT.DEPARTMENT_NO
GROUP BY TB_DEPARTMENT.DEPARTMENT_NAME
ORDER BY TB_DEPARTMENT.DEPARTMENT_NAME;



-- 학과의 학과정원을 다음과 같은 형태로 화면에 출력한다.
SELECT DEPARTMENT_NAME ||'의 정원은 '||CAPACITY||'명 입니다.' AS "학과별 정원"
FROM TB_DEPARTMENT;
