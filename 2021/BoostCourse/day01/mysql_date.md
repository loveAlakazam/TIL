##  MySQL 에서 날짜 자료형 컬럼의 DEFAULT값을 현재날짜로 하기.

테이블을 생성할 때, 데이터베이스 종류마다 다른 모습을 볼 수 있었다.

오라클의 경우에는 `DEFAULT SYSDATE` 로 하면 현재날짜를 기본값으로 한다.

반면 MySQL의 경우에는 에러메시지를 발생한다.

그러면 MySQL에서는 현재날짜를 기본값으로 할 수 있을까?

<br>

> ###  **`(CURDATE())`** 로 현재날짜를 기본값으로 설정 예시 코드

```sql
CREATE TABLE SAMPLE_TABLE(
  SAMPLE_DATE DATE DEFAULT (CURDATE());
);
```

[stack-overflow](https://stackoverflow.com/questions/20461030/current-date-curdate-not-working-as-default-date-value)를 통해 직접 테이블을 생성해본 결과 `(CURDATE())` 를 추가하면된다.

이는 **MySQL 8.x 버젼부터 가능하다.** 그 이전 버전에서는 오류메시지가 뜬다.

<br>

> ### **`(CURRENT_DATE)`** 로 현재날짜를 기본값으로 설정 예시 코드

```sql
CREATE TABLE SAMPLE_TABLE2(
  SAMPLE_DATE DATE DEFAULT (CURRENT_DATE);
)
```

<hr>

## MySQL과 Oracle의 차이점 : 날짜 조회 형식이 다르다.

현재날짜를 기본값으로 세팅하는 쿼리문이 다르다는 것을 알게되면서 또하나 떠오른 게 있는데

**날짜 조회**가 다르다는 점과 **함수**형태로 조회하느냐 안하느냐이다.

<br>

MySQL에서 현재날짜를 조회하는 SELECT문을 수행했을 때

`SELECT NOW();`, `SELECT CURDATE();`, `SELECT CURRENT_DATE;` 로도 현재시각(날짜)가 조회된다.

<br>

- **NOW()**

`2021-01-19 04:55:46` 과 같은 현재날짜를 포함한 현재시각을 보여준다.

<br>

- **CURRENT_DATE** 와 **CURDATE()**

`2021-01-19` 와 같은 날짜형식으로 보여준다.

특히 오라클과 다르게 `NOW()`, `CURDATE()` 와 같은 함수를 호출하여 현재날짜를 조회할 수 있다.

<br>


ORACLE 도 `SELECT CURRENT_DATE FROM DUAL;`로 현재날짜를 조회할 수 있다.

그러나 ORACLE은 함수를 호출해서 조회하지 않는다.


[참고 링크](https://stackoverflow.com/questions/20461030/current-date-curdate-not-working-as-default-date-value)


<hr>

## CURDATE() 와 CURRENT_DATE 와 NOW()

방명록 프로젝트를 진행하면서 해보고 싶은 것은 방명록을 작성한 날짜뿐만 아니라 **작성 시각(시, 분)**도 같이 넣고 싶었다.

MySQL에는 **`DATETIME`** 라는 자료형이 날짜와 시각(시,분,초) 정보를 저장한다.

그렇다면 DEFAULT 값을 `(CURRENT_DATE)` 했을 때 날짜데이터는 어떻게 나타낼까?


<br>

```sql
CREATE TABLE SAMPLE_DATE3(
  SDATE DATETIME NOT NULL DEFAULT (CURRENT_DATE);
);
```

위와 같은 테이블에서 데이터를 추가해봤다.

<br>

> ### 데이터 추가 1

```sql
INSERT INTO SAMPLE_DATE3 VALUES(CURRENT_DATE);
```

추가 후 SELECT문으로 조회해봤을 때

`SDATE` 컬럼은 `2021-01-19 00:00:00` 와 같은 형태로 저장한다.

<br>

> ### 데이터 추가 2

```sql
INSERT INTO SAMPLE_DATE3 VALUES(CURDATE());
```

데이터 추가 1 결과와 같다.

<br>

> ### 데이터 추가 3

```sql
INSERT INTO SAMPEL_DATE3 VALUES(NOW());
```

데이터 추가 1, 2 와 다르게 `2021-01-19 05:26:28` 처럼 시각정보도 같이 출력됐다.

<br>

> ### 데이터 추가 4

```sql
INSERT INTO SAMPLE_DATE3 VALUES();
```

테이블 생성할 때, 기본값이 `CURRENT_DATE` 로 설정 해놨으므로

데이터 1, 2의 결과와 동일한 형태로 조회된다.


<br>

따라서 작성한 시각 정보를 저장하고 싶다면, 기본값을 `NOW()` 를 사용해야한다.

```SQL
CREATE TABLE SAMPLE_DATE4(
  SDATE DATETIME NOT NULL DEFAULT(NOW())
);
```

<hr>

## 테이블 수정하기

위에서 이미 제시한 테이블 SAMPLE_DATE3 의 **SDATE** 컬럼의 정보를 수정하는 쿼리문이다.

`DATETIME` 에서 `DATE` 타입으로 변경했다.

```sql
ALTER TABLE SAMPLE_DATE3
MODIFY SDATE DATE NOT NULL DEFAULT (CURRENT_DATE);
```

```SQL
ALTER TABLE SAMPLE_DATE3
MODIFY SDATE DATE NOT NULL DEFAULT (CURDATE());
```

```sql
ALTER TABLE SAMPLE_DATE3
MODIFY SDATE DATE NOT NULL DEFAULT (NOW());
```

<br>

반대로 `DATE`타입에서 `DATETIME` 으로 변경이 가능하다.

```sql
ALTER TABLE SAMPLE_DATE4
MODIFY SDATE DATETIME NOT NULL DEFAULT(NOW());
```

<hr>

## MODIFY 와 CHANGE 의 차이점

Oracle의 경우에는 MODIFY 로 컬럼의 정보를 수정할 수 있다.

즉, `CHANGE` 예약어로 컬럼의 정보를 수정하지 않는다.

테이블에 데이터가 있는 경우에는 변경에 대한 제약이 있다.


MySQL에서는 컬럼을 수정하는 방법이 2가지나 있다.

<br>

> ### MODIFY : 컬럼이름을 제외한 컬럼에 저장되는 데이터 유형과 조건을 변경한다.

- 컬럼타입, 컬럼길이, null여부, default값 추가 등을 변경할 수 있다.

```sql
ALTER TABLE 테이블이름
MODIFY 컬럼이름 데이터타입 [NULL|NOT NULL] [DEFAULT 기본값];
```

<br>

> ### CHANGE : 컬럼이름과 컬럼 데이터 유형과 조건을 변경한다.

```sql
ALTER TABLE 테이블이름
CHANGE 기존컬럼이름 변경컬럼이름 데이터타입 [NULL|NOT NULL] [DEFAULT 기본값];
```
