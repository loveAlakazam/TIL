-- 문제6 - EMP 테이블에서 사원번호, 사원명, 직급, 입사일 조회
-- 입사일을 오름차순으로 정렬
SELECT EMPNO 사원번호, ENAME 사원명, JOB 직급, HIREDATE 입사일
FROM EMP
ORDER BY HIREDATE;
