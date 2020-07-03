# Database
- SQL (Structured Query Language)

- DML: 데이터 자체 조작
  - 삽입(INSERT)
  - 갱신(UPDATE)
  - 삭제(DELETE)
  - ( 조회(SELECT) )

- DQL: 데이터를 조회 및 검색
  - <b>SELECCT</b>

- DDL: 데이터 정의
  - CREATE
  - ALTER
  - DROP

- TCL: 트랜젝션 제어(제어를 어떻게 할건지.)
  - 권한을 부여받고, 변경상태에서 저장 및 되돌릴것인지를 결정
  - 변경사항을 저장하거나 최신상태로 돌리겠다.
  - COMMIT
  - ROLLBACK
  - GRANT


<HR>

- 튜플 = 행(가로)
  - 하나의 데이터 row

- 컬럼 = 열(세로)

- 기본키(Primary Key): 구분자 역할 - 튜플을 구분하는데 사용.
  - 중복되면 안된다.
  - 값이 비어있으면 안된다.

  - 아이디
  - 변경이 가능한 값은 기본키가 될 수 없다.
  - DB모델링에서 중요한 개념이다.

- 외래키
  - 테이블과 테이블 사이에서 관계를 지을 수 있다.
    - (A테이블) (B테이블) 간의 연관
      ```
      한 테이블의 기본키가 다른테이블의 일반컬럼으로 들어갔을 때
      테이블 A와 테이블 B의 관계가 맺어진다.
      ```
      - B테이블입장에서 그 일반컬럼은 테이블 A의 기본키에서 온 것이므로, 외래키이다.

- 테이블의 데이터에는 NULL값이 들어있을 수 있다.


<hr>


# SELECT

<B>
- *Result Set* : 데이터를 조회/검색/추출 한 결과물
- SELECT 구문에 의해서 반환된 행들의 집합
</B>

- Result Set은 *0개 이상의 행* 이 포함될 수 있다.
- 정렬도 가능하다.

```SQL
SELECT 컬럼명 -- 모든 컬럼을 다 조회  : *(*=아스트로)
FROM 테이블명
WHERE 조건식; -- 행을 선택하는 조건 기술.

```


```sql
-- SELECT
-- SELECT 구문으로 데이터를 조회한 결과물은 RESULT_SET 으로 반환

-- EMPLOYEE 테이블의 사번, 이름, 급여 조회
SELECT EMP_ID, EMP_NAME, SALARY
FROM EMPLOYEE;
```


```sql
-- 모든 사원수 조회
-- EMPLOYEE 테이블에서 모든 사원의 모든 정보를 조회
SELECT EMP_ID, EMP_NAME, EMP_NO, EMAIL, PHONE, JOB_CODE, SAL_LEVEL, SALARY,
BONUS, MANAGER_ID, HIRE_DATE, ENT_DATE, ENT_YN
FROM EMPLOYEE;

-- 동일 표현
SELECT *
FROM EMPLOYEE;
```

- 예제
```sql
-- JOB 테이블의 모든 정보 조회
SELECT * FROM JOB;

-- JOB 테이블의 직급 이름 조회
SELECT JOB_NAME FROM JOB;

-- DEPARTMENT 테이블의 모든 정보 조회
DESC DEPARTMENT ; --테이블의 구성요소를 볼 수 있음.
SELECT * FROM DEPARTMENT;

-- EMPLOYEE 테이블의 직원명, 이메일, 전화번호, 고용일 조회
DESC EMPLOYEE;
SELECT EMP_NAME, EMAIL, PHONE, HIRE_DATE FROM EMPLOYEE;

-- EMPLOYEE 테이블의 고용일, 사원이름 급여 조회
SELECT HIRE_DATE, EMP_NAME, SALARY FROM EMPLOYEE;
```

<HR>

- 컬럼값 산술연산
  - 컬럼에 있는 데이터를 계산하여 새로운 컬럼 만들기
```sql
-- 컬럼값 산술연산
-- SELECT 시 컬럼명 입력부분에 계산에 필요한
-- 컬럼명, 숫자, 연산자를 이용하여 결과 조회
-- EMPLOYEE 테이블에서 직원명, 연봉 조회(SALARY *12)

SELECT EMP_NAME, SALARY*12 "연봉"
FROM EMPLOYEE;


-- EMPLOYEE 테이블에서 직원명, 연봉, 보너스를 추가한 연봉 조회
SELECT EMP_NAME, SALARY*12 "연봉", 12*(SALARY+BONUS)  "보너스 추가 연봉"
FROM EMPLOYEE;
```

<BR>

- 예제
```sql
--EMPLOYEE테이블에서 이름, 연봉, 총수령액(보너스포함), 실수령액(총수령액-(연봉*세금3%)) 조회
DESC EMPLOYEE;
SELECT * FROM EMPLOYEE;

SELECT EMP_NAME, SALARY*12 "연봉" , SALARY*(1+BONUS)*12 "총수령액" , (SALARY*(1+BONUS)*12-(SALARY*12*0.03)) "실수령액"
FROM EMPLOYEE;


--EMPLOYEE테이블에서 이름, 고용일, 근무일수(오늘 날짜-고용일) 조회 (SYSDATE 현재날짜)
SELECT EMP_NAME, HIRE_DATE, (SYSDATE-HIRE_DATE) "근무일수", SYSDATE "현재날짜"
FROM EMPLOYEE;
```

<HR>


# 컬럼에 별칭 넣기

- 컬럼명 AS 별칭
- 컬럼명 "별칭"
- 컬럼명 AS "별칭"
- 컬럼명 별칭


- AS 사용 상관없이 별칭에 <B>띄어쓰기, 특수문자, 숫자</B>가 있다면 <B>""</B> 로 사용해야한다.

```sql
-- 컬럼 별칭
-- 별칭에 숫자, 특수문자가 들어오면 무조건 "" 을 이용해야함.

SELECT EMP_NAME AS 이름 , SALARY*12 AS "연봉(원)", (SALARY*(1+BONUS))*12 "총소득(원)"
FROM EMPLOYEE;


-- 예제2
SELECT EMP_NAME 이름, HIRE_DATE 고용일, SYSDATE-HIRE_DATE 근무일수
FROM EMPLOYEE;

```

<BR>

- 리터럴(Literal) = 값자체
- '': 문자를 집어넣을거면 홑따옴표를 이용
- "": 별칭
- DB는 대체로 대소문자 안가린다.
  - 대소문자를 가리는경우는, 문자열값에서 나타난다.
    - 'Won', 'won' 은 다른 값으로 인지한다.
    - 관리자계정/사용자 계정의  비밀번호는 대소문자 가린다.

```sql
SELECT EMP_ID "직원 번호", EMP_NAME 이름, SALARY "연봉(원)", '원 입니다' "단위"
FROM EMPLOYEE;

select emp_id, emp_name, SALARY, 'Won', 'won'
from employee;
```

<BR>

<HR>

- DISTINCT: 중복제거
  - DISTINCT는 <B>SELECT절에서 딱 한번만 쓸 수 있다.</B>

```sql
-- 중복제거1
SELECT JOB_CODE
FROM EMPLOYEE;

SELECT DISTINCT JOB_CODE
FROM EMPLOYEE;

-- 중복제거2
-- DEPT_CODE, JOB_CODE모두 묶어서 중복제거
SELECT DISTINCT DEPT_CODE,  JOB_CODE
FROM EMPLOYEE;

-- 에러발생 : DISTINCT는 한번만!
SELECT DISTINCT DEPT_CODE, DISTINCT JOB_CODE
FROM EMPLOYEE;
```

# WHERE
- 조회할 테이블에서 조건이 맞는 값을 가진 행을 골라낸다.
- 연산자를 사용하여 조건을 만든다.
  - `=`: 같다
  - `>`: 크다
  - `>=`: 크거나 같다

  - `<`: 작다
  - `<=`: 작거나 같다
  - `!=`, `^=`, `<>`: 같지않다

```SQL
-- EMPLOYEE 테이블에서 부서코드가 'D9'인 직원의 이름 부서코드 조회
SELECT EMP_NAME 직원 , DEPT_CODE 부서코드
FROM EMPLOYEE
WHERE DEPT_CODE='D9';

-- EMPLOYEE 테이블에서 부서코드가 'D9'가 아닌 직원이름 부서코드 조회

SELECT EMP_NAME 직원, DEPT_CODE 부서코드
FROM EMPLOYEE
WHERE DEPT_CODE<>'D9';
--WHERE DEPT_CODE!='D9';
--WHERE DEPT_CODE^='D9';
```

<BR>

# WHERE절에 논리 연산자 넣기

- 논리연산자: AND, OR
- JAVA: &&, ||
```sql
-- EMPLOYEE 테이블에서 부서코드가 D6이고
-- 급여가 200만원보다 많이 받는 직원의 이름, 부서코드, 급여조회
SELECT EMP_NAME "직원의 이름", DEPT_CODE 부서코드, SALARY 급여
FROM EMPLOYEE
WHERE (SALARY>=2000000) AND (DEPT_CODE='D6');


-- EMPLOYEE 테이블에서 부서코드가 D6이거나
-- 300만보다 많이 받는 직원의 이름, 부서코드, 급여조회
SELECT EMP_NAME, DEPT_CODE, SALARY
FROM EMPLOYEE
WHERE DEPT_CODE='D6' OR SALARY>3000000;


-- EMPLOYEE테이블에서 급여를 350만원 이상, 600만원 이하를 받는
-- 직원의 사번, 이름, 급여, 부서코드, 직급코드 조회
SELECT EMP_ID, EMP_NAME, SALARY, DEPT_CODE, JOB_CODE
FROM EMPLOYEE
WHERE SALARY>=3000000 AND SALARY<=6000000;

-- EMPLOYEE 테이블에서 월급이 4000000이상이고 JOB_CODE가 J2인 사원의 전체내용조회
SELECT *
FROM EMPLOYEE
WHERE SALARY>=4000000 AND JOB_CODE='J2'

-- EMPLOYEE 테이블에서 DEPT_CODE가 D9이거나 D5인 사원 중
-- 고용일이 02년 01월 01보다 빠른
-- 사원의 이름, 부서코드, 고용일 조회
SELECT EMP_NAME, DEPT_CODE, HIRE_DATE
FROM EMPLOYEE
WHERE (DEPT_CODE='D9' OR DEPT_CODE='D5') AND HIRE_DATE<'02/1/1';
```


# BETWEEN

```SQL
-- BETWEEN A AND B: A(하한값)이상 B(상한값)이하
-- 급여를 3500000원 이상받고 6000000원 이하로 받는 사원의 이름, 급여 조회
SELECT EMP_NAME, SALARY
FROM EMPLOYEE
WHERE SALARY>=3500000 AND SALARY<=6000000;


SELECT EMP_NAME, SALARY
FROM EMPLOYEE
WHERE SALARY BETWEEN 3000000 AND 6000000;

-- 급여가 3500000원 미만으로 받거나 6000000원 초과로 받는
-- 사원의 이름, 급여 조회
SELECT EMP_NAME, SALARY
FROM EMPLOYEE
WHERE SALARY<3500000 OR SALARY>6000000;

SELECT EMP_NAME, SALARY
FROM EMPLOYEE
WHERE SALARY NOT BETWEEN 3500000 AND 6000000;
--!(SALARY BETWEEN 3500000 AND 600000);

-- EMPLOYEE 테이블에서 고용일이 90/1/1 ~ 01/1/1인 사원의 전체내용 조회
SELECT *
FROM EMPLOYEE
WHERE HIRE_DATE BETWEEN 90/1/1 AND 01/1/1;

```
