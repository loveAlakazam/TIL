-- 문제3. 이름에 '형'이 들어가는 사원의 코드, 사원명, 직급조회
SELECT EMP_ID 사원코드, EMP_NAME 사원명, JOB_NAME 직급
FROM EMPLOYEE
    JOIN JOB USING(JOB_CODE)
WHERE EMP_NAME LIKE '%형%';
