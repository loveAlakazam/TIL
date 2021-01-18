# 방명록 프로젝트

## 1. 사용 기술 스택

|기술스택|상세정보|
|:--:|:--:|
|Language|- Java <br>- JSP & Servlet<br>- HTML, CSS, JS(jQuery), Ajax |
|Server| Apache Tomcat 9.0|
|Design Pattern| MVC Pattern|
|Database|Mysql 8.0.23|

<hr>

## 2. 프로젝트 개요

> ## 메인 페이지

- 방명록은 POST방식을 이용하여 등록하고, 비동기방식인 Ajax를 활용한다.

- JSTL & EL을 사용하여 방명록을 데이터를 화면에 랜더링 시킨다.

데이터베이스에 저장된 방명록이 존재하지 않을때는 존재하지 않는다는 메시지와 함께 화면에 랜더링한다.

메인 페이지에 보여주는 방명록은 최신순 5개를 보여준다.

- 목록버튼을 클릭하면 전체 방명록을 볼 수있다.

그러나 저장된 방명록이 없을때는 목록버튼을 볼 수 없다.

<br>

> ## 방명록 목록 리스트 페이지

- 테이블 형태로 방명록을 나타낸다.

방명록 테이블을 나타내는 모든 컬럼에 해당하는 데이터를 보여준다.

- 작성자 상관없이 방명록을 삭제할 수 있다.

- 메인페이지로 돌아가는 버튼이 있다.

- jQuery를 활용하여 맨위로 이동하는 고정 버튼이 있다.

<br>

> ## 방명록 조회 응답 & 요청 과정 도식화

<br>

> ## 방명록 등록/삭제  응답 & 요쳥 과정 도식화

<br>

> ## 방명록 테이블

```sql
CREATE TABLE GUESTBOOK(

GID INT NOT NULL AUTO_INCREMENT,
NAME VARCHAR(20) NOT NULL,
CONTENT VARCHAR(350) NOT NULL,
GDATE DATETIME NOT NULL DEFAULT (CURRENT_DATE),
PRIMARY KEY(GID)
);
```

<br>

> ###  MySQL 에서 날짜 자료형 컬럼의 DEFAULT값을 현재날짜로 하기.

테이블을 생성할 때, 데이터베이스 종류마다 다른 모습을 볼 수 있었다.

오라클의 경우에는 `DEFAULT SYSDATE` 로 하면 현재날짜를 기본값으로 한다.

반면 MySQL의 경우에는 에러메시지를 발생한다.

그러면 MySQL에서는 현재날짜를 기본값으로 할 수 있을까?

<br>


###  **`(CURDATE())`** 로 현재날짜를 기본값으로 설정 예시 코드

```sql
CREATE TABLE SAMPLE_TABLE(
  SAMPLE_DATE DATE DEFAULT (CURDATE());
);
```

stack-overflow를 통해 직접 테이블을 생성해본 결과

`(CURDATE())` 를 추가하면된다.

이는 **MySQL 8.x 버젼부터 가능하다.** 그 이전 버전에서는 오류메시지가 뜬다.

<br>

### **`(CURRENT_DATE)` 로 현재날짜를 기본값으로 설정 예시 코드

```sql
CREATE TABLE SAMPLE_TABLE2(
  SAMPLE_DATE DATE DEFAULT (CURRENT_DATE);
)
```

<BR>

> ### MySQL과 Oracle의 차이점 : 날짜 조회 형식이 다르다.

현재날짜를 기본값으로 세팅하는 쿼리문이

데이터베이스마다 다르다는 것을 알게되면서 또하나 떠오른 게 있는데

**날짜 조회**가 다르다는 점과 **함수**형태로 조회하느냐 안하느냐이다.

MySQL에서 현재날짜를 조회하는 SELECT문을 수행했을 때

`SELECT NOW();`, `SELECT CURDATE();`, `SELECT CURRENT_DATE;` 로도 현재시각(날짜)가 조회된다.

- **`NOW()`**

`2021-01-19 04:55:46` 과 같은 현재날짜를 포함한 현재시각을 보여준다.

<br>

- **`CURRENT_DATE`** 와 **`CURDATE()`**

`2021-01-19` 와 같은 날짜형식으로 보여준다.

특히 오라클과 다르게 `NOW()`, `CURDATE()` 와 같은 함수를 호출하여 현재날짜를 조회할 수 있다.

- ORACLE 도 `SELECT CURRENT_DATE FROM DUAL;`로 현재날짜를 조회할 수 있다.

그러나 ORACLE은 함수를 호출해서 조회하지 않는다.


[참고 링크](https://stackoverflow.com/questions/20461030/current-date-curdate-not-working-as-default-date-value)


<BR>

<hr>

## 3. 뷰 화면

<br>

## 4. 시연영상
