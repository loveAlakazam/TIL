-- 문제14 - EMP테이블에서 81년도에 입사한 직원 조회
SELECT *
FROM EMP
WHERE TO_CHAR(HIREDATE,'YY')=81;
