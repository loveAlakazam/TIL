-- EMPLOYEE 테이블에서 사원명, 입사일-오늘, 오늘-입사일 조회
-- 단, 별칭은 근무일수1, 근무일수 2로 하고 모두 정수처리(내림), 양수가 되도록 처리
SELECT EMP_NAME "사원명", FLOOR(ABS(MONTH_BETWEEN(HIRE_DATE, SYSDATE))) "근무일수1",
          FLOOR(ABS(MONTH_BETWEEN(SYSDATE, HIRE_DATE))) "근무일수2"
FROM EMPLOYEE;


-- EMPLOYEE 테이블에서 사번이 홀수인 직원들의 정보를 모두 조회
SELECT *
FROM EMPLOYEE
WHERE EMP_ID %2=1;

-- EMPLOYEE 테이블에서 근무 년수가 20년 이상인 직원 정보 조회
SELECT *
FROM EMPLOYEE
WHERE ABS(MONTH_BETWEEN(HIRE_DATE, SYSDATE))

-- EMPLOYEE 테이블에서 사원 명, 입사일, 입사한 달의 근무 일 수 조회.
