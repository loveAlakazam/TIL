-- EMPLOYEE 테이블에서 급여가 4000000 이상인 직원의 이름, 급여 조회
SELECT EMP_NAME "직원이름", SALARY "급여"
FROM EMPLOYEE
WHERE SALARY>=4000000;

-- EMPLOYEE 테이블에서 퇴사 여부가 N인 직원을 조회하고 근무 여부를 재직중으로 표시하여 사번, 이름, 고용일, 근무여부를 조회
DESC EMPLOYEE;
SELECT EMP_ID EMP_YN 퇴사여부 , EMP_NAME AS 이름, HIRE_DATE 고용일, '재직중' "근무여부"
FROM EMPLOYEE
WHERE ENT_YN='N';

-- EMPLOYEE 테이블에서 월급이 3000000이상인 사원의 이름, 월급, 고용일 조회
SELECT EMP_NAME 이름, SALARY 월급, HIRE_DATE 고용일
FROM EMPLOYEE
WHERE SALARY>= 3000000;

-- EMPLOYEE 테이블에서 SAL_LEVEL이 S1인 사원의 이름, 월급, 고용일, 연락처 조회
SELECT EMP_NAME "사원의 이름", SALARY 월급, HIRE_DATE 고용일, PHONE 연락처
FROM EMPLOYEE
WHERE SAL_LEVEL=51;

-- EMPLOYEE 테이블에서 실수령액(총수령액 - (연봉*세금 3%))이 5천만원 이상인 사원의 이름, 월급, 실수령액, 고용일 조회
SELECT EMP_NAME "사원의 이름", SALARY "월급", ((SALARY*(1+BONUS)*12)-(12*SALARY*0.03)) "실수령액", HIRE_DATE 고용일
FROM EMPLOYEE
WHERE (12*SALARY*(1+BONUS)- (12*SALARY*0.03))>= 50000000;
