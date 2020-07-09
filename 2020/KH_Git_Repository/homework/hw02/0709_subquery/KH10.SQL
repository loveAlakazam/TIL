-- 문제10. 보너스 포함한 연봉이 높은 5명의
-- 사번, 이름, 부서명, 직급, 입사일, 순위 조회
-- INLINE VIEW 복습
-- 풀이1) FROM에서 미리 "보너스 포함 연봉"을 기준으로 정렬
SELECT EMP_ID 사번, EMP_NAME 이름,
        DEPT_TITLE 부서명, JOB_NAME 직급, HIRE_DATE 입사일, ROWNUM 순위
FROM (SELECT * --보너스를 포함한 연봉을 기준으로 내림차순 정렬을 먼저 실행
      FROM EMPLOYEE
        JOIN JOB USING(JOB_CODE) --JOB테이블과 내부조인
        JOIN DEPARTMENT ON (DEPT_CODE=DEPT_ID) -- DEPARTMENT테이블과 내부조인
      ORDER BY SALARY*(1+NVL(BONUS,0))*12 DESC)
WHERE ROWNUM<=5; --상위 5명만 선택


-- 풀이2) WITH을 이용
-- AS()에 해당하는 데이터로우를 담는 테이블을 TOP_SAL이라 하겠다.
-- AS()안에 있는 데이터로우의 집합은
-- 보너스를 포함한 연봉을 내림차순으로 정렬한 결과이다.
WITH TOP_SAL AS(SELECT *
                FROM EMPLOYEE
                    JOIN JOB USING(JOB_CODE)
                    JOIN DEPARTMENT ON(DEPT_CODE=DEPT_ID)
                ORDER BY 12*SALARY*(1+NVL(BONUS,0)) DESC)
SELECT EMP_ID 사번, EMP_NAME 이름, DEPT_TITLE 부서명,
        JOB_NAME 직급, HIRE_DATE 입사일, ROWNUM 순위
FROM TOP_SAL
WHERE ROWNUM<=5;
