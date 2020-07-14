--문제3. TB_CATEGORY 테이블 NAME컬럼에 PRIMARY KEY를 생성하시오.
-- KEY 이름을 생성하지 않아도 무방함.
-- 만일 KEY이름을 지정하고자 한다면 이름은 본인이 알아서 적당한 이름사용.


-- 테이블을 만든 후에 제약조건 추가

ALTER TABLE TB_CATEGORY
  ADD CONSTRAINT PK_NAME PRIMARY KEY (NAME)


--뜯어보기
ALTER TABLE TB_CATEGORY --테이블 TB_CATEGORY를 수정
 ADD CONSTRAINT PK_NAME PRIMARY KEY(NAME)
 -- PK_NAME이름의 제약을 (테이블 TB_CATEGORY에) 추가한다.
 -- PK_NAME 제약조건은 NAME컬럼을 PRIMARY KEY로 하겠다.



--보충: ALTER TABLE을 이용한 제약조건 추가
ALTER TABLE 테이블이름 ADD PRIMARY KEY (컬럼이름);
ALTER TABLE 테이블이름 ADD FOREIGN KEY (컬럼이름)
                          REFERENCES 테이블이름(컬럼이름);

--보충
-- 제약조건 추가: 컬럼레벨/테이블레벨 에서 제약조건 정의 및 추가.
CREATE TABLE CONS_NAME(
    -- NN: NOT NULL
    -- UQ: UNQIUE

    -- 컬럼 레벨에서 제약조건 추가
    TEST_DATA1 VARCHAR2(20) CONSTRAINT NN_CN_TD1 NOT NULL,
                            -- TEST_DATA1에 적용되는 제약조건은
                            -- 제약조건의 이름이 NN_CN_TD1
                            -- 이 제약조건은 TEST_DATA1이 NOT NULL이다.
    TEST_DATA2 VARCHAR2(20) CONSTRAINT UQ_CN_TD2 UNIQUE,
                            -- TEST_DATA2에 적용되는 제약조건은
                            -- 제약조건의 이름이 UQ_CN_TD2이고
                            -- 이 제약조건은 TEST_DATA2가 UNIQUE하다.

    TEST_DATA3 VARCHAR2(20), --TEST_DATA3 컬럼 정의


    -- 테이블레벨에서 제약조건 추가
    CONSTRAINT UK_CN_TD3 UNIQUE(TEST_DATA3)
    -- 제약조건 이름이 UK_CN_TD3이고,
    -- 컬럼 TEST_DATAE3가 UNIQUE 해야한다.
);
