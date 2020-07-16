-- 사원의 연봉을 구하는 PL/SQL 블럭작성
-- 보너스가 있는 사원은 보너스도 포함하여 계산

-- SQL쿼리문으로 할때
SELECT EMP_NAME 이름, NVL(BONUS,0) 보너스 ,
        SALARY 급여, SALARY*(1+NVL(BONUS,0))*12 "연봉"
FROM EMPLOYEE;

-- PL/SQL 시작하기전에 사전테스트
SET SERVEROUTPUT ON;

BEGIN
    DBMS_OUTPUT.PUT_LINE('PL/SQL 동작 성공!');
END;
/
COMMIT;

-- PL/SQL선언
DECLARE
    -- 변수 선언하기
    -- 변수이름 변수타입 (테이블에 정의된 컬럼 타입을 참고)
    EMP_ID EMPLOYEE.EMP_ID%TYPE;
    EMP_NAME EMPLOYEE.EMP_NAME%TYPE;
    SALARY EMPLOYEE.SALARY%TYPE;
    BONUS EMPLOYEE.BONUS%TYPE;

    -- 내가 직접 만든 변수 (사원연봉) / NUMBER타입
    YEAR_TOTAL NUMBER;

-- PL/SQL실행문
BEGIN
    SELECT EMP_ID, EMP_NAME, SALARY , NVL(BONUS,0)
    -- EMPLOYEE테이블에서 구하려는 컬럼
    -- NVL(BONUS,0): 보너스가 NULL이라면 0으로 한다.

    INTO EMP_ID, EMP_NAME, SALARY, BONUS
    -- 변수에 컬럼에 해당하는 데이터를 넣는다.
    FROM EMPLOYEE
    WHERE EMP_ID ='&사번';

    -- 입력한 EMP_ID에 해당하는 사원의 이름/급여/보너스/연봉 출력
    --사번
    DBMS_OUTPUT.PUT_LINE('사번: ' || EMP_ID);

    --사원이름
    DBMS_OUTPUT.PUT_LINE('사원이름: ' || EMP_NAME);

    --급여
    DBMS_OUTPUT.PUT_LINE('급여: ' || SALARY || '원');

    --보너스
    DBMS_OUTPUT.PUT_LINE('보너스: ' || BONUS*100 || '%');

    --연봉
    YEAR_TOTAL := SALARY*(1+BONUS)*12;
    DBMS_OUTPUT.PUT_LINE('연봉: ' || YEAR_TOTAL || '원');
END;
/
