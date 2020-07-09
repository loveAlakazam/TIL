-- 문제4. 부서코드가 D5이거나 D6인 사원의
-- 사원명, 직급명, 부서코드, 부서명 조회
SELECT EMP_NAME 사원명, JOB_NAME 직급명,
        DEPT_CODE 부서코드, DEPT_TITLE 부서명
FROM EMPLOYEE
    JOIN DEPARTMENT ON (DEPT_ID=DEPT_CODE)
    JOIN JOB USING(JOB_CODE)
WHERE DEPT_CODE IN ('D5', 'D6')
ORDER BY 부서명 DESC, 직급명 DESC, 사원명;
