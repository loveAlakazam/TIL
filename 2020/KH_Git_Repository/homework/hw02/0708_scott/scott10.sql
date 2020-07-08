-- 문제10 - EMP 테이블에서 사번, 사원명, 급여 조회
-- 급여기준 내림차순 정렬
-- ROUND(SAL, -2) => SAL컬럼 데이터중 10단위에서 반올림.
SELECT EMPNO 사번, ENAME 사원명, ROUND(SAL,-2) 급여
FROM EMP
ORDER BY 급여 DESC;
