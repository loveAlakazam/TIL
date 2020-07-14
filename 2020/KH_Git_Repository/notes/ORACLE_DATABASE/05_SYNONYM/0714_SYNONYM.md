# SYNONYM

- 동의어
- 사용자가 다른 사용자의 객체를 참조할 때 `사용자ID.테이블명`

- 비공개 동의어
  - private 접근제한자와 같다.
    - 나만 사용할 수 있다.
  - 객체에 대한 접근 권한을 부여받은 사용자가 정의한 동의어

- 공개동의어
  - 권한을 주는 사용자(DBA)가 정의한 동의어
    - 권한을 주는 사용자= SYSTEM

  - 모든 사용자가 사용가능
  - public 접근제한자와 같다.
  - ex. DUAL


```SQL
  -- SYNONYM = 동의어
CREATE SYNONYM EMP -- EMPLOYEE테이블을 EMP라고 한다.
FOR EMPLOYEE;
-- 오류 보고 -
--ORA-00901: invalid CREATE command
--00901. 00000 -  "invalid CREATE command"
--권한이 필요함.

-- SYSTEM 으로 이동
GRANT CREATE SYNONYM TO KH;

CREATE SYNONYM EMP -- EMPLOYEE테이블을 EMP라고 한다.
FOR EMPLOYEE;

SELECT * FROM EMPLOYEE;
SELECT * FROM EMP;

--SYSTEM 계정
SELECT * FROM EMP; --없음
SELECT * FROM KH.EMP; --KH계정의 EMP테이블
SELECT * FROM KH.EMPLOYEE; -- KH계정의 EMPLOYEE
SELECT * FROM KH.DEPARTMENT;-- KH계정의 DEPARTMENT

--공개동의어 -> SYSTEM 계정에서만 사용가능
CREATE PUBLIC SYNONYM DEPT
FOR KH.DEPARTMENT; -- KH의 DEPARTMENT를 DEPT로 동의어로한다.
-- 다른데에서도 볼 수있다.

SELECT * FROM DEPT;
--SCOTT계정
SELECT * FROM DEPT; -- =>외부에서 접근할 수 있다.
```


<BR>

> # SYNONYM 삭제

```SQL
-- KH계정
--SYNONYM삭제
DROP SYNONYM EMP; --Synonym EMP이(가) 삭제되었습니다.

DROP SYNONYM DEPT;
--  "private synonym to be dropped does not exist"
-- DEPT는 PUBLIC SYNONYM이다.

DROP PUBLIC SYNONYM DEPT;
-- 계정은 KH로 되어있고
-- 공개 SYNONYM은 SYSTEM계정만이 삭제 가능하다.

-- SYSTEM계정
DROP PUBLIC SYNONYM DEPT; --SYNONYM DEPT이(가) 삭제되었습니다.
```

<BR>

> # INDEX

- 객체
- 검색연산을 최적화하기 위해서 데이터베이스의 객체
- 행(DATA ROW)들의 정보를 구성한다.
- 빠르게 검색할 수 있다.
