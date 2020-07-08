-- 문제12 - EMP 테이블에서 사원명, 입사일 조회
-- 단 입사일은 년도와 월을 분리 추출해서 출력
SELECT ENAME 사원명, EXTRACT(YEAR FROM HIREDATE) AS 입사년도, EXTRACT(MONTH FROM HIREDATE) 입사월
FROM EMP;
