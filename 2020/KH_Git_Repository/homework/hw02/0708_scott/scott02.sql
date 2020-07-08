-- 문제2 - EMP테이블에서 커미션을 받지 못한 직원 조회
SELECT *
FROM EMP
WHERE (COMM IS NULL) OR (COMM =0);
