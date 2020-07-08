
-- 문제8 - EMP 테이블에서 사번, 입사일, 사원명 급여 조회
-- 부서번호가 빠른순으로 같은 부서번호일 때는 최근 입사일 순으로 처리
SELECT EMPNO 사번, DEPTNO 부서번호 , HIREDATE 입사일, ENAME 사원명, SAL 급여
FROM EMP
ORDER BY DEPTNO , HIREDATE DESC;
