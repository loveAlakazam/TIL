# PL/SQL

- Procedural Language extension to SQL 약자
  - ORACLE 자체에 내장되어 있는 절차적 언어.

- SQL의 단점을 보완.
- SQL문장 내에서 `변수 정의` / `조건 처리` / `반복 처리` 등 지원.

- 선언부(DECLARE SECTION)
  - 데이터를 담는 공간을 미리 설정
  - 변수나 상수를 선언
  - <B>`DECLARE`</B> 로 시작


- 실행부(EXECUTABLE SECTION)
  - 변수와 상수를 이용하여 활용
  - 제어문, 반복문, 함수 정의와 같은 로직을 기술.
  - <B>`BEGIN`</B> 로 시작, <B>`END`</B> 로 끝
  - 끝 이후에는 <B>`/`</B> 를 표시해야한다.
    - PL/SQL이 끝났음을 나타낸다.

- 예외처리부(EXCEPTION SECTION)
  - 예외 사항 발생시 어떻게 해결할지를 기술.
  - <B>`EXCEPTION`</B> 로 시작


> ### 사용 예시

```SQL
SET SERVEROUTPUT ON;

BEGIN
  DBMS_OUTPUT.PUT_LINE('HELLO WORLD!'); --출력문장

END;
/ -- /표시를 해야 PLSQL이 완전히 끝났음을 알린다. 꼭 붙여야한다.
```

<HR>

> ## PL/SQL 실습 1

```SQL
-- PL/SQL
-- 오라클 자체에 내장되어 있는 절차적 언어.
-- 선언부 (DECLARE): 변수/ 상수 선언
-- 실행부 (BEGIN): 함수/ 반복문/ 조건문 로직기술
-- 예외처리부 (EXCEPTION): 예외발생시 예외처리하는 문장기술

BEGIN
    DBMS_OUTPUT.PUT_LINE('HELLO WOLRD!');
END;
/
--[출력결과] PL/SQL 프로시저가 성공적으로 완료되었습니다.
-- HELLO WORLD! 가 출력되지 않음.


--화면에 보여주도록 설정
--주석은 옆에 달지말자
SET SERVEROUTPUT ON;



BEGIN
    DBMS_OUTPUT.PUT_LINE('HELLO WOLRD!');
END;
/
--[출력결과] PL/SQL 프로시저가 성공적으로 완료되었습니다.
--          HELLO WOLRD!
```

<BR>

> ## 변수를 선언하여 초기화

```SQL
--2) 변수를 선언하여 초기화
-- 타이변수를 (직접) 선언
DECLARE
    EMP_ID NUMBER;
    -- 변수이름(EMP_ID) 변수타입(NUMBER)
    -- (JAVA) int emp_id;

    EMP_NAME VARCHAR2(20);
    -- (JAVA) String emp_name;

    PI CONSTANT NUMBER :=3.14;
    --상수
    --변수이름(PI) CONSTANT NUMBER
    --final 예약어 붙인것처럼, 예약어를 붙임
    --대입 `:=` 을 사용.

BEGIN
    EMP_ID := 888;
    EMP_NAME := '배장남';

    DBMS_OUTPUT.PUT_LINE('EMP_ID :' || EMP_ID);
    DBMS_OUTPUT.PUT_LINE('EMP_NAME: ' || EMP_NAME);
    DBMS_OUTPUT.PUT_LINE('PI: ' || PI);
END;
/

--EMP_ID :888
--EMP_NAME: 배장남
--PI: 3.14
--PL/SQL 프로시저가 성공적으로 완료되었습니다.

```

<BR>

> ## 래퍼런스 변수 선언 및 초기화

```SQL
-- 3) 래퍼런스 변수 선언 및 초기화
DECLARE
    EMP_ID EMPLOYEE.EMP_ID%TYPE;
    -- 직접 만들지 않음.
    -- EMPLOYEE테이블의 EMP_ID의 타입을 가져온다.
    -- 알아서 담기는건 프레임워크에서 함.

    EMP_NAME EMPLOYEE.EMP_NAME%TYPE;

BEGIN
    SELECT EMP_ID, EMP_NAME
    --노란줄 SELECT문에서 INTO절이 필요합니다.
    --EMPLOYEE테이블의 컬럼

    INTO EMP_ID, EMP_NAME
    --EMP_ID와 EMP_NAME에 집어넣겠다.
    --DECLARE에서 정의한 변수

    FROM EMPLOYEE
    WHERE EMP_ID=200;

    DBMS_OUTPUT.PUT_LINE('EMP_ID: '|| EMP_ID);
    DBMS_OUTPUT.PUT_LINE('EMP_NAME: ' || EMP_NAME);
END;
/

-- RESULT
--PL/SQL 프로시저가 성공적으로 완료되었습니다.
--EMP_ID: 200
--EMP_NAME: 선동일
```

<BR>

```SQL
-- 여러명의 사원을 보고 싶다.
DECLARE
    EMP_ID EMPLOYEE.EMP_ID%TYPE;
    -- 직접 만들지 않음.
    -- EMPLOYEE테이블의 EMP_ID의 타입을 가져온다.
    -- 알아서 담기는건 프레임워크에서 함.

    EMP_NAME EMPLOYEE.EMP_NAME%TYPE;

BEGIN
    SELECT EMP_ID, EMP_NAME
    --노란줄 SELECT문에서 INTO절이 필요합니다.
    --EMPLOYEE테이블의 컬럼

    INTO EMP_ID, EMP_NAME
    --EMP_ID와 EMP_NAME에 집어넣겠다.
    --DECLARE에서 정의한 변수

    FROM EMPLOYEE
--    WHERE EMP_ID= '&EMP_ID';
--      EMP_ID에 대한 값 입력 창이 뜸.

    WHERE EMP_ID= '&사번';
--      사번에 대한 값 입력 창이 뜸.

    DBMS_OUTPUT.PUT_LINE('EMP_ID: '|| EMP_ID);
    DBMS_OUTPUT.PUT_LINE('EMP_NAME: ' || EMP_NAME);
END;
/

--EMP_ID 값 입력 => 201
--결과
--EMP_ID: 201
--EMP_NAME: 송종기

--존재하지 않은 EMP_ID값 입력시 발생하는 에러
--01403. 00000 -  "no data found"
```

<BR>


```SQL
-- 4) 래퍼런스 변수로 EMP_ID, EMP_NAME, DEPT_CODE, JOB_CODE, SALARY
-- 를 조회하고 EMPLOYEE테이블에서 사번, 이름, 직급코드, 부서코드, 급여를
-- 조회하여 선언한 레퍼런스 변수에 담아 출력하시오.
-- 단, 입력받은 이름과 일치하는 조건의 직원을 조회하시오.

DECLARE
    EMP_ID EMPLOYEE.EMP_ID%TYPE;
    EMP_NAME EMPLOYEE.EMP_NAME%TYPE;
    DEPT_CODE EMPLOYEE.DEPT_CODE%TYPE;
    JOB_CODE EMPLOYEE.JOB_CODE%TYPE;
    SALARY EMPLOYEE.SALARY%TYPE;

BEGIN
    --EMPLOYEE테이블 컬럼
    SELECT EMP_ID, EMP_NAME, DEPT_CODE, JOB_CODE, SALARY

    --변수
    INTO EMP_ID, EMP_NAME, DEPT_CODE, JOB_CODE, SALARY
    FROM EMPLOYEE
    WHERE EMP_NAME='&이름';

    --출력=> 이름 입력창에서 입력한 이름과 같은 이름의
    --직원정보를 출력
    DBMS_OUTPUT.PUT_LINE('EMP_ID: '||EMP_ID);
    DBMS_OUTPUT.PUT_LINE('EMP_NAME: ' || EMP_NAME);
    DBMS_OUTPUT.PUT_LINE('DEPT_CODE: ' || DEPT_CODE);
    DBMS_OUTPUT.PUT_LINE('JOB_CODE: ' || JOB_CODE);
    DBMS_OUTPUT.PUT_LINE('SALARY: ' || SALARY);

END;
/

-- 노옹철 입력함.
--결과
--EMP_ID: 202
--EMP_NAME: 노옹철
--DEPT_CODE: D9
--JOB_CODE: J2
--SALARY: 3700000
--PL/SQL 프로시저가 성공적으로 완료되었습니다.
```

<BR>

> ## 한 행에 대한 ROWTYPE 변수 선언 및 초기화

```SQL
--5) 한 행에 대한 ROWTYPE 변수 선언 및 초기화
DECLARE
    E EMPLOYEE%ROWTYPE;
    -- %ROWTYPE: 여러개의 컬럼에 해당하는 데이터를 한꺼번에 갖고온다.
BEGIN
    SELECT *
    INTO E
    -- 모든 컬럼을 E에 넣는다.

    FROM EMPLOYEE
    WHERE EMP_ID='&사번';

    -- 변수 E안에 들어있다.
    DBMS_OUTPUT.PUT_LINE('EMP_ID : '||E.EMP_ID);
    DBMS_OUTPUT.PUT_LINE('EMP_NAME: '||E.EMP_NAME);
    DBMS_OUTPUT.PUT_LINE('EMP_NO: '||E.EMP_NO);
    DBMS_OUTPUT.PUT_LINE('SALARY: '||E.SALARY);
END;
/

-- 사번 213 입력
--EMP_ID : 213
--EMP_NAME: 하동운
--EMP_NO: 621111-1785463
--SALARY: 2320000
--PL/SQL 프로시저가 성공적으로 완료되었습니다.
```

<BR>

> ## IF ~ THEN ~ END IF (단일 IF문)

```SQL
--6) 조건문
-- IF~ THEN ~ END IF (단일 IF문)
-- EMP_ID를 입력받아 해당 사원의 사번/이름/급여/보너스율 을 출력
-- 단, 보너스를 받지 않는 사원은 보너스율 출력 전
-- 보너스를 지급받지 않은 사원입니다 를 출력.

DECLARE
    EMP_ID EMPLOYEE.EMP_ID%TYPE;
    EMP_NAME EMPLOYEE.EMP_NAME%TYPE;
    SALARY EMPLOYEE.SALARY%TYPE;
    BONUS EMPLOYEE.BONUS%TYPE;

BEGIN
    SELECT EMP_ID, EMP_NAME, SALARY, NVL(BONUS,0)
    INTO EMP_ID, EMP_NAME, SALARY, BONUS
    FROM EMPLOYEE
    WHERE EMP_ID='&사번';

    -- 입력한 사번에 해당하는 사원정보 출력.
    DBMS_OUTPUT.PUT_LINE('EMP_ID : ' || EMP_ID);
    DBMS_OUTPUT.PUT_LINE('EMP_NAME: '|| EMP_NAME);
    DBMS_OUTPUT.PUT_LINE('SALARY: '||SALARY);

    -- BONUS출력전에 보너스를 받지않으면
    -- 보너스를 지급받지 않은 사원입니다를 출력
    IF (BONUS=0)
        THEN DBMS_OUTPUT.PUT_LINE('보너스를 지급받지 않은 사원입니다.');
    END IF;

    DBMS_OUTPUT.PUT_LINE('BONUS: '|| BONUS*100 || '%');    
END;
/

-- 결과1: 사원번호 201입력
--EMP_ID : 201
--EMP_NAME: 송종기
--SALARY: 6000000
--보너스를 지급받지 않은 사원입니다.
--BONUS: 0%
--PL/SQL 프로시저가 성공적으로 완료되었습니다.

--결과2: 사원번호 213입력
--EMP_ID : 213
--EMP_NAME: 하동운
--SALARY: 2320000
--BONUS: 10%
--PL/SQL 프로시저가 성공적으로 완료되었습니다.
```

<BR>

> ## IF ~ THEN ELSE ~ END IF (IF~ELSE문)

```SQL
--7) IF ~ THEN ~ ELSE ~ END IF (IF~ELSE문)
-- EMP_ID를 입력받아 해당 사원의 사번/이름/부서명/소속 출력
-- TEAM 변수를 만들어 소속이 'KO'인 사원은 국내팀, 아닌사람은 해외팀으로 저장
DECLARE
    --사번
    EMP_ID EMPLOYEE.EMP_ID%TYPE;

    --이름
    EMP_NAME EMPLOYEE.EMP_NAME%TYPE;

    --부서명
    DEPT_TITLE DEPARTMENT.DEPT_TITLE%TYPE;

    --소속
    NATIONAL_CODE LOCATION.NATIONAL_CODE%TYPE;

    --팀변수 (직접만든다)
    TEAM VARCHAR2(20);

BEGIN
    SELECT EMP_ID, EMP_NAME, DEPT_TITLE, NATIONAL_CODE
    INTO EMP_ID, EMP_NAME, DEPT_TITLE, NATIONAL_CODE
    FROM EMPLOYEE
            LEFT JOIN DEPARTMENT ON(DEPT_CODE=DEPT_ID)
            LEFT JOIN LOCATION ON(LOCATION_ID=LOCAL_CODE)
    WHERE EMP_ID='&EMP_ID';

    --국내팀
    IF(NATIONAL_CODE='KO')
        THEN TEAM :='국내팀';
    --해외팀
    ELSE
        TEAM :='해외팀';
    END IF;

    DBMS_OUTPUT.PUT_LINE('사번: ' || EMP_ID);
    DBMS_OUTPUT.PUT_LINE('이름: ' || EMP_NAME);
    DBMS_OUTPUT.PUT_LINE('부서: ' || DEPT_TITLE);
    DBMS_OUTPUT.PUT_LINE('소속: ' || TEAM);
END;
/

-- 출력결과
--사번: 202
--이름: 노옹철
--부서: 총무부
--소속: 국내팀
--PL/SQL 프로시저가 성공적으로 완료되었습니다.

--사번: 213
--이름: 하동운
--부서:
--소속: 해외팀
--PL/SQL 프로시저가 성공적으로 완료되었습니다.
```

<BR>

```SQL
-- 사원의 연봉을 구하는 PL/SQL 블럭 작성
-- 보너스가 없는 사원은 보너스도 포함하여 계산
DECLARE
    VEMP EMPLOYEE%ROWTYPE;
    YSALARY NUMBER;
BEGIN
    SELECT * INTO VEMP
    FROM EMPLOYEE
    WHERE EMP_ID='&EMP_ID';

    IF(VEMP.BONUS IS NULL)
        THEN YSALARY := VEMP.SALARY *12;
    ELSE
        YSALARY:= VEMP.SALARY*(1+VEMP.BONUS)*12;

    END IF;

    DBMS_OUTPUT.PUT_LINE(VEMP.SALARY || ' ' || VEMP.EMP_NAME || ' '
                            || TO_CHAR(YSALARY, 'FML999,999,999'));
END;
/

--결과1:  213 입력
--2320000 하동운 ￦30,624,000
--PL/SQL 프로시저가 성공적으로 완료되었습니다.

```

<BR>

> ## IF ~ THEN ELSIF ~THEN ~ ELSE END IF (IF~ELSE IF~ELSE 문)

```SQL
-- IF~THEN~ELSIF~ELSE~END IF (IF~ELSE IF~ELSE문)
-- 점수를 입력 받아 SCORE변수에 저장하고
-- 90점 이상은 'A', 80점 이상은 'B', 70점 이상은 'C'
-- 60점 이상은 'D', 60점 미만은 'F'로 조건 처리하여
-- GRADE 변수에 저장.
-- '당신의 점수는 90점이고', 학점은 A학점입니다' 형태로 출력.
DECLARE
    SCORE INT; -- ANSI타입 자료형, ORACLE NUMBER(38)과 같음
    GRADE VARCHAR2(2);
BEGIN
    --점수를 받는다.
    SCORE:='&점수';

    IF SCORE>=90 THEN GRADE :='A';
    ELSIF SCORE>=80 THEN GRADE :='B';
    ELSIF SCORE>=70 THEN GRADE :='C';
    ELSIF SCORE>=60 THEN GRADE :='D';
    ELSE GRADE:='F';
    END IF;

    DBMS_OUTPUT.PUT_LINE('당신의 점수는 ' || SCORE || '점 이고, 학점은 "' || GRADE || '" 입니다!');
END;
/
--[결과] 점수 97 입력
--당신의 점수는 97점 이고, 학점은 "A" 입니다!
--PL/SQL 프로시저가 성공적으로 완료되었습니다.
```

<BR>

> # 반복문

> ## Basic loop

```SQL
-- BASIC LOOP: 내부에 처리문을 작성하고 마지막에 LOOP 벗어날 조건 명시
-- 1~5출력
DECLARE
    N NUMBER:=1;
BEGIN
    LOOP
        DBMS_OUTPUT.PUT_LINE(N);
        N:=N+1;
        IF N>5 THEN EXIT;
        --N이 5를 넘으면 나간다.
        END IF;
    END LOOP;
END;
/
--출력결과
--1
--2
--3
--4
--5
--PL/SQL 프로시저가 성공적으로 완료되었습니다.
```

```SQL
--반복문2 (BASIC LOOP) (1보다 더 간단함)
DECLARE
    N NUMBER:=1;
BEGIN
    LOOP
        DBMS_OUTPUT.PUT_LINE(N);
        N:=N+1;
        EXIT WHEN N>5;
    END LOOP;
END;
/
```

<BR>

> ## for loop

```SQL
BEGIN
    --루프 범위: 1..5 : 1부터 5까지
    FOR N IN 1..5
    LOOP
        DBMS_OUTPUT.PUT_LINE(N);
        --수행문
    END LOOP;
END;
/
--[결과]
--1
--2
--3
--4
--5
--PL/SQL 프로시저가 성공적으로 완료되었습니다.
```

```SQL
--5부터 1까지 반복문
BEGIN
    --루프 범위: 1..5 : 1부터 5까지
    FOR N IN REVERSE 1..5
    LOOP
        DBMS_OUTPUT.PUT_LINE(N);
        --수행문
    END LOOP;
END;
/

--출력결과
--5
--4
--3
--2
--1
--PL/SQL 프로시저가 성공적으로 완료되었습니다.
```

```SQL
CREATE TABLE TEST1(
    BUNHO NUMBER(3),
    NALJJA DATE
);
--Table TEST1이(가) 생성되었습니다.

BEGIN
    FOR I IN 1..10
    LOOP
        INSERT INTO TEST1 VALUES(I, SYSDATE);
    END LOOP;
END;
/
--PL/SQL 프로시저가 성공적으로 완료되었습니다.


SELECT * FROM TEST1;
```




<BR>

> ## while loop

```SQL
DECLARE
    N NUMBER :=1;
BEGIN
    WHILE N<=5
        LOOP
            DBMS_OUTPUT.PUT_LINE(N);
            N:=N+1;
        END LOOP;
END;
/
--출력결과
--1
--2
--3
--4
--5
--PL/SQL 프로시저가 성공적으로 완료되었습니다.
COMMIT;
```

<BR>

<HR>

> # 예외처리

- EXCEPTION : 예외가 발생 했을 때 처리 구문 기술
  - 미리 정의된 EXCEPTION
  - 사용자 정의 EXCEPTION
  - 주로 예외는 자바에서 처리.


> ### 예외처리 (UNIQUE)

```SQL
-- 예외처리 전
COMMIT;

BEGIN
    UPDATE EMPLOYEE
    SET EMP_ID ='&사번'
    WHERE EMP_ID=200;
END;
/
-- 201을 입력시 에러 발생
--ORA-00001: unique constraint (KH.EMPLOYEE_PK) violated
--ORA-06512: at line 2
--00001. 00000 -  "unique constraint (%s.%s) violated"
--*Cause:    An UPDATE or INSERT statement attempted to insert a duplicate key.
--           For Trusted Oracle configured in DBMS MAC mode, you may see
--           this message if a duplicate entry exists at a different level.
--*Action:   Either remove the unique restriction or do not insert the key.


-- 예외처리 후
BEGIN
    UPDATE EMPLOYEE
    SET EMP_ID ='&사번'
    WHERE EMP_ID=200;
EXCEPTION
    WHEN DUP_VAL_ON_INDEX
        THEN DBMS_OUTPUT.PUT_LINE('이미존재하는 사번입니다!');
END;
/
--예외처리 이후 출력결과 (입력 201)
--이미존재하는 사번입니다!
--PL/SQL 프로시저가 성공적으로 완료되었습니다.

```

<BR>


> ### NO-DATA-FOUND 예외처리

```SQL
-- NO_DATA_FOUND 예외처리
-- 예외처리 이전
DECLARE
    NAME VARCHAR2(30);
BEGIN
    SELECT EMP_NAME
    INTO NAME
    FROM EMPLOYEE
    WHERE EMP_ID=2044; --없음
END;
/
--[출력결과] NO-DATA-FOUND
--ORA-01403: no data found
--ORA-06512: at line 4
--01403. 00000 -  "no data found"
--*Cause:    No data was found from the objects.
--*Action:   There was no data from the objects which may be due to end of fetch.



--예외처리 이후
DECLARE
    NAME VARCHAR2(30);
BEGIN
    SELECT EMP_NAME
    INTO NAME
    FROM EMPLOYEE
    WHERE EMP_ID=2044; --없음
EXCEPTION
    WHEN NO_DATA_FOUND
        THEN DBMS_OUTPUT.PUT_LINE('조회 결과가 없습니다!');
END;
/

--조회 결과가 없습니다!
--PL/SQL 프로시저가 성공적으로 완료되었습니다.
```
