--문제5 - EMP테이블에서 급여가 같을 경우 커미션을 내림차순으로 정렬
SELECT *
FROM EMP
ORDER BY SAL DESC, COMM DESC; 
