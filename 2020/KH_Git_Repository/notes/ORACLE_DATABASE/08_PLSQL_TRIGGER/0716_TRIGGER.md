> # TRIGGER

- <B>테이블이나 뷰 INSERT/UPDATE/DELETE 등의 DML문에 의해
  변경될 경우 자동으로 실행될 내용을 정의하여 저장하는 객체</B>

- 변경이 일어나면 `자동적으로 수행`
- 입고/출고 같은 상황에서 많이 쓰임.
  - 입고/출고가 생기면 자동으로 만들어짐
  - 게시물에 대해서 좋아요 => 좋아요 합계를 카운트
    - 좋아요 수를 알아서...
    - INSERT/UPDATE/DELETE 전에, 후에 ...

- 실생활에서 많이 사용한다.


- TRIGGER 종류
  - SQL문의 실행 시기에따른 분류
    - BEFORE TRIGGER
    - AFTER TRIGGER

  - SQL문에 영향받는 각 ROW에 따른 분류
    - ROW TRIGGER
      - OLD
      - NEW
    - STATEMENT TRIGGER


> ### 실습1

```SQL
-- TRIGGER: 테이블/뷰가 DML문에 의해 변경될 경우
--          자동으로(묵시적으로) 실행될 내용을 정의하여
--          저장하는 객체

-- TRIGGER 종류
-- 1) SQL문의 실행 시기에 따른 분류
--  1-1) BEFORE TRIGGER: SQL문 실행 전에 트리거 발생
--  1-2) AFTER TRIGGER : SQL문 실행 후에 트리거 발생

-- 2) SQL문에 영향받는 각 ROW에 따른 분류
--  2-1) ROW TRIGGER      : SQL문 각 ROW에 대하여 한번씩 실행
--                          트리거 생성시 FOR EACH ROW 옵션 작성
--                          : OLD => 참조 전 열의 값
                            -- UPDATE: 수정 전 자료
                            -- DELETE: 삭제할 자료

--                          :NEW => 참조 후 열의값
                            -- INSERT: 입력할 자료에 대해서 대기
                            -- UPDATE: 수정할 자료

--  2-2) STATEMENT TRIGGER: SQL문에 대해서 1번만 실행
            --DEFAULT: STATEMENT TRIGGER

CREATE OR REPLACE TRIGGER TRG_G1
AFTER INSERT ON EMPLOYEE
BEGIN
    DBMS_OUTPUT.PUT_LINE('신입사원이 입사했습니다!');
END;
/
-- Trigger TRG_G1이(가) 컴파일되었습니다.

INSERT INTO EMPLOYEE
VALUES(905, '박신우', '010114-4111111', 'psw@naver.com', '01011112222',
        'D5', 'J1', 'S5', 50000000 , 0.9, 200, SYSDATE, NULL, DEFAULT);
--신입사원이 입사했습니다!
--1 행 이(가) 삽입되었습니다.


COMMIT;
```

<BR>

> ### 실습2

```SQL
CREATE TABLE PRODUCT(
    PCODE NUMBER PRIMARY KEY,
    PNAME VARCHAR2(30),
    BRAND VARCHAR2(30),
    PRICE NUMBER,
    STOCK NUMBER DEFAULT 0
);
-- Table PRODUCT이(가) 생성되었습니다.


CREATE TABLE PRO_DETAIL(
    DCODE NUMBER PRIMARY KEY,
    PCODE NUMBER,
    PDATE DATE,
    AMOUNT NUMBER,
    STATUS VARCHAR2(10) CHECK (STATUS IN('입고','출고')),
    FOREIGN KEY(PCODE) REFERENCES PRODUCT(PCODE)
);
-- Table PRO_DETAIL이(가) 생성되었습니다.

--SEQUENCE 만들기
CREATE SEQUENCE SEQ_PCODE;
CREATE SEQUENCE SEQ_DCODE;


INSERT INTO PRODUCT
VALUES(SEQ_PCODE.NEXTVAL, '갤럭시노트10', '삼성', 9000, DEFAULT);

INSERT INTO PRODUCT
VALUES(SEQ_PCODE.NEXTVAL, '아이폰11', '애플', 10000, DEFAULT);

INSERT INTO PRODUCT
VALUES(SEQ_PCODE.NEXTVAL, 'VEGQ12', 'LG', 8000, DEFAULT);

SELECT * FROM PRODUCT;
SELECT * FROM PRO_DETAIL;

-- 행이 들어갈때마다 트리거 발생
CREATE OR REPLACE TRIGGER TRG_02
AFTER INSERT ON PRO_DETAIL
-- PRO_DETAIL에 INSERT가 일어나면 트리거 발생.

FOR EACH ROW
BEGIN
    IF :NEW.STATUS ='입고'
        THEN
            UPDATE PRODUCT
            SET STOCK = STOCK+ :NEW.AMOUNT
            WHERE PCODE=:NEW.PCODE;
    END IF;

    IF :NEW.STATUS ='출고'
        THEN
            UPDATE PRODUCT
            SET STOCK = STOCK - :NEW.AMOUNT
            WHERE PCODE=:NEW.PCODE;
    END IF;
END;
/
-- Trigger TRG_02이(가) 컴파일되었습니다.


SELECT * FROM PRODUCT;

INSERT INTO PRO_DETAIL
VALUES (SEQ_DCODE.NEXTVAL, 1, SYSDATE, 5, '입고');

SELECT * FROM PRO_DETAIL; -- 5개 입고 성공
SELECT * FROM PRODUCT; -- 갤노트 STOCK 5개(트리거)


INSERT INTO PRO_DETAIL
VALUES (SEQ_DCODE.NEXTVAL, 2, SYSDATE, 15, '입고');

SELECT * FROM PRO_DETAIL; --아이폰 15개 입고 성공
SELECT * FROM PRODUCT;

INSERT INTO PRO_DETAIL
VALUES (SEQ_DCODE.NEXTVAL, 3, SYSDATE, 3, '입고');

INSERT INTO PRO_DETAIL
VALUES (SEQ_DCODE.NEXTVAL, 2, SYSDATE, 3, '입고');

INSERT INTO PRO_DETAIL
VALUES (SEQ_DCODE.NEXTVAL, 1, SYSDATE, 3, '출고');
SELECT * FROM PRO_DETAIL; --갤럭시 3개 출고 성공
SELECT * FROM PRODUCT; -- STOCK개수 2개로 줄어듦


INSERT INTO PRO_DETAIL VALUES(SEQ_DCODE.NEXTVAL, 2, SYSDATE, 2,'출고');
INSERT INTO PRO_DETAIL VALUES(SEQ_DCODE.NEXTVAL, 1, SYSDATE, 2,'출고');

INSERT INTO PRO_DETAIL VALUES(SEQ_DCODE.NEXTVAL, 1, SYSDATE, 50,'입고');
INSERT INTO PRO_DETAIL VALUES(SEQ_DCODE.NEXTVAL, 1, SYSDATE, 50,'출고');
```
