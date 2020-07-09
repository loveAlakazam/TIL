-- 문제8. 한 사원과 같은 부서에서 일하는 사원의 이름 조회
-- SELF JOIN
SELECT E.EMP_NAME 사원명, E.DEPT_CODE, P.EMP_NAME
FROM EMPLOYEE E, EMPLOYEE P -- P: 파트너사원
WHERE E.DEPT_CODE=P.DEPT_CODE --사원이름과 파트너사원은 같은 부서에 일한다.
        AND  E.EMP_NAME!=P.EMP_NAME --사원이름과 파트너사원 이름은 서로 다르다.
ORDER BY 1; --사원이름 오름차순
