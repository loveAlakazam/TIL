-- 문제 9. 보너스가 없고 직급 코드가 J4이거나 J7인
-- 사원의 이름, 직급 명, 급여조회

--1) NVL을 이용하지 않은 풀이
SELECT EMP_NAME 사원이름, JOB_NAME 직급명, SALARY 급여
FROM EMPLOYEE
        JOIN JOB USING(JOB_CODE) --테이블 JOB과 내부조인
WHERE JOB_CODE IN ('J4', 'J7') -- 직급코드가 J4, J7


--2) NVL을 이용한 풀이
-- 문제 9. 보너스가 없고 직급 코드가 J4이거나 J7인
-- 사원의 이름, 직급 명, 급여조회 (NVL이용)
SELECT EMP_NAME 사원이름, JOB_NAME 직급명, SALARY 급여
FROM EMPLOYEE
        JOIN JOB USING(JOB_CODE) --테이블 JOB과 내부조인
WHERE JOB_CODE IN ('J4', 'J7') -- 직급코드가 J4, J7
    AND NVL(BONUS,0)=0;--보너스가 없음
