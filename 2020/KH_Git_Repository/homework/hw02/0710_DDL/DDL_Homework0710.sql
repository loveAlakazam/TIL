-- [실습 문제]
-- 회원가입용 테이블 생성(USER_TEST)
-- 컬럼명 : USER_NO(회원번호) - 기본키(PK_USER_NO),
--         USER_ID(회원아이디) - 중복금지(UK_USER_ID),
--         USER_PWD(회원비밀번호) - NULL값 허용안함(NN_USER_PWD),
--         PNO(주민등록번호) - 중복금지(UK_PNO), NULL 허용안함(NN_PNO),
--         GENDER(성별) - '남' 혹은 '여'로 입력(CK_GENDER),
--         PHONE(연락처),
--         ADDRESS(주소),
--         STATUS(탈퇴여부) - NOT NULL(NN_STATUS), 'Y' 혹은 'N'으로 입력(CK_STATUS)
-- 각 컬럼의 제약조건에 이름 부여할 것
-- 5명 이상 INSERT할 것


-- USER_TEST 테이블 생성하기
CREATE TABLE USER_TEST( --USER_TEST테이블 생성
    USER_NO NUMBER, --기본키
    USER_ID VARCHAR2(30) , -- 중복금지(UNIQUE)

    -- USER_PWD / 제약조건: NOT NULL / 제약조건이름: NN_USER_PWD
    USER_PWD VARCHAR2(30) CONSTRAINT NN_USER_PWD NOT NULL, --NULL값 허용 안함

    -- PNO / 제약조건: NOT NULL / 제약조건이름: NN_PNO
    PNO CHAR(14) CONSTRAINT NN_PNO NOT NULL, --중복금지, NULL값 허용안함
    GENDER VARCHAR2(3), --남/여 로 입력 (한글 한글자: 3)
    PHONE VARCHAR2(20),
    ADDRESS VARCHAR2(50),
    STATUS VARCHAR2(1), --Y/N 으로 입력

    -- 테이블레벨에서 제약조건 추가
    -- USER_NO / 제약조건: PRIMARY KEY/ 제약조건이름: PK_USER_NO
    CONSTRAINT PK_USER_NO PRIMARY KEY(USER_NO),

    -- USER_ID / 제약조건: UNIQUE(중복금지)/ 제약조건이름: UK_USER_ID
    CONSTRAINT UK_USER_ID UNIQUE(USER_ID),

    -- PNO / 제약조건: 중복금지 / UK_PNO
    CONSTRAINT UK_PNO UNIQUE(PNO), --중복금지

    -- GENDER / 제약조건: 남/여 로 입력 CHECK / CK_GENDER
    CONSTRAINT CK_GENDER CHECK(GENDER IN ('남', '여')),

    -- STATUS / 제약조건: Y/N 로 입력 CHECK / CK_STATUS
    CONSTRAINT CK_STATUS CHECK(STATUS IN ('Y', 'N'))
);


-- USER_TEST 테이블에 데이터 추가하기
INSERT INTO USER_TEST
VALUES(1, 'ROOT', 'ROOT', '200714-1111111', '남',
        NULL, NULL , 'N');

INSERT INTO USER_TEST
VALUES(2, 'MEMBER1', 'M1', '200714-2222222', '여',
        '010-1111-2222', '서울시 강남구 역삼동' , 'N');
