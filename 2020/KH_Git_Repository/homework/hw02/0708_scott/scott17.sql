-- 문제17 - EMP테이블에서 사번, 사원명, 입사일, 입사일로부터 40년되는 날짜 조회
SELECT EMPNO 사번, ENAME 사원명, HIREDATE 입사일, ADD_MONTHS(HIREDATE,12*40) "입사일이후 40년"
FROM EMP;
