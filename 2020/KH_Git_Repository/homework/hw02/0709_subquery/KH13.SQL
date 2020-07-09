-- 문제13. WITH을 이용하여 급여합과 급여 평균 조회

-- 2) 두번째 사진에 해당하는 쿼리문
WITH SAL_SUM_AVG AS( SELECT SUM(SALARY) 급여합, AVG(SALARY) AS 급여평균
                     FROM EMPLOYEE)
SELECT *
FROM SAL_SUM_AVG;
