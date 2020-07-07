-- EMPLOYEE 테이블에서 사원명, 입사일-오늘, 오늘-입사일 조회
-- 단, 별칭은 근무일수1, 근무일수 2로 하고 모두 정수처리(내림), 양수가 되도록 처리
SELECT EMP_NAME "사원명", FLOOR(ABS(MONTH_BETWEEN(HIRE_DATE, SYSDATE))) "근무일수1",
          FLOOR(ABS(MONTH_BETWEEN(SYSDATE, HIRE_DATE))) "근무일수2"
FROM EMPLOYEE;


-- EMPLOYEE 테이블에서 사번이 홀수인 직원들의 정보를 모두 조회
SELECT *
FROM EMPLOYEE
WHERE MOD(TO_NUMBER(EMP_ID) ,2)=1; --EMP_ID가 VARCHAR타입이기때문에 숫자로 자동형변환

-- EMPLOYEE 테이블에서 근무 년수가 20년 이상인 직원 정보 조회
SELECT *
FROM EMPLOYEE
WHERE FLOOR(ABS(MONTH_BETWEEN(SYSDATE, HIRE_DATE)/12))>=20;

SELECT *
FROM EMPLOYEE
WHERE (SYSDATE-HIRE_DATE)/365 >=20;

SELECT *
FROM EMPLOYEE
WHERE MONTHS_BETWEEN(SYSDATE, HIRE_DATE) >=240;


SELECT *
FROM EMPLOYEE
WHERE EXTRACT( YEAR FROM ABS(MONTH_BETWEEN(SYSDATE, HIRE_DATE)))>=20;

-- EMPLOYEE 테이블에서 사원 명, 입사일, 입사한 달의 근무 일 수 조회.
SELECT EMP_NAME "사원명", HIRE_DATE 입사일, EXTRACT(DAY FROM )
FROM EMPLOYEE;

-- EMPLOYEE테이블에서 부서코드 별로 같은 직급인 사원의 급여 합계 조회
SELECT DEPT_CODE, JOB_CODE, SUM(SALARY)
FROM EMPLOYEE
GROUP BY DEPT_CODE, JOB_CODE
ORDER BY DEPT_CODE;



---------- 실습문제
--1. 직원명과 주민번호를 조회함
--  단, 주민번호 9번째 자리부터 끝까지는 '*'문자로 채움
--  예 : 홍길동 771120-1******
SELECT EMP_NAME, REPLACE(SUBSTR(EMP_NO, 9), '******')
FROM EMPLOYEE;

SELECT EMP_NAME, RPAD(SUBSTR(EMP_NO,1, 8), LENGTH(EMP_NO) , '*' )
FROM EMPLOYEE;

SELECT EMP_NAME, SUBSTR(EMP_NO, 1, 8 ) || '******'
FROM EMPLOYEE;



--2. 직원명, 직급코드, 보너스가 포함된 연봉(원) 조회
--  단, 연봉은 ￦57,000,000 으로 표시되게 함
SELECT EMP_NAME 직원명, JOB_CODE 직급코드,
        TO_CHAR(SALARY*(1+BONUS)*12, 'FML99,999,999') "보너스가 포함된 연봉(원)"
FROM EMPLOYEE;

SELECT EMP_NAME, JOB_CODE, TO_CHAR(SALARY*(1+NVL(BONUS,0))*12, 'FML99,999,999')
FROM EMPLOYEE;


--3. 부서코드가 D5, D9인 직원들 중에서 2004년도에 입사한 직원의 사번, 사원명, 부서코드, 입사일
SELECT EMP_ID, EMP_NAME, DEPT_CODE 부서코드 , HIRE_DATE 입사일
FROM EMPLOYEE
WHERE (DEPT_CODE IN ('D5', 'D9')) AND (EXTRACT(YEAR FROM HIRE_DATE)=2004);


SELECT EMP_ID, EMP_NAME, DEPT_CODE 부서코드 , HIRE_DATE 입사일
FROM EMPLOYEE
WHERE (DEPT_CODE IN ('D5', 'D9')) AND (SUBSTR(HIRE_DATE,1,2)=04);
WHERE (DEPT_CODE IN ('D5', 'D9')) AND (TO_CHAR(HIRE_DATE,'YY')=04);


--4. 직원명, 입사일, 입사한 달의 근무일수 조회(단, 주말과 입사한 날도 근무일수에 포함함)
SELECT EMP_NAME 직원명, HIRE_DATE 입사일,
        EXTRACT(DAY FROM ABS(MONTHS_BETWEEN(SYSDATE, HIRE_DATE))) 근무일수
FROM EMPLOYEE;


SELECT EMP_NAME, HIRE_DATE, LAST_DAY(HIRE_DATE)-HIRE_DATE+1
FROM EMPLOYEE;


--5. 부서코드가 D5와 D6이 아닌 사원들의 직원명, 부서코드, 생년월일, 나이(만) 조회
--  단, 생년월일은 주민번호에서 추출해서 ㅇㅇ년 ㅇㅇ월 ㅇㅇ일로 출력되게 하고
--  나이는 주민번호에서 추출해서 날짜데이터로 변환한 다음 계산
SELECT EMP_NAME 직원명, DEPT_CODE 부서코드,
        SUBSTR(EMP_NO, 1,2)||'년'||SUBSTR(EMP_NO,3,2)||'월'||SUBSTR(EMP_NO,5,2)||'일' 생년월일,
        EXTRACT(YEAR FROM SYSDATE)-TO_CHAR(TO_DATE(SUBSTR(EMP_NO, 1,2), 'RR'), 'YYYY') 나이,
FROM EMPLOYEE;


--6. 직원들의 입사일로 부터 년도만 가지고, 각 년도별 입사인원수를 구하시오.
--  아래의 년도에 입사한 인원수를 조회하시오.
--  => to_char, decode, sum 사용
--
--   -------------------------------------------------------------
--   전체직원수   2001년   2002년   2003년   2004년
--   -------------------------------------------------------------
SELECT COUNT(*) "전체 직원 수",
        COUNT(DECODE( TO_CHAR(EXTRACT(YEAR FROM HIRE_DATE)), '2001', 1)) "2001년",
        COUNT(DECODE( TO_CHAR(EXTRACT(YEAR FROM HIRE_DATE)), '2002', 1)) "2002년",
        COUNT(DECODE( TO_CHAR(EXTRACT(YEAR FROM HIRE_DATE)), '2003', 1)) "2003년",
        COUNT(DECODE( TO_CHAR(EXTRACT(YEAR FROM HIRE_DATE)), '2004', 1)) "2004년",
FROM EMPLOYEE;


--7.  부서코드가 D5이면 총무부, D6이면 기획부, D9이면 영업부로 처리하시오.
--   단, 부서코드가 D5, D6, D9 인 직원의 정보만 조회함
--  => case 사용
SELECT EMP_NAME, DEPT_CODE
  CASE WHEN DEPT_CODE='D5' THEN '총무부'
  CASE WHEN DEPT_CODE='D6' THEN '기획부'
  CASE WHEN DEPT_CODE='D9' THEN '영업부'
  END 부서
FROM EMPLOYEE
WHERE DEPT_CODE IN ('D5', 'D6', 'D9');


```
