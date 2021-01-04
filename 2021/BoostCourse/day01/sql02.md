> # DML

## 시작하기전, 셋팅하기

```shell
mysql -uconnectuser -p connectdb < examples.sql
```

<br>

```sql
show tables
```

<br>

![](./img_sql02/mysql/1.png)

<br>

> # 1. SELECT

```SQL
SELECT *
FROM DEPARTMENT;
```

![](./img_sql02/mysql/2.png)

<br>

```sql
SELECT DEPTNO, NAME
FROM DEPARTMENT;
```

![](./img_sql02/mysql/3.png)

<BR>

> ## 테이블에 구성하는 컬럼값 확인하기 (DESC)

```sql
DESC 테이블이름;
```

![](./img_sql02/mysql/desc.png)

<br>

> ## ALIAS(별칭)

```sql
SELECT DEPTNO "부서번호", NAME "부서명", LOCATION AS 지역
FROM DEPARTMENT;
```

![](./img_sql02/mysql/4.png)

<BR>

## CONCAT - 문자열을 결합시키는 함수

```sql
SELECT CONCAT(EMPNO,'-',EMPNO) AS 사번-부선번호
FROM EMPLOYEE;
```

![](./img_sql02/mysql/5.png)

<BR>

## DISTINCT - 단일값을 나타내는 함수

<BR>

```SQL
SELECT DEPTNO
FROM EMPLOYEE;
```

![](./img_sql02/mysql/61.png)

<BR><br>

```SQL
SELECT DISTINCT DEPTNO
FROM EMPLOYEE;
```

![](./img_sql02/mysql/62.png)

<BR>

## 정렬하기 - ORDER BY

- 이름을 오름차순 정렬

```SQL
SELECT EMPNO, NAME
FROM EMPLOYEE
ORDER BY NAME;
```

<BR>

- 이름을 내림차순으로 정렬

```sql
SELECT EMPNO, NAME
FROM EMPLOYEE
ORDER BY NAME DESC;
```

<BR>

## WHERE 절

```sql
-- EMPLOYEE 테이블에서 고용일이 1981년 이전의 사원이름과 고용일을 출력
SELECT NAME AS 사원이름, HIREDATE "고용일"
FROM EMPLOYEE
WHERE HIREDATE < '1981-01-01';
```

<br>

## IN

```SQL
SELECT *
FROM EMPLOYEE
WHERE DEPTNO IN (10,30);
```

![](./img_sql02/mysql/7.png)

<BR>

## LIKE

- `%` : 0자~ 여러개의 문자열을 나타냄


```SQL
-- 이름이 a로 시작하는 사원의 정보를 출력.
SELECT *
FROM EMPLOYEE
WHERE NAME LIKE 'a%'

-- 이름이 n으로 끝나는 사원
SELECT *
FROM EMPLOYEE
WHERE NAME LIKE '%a'

-- 이름에 a가 포함되어있는 사원.
SELECT *
FROM EMPLOYEE
WHERE NAME LIKE '%a%'
```

- `_` : 1자의 문자를 나타내는 와일드카드.

```sql
-- 이름의 두번째 문자가 a인 사람
-- _에 해당하는 문자는 건너뜀.
SELECT *
FROM EMPLOYEE
WHERE NAME LIKE '_a%'
```

![](./img_sql02/mysql/8.png)

<br>


## UPPER(UCASE), LOWER(LCASE)

![](./img_sql02/mysql/upper01.png)

<br>

![](./img_sql02/mysql/upper02.png)

<br>

![](./img_sql02/mysql/lower01.png)

<BR>

## SUBSTRING

- sql은 시작 인덱스는 1이다.

- 7번인덱스부터 시작하여, 3글자만 출력한다.

![](./img_sql02/mysql/substring.png)


<BR>

## LPAD, RPAD

- 남은 공간에 대치 문자를 넣는다.

![](./img_sql02/mysql/pad.png)

<br>

## TRIM, LTRIM, RTRIM

- 공백 제거.

![](./img_sql02/mysql/trim.png)

<br>

## 다양한 함수들

- `ABS(숫자)` : 절댓값
- `MOD(값, 나누려는값)` : 나눗셈 나머지값
- `FLOOR(x)` : x보다 작은 정수 중 가장 큰 정수
- `CEILING(x)`: x보다 큰 정수 중 가장 작은 정수
- `ROUND(x)` : x에 가장 근접한 정수 (반올림)

![](./img_sql02/mysql/round01.png)

![](./img_sql02/mysql/round02.png)

<br>

- `POW(x,y)`: x의 y제곱승
- `GREATEST(x,y, ...)` : 가장 큰 값을 반환
- `LEAST(x,y, ...)` : 가장 작은 값을 반환
- `CURDATE()`, `CURRENT_DATE` : 오늘날짜를 `YYYY-MM-DD`형식으로 반환
- `NOW()`, `SYSDATE`, `CURRENT_TIMESTAMP` : 오늘 현시각을 `YYY-MM-DD HH:MM:SS` 형식으로 반환

![](./img_sql02/mysql/now.png)

<BR>

> # 형변환 함수

## (MySQL) CAST

- 표기법

```sql
SELECT CAST(표현 AS TYPE);

SELECT CONVERT(표현, TYPE);
```

<BR>

|TYPE|타입종류|
|:--:|:--:|
|BINARY|이진수|
|CHAR|문자|
|DATE|날짜|
|DATETIME|날짜|
|SIGNED|부호가 있는 정수|
|TIME|시간|
|UNSIGNED|부호가 없는정수(음이 아닌정수)|

<br>

- 예시1

```SQL
SELECT CAST(NOW() AS DATE);
```

![](./img_sql02/mysql/cast.png)

<br>

- 예시2

```sql
SELECT CAST(1-2 AS UNSIGNED);
```

![](./img_sql02/mysql/cast02.png)


<br>

## (Oracle) TO_xxx

<br>

## 그룹함수

- 테이블 전체에 대해서 집계를 함.

### 1. COUNT

- NULL값을 포함해서 모두 카운트

```SQL
SELECT COUNT(*) FROM EMPLOYEE;
```

![](./img_sql02/mysql/select01.png)

<br>

- NULL값을 제외하여 카운트

```SQL
--BOSS컬럼이 null이 아닌것들만 카운트
SELECT COUNT(BOSS) FROM EMPLOYEE;
```

![](./img_sql02/mysql/select02.png)

<br>

### 2. AVG, MIN, MAX, SUM

<br>

### 3. GROUP BY

```SQL
SELECT DEPTNO, AVG(SALARY), SUM(SALARY)
FROM EMPLOYEE
GROUP BY DEPTNO;
```


<br>

<HR>

> # 2. INSERT


```sql
INSERT INTO 테이블명 (필드1, 필드2, 필드3, 필드4, ...)
VALUES (필드1값, 필드2값, 필드3값, 필드4값)


--모든 필드들의 값들을 부여
INSERT INTO 테이블명
VALUES (필드1값, 필드2값, 필드3값, ..., 마지막필드값)
```

- 예시

```sql
INSERT INTO ROLE VALUES(200, 'CEO');
```

- 프라이머리키는 널값을 넣을 수 없다.
- null값을 허용하지 않는 컬럼을 제외하면 에러를 발생.

<HR>

> # 3. UPDATE

```sql
UPDATE 테이블명
SET 필드1=필드1값, 필드2=필드2값, ...
WHERE 조건식;
```

- 예시

```sql
UPDATE ROLE
SET DESCRIPTION='CTO'
WHERE ROLE_ID=200;
```

<HR>

> # 4. DELETE

```sql
DELETE FROM 테이블명
WHERE 조건식;
```

- 예시

```sql
DELETE FROM ROLE
WHERE ROLE_ID=200;
```

<br>

> # ORACLE - DML 참고자료

- [ORACLE 계정설정](https://github.com/loveAlakazam/TIL/blob/master/2020/KH_Git_Repository/notes/ORACLE_DATABASE/01_DML/0701_%EA%B0%9C%EC%9A%94.MD)

- [ORACLE-DML 기초](https://github.com/loveAlakazam/TIL/blob/master/2020/KH_Git_Repository/notes/ORACLE_DATABASE/01_DML/0701_DML.md)

- [ORACLE-DML 문자열함수](https://github.com/loveAlakazam/TIL/blob/master/2020/KH_Git_Repository/notes/ORACLE_DATABASE/01_DML/0703.md)

- [ORACLE-DML 숫자함수](https://github.com/loveAlakazam/TIL/blob/master/2020/KH_Git_Repository/notes/ORACLE_DATABASE/01_DML/0706.md)

- [ORACLE-DML GROUP BY와 HAVING절](https://github.com/loveAlakazam/TIL/blob/master/2020/KH_Git_Repository/notes/ORACLE_DATABASE/01_DML/0707.md)

- [ORACLE-DML JOIN](https://github.com/loveAlakazam/TIL/blob/master/2020/KH_Git_Repository/notes/ORACLE_DATABASE/01_DML/0709.md)

- [ORACLE-DML INSERT/UPDATE/DELETE](https://github.com/loveAlakazam/TIL/blob/master/2020/KH_Git_Repository/notes/ORACLE_DATABASE/01_DML/0713_DML_2.md)
