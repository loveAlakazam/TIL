DROP TABLE MEMBER CASCADE CONSTRAINTS;
DROP TABLE CATEGORY CASCADE CONSTRAINTS;
DROP TABLE HOTEL CASCADE CONSTRAINTS;
DROP TABLE HOTEL_RESERVATION CASCADE CONSTRAINTS;
DROP TABLE HOTEL_REVIEW CASCADE CONSTRAINTS;
DROP TABLE IMG_FILE CASCADE CONSTRAINTS;
DROP TABLE REPLY CASCADE CONSTRAINTS;
DROP TABLE LOCAL_INFO CASCADE CONSTRAINTS;
DROP TABLE ROOM CASCADE CONSTRAINTS;
DROP TABLE BOARD CASCADE CONSTRAINTS;
DROP TABLE LIKES CASCADE CONSTRAINTS;
DROP TABLE CERTIFICATION;
DROP TABLE COURSE CASCADE CONSTRAINTS;
DROP TABLE TRAVEL CASCADE CONSTRAINTS;
DROP TABLE MYTRAVEL CASCADE CONSTRAINTS;

--뷰삭제
DROP VIEW HOTEL_DETAIL_IMG_VIEW;
DROP VIEW HOTEL_MINPRICE_ORDER_VIEW;
DROP VIEW HOTEL_REVIEW_INFO_VIEW;
DROP VIEW HOTEL_ROOM_INFO_VIEW;
DROP VIEW HOTEL_THUMBNAIL_IMG_VIEW;
DROP VIEW HOTEL_VIEW;
DROP VIEW TLIST;
DROP VIEW TDETAIL;

--시퀀스 삭제
DROP SEQUENCE SEQ_BO_NO;
DROP SEQUENCE SEQ_FILE_NO;
DROP SEQUENCE SEQ_RE_NO;
DROP SEQUENCE SEQ_TRNO;
DROP SEQUENCE SEQ_ROOM_NO;
DROP SEQUENCE SEQ_RESERVE_NO;
DROP SEQUENCE SEQ_CO_NO;

-- 멤버 테이블
CREATE TABLE MEMBER(
MEMBER_ID VARCHAR2(30) PRIMARY KEY,
MEMBER_PWD VARCHAR2(100),
MEMBER_NAMES VARCHAR2(30),
NICKNAME VARCHAR2(30) NOT NULL,
GENDER VARCHAR2(10),
PHONE VARCHAR2(30),
MEMBER_EMAIL VARCHAR2(50),
M_CATEGORY VARCHAR2(10) NOT NULL,
M_STATUS VARCHAR2(10) NOT NULL,
CHECK(GENDER IN('남자','여자')),
CHECK(M_STATUS IN('Y','N'))
);

ALTER TABLE MEMBER MODIFY (M_STATUS DEFAULT 'Y');
ALTER TABLE MEMBER ADD UNIQUE(PHONE);

-- 멤버 테이블 삽입
INSERT INTO MEMBER VALUES('admin', '$2a$10$D3RWlUNOhYRLaCGFSYbJg.YXwHYGfHvhr6BhZ8UH9sgHWI0Vn4kLO', '관리자', '관리자', '여자', '01012345678','admin@naver.com','member' ,default);
INSERT INTO MEMBER VALUES('soo', '$2a$10$D3RWlUNOhYRLaCGFSYbJg.YXwHYGfHvhr6BhZ8UH9sgHWI0Vn4kLO', '김수진', '수진k', '여자', '01095266236','sjrlaa@gmail.com','member' ,default);
INSERT INTO MEMBER VALUES('ko1850', '$2a$10$D3RWlUNOhYRLaCGFSYbJg.YXwHYGfHvhr6BhZ8UH9sgHWI0Vn4kLO', '이규호', '규호', '남자', '01024593141','ko1804@naver.com','member' ,default);
INSERT INTO MEMBER VALUES('TRIP', '$2a$10$a3KAdt7hoVH02YhsqIWszuXUumRpihW3kHnEe1z3hRMbcrs7.bAjK', '최은강', 'loveAlakazam', '여자', '01071685268','dmsrkd1216@gmail.com','member' ,default);
INSERT INTO MEMBER VALUES('joy', '$2a$10$D3RWlUNOhYRLaCGFSYbJg.YXwHYGfHvhr6BhZ8UH9sgHWI0Vn4kLO', '김기쁨', 'joy', '여자', '01030987909','lcocvce@naver.com','member' ,default);

--인증번호 테이블
CREATE TABLE CERTIFICATION(
EMAIL VARCHAR2(50) NOT NULL,
RANDOMKEY VARCHAR2(50) NOT NULL,
PRIMARY KEY(EMAIL, RANDOMKEY));

--카테고리 테이블
CREATE TABLE CATEGORY(
CA_CODE NUMBER(5) NOT NULL,
CA_NAME VARCHAR2(30) NOT NULL,
PRIMARY KEY (CA_CODE),
CHECK(CA_CODE BETWEEN 1 AND 5) --카테고리번호는 1~5로만 제한한다.
);

--카테고리 데이터 삽입
INSERT INTO CATEGORY VALUES(1, '여행지');
INSERT INTO CATEGORY VALUES(2, '여행 코스');
INSERT INTO CATEGORY VALUES(3, '여행지후기');
INSERT INTO CATEGORY VALUES(4, '맛집후기');
INSERT INTO CATEGORY VALUES(5, '호텔');

--BOARD 테이블
--생성시 제약조건 추가
CREATE TABLE BOARD(
BO_NO NUMBER(10) NOT NULL,
CA_CODE NUMBER(5) NOT NULL,
BO_TITLE VARCHAR2(300) NOT NULL,
BO_CONTENT LONG,
MEMBER_ID VARCHAR2(30) NOT NULL,
BO_COUNT NUMBER(10) DEFAULT 0 NOT NULL,
BO_TAG VARCHAR2(300),
BO_DELETE_YN VARCHAR2(10) DEFAULT 'N' NOT NULL,
REGDATE DATE DEFAULT SYSDATE,
PRIMARY KEY (BO_NO),
FOREIGN KEY (CA_CODE) REFERENCES CATEGORY(CA_CODE),
CONSTRAINT FK_BO_MID FOREIGN KEY (MEMBER_ID) REFERENCES MEMBER(MEMBER_ID) ON DELETE CASCADE,
CHECK (CA_CODE BETWEEN 1 AND 5), --테이블 카테고리번호는 1,2,3,4,5 로 제한한다.
CHECK (BO_DELETE_YN IN ('Y', 'N'))
);

-- 첨부파일 테이블
CREATE TABLE IMG_FILE(
FILE_NO NUMBER(10) NOT NULL,
BO_NO NUMBER(10) NOT NULL,
ORIGIN_NAME VARCHAR2(300) NOT NULL,
CHANGE_NAME VARCHAR2(300) NOT NULL,
FILE_LEVEL NUMBER(5) NOT NULL,
FILE_PATH VARCHAR2(1000),
FILE_DELETE_YN VARCHAR2(10) DEFAULT 'N' NOT NULL,
-- 제약조건
PRIMARY KEY(FILE_NO),
CONSTRAINT FK_IMG_BNO FOREIGN KEY(BO_NO) REFERENCES BOARD(BO_NO) ON DELETE CASCADE,
CHECK(FILE_LEVEL IN (1,2) ), --파일레벨 1(썸네일) / 2(기본 이미지)
CHECK(FILE_DELETE_YN IN ('Y', 'N'))
);

--LIKES 테이블
--CREATE TABLE LIKES(
--BO_NO NUMBER(10) NOT NULL,
--LIKE_YN VARCHAR2(10) DEFAULT 'N' NOT NULL,
--MEMBER_ID VARCHAR2(30) NOT NULL,
--PRIMARY KEY(BO_NO, MEMBER_ID),
--CONSTRAINT FK_LK_MID FOREIGN KEY(MEMBER_ID) REFERENCES MEMBER(MEMBER_ID) ON DELETE CASCADE, --나중에 제약조건추가
--CHECK(LIKE_YN IN ('Y', 'N'))
--);

CREATE TABLE LIKES(
BO_NO NUMBER(10) NOT NULL,
LIKE_YN VARCHAR2(10) DEFAULT 'N' NOT NULL,
MEMBER_ID VARCHAR2(30) NOT NULL,
PRIMARY KEY(BO_NO, MEMBER_ID),
CONSTRAINT FK_LK_MID FOREIGN KEY(MEMBER_ID) REFERENCES MEMBER(MEMBER_ID) ON DELETE CASCADE, --나중에 제약조건추가
CONSTRAINT FK_LK_BNO FOREIGN KEY(BO_NO) REFERENCES BOARD(BO_NO) ON DELETE CASCADE,
CHECK(LIKE_YN IN ('Y', 'N'))
);


--REPLY 테이블(은강/ 규호 공통)
CREATE TABLE REPLY(
RE_NO NUMBER(10) NOT NULL,
BO_NO NUMBER(10) NOT NULL,
MEMBER_ID VARCHAR2(30) NOT NULL,
RE_DATE DATE DEFAULT SYSDATE NOT NULL,
RE_CONTENT VARCHAR2(1500) NOT NULL,
RE_DELETE_YN VARCHAR2(10) DEFAULT 'N' NOT NULL,
PRIMARY KEY(RE_NO), --파일번호
CONSTRAINT RP_FK_BNO FOREIGN KEY(BO_NO) REFERENCES BOARD(BO_NO) ON DELETE CASCADE,
CONSTRAINT RP_FK_MID FOREIGN KEY(MEMBER_ID) REFERENCES MEMBER(MEMBER_ID) ON DELETE CASCADE,
CHECK(RE_DELETE_YN IN ('Y', 'N')) --파일 삭제여부 (Y/N)
);

-- 시퀀스 생성
CREATE SEQUENCE SEQ_BO_NO
START WITH 1
INCREMENT BY 1
MAXVALUE 9999999999
NOCYCLE
NOCACHE;

CREATE SEQUENCE SEQ_FILE_NO
START WITH 1
INCREMENT BY 1
MAXVALUE 9999999999
NOCYCLE
NOCACHE;

CREATE SEQUENCE SEQ_TRNO
START WITH 1
INCREMENT BY 1
MAXVALUE 9999999999
NOCYCLE
NOCACHE;

CREATE SEQUENCE SEQ_ROOM_NO
START WITH 1
INCREMENT BY 1
MAXVALUE 9999999999
NOCYCLE
NOCACHE;

CREATE SEQUENCE SEQ_RESERVE_NO
START WITH 1
INCREMENT BY 1
MAXVALUE 9999999999
NOCYCLE
NOCACHE;

CREATE SEQUENCE SEQ_CO_NO
START WITH 1
INCREMENT BY 1
MAXVALUE 9999999999
NOCYCLE
NOCACHE;

CREATE SEQUENCE SEQ_RE_NO
START WITH 1
INCREMENT BY 1
MAXVALUE 9999999999
NOCYCLE
NOCACHE;

--LOCAL_INFO
CREATE TABLE LOCAL_INFO(
LOCAL_CODE NUMBER(5) NOT NULL, --지역번호
LOCAL_NAME VARCHAR2(50) NOT NULL, --지역이름
PRIMARY KEY(LOCAL_CODE)
);

--지역정보 데이터 삽입
INSERT INTO LOCAL_INFO VALUES(1,'강원도');
INSERT INTO LOCAL_INFO VALUES(2,'경기도');
INSERT INTO LOCAL_INFO VALUES(3,'경상남도');
INSERT INTO LOCAL_INFO VALUES(4,'경상북도');
INSERT INTO LOCAL_INFO VALUES(5,'광주광역시');
INSERT INTO LOCAL_INFO VALUES(6, '대구광역시');
INSERT INTO LOCAL_INFO VALUES(7, '대전광역시');
INSERT INTO LOCAL_INFO VALUES(8, '부산광역시');
INSERT INTO LOCAL_INFO VALUES(9, '서울특별시');
INSERT INTO LOCAL_INFO VALUES(10, '세종특별자치시');
INSERT INTO LOCAL_INFO VALUES(11, '인천광역시');
INSERT INTO LOCAL_INFO VALUES(12, '울산광역시');
INSERT INTO LOCAL_INFO VALUES(13, '전라남도');
INSERT INTO LOCAL_INFO VALUES(14, '전라북도');
INSERT INTO LOCAL_INFO VALUES(15, '제주특별자치도');
INSERT INTO LOCAL_INFO VALUES(16, '충청남도');
INSERT INTO LOCAL_INFO VALUES(17, '충청북도');

--HOTEL 테이블
CREATE TABLE HOTEL(
BO_NO NUMBER(10) NOT NULL, --호텔번호
HOTEL_ADDRESS VARCHAR2(1000) NOT NULL,--호텔주소
HOTEL_LOCAL_CODE NUMBER(5) NOT NULL,--지역코드
HOTEL_SITE VARCHAR2(1000),--호텔사이트
HOTEL_TEL VARCHAR2(30) NULL,--전화번호
HOTEL_REVIEW_SCORE NUMBER(5,1) DEFAULT 0 NOT NULL, --호텔 후기 평점
HOTEL_RANK NUMBER(5), --호텔등급(1~5, 없음)
HOTEL_OPEN_TIME NUMBER(5) DEFAULT 0 NOT NULL,--호텔오픈시각
HOTEL_CLOSE_TIME NUMBER(5) DEFAULT 23 NOT NULL,--호텔종료시각
HOTEL_OPTION VARCHAR2(2000), --호텔옵션
CHECK_IN NUMBER(5) DEFAULT 10 NOT NULL, --체크인
CHECK_OUT NUMBER(5) DEFAULT 15 NOT NULL,--체크아웃
-- 제약조건
CONSTRAINT HT_PK PRIMARY KEY (BO_NO), --기본키(BO_NO)
CONSTRAINT HT_FK_BNO FOREIGN KEY(BO_NO) REFERENCES BOARD(BO_NO) ON DELETE CASCADE,
FOREIGN KEY(HOTEL_LOCAL_CODE) REFERENCES LOCAL_INFO(LOCAL_CODE) --외래키(HOTEL_LOCAL_CODE)
);

--ROOM 테이블
--호텔방(ROOM)테이블
CREATE TABLE ROOM(
ROOM_NO NUMBER(10), --방번호
BO_NO NUMBER(10) NOT NULL, --호텔번호
ROOM_TYPE VARCHAR2(200) NOT NULL, --방종류
ROOM_NAME VARCHAR2(1000) NOT NULL, --방이름
PRICE_PER_DAY NUMBER(10) NOT NULL, --1인당 이용가격
CONSTRAINT RO_PK PRIMARY KEY(ROOM_NO), --기본키(ROOM_NO)
CONSTRAINT RO_FK FOREIGN KEY(BO_NO) REFERENCES HOTEL(BO_NO) ON DELETE CASCADE --외래키(BO_NO)+나중에 삭제제약추가
);

--호텔리뷰 댓글
CREATE TABLE HOTEL_REVIEW(
RE_NO NUMBER(10), --댓글번호
REVIEW_SCORE NUMBER(5) NOT NULL,
CONSTRAINT HR_PK_RVN PRIMARY KEY(RE_NO), --기본키(RE_NO)
CONSTRAINT HR_FK_RVN FOREIGN KEY(RE_NO) REFERENCES REPLY(RE_NO) ON DELETE CASCADE, --외래키(RE_NO)
CONSTRAINT HR_CK_RVS CHECK(REVIEW_SCORE BETWEEN 0 AND 5) --제약조건(REVIEW_SCORE 0~5점만 부여가능)
);





CREATE OR REPLACE VIEW HOTEL_VIEW
AS
SELECT *
FROM BOARD JOIN HOTEL USING(BO_NO)
WHERE BO_DELETE_YN='N' AND CA_CODE=5;

CREATE OR REPLACE VIEW HOTEL_ROOM_INFO_VIEW
AS
SELECT *
FROM BOARD
JOIN HOTEL USING(BO_NO)
JOIN ROOM USING(BO_NO)
WHERE BO_DELETE_YN='N';

CREATE OR REPLACE VIEW HOTEL_REVIEW_INFO_VIEW
AS
SELECT *
FROM REPLY JOIN HOTEL_REVIEW USING(RE_NO);

CREATE OR REPLACE VIEW HOTEL_THUMBNAIL_IMG_VIEW
AS
SELECT *
FROM BOARD
JOIN IMG_FILE USING(BO_NO)
WHERE BO_DELETE_YN='N' AND FILE_DELETE_YN='N' AND FILE_LEVEL=1 AND CA_CODE=5;

CREATE OR REPLACE VIEW HOTEL_DETAIL_IMG_VIEW
AS
SELECT *
FROM BOARD
JOIN IMG_FILE USING(BO_NO)
WHERE BO_DELETE_YN='N' AND FILE_DELETE_YN='N' AND FILE_LEVEL=2 AND CA_CODE=5;

CREATE OR REPLACE VIEW HOTEL_MINPRICE_ORDER_VIEW
AS
SELECT BO_NO, MIN(PRICE_PER_DAY) AS MIN_PRICE
FROM HOTEL_ROOM_INFO_VIEW
GROUP BY BO_NO;

-- 여행지 테이블
CREATE TABLE "TRIP2REAP"."TRAVEL"
( "TR_NO" NUMBER(10,0),
"BO_NO" NUMBER(10,0) NOT NULL ENABLE,
"TR_ADDR" VARCHAR2(300 BYTE) NOT NULL ENABLE,
"TR_THEME" VARCHAR2(50 BYTE) NOT NULL ENABLE,
"TR_REG" VARCHAR2(50 BYTE) NOT NULL ENABLE,
"TR_TITLE" VARCHAR2(100 BYTE),
"TR_PHONE" VARCHAR2(20 BYTE),
PRIMARY KEY ("TR_NO")
USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS
STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1 BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
TABLESPACE "SYSTEM" ENABLE,
FOREIGN KEY ("BO_NO")
REFERENCES "TRIP2REAP"."BOARD" ("BO_NO") ENABLE
) SEGMENT CREATION IMMEDIATE
PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 NOCOMPRESS LOGGING
STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1 BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
TABLESPACE "SYSTEM" ;

CREATE OR REPLACE FORCE VIEW "TRIP2REAP"."TLIST" ("BO_NO", "CA_CODE", "BO_TITLE", "BO_CONTENT", "MEMBER_ID", "BO_COUNT", "BO_TAG", "BO_DELETE_YN", "TR_ADDR", "TR_THEME", "CHANGE_NAME")
AS
SELECT BOARD.BO_NO, BOARD.CA_CODE, BO_TITLE, BO_CONTENT, BOARD.MEMBER_ID, BO_COUNT, BO_TAG, BO_DELETE_YN, TR_ADDR, TR_THEME, CHANGE_NAME
FROM BOARD
JOIN TRAVEL T ON (T.BO_NO = BOARD.BO_NO)
JOIN MEMBER M ON (M.MEMBER_ID = BOARD.MEMBER_ID)
JOIN CATEGORY C ON (C.CA_CODE = BOARD.CA_CODE)
JOIN IMG_FILE I ON (BOARD.BO_NO = I.BO_NO)
WHERE BO_DELETE_YN = 'N'
ORDER BY REGDATE DESC;

CREATE OR REPLACE FORCE VIEW "TRIP2REAP"."TDETAIL" ("BO_NO", "CA_CODE", "BO_TITLE", "BO_CONTENT", "MEMBER_ID", "BO_COUNT", "BO_TAG", "BO_DELETE_YN", "REGDATE", "TR_ADDR", "TR_THEME", "CHANGE_NAME")
AS
SELECT BOARD.BO_NO, BOARD.CA_CODE, BO_TITLE, BO_CONTENT, BOARD.MEMBER_ID, BO_COUNT, BO_TAG, BO_DELETE_YN, REGDATE, TR_ADDR, TR_THEME, CHANGE_NAME
FROM BOARD
JOIN TRAVEL T ON (T.BO_NO = BOARD.BO_NO)
JOIN MEMBER M ON (M.MEMBER_ID = BOARD.MEMBER_ID)
JOIN CATEGORY C ON (C.CA_CODE = BOARD.CA_CODE)
JOIN IMG_FILE I ON (BOARD.BO_NO = I.BO_NO)
WHERE BO_DELETE_YN = 'N'
ORDER BY REGDATE DESC;

-- 여행코스 테이블
CREATE TABLE COURSE(
COURSE_NO NUMBER(10) PRIMARY KEY,
BO_NO NUMBER(10) NOT NULL,
THEME VARCHAR2(50) NOT NULL,
SCHEDULE VARCHAR2(50) NOT NULL,
COURSE_DAY VARCHAR2(100),
COURSE_NAME VARCHAR2(1000),
COURSE_X VARCHAR2(1000),
COURSE_Y VARCHAR2(1000),
COURSE_DISTANCE VARCHAR2(100),
CONSTRAINT CO_FK_BNO FOREIGN KEY(BO_NO) REFERENCES BOARD(BO_NO)
);

COMMIT;

--2020.12.14
--김기쁨 MY_TRAVEL
-- 내가 담은 여행지 테이블
CREATE TABLE MYTRAVEL(
    BO_NO NUMBER(10),
    MEMBER_ID VARCHAR2(50),
    PRIMARY KEY(BO_NO, MEMBER_ID),
    CONSTRAINT MT_FK_MID FOREIGN KEY(MEMBER_ID) REFERENCES MEMBER(MEMBER_ID) ON DELETE CASCADE,
    CONSTRAINT MT_FK_BNO FOREIGN KEY(BO_NO) REFERENCES BOARD(BO_NO) ON DELETE CASCADE
);

COMMIT;


--2020.12.14 - 김수진
CREATE OR REPLACE FORCE VIEW "TRIP2REAP"."TDETAIL" ("BO_NO", "CA_CODE", "BO_TITLE", "BO_CONTENT", "MEMBER_ID", "BO_COUNT", "BO_TAG", "BO_DELETE_YN", "REGDATE", "TR_ADDR", "TR_THEME", "CHANGE_NAME", "TR_REG") AS 
SELECT BOARD.BO_NO, BOARD.CA_CODE, BO_TITLE, BO_CONTENT, BOARD.MEMBER_ID, BO_COUNT, BO_TAG, BO_DELETE_YN, REGDATE, TR_ADDR, TR_THEME, CHANGE_NAME, TR_REG
FROM BOARD
    JOIN TRAVEL T ON (T.BO_NO = BOARD.BO_NO)
    JOIN MEMBER M ON (M.MEMBER_ID = BOARD.MEMBER_ID)
    JOIN CATEGORY C ON (C.CA_CODE = BOARD.CA_CODE)
    JOIN IMG_FILE I ON (BOARD.BO_NO = I.BO_NO)
WHERE BO_DELETE_YN = 'N'
ORDER BY REGDATE DESC;

COMMIT;


--호텔예약
CREATE TABLE HOTEL_RESERVATION(
    RESERVE_NO NUMBER(10),              --예약번호
    MEMBER_ID VARCHAR2(30) NOT NULL,    --예약자ID
    BO_NO NUMBER(10) NOT NULL,          --호텔번호
    ROOM_NO NUMBER(10) NOT NULL,        --방번호
    RESERVE_PRICE NUMBER(10) NOT NULL,  --예약가격(총가격)
    
    RESERVE_ROOM_CNT NUMBER(10) DEFAULT 1 NOT NULL,   --예약 객실 수(기본값:1)
    RESERVE_TOTAL_PERSON_CNT NUMBER(10) DEFAULT 2 NOT NULL,         --예약인원수(전체인원수: 기본값 2)
    RESERVE_PERSON_ADULT_CNT NUMBER(10) DEFAULT 2 NOT NULL,--성인수(기본값: 2)
    RESERVE_PERSON_CHILD_CNT NUMBER(10) DEFAULT 0 NOT NULL,--어린이수(기본값: 0)
    
    CHECK_IN_DATE DATE DEFAULT SYSDATE NOT NULL,    --체크인 날짜
    CHECK_OUT_DATE DATE DEFAULT SYSDATE NOT NULL,   --체크아웃 날짜
    RESERVE_CHECK VARCHAR2(5) DEFAULT 'N' NOT NULL, --예약확인
    REFUND_CHECK VARCHAR2(5)  DEFAULT 'N' NOT NULL, --환불확인
    
    RESERVE_NAME VARCHAR2(20) NOT NULL,
    RESERVE_PHONE VARCHAR2(20) NOT NULL,
    RESERVE_EMAIL VARCHAR2(300) NOT NULL,
    
    PAYMENT_UID VARCHAR2(200) NOT NULL,
    MERCHANT_UID VARCHAR2(200) NOT NULL,
    PAYMENT_TYPE VARCHAR2(100) NOT NULL,
    
    CONSTRAINT RS_PK PRIMARY KEY(RESERVE_NO),                                   --기본키(RESERVE_NO)
    CONSTRAINT RS_FK_MID FOREIGN KEY(MEMBER_ID) REFERENCES MEMBER(MEMBER_ID)ON DELETE CASCADE,   --외래키(MEMBER_ID)+나중에 제약조건추가
    CONSTRAINT RS_FK_BN FOREIGN KEY(BO_NO) REFERENCES HOTEL(BO_NO) ON DELETE CASCADE,             --외래키(BO_NO)+나중에 제약조건추가
    CONSTRAINT RS_FK_RN FOREIGN KEY(ROOM_NO) REFERENCES ROOM(ROOM_NO) ON DELETE CASCADE,          --외래키(ROOM_NO)
    CONSTRAINT RS_CK_RSC CHECK(RESERVE_CHECK IN ('Y', 'N')),                    --제약조건(RESERVE_CHECK)
    CONSTRAINT RS_CK_RFC CHECK(REFUND_CHECK IN('Y','N'))                        --제약조건(REFUND_CHECK)
);


Commit;


--------
--data--
--------
set define off;
Insert into BOARD (BO_NO,CA_CODE,BO_TITLE,BO_CONTENT,MEMBER_ID,BO_COUNT,BO_TAG,BO_DELETE_YN,REGDATE) 
values (SEQ_BO_NO.NEXTVAL,1,'대창반점','1980년에 개업했으며 삼선짬뽕과 전가복, 샥스핀을 대표 메뉴로 하고 있다. 다른 집처럼 규모가 크지는 않지만 아늑한 분위기가 잘 어울린다.','admin',0,'#맛집#인천#차이나타운','N',to_date('20/12/10','RR/MM/DD'));
Insert into TRAVEL (TR_NO,BO_NO,TR_ADDR,TR_THEME,TR_REG,TR_TITLE,TR_PHONE) 
values (SEQ_TRNO.NEXTVAL,SEQ_BO_NO.CURRVAL,'인천 중구 차이나타운로 49','음식점','인천',null,null);
Insert into IMG_FILE (FILE_NO,BO_NO,ORIGIN_NAME,CHANGE_NAME,FILE_LEVEL,FILE_PATH,FILE_DELETE_YN) 
values (SEQ_FILE_NO.NEXTVAL,SEQ_BO_NO.CURRVAL,'대창반점.jpg','travel20201210135722.jpg',1,'null','N');


Insert into BOARD (BO_NO,CA_CODE,BO_TITLE,BO_CONTENT,MEMBER_ID,BO_COUNT,BO_TAG,BO_DELETE_YN,REGDATE) values (SEQ_BO_NO.NEXTVAL,1,'연안부두','서해 도서로 운항하는 여객선의 출발지이다. 싱싱한 생선과 젓갈 등을 저렴한 가격으로 구입할 수 있는 인천종합어시장과 수협에서 직영하는 회센타 (일반시중가의 60~70%선), 바다낚시를 즐길 수 있는 남항부두가 있는가 하면 해수탕도 여러 곳 있다. 최근에 관광특구로 지정되었다. 우렁찬 뱃고동 소리를 가장 가까운 거리에서 들을수 있는 곳, 연안부두는 해양도시로 인천 중구의 상징이며 미지의 섬으로 떠나고 싶은 사람이 많이 방문하는 곳이기도 하다.','admin',0,'#연안부두#인천#항구','N',to_date('20/12/10','RR/MM/DD'));
Insert into TRAVEL (TR_NO,BO_NO,TR_ADDR,TR_THEME,TR_REG,TR_TITLE,TR_PHONE) values (SEQ_TRNO.NEXTVAL,SEQ_BO_NO.CURRVAL,'인천 중구 연안부두로 3','관광지','인천',null,null);
Insert into IMG_FILE (FILE_NO,BO_NO,ORIGIN_NAME,CHANGE_NAME,FILE_LEVEL,FILE_PATH,FILE_DELETE_YN) values (SEQ_FILE_NO.NEXTVAL,SEQ_BO_NO.CURRVAL,'연안부두.jpg','travel20201210135811.jpg',1,'null','N');



Insert into BOARD (BO_NO,CA_CODE,BO_TITLE,BO_CONTENT,MEMBER_ID,BO_COUNT,BO_TAG,BO_DELETE_YN,REGDATE) values (SEQ_BO_NO.NEXTVAL,1,'월미도','월미도는 효종4년(1653)에 월미도에 행궁을 설치했다는 기록 외에는 조선조 말기까지 역사에 등장하는 일이 거의 없었다. 행궁의 위치는 동쪽해안에 있던 임해사터라고 되어 있으나 지금으로서는 확인할 길이 없다. 1920년대 후반부터 1930년대까지가 월미도 유원지의 전성기였다. 당시 조선인과 일본인 남녀노소를 가릴 것 없이 월미도의 이름을 모르는 사람이 없을 정도였다 한다. 1989년 7월 문화의 거리가 조성된 이래 문화예술의 장, 만남과 교환의 장 그리고 공연놀이 마당 등으로도 알려지기 시작한 월미도는 인천하면 떠올릴 만큼 유명한 곳으로 자리잡고 
있다.','admin',1,'인천#월미도','N',to_date('20/12/10','RR/MM/DD'));
Insert into TRAVEL (TR_NO,BO_NO,TR_ADDR,TR_THEME,TR_REG,TR_TITLE,TR_PHONE) values (SEQ_TRNO.NEXTVAL,SEQ_BO_NO.CURRVAL,'인천 중구 월미문화로 84','관광지','인천',null,null);
Insert into IMG_FILE (FILE_NO,BO_NO,ORIGIN_NAME,CHANGE_NAME,FILE_LEVEL,FILE_PATH,FILE_DELETE_YN) values (SEQ_FILE_NO.NEXTVAL,SEQ_BO_NO.CURRVAL,'월미도.JPG','travel20201210135906.JPG',1,'null','N');


Insert into BOARD (BO_NO,CA_CODE,BO_TITLE,BO_CONTENT,MEMBER_ID,BO_COUNT,BO_TAG,BO_DELETE_YN,REGDATE) values (SEQ_BO_NO.NEXTVAL,1,'인천대교','첨단공학의 집합체로 수많은 기록과 화제를 낳은 인천대교가 52개월의 역사 끝에 드디어 2009년 10월 16일 개통했다.바다를 가로지는 그 길이와 웅장함에 사업기간 내내 세간의 관심을 한몸에 받았고 또한 국내 최초로 사회간접자본 사업에 외국인이 사업시행자로 참여하여 시공과 시행을 분리한 국제금융 프로젝트로 추진되어 사업추진방식의 혁신성으로도 높이 평가되었다.21.38km로 우리나라 최장 다리가 된 인천대교는 다리 길이로는 세계7위, 교량으로 연결된 18.38km의 사장교 길이로는 세계6위, 주탑과 주탑 사이를 가리키는 주경간 800m 거리의 사장교 규모로는 세계5위이다.','admin',0,'인천#대교#야경','N',to_date('20/12/10','RR/MM/DD'));
Insert into TRAVEL (TR_NO,BO_NO,TR_ADDR,TR_THEME,TR_REG,TR_TITLE,TR_PHONE) values (SEQ_TRNO.NEXTVAL,SEQ_BO_NO.CURRVAL,'인천 중구 영종해안남로 1017','관광지','인천',null,null);
Insert into IMG_FILE (FILE_NO,BO_NO,ORIGIN_NAME,CHANGE_NAME,FILE_LEVEL,FILE_PATH,FILE_DELETE_YN) values (SEQ_FILE_NO.NEXTVAL,SEQ_BO_NO.CURRVAL,'인천대교.jpg','travel20201210140000.jpg',1,'null','N');


Insert into BOARD (BO_NO,CA_CODE,BO_TITLE,BO_CONTENT,MEMBER_ID,BO_COUNT,BO_TAG,BO_DELETE_YN,REGDATE) values (SEQ_BO_NO.NEXTVAL,1,'인천종합어시장','인천은 동북아의 거정항만으로 자리잡기 위해 다양한 해운 네트워크를 구축하고 인천항을 동북아 경제권의 복합운송항만으로 발전하도록 노력하고 있다. 황해안의 넓은 바다와 다양하고 풍부한 수산자원이 넘쳐나는 수산물의 보고인 인천에서 인천 어민들이 직접 포획한 싱싱한 수산물을 공급하고, 전국에서 당일 직송되는 수산물을 수도권으로 유통하는 기능을 담당하고 있는 시장이다.','admin',0,'인천#어시장#가족과함께','N',to_date('20/12/10','RR/MM/DD'));
Insert into TRAVEL (TR_NO,BO_NO,TR_ADDR,TR_THEME,TR_REG,TR_TITLE,TR_PHONE) values (SEQ_TRNO.NEXTVAL,SEQ_BO_NO.CURRVAL,'인천 중구 연안부두로33번길 37','축제','인천',null,null);
Insert into IMG_FILE (FILE_NO,BO_NO,ORIGIN_NAME,CHANGE_NAME,FILE_LEVEL,FILE_PATH,FILE_DELETE_YN) values (SEQ_FILE_NO.NEXTVAL,SEQ_BO_NO.CURRVAL,'인천종합어시장.jpg','travel20201210140053.jpg',1,'null','N');


Insert into BOARD (BO_NO,CA_CODE,BO_TITLE,BO_CONTENT,MEMBER_ID,BO_COUNT,BO_TAG,BO_DELETE_YN,REGDATE) values (SEQ_BO_NO.NEXTVAL,1,'차이나타운','※ 19_20 한국관광 100선 ※

인천 차이나타운은 1883년 인천항이 개항되고 1884년 이 지역이 청의 치외법권(治外法權, extraterritoriality) 지역으로 지정되면서 생겨났다. 과거에는 중국에서 수입된 물품들을 파는 상점들이 대부분이었으나 현재는 거의가 중국 음식점이다. 현재 이 거리를 지키고 있는 한국 내 거주 중국인들은 초기 정착민들의 2세나 3세들이어서 1세들이 지키고 있었던 전통문화를 많이는 지키지 못하고 있지만 중국의 맛만은 고수하고 있다.','admin',2,'인천#가족과함께#연인','N',to_date('20/12/10','RR/MM/DD'));
Insert into TRAVEL (TR_NO,BO_NO,TR_ADDR,TR_THEME,TR_REG,TR_TITLE,TR_PHONE) values (SEQ_TRNO.NEXTVAL,SEQ_BO_NO.CURRVAL,'경기 용인시 처인구 모현읍 백옥대로 2487','명소','인천',null,null);
Insert into IMG_FILE (FILE_NO,BO_NO,ORIGIN_NAME,CHANGE_NAME,FILE_LEVEL,FILE_PATH,FILE_DELETE_YN) values (SEQ_FILE_NO.NEXTVAL,SEQ_BO_NO.CURRVAL,'차이나타운.jpg','travel20201210140228.jpg',1,'null','N');



Insert into BOARD (BO_NO,CA_CODE,BO_TITLE,BO_CONTENT,MEMBER_ID,BO_COUNT,BO_TAG,BO_DELETE_YN,REGDATE) values (SEQ_BO_NO.NEXTVAL,1,'헌책방거리','과거 서민들이 끈질기게 삶을 이어가던 터전이었던 배다리 일대에는 아직도 옛 모습과 과거의 기억들을 고스란히 간직한 명소들이 많은데요. 배다리 헌책방 거리에도 과거 40여 곳에 달하는 헌책방들이 있었습니다. 하지만 지금은 고작 다섯 곳만 남아있는데요. 집현전, 아벨서점, 삼성서림, 한미서점, 대창서림 등입니다. 집현전 역시 최근 매각되어 새로운 서점으로 거듭난다고 하니 옛 모습을 간직한 헌책방들은 더욱 줄어들고 있습니다.','admin',0,'걷기좋은#연인과함께','N',to_date('20/12/10','RR/MM/DD'));
Insert into TRAVEL (TR_NO,BO_NO,TR_ADDR,TR_THEME,TR_REG,TR_TITLE,TR_PHONE) values (SEQ_TRNO.NEXTVAL,SEQ_BO_NO.CURRVAL,'인천 동구 금곡로 19','0','0',null,null);
Insert into IMG_FILE (FILE_NO,BO_NO,ORIGIN_NAME,CHANGE_NAME,FILE_LEVEL,FILE_PATH,FILE_DELETE_YN) values (SEQ_FILE_NO.NEXTVAL,SEQ_BO_NO.CURRVAL,'헌책방거리.jpg','travel20201210140837.jpg',1,'null','N');


Insert into BOARD (BO_NO,CA_CODE,BO_TITLE,BO_CONTENT,MEMBER_ID,BO_COUNT,BO_TAG,BO_DELETE_YN,REGDATE) values (SEQ_BO_NO.NEXTVAL,1,'인천문화양조장','스페이스 빔, 인천도시 공공성 네트워크, 도서출판 작가들, 책방 커넥더닷츠, 한지공방 아트 등 여러 단체가 같은 공간을 사용한다고 하는데요. 글, 그림, 예술작품, 공방까지 다양한 문화 예술을 자유로운 분위기에서 즐길 수 있는 공간이라 할 수 있습니다.','admin',0,'양조장#역사','N',to_date('20/12/10','RR/MM/DD'));
Insert into TRAVEL (TR_NO,BO_NO,TR_ADDR,TR_THEME,TR_REG,TR_TITLE,TR_PHONE) values (SEQ_TRNO.NEXTVAL,SEQ_BO_NO.CURRVAL,'인천 동구 서해대로513번길 15','명소','인천',null,null);
Insert into IMG_FILE (FILE_NO,BO_NO,ORIGIN_NAME,CHANGE_NAME,FILE_LEVEL,FILE_PATH,FILE_DELETE_YN) values (SEQ_FILE_NO.NEXTVAL,SEQ_BO_NO.CURRVAL,'인천문화양조장.jpg','travel20201210141243.jpg',1,'null','N');


Insert into BOARD (BO_NO,CA_CODE,BO_TITLE,BO_CONTENT,MEMBER_ID,BO_COUNT,BO_TAG,BO_DELETE_YN,REGDATE) values (SEQ_BO_NO.NEXTVAL,1,'인천애관극장','1950년 한국전쟁 중에 소실되었다가 1960년 보수 및 재개관을 했고 2004년에 또 한 번의 보수가 이뤄지면서 전문적인 영화관으로 운영되고 있습니다. 애관극장 내부에는 정겨운 모습들이 가득했는데요. 나비넥타이를 착용하고 계신 직원분들과 직접 마이크로 안내해주시는 티켓 오피스, 수작업으로 붙여둔 ''커밍 순'' 안내판까지! 오래됐지만 소박하고 내실 있는 모습의 영화관이었습니다.','admin',0,'#극장#가족과함께#인천','N',to_date('20/12/10','RR/MM/DD'));
Insert into TRAVEL (TR_NO,BO_NO,TR_ADDR,TR_THEME,TR_REG,TR_TITLE,TR_PHONE) values (SEQ_TRNO.NEXTVAL,SEQ_BO_NO.CURRVAL,'인천 중구 개항로 63-2','명소','인천',null,null);
Insert into IMG_FILE (FILE_NO,BO_NO,ORIGIN_NAME,CHANGE_NAME,FILE_LEVEL,FILE_PATH,FILE_DELETE_YN) values (SEQ_FILE_NO.NEXTVAL,SEQ_BO_NO.CURRVAL,'애관극장.jpg','travel20201210141329.jpg',1,'null','N');



Insert into BOARD (BO_NO,CA_CODE,BO_TITLE,BO_CONTENT,MEMBER_ID,BO_COUNT,BO_TAG,BO_DELETE_YN,REGDATE) values (SEQ_BO_NO.NEXTVAL,1,'신포국제시장','대표적인 먹거리로는 닭강정과 직접 기름을 발라 바로 구워서 내주는 김, 오랜 전통을 가진 중국식 공갈빵 등이 있습니다. 또한 시장 내부에는 시장만큼이나 오래된 가게들이 많아 그 자체만으로 박물관 역할을 한다는 평가를 받기도 합니다.','admin',0,'먹거리#시장','N',to_date('20/12/10','RR/MM/DD'));
Insert into TRAVEL (TR_NO,BO_NO,TR_ADDR,TR_THEME,TR_REG,TR_TITLE,TR_PHONE) values (SEQ_TRNO.NEXTVAL,SEQ_BO_NO.CURRVAL,'인천 중구 우현로 51-1','음식점','인천',null,null);
Insert into IMG_FILE (FILE_NO,BO_NO,ORIGIN_NAME,CHANGE_NAME,FILE_LEVEL,FILE_PATH,FILE_DELETE_YN) values (SEQ_FILE_NO.NEXTVAL,SEQ_BO_NO.CURRVAL,'신포국제시장.jpg','travel20201210141441.jpg',1,'null','N');








--서울지역



Insert into BOARD (BO_NO,CA_CODE,BO_TITLE,BO_CONTENT,MEMBER_ID,BO_COUNT,BO_TAG,BO_DELETE_YN,REGDATE) values (SEQ_BO_NO.NEXTVAL,1,'밤도깨비 야시장','서울 밤도깨비 야시장은 서울특별시에서 주최하는 행사로 서울 밤도깨비 야시장에서는 핸드메이드 제품 판매, 푸드트럭 장터운영, 문화공연 등이 진행된다.','admin',0,'야시장#서울#먹거리','N',to_date('20/12/10','RR/MM/DD'));
Insert into TRAVEL (TR_NO,BO_NO,TR_ADDR,TR_THEME,TR_REG,TR_TITLE,TR_PHONE) values (SEQ_TRNO.NEXTVAL,SEQ_BO_NO.CURRVAL,'서울 광진구 강변북로 139','축제','서울',null,null);
Insert into IMG_FILE (FILE_NO,BO_NO,ORIGIN_NAME,CHANGE_NAME,FILE_LEVEL,FILE_PATH,FILE_DELETE_YN) values (SEQ_FILE_NO.NEXTVAL,SEQ_BO_NO.CURRVAL,'밤도깨비야시장.jpg','travel20201210141747.jpg',1,'null','N');



Insert into BOARD (BO_NO,CA_CODE,BO_TITLE,BO_CONTENT,MEMBER_ID,BO_COUNT,BO_TAG,BO_DELETE_YN,REGDATE) values (SEQ_BO_NO.NEXTVAL,1,'서울 크리스마스 페스티벌','올해 5회째를 맞는 서울크리스마스페스티벌은 크리스마스와 화려한 LED조명작품, 산타마을, 꿈의궁전 등 풍성한 볼거리를 제공한다. 시민들을 겨울동화 속으로 빠져들게 할 서울크리스마스페스티벌에 많은 참여와 성원 바란다.','admin',0,'축제#크리스마스#청계천','N',to_date('20/12/10','RR/MM/DD'));
Insert into TRAVEL (TR_NO,BO_NO,TR_ADDR,TR_THEME,TR_REG,TR_TITLE,TR_PHONE) values (SEQ_TRNO.NEXTVAL,SEQ_BO_NO.CURRVAL,'서울 종로구 청계천로 41','축제','서울',null,null);
Insert into IMG_FILE (FILE_NO,BO_NO,ORIGIN_NAME,CHANGE_NAME,FILE_LEVEL,FILE_PATH,FILE_DELETE_YN) values (SEQ_FILE_NO.NEXTVAL,SEQ_BO_NO.CURRVAL,'서울크리스마스.jpg','travel20201210141907.jpg',1,'null','N');


Insert into BOARD (BO_NO,CA_CODE,BO_TITLE,BO_CONTENT,MEMBER_ID,BO_COUNT,BO_TAG,BO_DELETE_YN,REGDATE) values (SEQ_BO_NO.NEXTVAL,1,'서울디저트페어 [초코딸기전]','국내 최대 수제 디저트페어 “서울디저트페어”
26회 서울디저트페어 [초코딸기전]에서는 발렌타인데이의 설렘 가득한 초콜릿과 딸기를 컨셉으로 달콤!상콤한 디자인 마카롱, 수제청 및 에이드 카놀리 등 초코와 딸기컨셉 디저트와 함께 꿀케이크나 두부 아이스크림 등 이색 디저트로 달콤한 즐거움을 선보일 예정이다.
취향을 저격하는 핸드메이드''수공예존'' 까지 한 전시장에서 만나 볼 수 있는 서울디저트페어!
각 지역의 디저트 맛집이 한 자리에 모인 서울디저트페어를 강남에서 만나보자.
','admin',0,'디저트페어#축제#2020','N',to_date('20/12/10','RR/MM/DD'));
Insert into TRAVEL (TR_NO,BO_NO,TR_ADDR,TR_THEME,TR_REG,TR_TITLE,TR_PHONE) values (SEQ_TRNO.NEXTVAL,SEQ_BO_NO.CURRVAL,'서울 서초구 강남대로 27','축제','서울',null,null);
Insert into IMG_FILE (FILE_NO,BO_NO,ORIGIN_NAME,CHANGE_NAME,FILE_LEVEL,FILE_PATH,FILE_DELETE_YN) values (SEQ_FILE_NO.NEXTVAL,SEQ_BO_NO.CURRVAL,'디저트페어.JPG','travel20201210142141.JPG',1,'null','N');


Insert into BOARD (BO_NO,CA_CODE,BO_TITLE,BO_CONTENT,MEMBER_ID,BO_COUNT,BO_TAG,BO_DELETE_YN,REGDATE) values (SEQ_BO_NO.NEXTVAL,1,'롯데월드','롯데월드 어드벤처가 지난해 선풍적인 열풍을 몰고 온 가을시즌 축제 호러 할로윈 :The Invitation, 9월 5일부터 11월 15일(일)까지 개최한다. 낮에는 남녀노소 누구나 신나게 즐기는 큐티 할로윈이, 저녁 6시 이후엔 심장을 쫄깃하게 만드는 본격적인 호러 할로윈이 파크 곳곳에서 펼쳐진다.','admin',1,'놀이공원#서울#할로윈','N',to_date('20/12/10','RR/MM/DD'));
Insert into TRAVEL (TR_NO,BO_NO,TR_ADDR,TR_THEME,TR_REG,TR_TITLE,TR_PHONE) values (SEQ_TRNO.NEXTVAL,SEQ_BO_NO.CURRVAL,'서울 송파구 올림픽로 240','명소','서울',null,null);    
Insert into IMG_FILE (FILE_NO,BO_NO,ORIGIN_NAME,CHANGE_NAME,FILE_LEVEL,FILE_PATH,FILE_DELETE_YN) values (SEQ_FILE_NO.NEXTVAL,SEQ_BO_NO.CURRVAL,'롯데월드.JPG','travel20201210142318.JPG',1,'null','N');



Insert into BOARD (BO_NO,CA_CODE,BO_TITLE,BO_CONTENT,MEMBER_ID,BO_COUNT,BO_TAG,BO_DELETE_YN,REGDATE) values (SEQ_BO_NO.NEXTVAL,1,'청계천','청계천이 시작되는 세종로에 조성된 청계광장.청계천 복원 시작지점인 동아일보사 앞에서부터 신답철교 사이로 연장160m, 폭50m, 총 면적 2천 106평의 규모로 조성되었다. 분수와 폭포, 청계천 미니어처, 산책로와 탐방로 등으로 꾸며져있고, 청계천 복원의 의미와 함께 만남과 화합, 평화와 통일을 염원하는 장소로 만들어져 있다. 이 중 광장은 청계천 복원 시작지점중심에 741평 규모로 조성되었고, 우리나라 전통적보자기형태의 디자인을 가져와 다양한 색상의 석재포장으로 우아한 전통미를 살린다. 
이 곳에는 청계천 축소모형인 청계 미니어처가 설치되어 복원된 청계천의 모습을 한눈에 볼 수 있다. 청계천을 가로지르는 22개 다리에 대한 해설판도 설치되어 있고, 이외에도 다양한 형상의 분수가 만들어져 아름다운 경관을 연출한다.한편, 광장에서 청계천으로 진입하기 위한 시설로는 왼편에 계단형 진입로, 오른편에 청계탐방로가 들어 서 있다. 청계 탐방로 중 18m 구간에는 터널이 설치돼 광장에서 청계천으로 들어 오는 시민들에게 색다른 경험을 선사한다. 서울시는 청계천광장 조성 후 공휴일에는 이 곳을 차 없는 거리로 만들어 광장, 수변공간, 도로가 시민들의 휴식과 문화공간으로 이용되도록 마련해놓았다. 삼색 조명이 어우러진 캔들 분수와 4m 아래로 떨어지는 2단 폭포가 장관을 연출한다. 폭포 양 옆에는 전국에서 돌을 가져온 8도석으로 제작된 ''''팔석담''''을 깔았다. 밤이면 빛과 물이 어우러지는 환상적인 모습을 연출한다. 또, 청계천 전구간을 1/100로 축소한 미니어쳐 역시 멋진 볼거리를 제공한다.','admin',6,'가족과함께#걷기좋은','N',to_date('20/12/11','RR/MM/DD'));
Insert into TRAVEL (TR_NO,BO_NO,TR_ADDR,TR_THEME,TR_REG,TR_TITLE,TR_PHONE) values (SEQ_TRNO.NEXTVAL,SEQ_BO_NO.CURRVAL,'서울 성동구 살곶이길 69','관광지','서울',null,null);
Insert into IMG_FILE (FILE_NO,BO_NO,ORIGIN_NAME,CHANGE_NAME,FILE_LEVEL,FILE_PATH,FILE_DELETE_YN) values (SEQ_FILE_NO.NEXTVAL,SEQ_BO_NO.CURRVAL,'청계천.jpg','travel20201211073701.jpg',1,'null','N');


Insert into BOARD (BO_NO,CA_CODE,BO_TITLE,BO_CONTENT,MEMBER_ID,BO_COUNT,BO_TAG,BO_DELETE_YN,REGDATE) values (SEQ_BO_NO.NEXTVAL,1,'창덕궁','올해로 11년째를 맞는 「창덕궁 달빛기행」은 유네스코 세계유산 창덕궁에서 펼쳐지는 대표적인 고품격 문화행사이다.
은은한 달빛 아래 청사초롱으로 길을 밝히며 듣는 해설과 전통예술 공연 감상으로 도심 속 고궁에서의 잊을 수 없는 감동과 추억을 선사한다.

[행사내용]
1.해설과 함께하는 야간 기행
해설사와 함께 어둠이 깔린 창덕궁 곳곳을 누비며 전각마다 얽힌 옛이야기를 듣는다. 창덕궁의 역사·공간·인물에 대한 해설을 통해 마치 과거로 시간 여행을 떠난 듯 고궁의 야경을 체험할 수 있다. 더불어 왕이 사랑한 후원을 거닐며 밤이 주는 고궁의 운치를 만끽할 수 있다.
2.전통예술 공연 감상
향긋한 전통차를 즐기며 가(歌)·무(舞)·악(樂)으로 구성된 전통예술 공연 및 그림자극을 관람한다.

[참가안내]
인터넷 예매: 옥션티켓(http://ticket.auction.co.kr) / 장애인, 국가유공자 대상 전화예매(옥션티켓 1566-1369)
자세한 사항은 한국문화재재단 홈페이지 참고','admin',1,'걷기좋은#야간개장','N',to_date('20/12/11','RR/MM/DD'));
Insert into TRAVEL (TR_NO,BO_NO,TR_ADDR,TR_THEME,TR_REG,TR_TITLE,TR_PHONE) 
values (SEQ_TRNO.NEXTVAL,SEQ_BO_NO.CURRVAL,'서울 종로구 율곡로 99','명소','서울',null,null);

Insert into IMG_FILE (FILE_NO,BO_NO,ORIGIN_NAME,CHANGE_NAME,FILE_LEVEL,FILE_PATH,FILE_DELETE_YN)
values (SEQ_FILE_NO.NEXTVAL,SEQ_BO_NO.CURRVAL,'창덕궁.jpg','travel20201211080430.jpg',1,'null','N');


Insert into BOARD (BO_NO,CA_CODE,BO_TITLE,BO_CONTENT,MEMBER_ID,BO_COUNT,BO_TAG,BO_DELETE_YN,REGDATE) 
values (SEQ_BO_NO.NEXTVAL,1,'이태원 지구촌축제','이태원 지구촌 축제는 한국의 전통문화와 이태원의 외국 문화를 결합하고, 이태원 지역의 활성화 및 관광객 유치를 위해 2002년 처음 개최되었다. 다양한 볼거리로 가을에 개최되는 서울의 대표적인 축제로 자리매김되어 오고 있으며, 세계 각국의 음식전과 풍물전, 800여 참가자들의 퍼레이드, 한류의 중심을 이루는 K-POP 가수들의 콘서트, 세계문화체험관 등 다양한 문화교류행사로 이태원을 찾은 관광객들에게 즐거움을 선사한다.


[행사내용]
- 퍼레이드 : 국방부 군악대, 각국 대사관세계의상 참여팀 등

- 음식과 풍물 : 50여개 국가의 세계음식 및 세계 나라별 홍보부스

- 공연 : 개·폐막 콘서트, 요리이태원, 거리공연 등','admin',31,'축제#먹거리#공연','N',to_date('20/12/11','RR/MM/DD'));

Insert into TRAVEL (TR_NO,BO_NO,TR_ADDR,TR_THEME,TR_REG,TR_TITLE,TR_PHONE) 
values (SEQ_TRNO.NEXTVAL,SEQ_BO_NO.CURRVAL,'서울 용산구 이태원로 1','축제','서울',null,null);

Insert into IMG_FILE (FILE_NO,BO_NO,ORIGIN_NAME,CHANGE_NAME,FILE_LEVEL,FILE_PATH,FILE_DELETE_YN) 
values (SEQ_FILE_NO.NEXTVAL, SEQ_BO_NO.CURRVAL,'이태원.jpg','travel20201211080714.jpg',1,'null','N');


Insert into BOARD (BO_NO,CA_CODE,BO_TITLE,BO_CONTENT,MEMBER_ID,BO_COUNT,BO_TAG,BO_DELETE_YN,REGDATE) 
values (SEQ_BO_NO.NEXTVAL,1,'다운 타우너','다운타우너는 버거란 두 손으로 잡고 베어먹어야 한다는 철학을 바탕으로 서 있는 버거를 고안해냈다고 합니다. 
사진에서 볼 수 있듯 박스를 이용해 두 손으로 잡기 편하게 되어있습니다. 
아울러 미국의 현지 맛을 내기 위해 고안한 아보카도 버거도 최고 인기 메뉴가 됐습니다.
직접 가본 다운타우너는 오픈 시간 전부터 손님들이 기다리고 있을 정도로 인기가 높았는데요. 음식의 특성상 회전율은 빠른 편이라서 그리 오래 기다리지는 않아도 됐습니다. 대기를 하면서 미리 주문을 정할 수 있었어요.
방금 만들어 따끈따끈한 버거는 그냥 보아도 속이 꽉 차 있어 알차 보입니다. 거기에 고소한 참깨가 가득 뿌려져 먹음직스러운 비주얼인데요. 다운타우너의 빵은 부드럽고 오일을 한껏 머금어 폭신한 느낌입니다.
패티는 흑후추가 많이 들어가 있어 불 맛보다는 후추 향이 좀 더 강한 편이었습니다. 
육질이나 육즙은 아주 훌륭했어요. 또한 다운타우너의 소스는 청양고추를 더해 살짝 매콤한 특제 랜치소스를 사용하는데요. 
소스가 흘러내릴 정도로 가득 발려져 있습니다.
감칠맛이 느껴지는 소스에 빼곡하게 채워진 양파, 토마토, 로메인이 느끼함을 덮어주고 두툼한 패티에 더해진 흑후추로 뒷맛까지 좋습니다.
평소 맛이 진하고 알찬 스타일의 수제버거를 좋아하신다면 다운타우너에 방문해보시기를 추천드립니다.','admin',1,'맛집#이태원#수제버거','N',to_date('20/12/11','RR/MM/DD'));

Insert into TRAVEL (TR_NO,BO_NO,TR_ADDR,TR_THEME,TR_REG,TR_TITLE,TR_PHONE) 
values (SEQ_TRNO.NEXTVAL,SEQ_BO_NO.CURRVAL,'서울 강남구 도산대로53길 14','음식점','서울',null,null);

Insert into IMG_FILE (FILE_NO,BO_NO,ORIGIN_NAME,CHANGE_NAME,FILE_LEVEL,FILE_PATH,FILE_DELETE_YN) 
values (SEQ_FILE_NO.NEXTVAL, SEQ_BO_NO.CURRVAL,'다운타우너.jpg','travel20201211081934.jpg',1,'null','N');


Insert into BOARD (BO_NO,CA_CODE,BO_TITLE,BO_CONTENT,MEMBER_ID,BO_COUNT,BO_TAG,BO_DELETE_YN,REGDATE) 
values (SEQ_BO_NO.NEXTVAL,1,'이야기 하나','혼밥 레벨의 최고봉이라는 혼자 고기 구워 먹기도 강남역, ''이야기하나'' 식당에 가면 그다지 어려운 일이 아니다. 저녁 6시부터 시작하는 이야기하나는 선술집 분위기이지만, 1인용 화로구이에서 좋은 품질의 한우를 구워 먹을 수 있어 솔로 손님에게 사랑받는 곳. 16가지의 한우 부위를 오로지 내 스타일로 익히고 먹는 것에 집중할 수 있다.

부위별로 30g씩 두세 점 나오는데, 지방을 적절히 발라내고 살코기로만 나온다. 질이 좋은 꽃등심은 두툼하게 잘라 나오는데, 소고기에 대한 주인장의 자부심처럼 웰던으로 구워도 질기지 않다. 고기를 구워 먹고 나서 화로에 주먹밥을 구워 먹어도 별미. 곁들여 나오는 선지해장국은 구수하고 얼큰하다. 가격대가 만만치 않지만, 맛있는 한우를 골고루 맛볼 수 있어 특별한 날에 한 번쯤 사치를 부려볼 만하다. 소문을 듣고 찾아오는 일본, 중국 솔로 여행자들도 꽤 많다.

-영업시간 : 월~금 18:00 ~ 04:00(익일), 토요일 17:00 ~ 04:00(익일), 일요일 17:00 ~ 01:00(익일)
-휴무 : 명절
-메뉴 : 한우 부위별로 30g당 5,400~11,200원','admin',3,'혼밥#혼고기#맛집','N',to_date('20/12/11','RR/MM/DD'));

Insert into TRAVEL (TR_NO,BO_NO,TR_ADDR,TR_THEME,TR_REG,TR_TITLE,TR_PHONE) 
values (SEQ_TRNO.NEXTVAL,SEQ_BO_NO.CURRVAL,'서울 강남구 강남대로110길 22','음식점','서울',null,null);

Insert into IMG_FILE (FILE_NO,BO_NO,ORIGIN_NAME,CHANGE_NAME,FILE_LEVEL,FILE_PATH,FILE_DELETE_YN) 
values (SEQ_FILE_NO.NEXTVAL,SEQ_BO_NO.CURRVAL,'고기집.JPG','travel20201211082251.JPG',1,'null','N');


Insert into BOARD (BO_NO,CA_CODE,BO_TITLE,BO_CONTENT,MEMBER_ID,BO_COUNT,BO_TAG,BO_DELETE_YN,REGDATE) 
values (SEQ_BO_NO.NEXTVAL,1,'블루스퀘어','블루스퀘어는 2011년 11월 뮤지컬과 콘서트 전문 공연장으로 문을 열었다. 다채로운 공연 문화를 선보이고 있던 중 2016년 7월 카오스 북파크를 개관하고 2017년 봄 스테이지 B와 솔로스 키친이라는 레스토랑을 오픈했다. 한남아트갤러리, 공방 투 핸즈 등 예술공간도 마련했다. 전천후 복합문화예술 공간으로 재탄생한 블루스퀘어는 짧은 이벤트도 연중 진행한다. 소소한 즐거움이 가득한 블루스퀘어, 방문하기 전 홈페이지에 들러 똑소리 나는 일정을 짜보자.

블루스퀘어 안에는 카페가 여럿이다. 블루스퀘어 직영 테라스 카페 필로스(3층), 티켓박스 옆 케이크 전문 카페 Cake Gallery(공연장 로비층)가 입점해 있다. 카페 필로스는 북파크 내 자리해 책을 읽으며 머물러도 괜찮다. 단 음료를 들고 서고 쪽으로 가는 것은 자제하자. 북파크의 모든 책을 내 책인 듯 읽을 수 있으니, 책에 대한 예의 역시 내 책인 듯 대하면 좋을 것이다.

블루스퀘어 내, 솔로스 키친은 주방 앞에 바(bar) 형태의 식사공간과 복도 양쪽에 길게 나열된 테이블, 스탠딩 테이블이 있다. 날씨에 따라 출입구 밖 테라스 공간도 오픈한다. 바에서 식사하는 경우를 제외하고 모두 포장판매(테이크아웃) 용기에 음식을 제공한다.

영업시간 화~금요일 12:00~22:00, 토·일요일 12:00~20:30 휴무 월요일','admin',1,'24시#이태원#책','N',to_date('20/12/11','RR/MM/DD'));

Insert into TRAVEL (TR_NO,BO_NO,TR_ADDR,TR_THEME,TR_REG,TR_TITLE,TR_PHONE) 
values (SEQ_TRNO.NEXTVAL,SEQ_BO_NO.CURRVAL,'서울 용산구 이태원로 294','음식점','서울',null,null);

Insert into IMG_FILE (FILE_NO,BO_NO,ORIGIN_NAME,CHANGE_NAME,FILE_LEVEL,FILE_PATH,FILE_DELETE_YN) 
values (SEQ_FILE_NO.NEXTVAL,SEQ_BO_NO.CURRVAL,'블루스퀘어.jpg','travel20201211083053.jpg',1,'null','N');

COMMIT;
---

--board
Insert into TRIP2REAP.BOARD (BO_NO,CA_CODE,BO_TITLE,BO_CONTENT,MEMBER_ID,BO_COUNT,BO_TAG,BO_DELETE_YN,REGDATE) 
values (SEQ_BO_NO.NEXTVAL , 5,'호텔 리젠트 마린 더 블루','호텔 리젠트 마린 더 블루에서 차로 15분이면 제주국제공항까지 가실 수 있습니다. 차로 약 10분 거리에 제주의 역사를 한눈에 볼 수 있는 제주 삼성혈과 민속 자연사 박물관이 있습니다. 또한 차로 15분이면 도심에서 가장 가까운 해변인 이호테우 해변까지 가실 수 있습니다. 편안한 객실과 시설을 제공하는 이 호텔은 관광객과 비즈니스 출장객 모두에게 좋은 숙소입니다. 무료 구내 전용 주차장도 이용하실 수 있습니다. 호텔 내 객실에는 에어컨이 완비되어 있고 평면 TV, 커피 메이커, 슬리퍼 등이 갖춰져 있습니다. 전 객실에서는 냉장고, 플러그 앤 플레이 패널 등을 사용하실 수 있으며 전용 욕실에는 샤워 시설도 구비되어 있습니다. 이 호텔에서는 날마다 푸짐한 조식을 제공합니다. 그 밖에도 근처에는 수많은 식당가와 분위기 좋은 카페가 즐비해 있습니다.','admin',0,'제주앞바다, 제주공항15분거리','N',to_date('20/12/13','RR/MM/DD'));

--hotel
Insert into TRIP2REAP.HOTEL (BO_NO,HOTEL_ADDRESS,HOTEL_LOCAL_CODE,HOTEL_SITE,HOTEL_TEL,HOTEL_REVIEW_SCORE,HOTEL_RANK,HOTEL_OPEN_TIME,HOTEL_CLOSE_TIME,HOTEL_OPTION,CHECK_IN,CHECK_OUT) 
values (SEQ_BO_NO.CURRVAL,'제주특별자치도 제주시 서부두2길 20',15,'http://www.hotelrmblue.com/hotel/index.html','064-717-5000',0,4,0,23,'와이파이, 조식, 레스토랑, 세탁, 24시간 리셉션, 수하물 보관, 수영장, 비즈니스 시설, 주차, 장애인 편의시설, 주방',15,12);



--img
Insert into TRIP2REAP.IMG_FILE (FILE_NO,BO_NO,ORIGIN_NAME,CHANGE_NAME,FILE_LEVEL,FILE_PATH,FILE_DELETE_YN) 
values (SEQ_FILE_NO.NEXTVAL ,SEQ_BO_NO.CURRVAL,'썸네일.jpeg','hotel_thumbnail_202012140518320221.jpeg',1,'/Users/ek/Documents/GitHub/Spring-Project-Trip2Reap/Spring-Final-Trip2Reap/src/main/webapp/resources/buploadFiles/hotel_thumbnail_202012140518320221.jpeg','N');

Insert into TRIP2REAP.IMG_FILE (FILE_NO,BO_NO,ORIGIN_NAME,CHANGE_NAME,FILE_LEVEL,FILE_PATH,FILE_DELETE_YN) 
values (SEQ_FILE_NO.NEXTVAL ,SEQ_BO_NO.CURRVAL,'디테일1.jpeg','hotel_detail_202012140518320250.jpeg',2,'/Users/ek/Documents/GitHub/Spring-Project-Trip2Reap/Spring-Final-Trip2Reap/src/main/webapp/resources/buploadFiles/hotel_detail_202012140518320250.jpeg','N');

Insert into TRIP2REAP.IMG_FILE (FILE_NO,BO_NO,ORIGIN_NAME,CHANGE_NAME,FILE_LEVEL,FILE_PATH,FILE_DELETE_YN) 
values (SEQ_FILE_NO.NEXTVAL ,SEQ_BO_NO.CURRVAL,'디테일2.jpeg','hotel_detail_202012140518320257.jpeg',2,'/Users/ek/Documents/GitHub/Spring-Project-Trip2Reap/Spring-Final-Trip2Reap/src/main/webapp/resources/buploadFiles/hotel_detail_202012140518320257.jpeg','N');

Insert into TRIP2REAP.IMG_FILE (FILE_NO,BO_NO,ORIGIN_NAME,CHANGE_NAME,FILE_LEVEL,FILE_PATH,FILE_DELETE_YN) 
values (SEQ_FILE_NO.NEXTVAL ,SEQ_BO_NO.CURRVAL,'디테일3.jpeg','hotel_detail_202012140518320268.jpeg',2,'/Users/ek/Documents/GitHub/Spring-Project-Trip2Reap/Spring-Final-Trip2Reap/src/main/webapp/resources/buploadFiles/hotel_detail_202012140518320268.jpeg','N');

Insert into TRIP2REAP.IMG_FILE (FILE_NO,BO_NO,ORIGIN_NAME,CHANGE_NAME,FILE_LEVEL,FILE_PATH,FILE_DELETE_YN) 
values (SEQ_FILE_NO.NEXTVAL ,SEQ_BO_NO.CURRVAL,'디테일4.jpeg','hotel_detail_202012140518320275.jpeg',2,'/Users/ek/Documents/GitHub/Spring-Project-Trip2Reap/Spring-Final-Trip2Reap/src/main/webapp/resources/buploadFiles/hotel_detail_202012140518320275.jpeg','N');

Insert into TRIP2REAP.IMG_FILE (FILE_NO,BO_NO,ORIGIN_NAME,CHANGE_NAME,FILE_LEVEL,FILE_PATH,FILE_DELETE_YN) 
values (SEQ_FILE_NO.NEXTVAL ,SEQ_BO_NO.CURRVAL,'디테일5.jpeg','hotel_detail_202012140518320282.jpeg',2,'/Users/ek/Documents/GitHub/Spring-Project-Trip2Reap/Spring-Final-Trip2Reap/src/main/webapp/resources/buploadFiles/hotel_detail_202012140518320282.jpeg','N');

Insert into TRIP2REAP.IMG_FILE (FILE_NO,BO_NO,ORIGIN_NAME,CHANGE_NAME,FILE_LEVEL,FILE_PATH,FILE_DELETE_YN) 
values (SEQ_FILE_NO.NEXTVAL ,SEQ_BO_NO.CURRVAL,'디테일6.jpeg','hotel_detail_202012140518320294.jpeg',2,'/Users/ek/Documents/GitHub/Spring-Project-Trip2Reap/Spring-Final-Trip2Reap/src/main/webapp/resources/buploadFiles/hotel_detail_202012140518320294.jpeg','N');

Insert into TRIP2REAP.IMG_FILE (FILE_NO,BO_NO,ORIGIN_NAME,CHANGE_NAME,FILE_LEVEL,FILE_PATH,FILE_DELETE_YN) 
values (SEQ_FILE_NO.NEXTVAL ,SEQ_BO_NO.CURRVAL,'디테일7.jpeg','hotel_detail_202012140518320300.jpeg',2,'/Users/ek/Documents/GitHub/Spring-Project-Trip2Reap/Spring-Final-Trip2Reap/src/main/webapp/resources/buploadFiles/hotel_detail_202012140518320300.jpeg','N');

Insert into TRIP2REAP.IMG_FILE (FILE_NO,BO_NO,ORIGIN_NAME,CHANGE_NAME,FILE_LEVEL,FILE_PATH,FILE_DELETE_YN) 
values (SEQ_FILE_NO.NEXTVAL ,SEQ_BO_NO.CURRVAL,'디테일8.jpeg','hotel_detail_202012140518320308.jpeg',2,'/Users/ek/Documents/GitHub/Spring-Project-Trip2Reap/Spring-Final-Trip2Reap/src/main/webapp/resources/buploadFiles/hotel_detail_202012140518320308.jpeg','N');

Insert into TRIP2REAP.IMG_FILE (FILE_NO,BO_NO,ORIGIN_NAME,CHANGE_NAME,FILE_LEVEL,FILE_PATH,FILE_DELETE_YN) 
values (SEQ_FILE_NO.NEXTVAL ,SEQ_BO_NO.CURRVAL,'디테일9.jpeg','hotel_detail_202012140518320316.jpeg',2,'/Users/ek/Documents/GitHub/Spring-Project-Trip2Reap/Spring-Final-Trip2Reap/src/main/webapp/resources/buploadFiles/hotel_detail_202012140518320316.jpeg','N');

Insert into TRIP2REAP.IMG_FILE (FILE_NO,BO_NO,ORIGIN_NAME,CHANGE_NAME,FILE_LEVEL,FILE_PATH,FILE_DELETE_YN) 
values (SEQ_FILE_NO.NEXTVAL ,SEQ_BO_NO.CURRVAL,'디테일10.jpeg','hotel_detail_202012140518320325.jpeg',2,'/Users/ek/Documents/GitHub/Spring-Project-Trip2Reap/Spring-Final-Trip2Reap/src/main/webapp/resources/buploadFiles/hotel_detail_202012140518320325.jpeg','N');

Insert into TRIP2REAP.IMG_FILE (FILE_NO,BO_NO,ORIGIN_NAME,CHANGE_NAME,FILE_LEVEL,FILE_PATH,FILE_DELETE_YN) 
values (SEQ_FILE_NO.NEXTVAL ,SEQ_BO_NO.CURRVAL,'썸네일.jpeg','hotel_detail_202012140518320332.jpeg',2,'/Users/ek/Documents/GitHub/Spring-Project-Trip2Reap/Spring-Final-Trip2Reap/src/main/webapp/resources/buploadFiles/hotel_detail_202012140518320332.jpeg','N');


--ROOM
Insert into TRIP2REAP.ROOM (ROOM_NO,BO_NO,ROOM_TYPE,ROOM_NAME,PRICE_PER_DAY) values (SEQ_ROOM_NO.NEXTVAL ,SEQ_BO_NO.CURRVAL ,'더블룸','스탠다드 더블룸-도시전망',62200);
Insert into TRIP2REAP.ROOM (ROOM_NO,BO_NO,ROOM_TYPE,ROOM_NAME,PRICE_PER_DAY) values (SEQ_ROOM_NO.NEXTVAL ,SEQ_BO_NO.CURRVAL ,'스탠다드룸','스탠다드 더블룸-도시전망',62200);
Insert into TRIP2REAP.ROOM (ROOM_NO,BO_NO,ROOM_TYPE,ROOM_NAME,PRICE_PER_DAY) values (SEQ_ROOM_NO.NEXTVAL ,SEQ_BO_NO.CURRVAL ,'트윈룸','스탠다드 트윈룸-도시전망',58800);
Insert into TRIP2REAP.ROOM (ROOM_NO,BO_NO,ROOM_TYPE,ROOM_NAME,PRICE_PER_DAY) values (SEQ_ROOM_NO.NEXTVAL ,SEQ_BO_NO.CURRVAL ,'트윈룸','스탠다드 트윈룸-도시전망',58800);


---


insert into board values(SEQ_BO_NO.NEXTVAL,2,'★별보러가자★',null,'joy',0,null,'N',to_date('20/12/10','RR/MM/DD'));
Insert into IMG_FILE values (SEQ_FILE_NO.NEXTVAL,SEQ_BO_NO.CURRVAL,'course7.jpg','1607969035089course7.JPG',1,'null','N');
insert into course values(SEQ_CO_NO.NEXTVAL,SEQ_BO_NO.CURRVAL,'가족','당일치기','0,0,0,0','영양반딧불이천문대,석보갈비,선바위관광지,커피베이 경북영양점','129.26945106775,129.101560844106,129.081086315202,129.11071218641237','36.8304157868791,36.5563906091168,36.6087837193124,36.66347869486301','46.4');


insert into board values(SEQ_BO_NO.NEXTVAL,2,'북촌한옥마을',null,'soo',0,null,'N',to_date('20/12/09','RR/MM/DD'));
Insert into IMG_FILE values (SEQ_FILE_NO.NEXTVAL,SEQ_BO_NO.CURRVAL,'course3.jpg','1607936714070course3.JPG',1,'null','N');
insert into course values(SEQ_CO_NO.NEXTVAL,SEQ_BO_NO.CURRVAL,'우정','당일치기','0,0,0,0,0','북촌한옥마을,카페노티드 안국,소금집델리 안국,창덕궁,종묘','126.983384576672,126.986039353435,126.98623370380619,126.99164485515004,126.994212979827','37.5829185302128,37.5774624552685,37.57944556614759,37.58187064743792,37.5761080433804','2');



insert into board values(SEQ_BO_NO.NEXTVAL,2,'경주여행 레고',null,'TRIP',0,null,'N',to_date('20/12/06','RR/MM/DD'));
Insert into IMG_FILE values (SEQ_FILE_NO.NEXTVAL,SEQ_BO_NO.CURRVAL,'course6.jpg','1607968572615course6.JPG',1,'null','N');
insert into course values(SEQ_CO_NO.NEXTVAL,SEQ_BO_NO.CURRVAL,'나홀로','당일치기','0,0,0,0,0','첨성대,함양집 경주보문점,동국대학교 경주캠퍼스,포석정,신경주역','129.219020190172,129.262183765744,129.19450495505598,129.213092771083,129.13899826575','35.8347180469201,35.8520273426589,35.862538617367974,35.8071183926353,35.7983754706903','23.7');




insert into board values(SEQ_BO_NO.NEXTVAL,2,'부산으로 떠나요!',null,'TRIP',0,null,'N',to_date('20/12/08','RR/MM/DD'));
Insert into IMG_FILE values (SEQ_FILE_NO.NEXTVAL,SEQ_BO_NO.CURRVAL,'course4.jpg','1607937458015course4.JPG',1,'null','N');
insert into course values(SEQ_CO_NO.NEXTVAL,SEQ_BO_NO.CURRVAL,'가족','당일치기','0,0,0,0,0','마린시티,해운대가야밀면,해운대해수욕장,비비비당,해운대달맞이공원','129.116248485217,129.166334485854,129.159854668484,129.1850134393127,129.17893035431','35.172125477434,35.1688354703383,35.1585232170784,35.162550535259946,35.1560728255183','9.1');



insert into board values(SEQ_BO_NO.NEXTVAL,2,'제주 남부 여행',null,'joy',0,null,'N',to_date('20/12/09','RR/MM/DD'));
Insert into IMG_FILE values (SEQ_FILE_NO.NEXTVAL,SEQ_BO_NO.CURRVAL,'course2.jpg','1607934467823course2.JPG',1,'null','N');
insert into course values(SEQ_CO_NO.NEXTVAL,SEQ_BO_NO.CURRVAL,'커플','당일치기','0,0,0,0,0','함덕해수욕장,카페더콘테나,교래흑돼지 본점,산굼부리,비자림','126.669238934013,126.67895539907079,126.6750575197852,126.693840600964,126.80998754971','33.5430615661113,33.49808308071445,33.42372662293438,33.4325741154168,33.4904083697986','28');



insert into board values(SEQ_BO_NO.NEXTVAL,2,'가평 수상레저 즐기기',null,'ko1850',0,null,'N',to_date('20/12/07','RR/MM/DD'));
Insert into IMG_FILE values (SEQ_FILE_NO.NEXTVAL,SEQ_BO_NO.CURRVAL,'course5.jpg','1607937714736course5.JPG',1,'null','N');
insert into course values(SEQ_CO_NO.NEXTVAL,SEQ_BO_NO.CURRVAL,'액티비티','당일치기','0,0,0,0,0','가평빠지 바이킹수상레저,봉화산,구곡폭포,남이섬,스윙카페','127.54063465265088,127.611155351119,127.609196555667,127.525209237483,127.52677494487004','37.75654910133039,37.7809662687697,37.7940221581331,37.7916335528514,37.7943672578702','16');



insert into board values(SEQ_BO_NO.NEXTVAL,2,'제주 서부로 떠나자~!!',null,'joy',0,null,'N',to_date('20/12/05','RR/MM/DD'));
Insert into IMG_FILE values (SEQ_FILE_NO.NEXTVAL,SEQ_BO_NO.CURRVAL,'course1.jpg','1607934324177course1.JPG',1,'null','N');
insert into course values(SEQ_CO_NO.NEXTVAL,SEQ_BO_NO.CURRVAL,'나홀로','당일치기','0,0,0,0,0','하이엔드제주,골목카페옥수,9.81파크,아르떼뮤지엄,새별오름','126.30917383944714,126.379977434507,126.36666400048769,126.34500847325,126.357711941768','33.46359065428745,33.4397509795262,33.39028982281912,33.3966977646567,33.3661936453469','18.4');


COMMIT;


-----



SET DEFINE OFF;

Insert into TRIP2REAP.BOARD (BO_NO,CA_CODE,BO_TITLE,BO_CONTENT,MEMBER_ID,BO_COUNT,BO_TAG,BO_DELETE_YN,REGDATE) values (SEQ_BO_NO.NEXTVAL ,5,'신라스테이 광화문','신라스테이 광화문 - <3성급:한국관광공사 인증> - 신라스테이 광화문은 5호선 광화문역 2번 출구에서 도보로 5분 거리에 있습니다. 가까운 도보 거리에 시청, 대사관, 서울 파이낸스 센터 등이 있어 비즈니스 여행객에게 편리한 위치를 자랑합니다. 뿐만 아니라 서울 4대 고궁, 북촌한옥마을과 명동까지 차로 약 10분이면 가실 수 있어 관광객분들께도 최적의 위치를 자랑합니다. 호텔 내에 다양한 규모의 미팅룸 4개가 준비되어 있으며 컴퓨터와 프린터가 마련된 비즈니스 코너가 24시간 운영되고 있습니다. 호텔 8층에는 로비, 레스토랑, 미팅룸, 피트니스 센터가 모두 모여 있어 번거롭게 이동하지 않으셔도 됩니다. 또한, 주차장을 무료로 제공하고 있습니다. 모던한 인테리어가 돋보이는 339개의 객실을 보유하고 있으며 일부 객실에서는 조계사와 삼청동 전망을 조망하실 수 있습니다. 각 객실에는 LED TV와 미니 냉장고가 마련되어 있으며 거위 털 이불과 오리털 베개 등을 비롯한 고급 침구가 기분 좋은 숙면을 돕습니다. 욕실에는 아베다 욕실용품, 비데, 샤워 가운 등이 준비되어 있습니다. 8층에 위치한 카페에서는 조식과 중식으로 각국의 다양한 요리를 뷔페를 맛보실 수 있으며 저녁에는 라운지 바로 운영되고 있습니다.','admin',3,'광화문, 신라스테이','N',to_date('20/12/10','RR/MM/DD'));
Insert into TRIP2REAP.HOTEL (BO_NO,HOTEL_ADDRESS,HOTEL_LOCAL_CODE,HOTEL_SITE,HOTEL_TEL,HOTEL_REVIEW_SCORE,HOTEL_RANK,HOTEL_OPEN_TIME,HOTEL_CLOSE_TIME,HOTEL_OPTION,CHECK_IN,CHECK_OUT) values (SEQ_BO_NO.CURRVAL ,'서울 종로구 삼봉로 71',9,'https://shillastay.com/gwanghwamun/index.do?lang=ko','02-2230-0700',0,3,0,23,'와이파이, 조식, 레스토랑, 세탁, 24시간 리셉션, 수하물 보관, 피트니스, 카페, 비즈니스 시설, 주차, 공항셔틀, 장애인 편의시설, 바/라운지, 주방',13,10);

Insert into TRIP2REAP.IMG_FILE (FILE_NO,BO_NO,ORIGIN_NAME,CHANGE_NAME,FILE_LEVEL,FILE_PATH,FILE_DELETE_YN) values (SEQ_FILE_NO.NEXTVAL ,SEQ_BO_NO.CURRVAL ,'신라스테이광화문썸네일.jpeg','hotel_thumbnail_202012102048530909.jpeg',1,'/Users/ek/Documents/GitHub/Spring-Project-Trip2Reap/Spring-Final-Trip2Reap/src/main/webapp/resources/buploadFiles/hotel_thumbnail_202012102048530909.jpeg','N');
Insert into TRIP2REAP.IMG_FILE (FILE_NO,BO_NO,ORIGIN_NAME,CHANGE_NAME,FILE_LEVEL,FILE_PATH,FILE_DELETE_YN) values (SEQ_FILE_NO.NEXTVAL ,SEQ_BO_NO.CURRVAL ,'신라스테이광화문디테일1.jpeg','hotel_detail_202012102048530931.jpeg',2,'/Users/ek/Documents/GitHub/Spring-Project-Trip2Reap/Spring-Final-Trip2Reap/src/main/webapp/resources/buploadFiles/hotel_detail_202012102048530931.jpeg','N');
Insert into TRIP2REAP.IMG_FILE (FILE_NO,BO_NO,ORIGIN_NAME,CHANGE_NAME,FILE_LEVEL,FILE_PATH,FILE_DELETE_YN) values (SEQ_FILE_NO.NEXTVAL ,SEQ_BO_NO.CURRVAL ,'신라스테이광화문디테일2.jpeg','hotel_detail_202012102048530941.jpeg',2,'/Users/ek/Documents/GitHub/Spring-Project-Trip2Reap/Spring-Final-Trip2Reap/src/main/webapp/resources/buploadFiles/hotel_detail_202012102048530941.jpeg','N');
Insert into TRIP2REAP.IMG_FILE (FILE_NO,BO_NO,ORIGIN_NAME,CHANGE_NAME,FILE_LEVEL,FILE_PATH,FILE_DELETE_YN) values (SEQ_FILE_NO.NEXTVAL ,SEQ_BO_NO.CURRVAL ,'신라스테이광화문디테일3.jpeg','hotel_detail_202012102048530951.jpeg',2,'/Users/ek/Documents/GitHub/Spring-Project-Trip2Reap/Spring-Final-Trip2Reap/src/main/webapp/resources/buploadFiles/hotel_detail_202012102048530951.jpeg','N');
Insert into TRIP2REAP.IMG_FILE (FILE_NO,BO_NO,ORIGIN_NAME,CHANGE_NAME,FILE_LEVEL,FILE_PATH,FILE_DELETE_YN) values (SEQ_FILE_NO.NEXTVAL ,SEQ_BO_NO.CURRVAL ,'신라스테이광화문디테일4.jpeg','hotel_detail_202012102048530962.jpeg',2,'/Users/ek/Documents/GitHub/Spring-Project-Trip2Reap/Spring-Final-Trip2Reap/src/main/webapp/resources/buploadFiles/hotel_detail_202012102048530962.jpeg','N');
Insert into TRIP2REAP.IMG_FILE (FILE_NO,BO_NO,ORIGIN_NAME,CHANGE_NAME,FILE_LEVEL,FILE_PATH,FILE_DELETE_YN) values (SEQ_FILE_NO.NEXTVAL ,SEQ_BO_NO.CURRVAL ,'신라스테이광화문디테일5.jpeg','hotel_detail_202012102048530971.jpeg',2,'/Users/ek/Documents/GitHub/Spring-Project-Trip2Reap/Spring-Final-Trip2Reap/src/main/webapp/resources/buploadFiles/hotel_detail_202012102048530971.jpeg','N');
Insert into TRIP2REAP.IMG_FILE (FILE_NO,BO_NO,ORIGIN_NAME,CHANGE_NAME,FILE_LEVEL,FILE_PATH,FILE_DELETE_YN) values (SEQ_FILE_NO.NEXTVAL ,SEQ_BO_NO.CURRVAL ,'신라스테이광화문디테일6.jpeg','hotel_detail_202012102048530984.jpeg',2,'/Users/ek/Documents/GitHub/Spring-Project-Trip2Reap/Spring-Final-Trip2Reap/src/main/webapp/resources/buploadFiles/hotel_detail_202012102048530984.jpeg','N');
Insert into TRIP2REAP.IMG_FILE (FILE_NO,BO_NO,ORIGIN_NAME,CHANGE_NAME,FILE_LEVEL,FILE_PATH,FILE_DELETE_YN) values (SEQ_FILE_NO.NEXTVAL ,SEQ_BO_NO.CURRVAL ,'신라스테이광화문디테일7.jpeg','hotel_detail_202012102048530994.jpeg',2,'/Users/ek/Documents/GitHub/Spring-Project-Trip2Reap/Spring-Final-Trip2Reap/src/main/webapp/resources/buploadFiles/hotel_detail_202012102048530994.jpeg','N');
Insert into TRIP2REAP.IMG_FILE (FILE_NO,BO_NO,ORIGIN_NAME,CHANGE_NAME,FILE_LEVEL,FILE_PATH,FILE_DELETE_YN) values (SEQ_FILE_NO.NEXTVAL ,SEQ_BO_NO.CURRVAL ,'신라스테이광화문디테일8.jpeg','hotel_detail_202012102048540003.jpeg',2,'/Users/ek/Documents/GitHub/Spring-Project-Trip2Reap/Spring-Final-Trip2Reap/src/main/webapp/resources/buploadFiles/hotel_detail_202012102048540003.jpeg','N');
Insert into TRIP2REAP.IMG_FILE (FILE_NO,BO_NO,ORIGIN_NAME,CHANGE_NAME,FILE_LEVEL,FILE_PATH,FILE_DELETE_YN) values (SEQ_FILE_NO.NEXTVAL ,SEQ_BO_NO.CURRVAL ,'신라스테이광화문썸네일.jpeg','hotel_detail_202012102048540016.jpeg',2,'/Users/ek/Documents/GitHub/Spring-Project-Trip2Reap/Spring-Final-Trip2Reap/src/main/webapp/resources/buploadFiles/hotel_detail_202012102048540016.jpeg','N');

Insert into TRIP2REAP.ROOM (ROOM_NO,BO_NO,ROOM_TYPE,ROOM_NAME,PRICE_PER_DAY) values ( SEQ_ROOM_NO.NEXTVAL ,SEQ_BO_NO.CURRVAL ,'스탠다드룸','스탠다드 트윈룸',67200);
Insert into TRIP2REAP.ROOM (ROOM_NO,BO_NO,ROOM_TYPE,ROOM_NAME,PRICE_PER_DAY) values ( SEQ_ROOM_NO.NEXTVAL ,SEQ_BO_NO.CURRVAL ,'트윈룸','스탠다드 트윈룸',67200);
Insert into TRIP2REAP.ROOM (ROOM_NO,BO_NO,ROOM_TYPE,ROOM_NAME,PRICE_PER_DAY) values ( SEQ_ROOM_NO.NEXTVAL ,SEQ_BO_NO.CURRVAL ,'스탠다드룸','스탠다드 더블룸',67200);
Insert into TRIP2REAP.ROOM (ROOM_NO,BO_NO,ROOM_TYPE,ROOM_NAME,PRICE_PER_DAY) values ( SEQ_ROOM_NO.NEXTVAL ,SEQ_BO_NO.CURRVAL ,'더블룸','스탠다드 더블룸',67200);
Insert into TRIP2REAP.ROOM (ROOM_NO,BO_NO,ROOM_TYPE,ROOM_NAME,PRICE_PER_DAY) values ( SEQ_ROOM_NO.NEXTVAL ,SEQ_BO_NO.CURRVAL ,'트윈룸','패밀리 트윈룸',72000);
Insert into TRIP2REAP.ROOM (ROOM_NO,BO_NO,ROOM_TYPE,ROOM_NAME,PRICE_PER_DAY) values ( SEQ_ROOM_NO.NEXTVAL ,SEQ_BO_NO.CURRVAL ,'패밀리룸','패밀리 트윈룸',72000);
Insert into TRIP2REAP.ROOM (ROOM_NO,BO_NO,ROOM_TYPE,ROOM_NAME,PRICE_PER_DAY) values ( SEQ_ROOM_NO.NEXTVAL ,SEQ_BO_NO.CURRVAL ,'디럭스룸','디럭스 더블룸',71200);
Insert into TRIP2REAP.ROOM (ROOM_NO,BO_NO,ROOM_TYPE,ROOM_NAME,PRICE_PER_DAY) values ( SEQ_ROOM_NO.NEXTVAL ,SEQ_BO_NO.CURRVAL ,'더블룸','디럭스 더블룸',71200);
Insert into TRIP2REAP.ROOM (ROOM_NO,BO_NO,ROOM_TYPE,ROOM_NAME,PRICE_PER_DAY) values ( SEQ_ROOM_NO.NEXTVAL ,SEQ_BO_NO.CURRVAL ,'더블룸','디럭스 더블룸 -와이파이 포함',71800);

------23
Insert into TRIP2REAP.BOARD (BO_NO,CA_CODE,BO_TITLE,BO_CONTENT,MEMBER_ID,BO_COUNT,BO_TAG,BO_DELETE_YN,REGDATE) values (SEQ_BO_NO.NEXTVAL ,5,'신라스테이 서대문','신라스테이 서대문 - <3성급:한국관광공사 인증> - 신라 스테이 서대문은 5호선 서대문역 7, 8번 출구 바로 앞에 있습니다. 차로 10분 거리에 시청, 서울 파이낸스 센터 등이 있어 비즈니스 여행객에게 편리한 위치를 자랑합니다. 뿐만 아니라 명동, 롯데백화점 본점, 남대문 등도 차로 10분 거리에 있어 쇼핑을 즐기시기에 편리한 위치를 자랑합니다. 호텔 내에 미팅룸이 준비되어 있으며 컴퓨터와 프린터가 마련된 비즈니스 코너가 24시간 운영되고 있습니다. 또한, 여러 유/무산소 기구가 완비된 피트니스 센터가 있으며, 유료 발렛 주차가 가능합니다. 전체 319개의 객실을 보유하고 있으며, 모든 객실에는 LED TV와 유니버설 어댑터가 있으며 거위 털 이불과 오리털 베개 등을 비롯한 고급 침구가 기분 좋은 숙면을 돕습니다. 욕실에는 아베다 욕실용품, 비데, 샤워 가운 등이 준비되어 있습니다. 또한, 객실 유형에 따라, 샤워부스, 욕조, 샤워부스 및 욕조가 있습니다. 지하 1층에 위치한 카페에서는 각국의 다양한 요리를 조식, 중식 뷔페로 맛보실 수 있으며 별도의 요금이 발생합니다.','admin',2,'서대문, 신라스테이','N',to_date('20/12/10','RR/MM/DD'));
Insert into TRIP2REAP.HOTEL (BO_NO,HOTEL_ADDRESS,HOTEL_LOCAL_CODE,HOTEL_SITE,HOTEL_TEL,HOTEL_REVIEW_SCORE,HOTEL_RANK,HOTEL_OPEN_TIME,HOTEL_CLOSE_TIME,HOTEL_OPTION,CHECK_IN,CHECK_OUT) 
values ( SEQ_BO_NO.CURRVAL ,'서울 서대문구 충정로 76',9,'https://shillastay.com/seodaemun/index.do?lang=ko','02-2233-3131',0,3,9,18,'와이파이, 조식, 레스토랑, 세탁, 24시간 리셉션, 수하물 보관, 피트니스, 비즈니스 시설',10,13);

Insert into TRIP2REAP.IMG_FILE (FILE_NO,BO_NO,ORIGIN_NAME,CHANGE_NAME,FILE_LEVEL,FILE_PATH,FILE_DELETE_YN) values (SEQ_FILE_NO.NEXTVAL , SEQ_BO_NO.CURRVAL ,'신라스테이서대문썸네일.jpeg','hotel_thumbnail_202012102057450555.jpeg',1,'/Users/ek/Documents/GitHub/Spring-Project-Trip2Reap/Spring-Final-Trip2Reap/src/main/webapp/resources/buploadFiles/hotel_thumbnail_202012102057450555.jpeg','N');
Insert into TRIP2REAP.IMG_FILE (FILE_NO,BO_NO,ORIGIN_NAME,CHANGE_NAME,FILE_LEVEL,FILE_PATH,FILE_DELETE_YN) values (SEQ_FILE_NO.NEXTVAL , SEQ_BO_NO.CURRVAL ,'신라스테이서대문디테일1.jpeg','hotel_detail_202012102057450572.jpeg',2,'/Users/ek/Documents/GitHub/Spring-Project-Trip2Reap/Spring-Final-Trip2Reap/src/main/webapp/resources/buploadFiles/hotel_detail_202012102057450572.jpeg','N');
Insert into TRIP2REAP.IMG_FILE (FILE_NO,BO_NO,ORIGIN_NAME,CHANGE_NAME,FILE_LEVEL,FILE_PATH,FILE_DELETE_YN) values (SEQ_FILE_NO.NEXTVAL , SEQ_BO_NO.CURRVAL ,'신라스테이서대문디테일2.jpeg','hotel_detail_202012102057450579.jpeg',2,'/Users/ek/Documents/GitHub/Spring-Project-Trip2Reap/Spring-Final-Trip2Reap/src/main/webapp/resources/buploadFiles/hotel_detail_202012102057450579.jpeg','N');
Insert into TRIP2REAP.IMG_FILE (FILE_NO,BO_NO,ORIGIN_NAME,CHANGE_NAME,FILE_LEVEL,FILE_PATH,FILE_DELETE_YN) values (SEQ_FILE_NO.NEXTVAL , SEQ_BO_NO.CURRVAL ,'신라스테이서대문디테일3.jpeg','hotel_detail_202012102057450588.jpeg',2,'/Users/ek/Documents/GitHub/Spring-Project-Trip2Reap/Spring-Final-Trip2Reap/src/main/webapp/resources/buploadFiles/hotel_detail_202012102057450588.jpeg','N');
Insert into TRIP2REAP.IMG_FILE (FILE_NO,BO_NO,ORIGIN_NAME,CHANGE_NAME,FILE_LEVEL,FILE_PATH,FILE_DELETE_YN) values (SEQ_FILE_NO.NEXTVAL , SEQ_BO_NO.CURRVAL ,'신라스테이서대문디테일4.jpeg','hotel_detail_202012102057450598.jpeg',2,'/Users/ek/Documents/GitHub/Spring-Project-Trip2Reap/Spring-Final-Trip2Reap/src/main/webapp/resources/buploadFiles/hotel_detail_202012102057450598.jpeg','N');
Insert into TRIP2REAP.IMG_FILE (FILE_NO,BO_NO,ORIGIN_NAME,CHANGE_NAME,FILE_LEVEL,FILE_PATH,FILE_DELETE_YN) values (SEQ_FILE_NO.NEXTVAL , SEQ_BO_NO.CURRVAL ,'신라스테이서대문썸네일.jpeg','hotel_detail_202012102057450608.jpeg',2,'/Users/ek/Documents/GitHub/Spring-Project-Trip2Reap/Spring-Final-Trip2Reap/src/main/webapp/resources/buploadFiles/hotel_detail_202012102057450608.jpeg','N');

Insert into TRIP2REAP.ROOM (ROOM_NO,BO_NO,ROOM_TYPE,ROOM_NAME,PRICE_PER_DAY) values ( SEQ_ROOM_NO.NEXTVAL , SEQ_BO_NO.CURRVAL ,'스탠다드룸','스탠다드 트윈룸',59600);
Insert into TRIP2REAP.ROOM (ROOM_NO,BO_NO,ROOM_TYPE,ROOM_NAME,PRICE_PER_DAY) values ( SEQ_ROOM_NO.NEXTVAL , SEQ_BO_NO.CURRVAL ,'트윈룸','스탠다드 트윈룸',59600);
Insert into TRIP2REAP.ROOM (ROOM_NO,BO_NO,ROOM_TYPE,ROOM_NAME,PRICE_PER_DAY) values ( SEQ_ROOM_NO.NEXTVAL , SEQ_BO_NO.CURRVAL ,'트윈룸','디럭스 트윈룸',64100);
Insert into TRIP2REAP.ROOM (ROOM_NO,BO_NO,ROOM_TYPE,ROOM_NAME,PRICE_PER_DAY) values ( SEQ_ROOM_NO.NEXTVAL , SEQ_BO_NO.CURRVAL ,'디럭스룸','디럭스 트윈룸',64100);
Insert into TRIP2REAP.ROOM (ROOM_NO,BO_NO,ROOM_TYPE,ROOM_NAME,PRICE_PER_DAY) values ( SEQ_ROOM_NO.NEXTVAL , SEQ_BO_NO.CURRVAL ,'스탠다드룸','스탠다드 더블룸',65000);
Insert into TRIP2REAP.ROOM (ROOM_NO,BO_NO,ROOM_TYPE,ROOM_NAME,PRICE_PER_DAY) values ( SEQ_ROOM_NO.NEXTVAL , SEQ_BO_NO.CURRVAL ,'더블룸','스탠다드 더블룸',65000);

-------24
Insert into TRIP2REAP.BOARD (BO_NO,CA_CODE,BO_TITLE,BO_CONTENT,MEMBER_ID,BO_COUNT,BO_TAG,BO_DELETE_YN,REGDATE) values (SEQ_BO_NO.NEXTVAL ,5,'롯데시티 호텔 명동','롯데시티호텔 명동 - <4성급:한국관광공사 인증> - 롯데시티호텔 명동은 명동과 청계천 사이에 위치하고 있어 뛰어난 입지 조건을 자랑합니다. 도보 단 3분 거리에 을지로3가역 1번 출구가 위치해 있습니다. 가까운 거리에 롯데 백화점, 영플라자, 명동이 있어 쇼핑을 즐기시기에 편리합니다. 지상 27층 규모의 이 프리미엄 비즈니스 호텔에는 비즈니스 코너, 미팅룸, 피트니스 등 비즈니스 고객님을 위한 다양한 시설이 마련되어 있습니다. 또한, 24시간 운영되는 코인 세탁실이 있으며 편의점과 간단한 음료를 마실 수 있는 벤딩 라운지도 있습니다. 또한, 총 65대 수용이 가능한 내부 주차장이 있으며, 만차 시 인근 유료 주차장을 이용하실 수 있습니다. 전체 430개의 객실에서는 스마트폰으로 객실 제어가 가능한 스마트 통합 솔루션을 이용하실 수 있습니다. 모던한 느낌의 객실에서는 HD TV, 금고, 냉장고 등이 마련되어 있으며 유/무선 인터넷을 무료로 사용하실 수 있습니다. 27층에 위치한 C''Cafe에서는 명동과 청계천 조망을 내려다보며 올데이 다이닝을 즐기실 수 있습니다. 2층에 마련된 프리미엄 중동 레스토랑, 샤프란(Saffron)에서는 중동의 신비로운 다이닝 분위기와 함께 전통 할랄 요리를 선보입니다.','admin',0,'롯데시티명동, 명동4성급호텔','N',to_date('20/12/10','RR/MM/DD'));
Insert into TRIP2REAP.HOTEL (BO_NO,HOTEL_ADDRESS,HOTEL_LOCAL_CODE,HOTEL_SITE,HOTEL_TEL,HOTEL_REVIEW_SCORE,HOTEL_RANK,HOTEL_OPEN_TIME,HOTEL_CLOSE_TIME,HOTEL_OPTION,CHECK_IN,CHECK_OUT) 
values ( SEQ_BO_NO.CURRVAL ,'서울 중구 삼일대로 362',9,'https://www.lottehotel.com/myeongdong-city/ko.html','02-6112-1000',0,4,0,23,'와이파이, 조식, 레스토랑, 세탁, 24시간 리셉션, 수하물 보관, 피트니스, 카페, 비즈니스 시설, 주차, 장애인 편의시설, 주방',15,12);
Insert into TRIP2REAP.IMG_FILE (FILE_NO,BO_NO,ORIGIN_NAME,CHANGE_NAME,FILE_LEVEL,FILE_PATH,FILE_DELETE_YN) values (SEQ_FILE_NO.NEXTVAL , SEQ_BO_NO.CURRVAL ,'롯데시티명동썸네일.jpeg','hotel_thumbnail_202012102125410927.jpeg',1,'/Users/ek/Documents/GitHub/Spring-Project-Trip2Reap/Spring-Final-Trip2Reap/src/main/webapp/resources/buploadFiles/hotel_thumbnail_202012102125410927.jpeg','N');
Insert into TRIP2REAP.IMG_FILE (FILE_NO,BO_NO,ORIGIN_NAME,CHANGE_NAME,FILE_LEVEL,FILE_PATH,FILE_DELETE_YN) values (SEQ_FILE_NO.NEXTVAL , SEQ_BO_NO.CURRVAL ,'롯데시티명동디테일1.jpeg','hotel_detail_202012102125410935.jpeg',2,'/Users/ek/Documents/GitHub/Spring-Project-Trip2Reap/Spring-Final-Trip2Reap/src/main/webapp/resources/buploadFiles/hotel_detail_202012102125410935.jpeg','N');
Insert into TRIP2REAP.IMG_FILE (FILE_NO,BO_NO,ORIGIN_NAME,CHANGE_NAME,FILE_LEVEL,FILE_PATH,FILE_DELETE_YN) values (SEQ_FILE_NO.NEXTVAL , SEQ_BO_NO.CURRVAL ,'롯데시티명동디테일2.jpeg','hotel_detail_202012102125410943.jpeg',2,'/Users/ek/Documents/GitHub/Spring-Project-Trip2Reap/Spring-Final-Trip2Reap/src/main/webapp/resources/buploadFiles/hotel_detail_202012102125410943.jpeg','N');
Insert into TRIP2REAP.IMG_FILE (FILE_NO,BO_NO,ORIGIN_NAME,CHANGE_NAME,FILE_LEVEL,FILE_PATH,FILE_DELETE_YN) values (SEQ_FILE_NO.NEXTVAL , SEQ_BO_NO.CURRVAL ,'롯데시티명동디테일3.jpeg','hotel_detail_202012102125410952.jpeg',2,'/Users/ek/Documents/GitHub/Spring-Project-Trip2Reap/Spring-Final-Trip2Reap/src/main/webapp/resources/buploadFiles/hotel_detail_202012102125410952.jpeg','N');
Insert into TRIP2REAP.IMG_FILE (FILE_NO,BO_NO,ORIGIN_NAME,CHANGE_NAME,FILE_LEVEL,FILE_PATH,FILE_DELETE_YN) values (SEQ_FILE_NO.NEXTVAL , SEQ_BO_NO.CURRVAL ,'롯데시티명동디테일4.jpeg','hotel_detail_202012102125410959.jpeg',2,'/Users/ek/Documents/GitHub/Spring-Project-Trip2Reap/Spring-Final-Trip2Reap/src/main/webapp/resources/buploadFiles/hotel_detail_202012102125410959.jpeg','N');
Insert into TRIP2REAP.IMG_FILE (FILE_NO,BO_NO,ORIGIN_NAME,CHANGE_NAME,FILE_LEVEL,FILE_PATH,FILE_DELETE_YN) values (SEQ_FILE_NO.NEXTVAL , SEQ_BO_NO.CURRVAL ,'롯데시티명동디테일5.jpeg','hotel_detail_202012102125410967.jpeg',2,'/Users/ek/Documents/GitHub/Spring-Project-Trip2Reap/Spring-Final-Trip2Reap/src/main/webapp/resources/buploadFiles/hotel_detail_202012102125410967.jpeg','N');
Insert into TRIP2REAP.IMG_FILE (FILE_NO,BO_NO,ORIGIN_NAME,CHANGE_NAME,FILE_LEVEL,FILE_PATH,FILE_DELETE_YN) values (SEQ_FILE_NO.NEXTVAL , SEQ_BO_NO.CURRVAL ,'롯데시티명동썸네일.jpeg','hotel_detail_202012102125410975.jpeg',2,'/Users/ek/Documents/GitHub/Spring-Project-Trip2Reap/Spring-Final-Trip2Reap/src/main/webapp/resources/buploadFiles/hotel_detail_202012102125410975.jpeg','N');

Insert into TRIP2REAP.ROOM (ROOM_NO,BO_NO,ROOM_TYPE,ROOM_NAME,PRICE_PER_DAY) values ( SEQ_ROOM_NO.NEXTVAL , SEQ_BO_NO.CURRVAL ,'스탠다드룸','스탠다드 더블룸 - 와이파이포함, 피트니스 센터이용가능',76000);
Insert into TRIP2REAP.ROOM (ROOM_NO,BO_NO,ROOM_TYPE,ROOM_NAME,PRICE_PER_DAY) values ( SEQ_ROOM_NO.NEXTVAL , SEQ_BO_NO.CURRVAL ,'더블룸','스탠다드 더블룸 - 와이파이포함, 피트니스센터 이용가능',76000);
Insert into TRIP2REAP.ROOM (ROOM_NO,BO_NO,ROOM_TYPE,ROOM_NAME,PRICE_PER_DAY) values ( SEQ_ROOM_NO.NEXTVAL , SEQ_BO_NO.CURRVAL ,'트윈룸','수페리어 트윈룸',76000);
Insert into TRIP2REAP.ROOM (ROOM_NO,BO_NO,ROOM_TYPE,ROOM_NAME,PRICE_PER_DAY) values ( SEQ_ROOM_NO.NEXTVAL , SEQ_BO_NO.CURRVAL ,'슈페리어룸','수페리어 트윈룸',76000);
Insert into TRIP2REAP.ROOM (ROOM_NO,BO_NO,ROOM_TYPE,ROOM_NAME,PRICE_PER_DAY) values ( SEQ_ROOM_NO.NEXTVAL , SEQ_BO_NO.CURRVAL ,'더블룸','수페리어 더블룸',85500);
Insert into TRIP2REAP.ROOM (ROOM_NO,BO_NO,ROOM_TYPE,ROOM_NAME,PRICE_PER_DAY) values ( SEQ_ROOM_NO.NEXTVAL , SEQ_BO_NO.CURRVAL ,'슈페리어룸','수페리어 더블룸',85500);

-------25
Insert into TRIP2REAP.BOARD (BO_NO,CA_CODE,BO_TITLE,BO_CONTENT,MEMBER_ID,BO_COUNT,BO_TAG,BO_DELETE_YN,REGDATE) values (SEQ_BO_NO.NEXTVAL ,5,'신라스테이 서초','2017년 오픈한 신라스테이 서초는 강남역 5번 출구에서 걸어서 약 10분 거리에 있고, 인천국제공항으로 갈 수 있는 도심공항터미널까지 차로 약 15분 소요됩니다. 전시와 공연을 즐길 수 있는 예술의 전당이 차로 약 10분, 명품샵이 즐비한 압구정 로데오 거리는 차로 약 20분 거리에 있습니다. 호텔 내에는 주차장, 비즈니스 코너, 피트니스 센터, 회의실 등의 편의시설이 마련되어 있습니다. 투숙객들은 머무는 동안 미팅룸을 제외한 주차장, 비즈니스 코너, 피트니스 센터를 무료로 이용할 수 있습니다. 총 305개의 객실은 스탠다드, 디럭스, 그랜드 등으로 다양하게 구성되어 있으며, 객실 내에는 냉장고, 개인금고, 전화기, 냉난방 장치, 목욕용품, 헤어드라이어, 목욕가운 등이 갖춰져 있습니다. 호텔 3층에 자리한 캐주얼 레스토랑에서는 조식과 중식 뷔페를 즐길 수 있으며, 1층 라운지 바에서는 고급스러운 분위기에서 휴식을 취할 수 있습니다.','admin',5,'신라스테이','N',to_date('20/12/10','RR/MM/DD'));
Insert into TRIP2REAP.HOTEL (BO_NO,HOTEL_ADDRESS,HOTEL_LOCAL_CODE,HOTEL_SITE,HOTEL_TEL,HOTEL_REVIEW_SCORE,HOTEL_RANK,HOTEL_OPEN_TIME,HOTEL_CLOSE_TIME,HOTEL_OPTION,CHECK_IN,CHECK_OUT) 
values ( SEQ_BO_NO.CURRVAL ,'서울 서초구 효령로 427',9,'https://shillastay.com/seocho/index.do','02-2219-9000',0,3,0,23,'와이파이, 조식, 레스토랑, 세탁, 24시간 리셉션, 수하물 보관, 피트니스, 주차, 장애인 편의시설, 주방',15,12);

Insert into TRIP2REAP.IMG_FILE (FILE_NO,BO_NO,ORIGIN_NAME,CHANGE_NAME,FILE_LEVEL,FILE_PATH,FILE_DELETE_YN) values (SEQ_FILE_NO.NEXTVAL , SEQ_BO_NO.CURRVAL ,'신라스테이서초썸네일.jpeg','hotel_thumbnail_202012102148380313.jpeg',1,'/Users/ek/Documents/GitHub/Spring-Project-Trip2Reap/Spring-Final-Trip2Reap/src/main/webapp/resources/buploadFiles/hotel_thumbnail_202012102148380313.jpeg','N');
Insert into TRIP2REAP.IMG_FILE (FILE_NO,BO_NO,ORIGIN_NAME,CHANGE_NAME,FILE_LEVEL,FILE_PATH,FILE_DELETE_YN) values (SEQ_FILE_NO.NEXTVAL , SEQ_BO_NO.CURRVAL ,'신라스테이서초디테일1.jpeg','hotel_detail_202012102148380329.jpeg',2,'/Users/ek/Documents/GitHub/Spring-Project-Trip2Reap/Spring-Final-Trip2Reap/src/main/webapp/resources/buploadFiles/hotel_detail_202012102148380329.jpeg','N');
Insert into TRIP2REAP.IMG_FILE (FILE_NO,BO_NO,ORIGIN_NAME,CHANGE_NAME,FILE_LEVEL,FILE_PATH,FILE_DELETE_YN) values (SEQ_FILE_NO.NEXTVAL , SEQ_BO_NO.CURRVAL ,'신라스테이서초디테일2.jpeg','hotel_detail_202012102148380337.jpeg',2,'/Users/ek/Documents/GitHub/Spring-Project-Trip2Reap/Spring-Final-Trip2Reap/src/main/webapp/resources/buploadFiles/hotel_detail_202012102148380337.jpeg','N');
Insert into TRIP2REAP.IMG_FILE (FILE_NO,BO_NO,ORIGIN_NAME,CHANGE_NAME,FILE_LEVEL,FILE_PATH,FILE_DELETE_YN) values (SEQ_FILE_NO.NEXTVAL , SEQ_BO_NO.CURRVAL ,'신라스테이서초디테일3.jpeg','hotel_detail_202012102148380346.jpeg',2,'/Users/ek/Documents/GitHub/Spring-Project-Trip2Reap/Spring-Final-Trip2Reap/src/main/webapp/resources/buploadFiles/hotel_detail_202012102148380346.jpeg','N');
Insert into TRIP2REAP.IMG_FILE (FILE_NO,BO_NO,ORIGIN_NAME,CHANGE_NAME,FILE_LEVEL,FILE_PATH,FILE_DELETE_YN) values (SEQ_FILE_NO.NEXTVAL , SEQ_BO_NO.CURRVAL ,'신라스테이서초디테일4.jpeg','hotel_detail_202012102148380352.jpeg',2,'/Users/ek/Documents/GitHub/Spring-Project-Trip2Reap/Spring-Final-Trip2Reap/src/main/webapp/resources/buploadFiles/hotel_detail_202012102148380352.jpeg','N');
Insert into TRIP2REAP.IMG_FILE (FILE_NO,BO_NO,ORIGIN_NAME,CHANGE_NAME,FILE_LEVEL,FILE_PATH,FILE_DELETE_YN) values (SEQ_FILE_NO.NEXTVAL , SEQ_BO_NO.CURRVAL ,'신라스테이서초디테일5.jpeg','hotel_detail_202012102148380363.jpeg',2,'/Users/ek/Documents/GitHub/Spring-Project-Trip2Reap/Spring-Final-Trip2Reap/src/main/webapp/resources/buploadFiles/hotel_detail_202012102148380363.jpeg','N');
Insert into TRIP2REAP.IMG_FILE (FILE_NO,BO_NO,ORIGIN_NAME,CHANGE_NAME,FILE_LEVEL,FILE_PATH,FILE_DELETE_YN) values (SEQ_FILE_NO.NEXTVAL , SEQ_BO_NO.CURRVAL ,'신라스테이서초디테일6.jpeg','hotel_detail_202012102148380370.jpeg',2,'/Users/ek/Documents/GitHub/Spring-Project-Trip2Reap/Spring-Final-Trip2Reap/src/main/webapp/resources/buploadFiles/hotel_detail_202012102148380370.jpeg','N');
Insert into TRIP2REAP.IMG_FILE (FILE_NO,BO_NO,ORIGIN_NAME,CHANGE_NAME,FILE_LEVEL,FILE_PATH,FILE_DELETE_YN) values (SEQ_FILE_NO.NEXTVAL , SEQ_BO_NO.CURRVAL ,'신라스테이서초디테일7.jpeg','hotel_detail_202012102148380380.jpeg',2,'/Users/ek/Documents/GitHub/Spring-Project-Trip2Reap/Spring-Final-Trip2Reap/src/main/webapp/resources/buploadFiles/hotel_detail_202012102148380380.jpeg','N');
Insert into TRIP2REAP.IMG_FILE (FILE_NO,BO_NO,ORIGIN_NAME,CHANGE_NAME,FILE_LEVEL,FILE_PATH,FILE_DELETE_YN) values (SEQ_FILE_NO.NEXTVAL , SEQ_BO_NO.CURRVAL ,'신라스테이서초디테일8.jpeg','hotel_detail_202012102148380388.jpeg',2,'/Users/ek/Documents/GitHub/Spring-Project-Trip2Reap/Spring-Final-Trip2Reap/src/main/webapp/resources/buploadFiles/hotel_detail_202012102148380388.jpeg','N');
Insert into TRIP2REAP.IMG_FILE (FILE_NO,BO_NO,ORIGIN_NAME,CHANGE_NAME,FILE_LEVEL,FILE_PATH,FILE_DELETE_YN) values (SEQ_FILE_NO.NEXTVAL , SEQ_BO_NO.CURRVAL ,'신라스테이서초썸네일.jpeg','hotel_detail_202012102148380396.jpeg',2,'/Users/ek/Documents/GitHub/Spring-Project-Trip2Reap/Spring-Final-Trip2Reap/src/main/webapp/resources/buploadFiles/hotel_detail_202012102148380396.jpeg','N');

Insert into TRIP2REAP.ROOM (ROOM_NO,BO_NO,ROOM_TYPE,ROOM_NAME,PRICE_PER_DAY) values ( SEQ_ROOM_NO.NEXTVAL , SEQ_BO_NO.CURRVAL ,'스탠다드룸','스탠다드룸 - 무료wifi',71900);
Insert into TRIP2REAP.ROOM (ROOM_NO,BO_NO,ROOM_TYPE,ROOM_NAME,PRICE_PER_DAY) values ( SEQ_ROOM_NO.NEXTVAL , SEQ_BO_NO.CURRVAL ,'스탠다드룸','스탠다드 트윈룸',74200);
Insert into TRIP2REAP.ROOM (ROOM_NO,BO_NO,ROOM_TYPE,ROOM_NAME,PRICE_PER_DAY) values ( SEQ_ROOM_NO.NEXTVAL , SEQ_BO_NO.CURRVAL ,'트윈룸','스탠다드 트윈룸',74200);
Insert into TRIP2REAP.ROOM (ROOM_NO,BO_NO,ROOM_TYPE,ROOM_NAME,PRICE_PER_DAY) values ( SEQ_ROOM_NO.NEXTVAL , SEQ_BO_NO.CURRVAL ,'스탠다드룸','스탠다드 더블룸',74200);
Insert into TRIP2REAP.ROOM (ROOM_NO,BO_NO,ROOM_TYPE,ROOM_NAME,PRICE_PER_DAY) values ( SEQ_ROOM_NO.NEXTVAL , SEQ_BO_NO.CURRVAL ,'더블룸','스탠다드 더블룸',74200);
Insert into TRIP2REAP.ROOM (ROOM_NO,BO_NO,ROOM_TYPE,ROOM_NAME,PRICE_PER_DAY) values ( SEQ_ROOM_NO.NEXTVAL , SEQ_BO_NO.CURRVAL ,'더블룸','디럭스 더블룸',74200);
Insert into TRIP2REAP.ROOM (ROOM_NO,BO_NO,ROOM_TYPE,ROOM_NAME,PRICE_PER_DAY) values ( SEQ_ROOM_NO.NEXTVAL , SEQ_BO_NO.CURRVAL ,'디럭스룸','디럭스 더블룸',74200);

-------26
Insert into TRIP2REAP.BOARD (BO_NO,CA_CODE,BO_TITLE,BO_CONTENT,MEMBER_ID,BO_COUNT,BO_TAG,BO_DELETE_YN,REGDATE) values (SEQ_BO_NO.NEXTVAL ,5,'글래드 여의도','글래드 호텔 여의도 - <4성급:한국관광공사 인증> - KBS 방송국 바로 옆에 있는 글래드 호텔 여의도는 9호선 국회의사당역 4번 출구에서 도보 1분 거리에 있습니다. 여의도 공원은 도보로 5분 거리에 있으며 걸어서 15분이면 IFC 몰에 도착하실 수 있습니다. 차로 15분이면 63빌딩과 한강 유람선 선착장에 도착하실 수 있습니다. 2층에 마련된 크리에이티브 라운지에는 PC, 스캐너, 레이저 프린터 등 다양한 비즈니스 시설이 구비되어 있으며 24시간 이용 가능합니다. 또한, 피트니스 센터에서도 24시간 무료로 운동을 하실 수 있습니다. 뿐만 아니라, 무료 주차장도 이용하실 수 있습니다. 전체 319개의 객실이 있으며 스탠다드부터 글래드 하우스까지 9가지 유형의 다양한 객실이 준비되어 있습니다. 블랙 앤 화이트의 깔끔한 인테리어의 객실 내에는 최고급 침구, 블루투스 스피커, LED TV가 마련되어 있으며 다양한 종류의 베개 중에 선택하실 수 있습니다. 또한 욕실 내에는 비데, 코튼 목욕 가운 등이 있으며 로비 층에 위치한 Greets에서는 7개의 라이브 스테이션에서 준비되는 뷔페와 한식 중식, 일식, 양식 단품 요리를 맛보실 수 있으며 영화 <킹스맨> 컨셉의 국내 최고 수준의 싱글 몰트 스카치 위스키를 보유한 BLACK BAR가 있습니다.','admin',0,'글래드여의도, 글래드호텔, 여의도4성급호텔','N',to_date('20/12/10','RR/MM/DD'));
Insert into TRIP2REAP.HOTEL (BO_NO,HOTEL_ADDRESS,HOTEL_LOCAL_CODE,HOTEL_SITE,HOTEL_TEL,HOTEL_REVIEW_SCORE,HOTEL_RANK,HOTEL_OPEN_TIME,HOTEL_CLOSE_TIME,HOTEL_OPTION,CHECK_IN,CHECK_OUT) 
values ( SEQ_BO_NO.CURRVAL ,'서울 영등포구 의사당대로 16',9,'https://gladyeouido-hotels.com/','02-6222-5000',0,4,11,18,'와이파이, 조식, 레스토랑, 세탁, 24시간 리셉션, 수하물 보관, 피트니스, 비즈니스 시설, 주차, 주방, 룸서비스',13,10);

Insert into TRIP2REAP.IMG_FILE (FILE_NO,BO_NO,ORIGIN_NAME,CHANGE_NAME,FILE_LEVEL,FILE_PATH,FILE_DELETE_YN) values (SEQ_FILE_NO.NEXTVAL , SEQ_BO_NO.CURRVAL ,'글래드여의도썸네일.jpeg','hotel_thumbnail_202012102206350716.jpeg',1,'/Users/ek/Documents/GitHub/Spring-Project-Trip2Reap/Spring-Final-Trip2Reap/src/main/webapp/resources/buploadFiles/hotel_thumbnail_202012102206350716.jpeg','N');
Insert into TRIP2REAP.IMG_FILE (FILE_NO,BO_NO,ORIGIN_NAME,CHANGE_NAME,FILE_LEVEL,FILE_PATH,FILE_DELETE_YN) values (SEQ_FILE_NO.NEXTVAL , SEQ_BO_NO.CURRVAL ,'글래드여의도디테일1.jpeg','hotel_detail_202012102206350728.jpeg',2,'/Users/ek/Documents/GitHub/Spring-Project-Trip2Reap/Spring-Final-Trip2Reap/src/main/webapp/resources/buploadFiles/hotel_detail_202012102206350728.jpeg','N');
Insert into TRIP2REAP.IMG_FILE (FILE_NO,BO_NO,ORIGIN_NAME,CHANGE_NAME,FILE_LEVEL,FILE_PATH,FILE_DELETE_YN) values (SEQ_FILE_NO.NEXTVAL , SEQ_BO_NO.CURRVAL ,'글래드여의도디테일2.jpeg','hotel_detail_202012102206350737.jpeg',2,'/Users/ek/Documents/GitHub/Spring-Project-Trip2Reap/Spring-Final-Trip2Reap/src/main/webapp/resources/buploadFiles/hotel_detail_202012102206350737.jpeg','N');
Insert into TRIP2REAP.IMG_FILE (FILE_NO,BO_NO,ORIGIN_NAME,CHANGE_NAME,FILE_LEVEL,FILE_PATH,FILE_DELETE_YN) values (SEQ_FILE_NO.NEXTVAL , SEQ_BO_NO.CURRVAL ,'글래드여의도디테일3.jpeg','hotel_detail_202012102206350748.jpeg',2,'/Users/ek/Documents/GitHub/Spring-Project-Trip2Reap/Spring-Final-Trip2Reap/src/main/webapp/resources/buploadFiles/hotel_detail_202012102206350748.jpeg','N');
Insert into TRIP2REAP.IMG_FILE (FILE_NO,BO_NO,ORIGIN_NAME,CHANGE_NAME,FILE_LEVEL,FILE_PATH,FILE_DELETE_YN) values (SEQ_FILE_NO.NEXTVAL , SEQ_BO_NO.CURRVAL ,'글래드여의도디테일4.jpeg','hotel_detail_202012102206350759.jpeg',2,'/Users/ek/Documents/GitHub/Spring-Project-Trip2Reap/Spring-Final-Trip2Reap/src/main/webapp/resources/buploadFiles/hotel_detail_202012102206350759.jpeg','N');
Insert into TRIP2REAP.IMG_FILE (FILE_NO,BO_NO,ORIGIN_NAME,CHANGE_NAME,FILE_LEVEL,FILE_PATH,FILE_DELETE_YN) values (SEQ_FILE_NO.NEXTVAL , SEQ_BO_NO.CURRVAL ,'글래드여의도디테일5.jpeg','hotel_detail_202012102206350768.jpeg',2,'/Users/ek/Documents/GitHub/Spring-Project-Trip2Reap/Spring-Final-Trip2Reap/src/main/webapp/resources/buploadFiles/hotel_detail_202012102206350768.jpeg','N');
Insert into TRIP2REAP.IMG_FILE (FILE_NO,BO_NO,ORIGIN_NAME,CHANGE_NAME,FILE_LEVEL,FILE_PATH,FILE_DELETE_YN) values (SEQ_FILE_NO.NEXTVAL , SEQ_BO_NO.CURRVAL ,'글래드여의도썸네일.jpeg','hotel_detail_202012102206350783.jpeg',2,'/Users/ek/Documents/GitHub/Spring-Project-Trip2Reap/Spring-Final-Trip2Reap/src/main/webapp/resources/buploadFiles/hotel_detail_202012102206350783.jpeg','N');

Insert into TRIP2REAP.ROOM (ROOM_NO,BO_NO,ROOM_TYPE,ROOM_NAME,PRICE_PER_DAY) values ( SEQ_ROOM_NO.NEXTVAL , SEQ_BO_NO.CURRVAL ,'디럭스룸','디럭스 트윈룸 - 와이파이 포함,피트니스 이용가능',70000);
Insert into TRIP2REAP.ROOM (ROOM_NO,BO_NO,ROOM_TYPE,ROOM_NAME,PRICE_PER_DAY) values ( SEQ_ROOM_NO.NEXTVAL , SEQ_BO_NO.CURRVAL ,'트윈룸','디럭스 트윈룸- 와이파이 포함,피트니스 이용가능',70000);
Insert into TRIP2REAP.ROOM (ROOM_NO,BO_NO,ROOM_TYPE,ROOM_NAME,PRICE_PER_DAY) values ( SEQ_ROOM_NO.NEXTVAL , SEQ_BO_NO.CURRVAL ,'더블룸','스탠다드 더블룸',70000);
Insert into TRIP2REAP.ROOM (ROOM_NO,BO_NO,ROOM_TYPE,ROOM_NAME,PRICE_PER_DAY) values ( SEQ_ROOM_NO.NEXTVAL , SEQ_BO_NO.CURRVAL ,'스탠다드룸','스탠다드 더블룸',70000);
Insert into TRIP2REAP.ROOM (ROOM_NO,BO_NO,ROOM_TYPE,ROOM_NAME,PRICE_PER_DAY) values ( SEQ_ROOM_NO.NEXTVAL , SEQ_BO_NO.CURRVAL ,'디럭스룸','디럭스 더블룸',90000);
Insert into TRIP2REAP.ROOM (ROOM_NO,BO_NO,ROOM_TYPE,ROOM_NAME,PRICE_PER_DAY) values ( SEQ_ROOM_NO.NEXTVAL , SEQ_BO_NO.CURRVAL ,'더블룸','디럭스 더블룸',90000);

------27
Insert into TRIP2REAP.BOARD (BO_NO,CA_CODE,BO_TITLE,BO_CONTENT,MEMBER_ID,BO_COUNT,BO_TAG,BO_DELETE_YN,REGDATE) values (SEQ_BO_NO.NEXTVAL ,5,'글래드 강남 코엑스센터','글래드 강남 코엑스센터 - <3성급:한국관광공사 인증> - 글래드 강남 코엑스센터는 지하철 2호선 삼성역 1번 출구에서 도보로 단 1분 거리에 위치해 있습니다. 주변 관광지로는 코엑스몰과 무역센터가 도보로 10분 거리에 있습니다. 또한 압구정 로데오거리까지는 차로 15분이면 가실 수 있으며, 신사동 가로수길까지는 차로 약 20분이 소요됩니다. 호텔 건물 지하 2층에는 미팅룸과 피트니스 센터가 갖춰져 있습니다. 1층에는 비즈니스 라운지가 마련되어 있어 편리하게 업무도 보실 수 있습니다. 객실은 총 282개로 구성되어 있으며, 42인치 LED TV와 개인 금고, 멀티 아울렛 등의 설비가 갖춰져 있습니다. 모든 객실에는 유무선 인터넷이 제공되며, 비데와 스파 어매니티, 생수, 커피와 티도 구비되어 있습니다. 호텔 1층에는 이탈리아 대표 커피 브랜드 ''세가프레도'', 그리고 지하 1층에는 컨템포러리 유러피안 다이닝 ''레스토랑 G'', 지하 2층에는 제철 식재료를 사용한 프리미엄 ''뷔페 G'' 가 있습니다.','admin',2,'GLAD, 글래드강남코엑스, 강남역호텔','N',to_date('20/12/10','RR/MM/DD'));
Insert into TRIP2REAP.HOTEL (BO_NO,HOTEL_ADDRESS,HOTEL_LOCAL_CODE,HOTEL_SITE,HOTEL_TEL,HOTEL_REVIEW_SCORE,HOTEL_RANK,HOTEL_OPEN_TIME,HOTEL_CLOSE_TIME,HOTEL_OPTION,CHECK_IN,CHECK_OUT) values ( SEQ_BO_NO.CURRVAL ,'서울 강남구 테헤란로 610',9,'https://www.gladgangnamcoex-hotels.com/','02-6474-5000',0,3,0,23,'와이파이, 조식, 레스토랑, 세탁, 24시간 리셉션, 수하물 보관, 피트니스, 비즈니스 시설, 주차, 주방',15,12);

Insert into TRIP2REAP.IMG_FILE (FILE_NO,BO_NO,ORIGIN_NAME,CHANGE_NAME,FILE_LEVEL,FILE_PATH,FILE_DELETE_YN) values (SEQ_FILE_NO.NEXTVAL , SEQ_BO_NO.CURRVAL ,'글래드강남코엑스썸네일.jpeg','hotel_thumbnail_202012102214030888.jpeg',1,'/Users/ek/Documents/GitHub/Spring-Project-Trip2Reap/Spring-Final-Trip2Reap/src/main/webapp/resources/buploadFiles/hotel_thumbnail_202012102214030888.jpeg','N');
Insert into TRIP2REAP.IMG_FILE (FILE_NO,BO_NO,ORIGIN_NAME,CHANGE_NAME,FILE_LEVEL,FILE_PATH,FILE_DELETE_YN) values (SEQ_FILE_NO.NEXTVAL , SEQ_BO_NO.CURRVAL ,'글래드강남코엑스디테일1.jpeg','hotel_detail_202012102214030899.jpeg',2,'/Users/ek/Documents/GitHub/Spring-Project-Trip2Reap/Spring-Final-Trip2Reap/src/main/webapp/resources/buploadFiles/hotel_detail_202012102214030899.jpeg','N');
Insert into TRIP2REAP.IMG_FILE (FILE_NO,BO_NO,ORIGIN_NAME,CHANGE_NAME,FILE_LEVEL,FILE_PATH,FILE_DELETE_YN) values (SEQ_FILE_NO.NEXTVAL , SEQ_BO_NO.CURRVAL ,'글래드강남코엑스디테일2.jpeg','hotel_detail_202012102214030930.jpeg',2,'/Users/ek/Documents/GitHub/Spring-Project-Trip2Reap/Spring-Final-Trip2Reap/src/main/webapp/resources/buploadFiles/hotel_detail_202012102214030930.jpeg','N');
Insert into TRIP2REAP.IMG_FILE (FILE_NO,BO_NO,ORIGIN_NAME,CHANGE_NAME,FILE_LEVEL,FILE_PATH,FILE_DELETE_YN) values (SEQ_FILE_NO.NEXTVAL , SEQ_BO_NO.CURRVAL ,'글래드강남코엑스디테일3.jpeg','hotel_detail_202012102214030947.jpeg',2,'/Users/ek/Documents/GitHub/Spring-Project-Trip2Reap/Spring-Final-Trip2Reap/src/main/webapp/resources/buploadFiles/hotel_detail_202012102214030947.jpeg','N');
Insert into TRIP2REAP.IMG_FILE (FILE_NO,BO_NO,ORIGIN_NAME,CHANGE_NAME,FILE_LEVEL,FILE_PATH,FILE_DELETE_YN) values (SEQ_FILE_NO.NEXTVAL , SEQ_BO_NO.CURRVAL ,'글래드강남코엑스디테일4.jpeg','hotel_detail_202012102214030957.jpeg',2,'/Users/ek/Documents/GitHub/Spring-Project-Trip2Reap/Spring-Final-Trip2Reap/src/main/webapp/resources/buploadFiles/hotel_detail_202012102214030957.jpeg','N');
Insert into TRIP2REAP.IMG_FILE (FILE_NO,BO_NO,ORIGIN_NAME,CHANGE_NAME,FILE_LEVEL,FILE_PATH,FILE_DELETE_YN) values (SEQ_FILE_NO.NEXTVAL , SEQ_BO_NO.CURRVAL ,'글래드강남코엑스디테일5.jpeg','hotel_detail_202012102214030967.jpeg',2,'/Users/ek/Documents/GitHub/Spring-Project-Trip2Reap/Spring-Final-Trip2Reap/src/main/webapp/resources/buploadFiles/hotel_detail_202012102214030967.jpeg','N');
Insert into TRIP2REAP.IMG_FILE (FILE_NO,BO_NO,ORIGIN_NAME,CHANGE_NAME,FILE_LEVEL,FILE_PATH,FILE_DELETE_YN) values (SEQ_FILE_NO.NEXTVAL , SEQ_BO_NO.CURRVAL ,'글래드강남코엑스썸네일.jpeg','hotel_detail_202012102214030980.jpeg',2,'/Users/ek/Documents/GitHub/Spring-Project-Trip2Reap/Spring-Final-Trip2Reap/src/main/webapp/resources/buploadFiles/hotel_detail_202012102214030980.jpeg','N');

Insert into TRIP2REAP.ROOM (ROOM_NO,BO_NO,ROOM_TYPE,ROOM_NAME,PRICE_PER_DAY) values ( SEQ_ROOM_NO.NEXTVAL , SEQ_BO_NO.CURRVAL ,'트윈룸','스탠다드 트윈룸 - 무료와이파이',72000);
Insert into TRIP2REAP.ROOM (ROOM_NO,BO_NO,ROOM_TYPE,ROOM_NAME,PRICE_PER_DAY) values ( SEQ_ROOM_NO.NEXTVAL , SEQ_BO_NO.CURRVAL ,'스탠다드룸','스탠다드 트윈룸- 무료와이파이',72000);
Insert into TRIP2REAP.ROOM (ROOM_NO,BO_NO,ROOM_TYPE,ROOM_NAME,PRICE_PER_DAY) values ( SEQ_ROOM_NO.NEXTVAL , SEQ_BO_NO.CURRVAL ,'스탠다드룸','스탠다드 더블룸',85000);
Insert into TRIP2REAP.ROOM (ROOM_NO,BO_NO,ROOM_TYPE,ROOM_NAME,PRICE_PER_DAY) values ( SEQ_ROOM_NO.NEXTVAL , SEQ_BO_NO.CURRVAL ,'더블룸','스탠다드 더블룸',85000);
Insert into TRIP2REAP.ROOM (ROOM_NO,BO_NO,ROOM_TYPE,ROOM_NAME,PRICE_PER_DAY) values ( SEQ_ROOM_NO.NEXTVAL , SEQ_BO_NO.CURRVAL ,'더블룸','수페리어 더블룸',114900);
Insert into TRIP2REAP.ROOM (ROOM_NO,BO_NO,ROOM_TYPE,ROOM_NAME,PRICE_PER_DAY) values ( SEQ_ROOM_NO.NEXTVAL , SEQ_BO_NO.CURRVAL ,'슈페리어룸','수페리어 더블룸',114900);
Insert into TRIP2REAP.ROOM (ROOM_NO,BO_NO,ROOM_TYPE,ROOM_NAME,PRICE_PER_DAY) values ( SEQ_ROOM_NO.NEXTVAL , SEQ_BO_NO.CURRVAL ,'트윈룸','디럭스 트윈룸',115000);
Insert into TRIP2REAP.ROOM (ROOM_NO,BO_NO,ROOM_TYPE,ROOM_NAME,PRICE_PER_DAY) values ( SEQ_ROOM_NO.NEXTVAL , SEQ_BO_NO.CURRVAL ,'디럭스룸','디럭스 트윈룸',115000);


------28
Insert into TRIP2REAP.BOARD (BO_NO,CA_CODE,BO_TITLE,BO_CONTENT,MEMBER_ID,BO_COUNT,BO_TAG,BO_DELETE_YN,REGDATE) values (SEQ_BO_NO.NEXTVAL ,5,'글래드마포','글래드 마포- <4성급:한국관광공사 인증> -군더더기 없는 실용성과 내 집 같은 편안함을 추구하는 글래드 마포는 종로, 명동, 홍대 같은 서울의 주요 관광지까지 차로 약 20분 거리에 위치해 있습니다. 또한 역세권에 위치하여 교통 역시 매우 편리합니다. 5호선과 6호선 공덕역 8번 출구, 경의 중앙선과 공항철도가 지나는 공덕역 9번 출구에서 도보로 1분이면 호텔에 오실 수 있습니다. 또한 지하철 5호선 마포역 3번 출구에서는 도보로 약 9분, 김포 공항에서는 차로 약 45분, 인천 공항에서는 약 60분 정도 소요됩니다. 호텔 내 편의 시설로는 최고급 운동기기를 구비한 24시간 피트니스 클럽, PC와 무선 인터넷, 스캐너, 레이저 프린터를 사용하거나 신문과 잡지를 읽을 수 있는 크리에이티브 라운지 (Creative Lounge), 그리고 편의점이 있습니다. 또는 프런트 데스크에서 환전, 가방 보관, 컨시어지 및 우편 서비스 등을 이용하실 수 있습니다. 모던하면서도 아늑한 인테리어로 꾸며진 총 378개의 객실에는 에어컨, 방음 시설이 갖춰져 있으며, 슬리퍼, 냉장고, 금고 또한 구비되어 있습니다. 전용 욕실에는 비데, 샤워 시설, 헤어드라이어, 목욕 가운 등이 비치되어 있습니다. 호텔 내에서 식사를 하실 경우 프리미엄 뷔페 Greets M에서 신선한 현지의 식재료들을 이용한 각양각색의 음식을 와인 또는 맥주와 맛보실 수 있습니다. 또한 낮에는 카페로 운영되고, 밤에는 분위기 있는 바로 운영되는 Segafredo cafe&bar를 이용하실 수 있습니다.','admin',1,'글래드호텔, GLAD, 글래드마포','N',to_date('20/12/10','RR/MM/DD'));
Insert into TRIP2REAP.HOTEL (BO_NO,HOTEL_ADDRESS,HOTEL_LOCAL_CODE,HOTEL_SITE,HOTEL_TEL,HOTEL_REVIEW_SCORE,HOTEL_RANK,HOTEL_OPEN_TIME,HOTEL_CLOSE_TIME,HOTEL_OPTION,CHECK_IN,CHECK_OUT) values ( SEQ_BO_NO.CURRVAL ,'서울 마포구 마포대로 92',9,'https://gladmapo-hotels.com/','02-2197-5000',0,4,11,21,'와이파이, 조식, 레스토랑, 세탁, 24시간 리셉션, 수하물 보관, 피트니스, 카페, 비즈니스 시설, 주차, 공항셔틀, 주방',13,12);

Insert into TRIP2REAP.IMG_FILE (FILE_NO,BO_NO,ORIGIN_NAME,CHANGE_NAME,FILE_LEVEL,FILE_PATH,FILE_DELETE_YN) values (SEQ_FILE_NO.NEXTVAL , SEQ_BO_NO.CURRVAL ,'썸네일.jpeg','hotel_thumbnail_202012102242520846.jpeg',1,'/Users/ek/Documents/GitHub/Spring-Project-Trip2Reap/Spring-Final-Trip2Reap/src/main/webapp/resources/buploadFiles/hotel_thumbnail_202012102242520846.jpeg','N');
Insert into TRIP2REAP.IMG_FILE (FILE_NO,BO_NO,ORIGIN_NAME,CHANGE_NAME,FILE_LEVEL,FILE_PATH,FILE_DELETE_YN) values (SEQ_FILE_NO.NEXTVAL , SEQ_BO_NO.CURRVAL ,'디테일1.jpeg','hotel_detail_202012102242520857.jpeg',2,'/Users/ek/Documents/GitHub/Spring-Project-Trip2Reap/Spring-Final-Trip2Reap/src/main/webapp/resources/buploadFiles/hotel_detail_202012102242520857.jpeg','N');
Insert into TRIP2REAP.IMG_FILE (FILE_NO,BO_NO,ORIGIN_NAME,CHANGE_NAME,FILE_LEVEL,FILE_PATH,FILE_DELETE_YN) values (SEQ_FILE_NO.NEXTVAL , SEQ_BO_NO.CURRVAL ,'디테일2.jpeg','hotel_detail_202012102242520878.jpeg',2,'/Users/ek/Documents/GitHub/Spring-Project-Trip2Reap/Spring-Final-Trip2Reap/src/main/webapp/resources/buploadFiles/hotel_detail_202012102242520878.jpeg','N');
Insert into TRIP2REAP.IMG_FILE (FILE_NO,BO_NO,ORIGIN_NAME,CHANGE_NAME,FILE_LEVEL,FILE_PATH,FILE_DELETE_YN) values (SEQ_FILE_NO.NEXTVAL , SEQ_BO_NO.CURRVAL ,'디테일3.jpeg','hotel_detail_202012102242520903.jpeg',2,'/Users/ek/Documents/GitHub/Spring-Project-Trip2Reap/Spring-Final-Trip2Reap/src/main/webapp/resources/buploadFiles/hotel_detail_202012102242520903.jpeg','N');
Insert into TRIP2REAP.IMG_FILE (FILE_NO,BO_NO,ORIGIN_NAME,CHANGE_NAME,FILE_LEVEL,FILE_PATH,FILE_DELETE_YN) values (SEQ_FILE_NO.NEXTVAL , SEQ_BO_NO.CURRVAL ,'디테일4.jpeg','hotel_detail_202012102242520928.jpeg',2,'/Users/ek/Documents/GitHub/Spring-Project-Trip2Reap/Spring-Final-Trip2Reap/src/main/webapp/resources/buploadFiles/hotel_detail_202012102242520928.jpeg','N');
Insert into TRIP2REAP.IMG_FILE (FILE_NO,BO_NO,ORIGIN_NAME,CHANGE_NAME,FILE_LEVEL,FILE_PATH,FILE_DELETE_YN) values (SEQ_FILE_NO.NEXTVAL , SEQ_BO_NO.CURRVAL ,'썸네일.jpeg','hotel_detail_202012102242520942.jpeg',2,'/Users/ek/Documents/GitHub/Spring-Project-Trip2Reap/Spring-Final-Trip2Reap/src/main/webapp/resources/buploadFiles/hotel_detail_202012102242520942.jpeg','N');


Insert into TRIP2REAP.ROOM (ROOM_NO,BO_NO,ROOM_TYPE,ROOM_NAME,PRICE_PER_DAY) values ( SEQ_ROOM_NO.NEXTVAL , SEQ_BO_NO.CURRVAL ,'더블룸','스탠다드 더블룸',60500);
Insert into TRIP2REAP.ROOM (ROOM_NO,BO_NO,ROOM_TYPE,ROOM_NAME,PRICE_PER_DAY) values ( SEQ_ROOM_NO.NEXTVAL , SEQ_BO_NO.CURRVAL ,'스탠다드룸','스탠다드 더블룸',60500);
Insert into TRIP2REAP.ROOM (ROOM_NO,BO_NO,ROOM_TYPE,ROOM_NAME,PRICE_PER_DAY) values ( SEQ_ROOM_NO.NEXTVAL , SEQ_BO_NO.CURRVAL ,'트윈룸','디럭스 트윈룸',66500);
Insert into TRIP2REAP.ROOM (ROOM_NO,BO_NO,ROOM_TYPE,ROOM_NAME,PRICE_PER_DAY) values ( SEQ_ROOM_NO.NEXTVAL , SEQ_BO_NO.CURRVAL ,'디럭스룸','디럭스 트윈룸',66500);
Insert into TRIP2REAP.ROOM (ROOM_NO,BO_NO,ROOM_TYPE,ROOM_NAME,PRICE_PER_DAY) values ( SEQ_ROOM_NO.NEXTVAL , SEQ_BO_NO.CURRVAL ,'더블룸','슈페리어 더블룸',80000);
Insert into TRIP2REAP.ROOM (ROOM_NO,BO_NO,ROOM_TYPE,ROOM_NAME,PRICE_PER_DAY) values ( SEQ_ROOM_NO.NEXTVAL , SEQ_BO_NO.CURRVAL ,'슈페리어룸','슈페리어 더블룸',80000);
Insert into TRIP2REAP.ROOM (ROOM_NO,BO_NO,ROOM_TYPE,ROOM_NAME,PRICE_PER_DAY) values ( SEQ_ROOM_NO.NEXTVAL , SEQ_BO_NO.CURRVAL ,'디럭스룸','디럭스 패밀리룸',90000);
Insert into TRIP2REAP.ROOM (ROOM_NO,BO_NO,ROOM_TYPE,ROOM_NAME,PRICE_PER_DAY) values ( SEQ_ROOM_NO.NEXTVAL , SEQ_BO_NO.CURRVAL ,'패밀리룸','디럭스 패밀리룸',90000);
Insert into TRIP2REAP.ROOM (ROOM_NO,BO_NO,ROOM_TYPE,ROOM_NAME,PRICE_PER_DAY) values ( SEQ_ROOM_NO.NEXTVAL , SEQ_BO_NO.CURRVAL ,'디럭스룸','디럭스 패밀리 트윈',90000);
Insert into TRIP2REAP.ROOM (ROOM_NO,BO_NO,ROOM_TYPE,ROOM_NAME,PRICE_PER_DAY) values ( SEQ_ROOM_NO.NEXTVAL , SEQ_BO_NO.CURRVAL ,'패밀리룸','디럭스 패밀리 트윈',90000);
Insert into TRIP2REAP.ROOM (ROOM_NO,BO_NO,ROOM_TYPE,ROOM_NAME,PRICE_PER_DAY) values ( SEQ_ROOM_NO.NEXTVAL , SEQ_BO_NO.CURRVAL ,'트윈룸','디럭스 패밀리 트윈',90000);


-------29
Insert into TRIP2REAP.BOARD (BO_NO,CA_CODE,BO_TITLE,BO_CONTENT,MEMBER_ID,BO_COUNT,BO_TAG,BO_DELETE_YN,REGDATE) values (SEQ_BO_NO.NEXTVAL ,5,'나인트리 프리미어 호텔 명동','나인트리 프리미어 호텔 명동 2 - <4성급:한국관광공사 인증> - 서울 중심지에 자리한 이 호텔은 남산골한옥마을에서 가까운 거리에 있습니다. 그 밖에도 내부 어디에서든 무료로 인터넷에 접속하실 수 있습니다. 이 호텔에서는 리셉션을 24시간 운영하고 있고 익스프레스 체크인/체크아웃, 컨시어지 서비스, 회의실도 마련되어 있습니다. 환전, 투어 데스크, 티켓 서비스 등도 갖춰져 있어 편리하게 이용하실 수 있습니다. 각 객실에는 에어컨이 완비되어 있고 헤어드라이어, 평면 TV도 갖추고 있습니다. 모든 객실에 방에 딸린 옷장, 객실 내 금고, 슬리퍼 등이 구비되어 있습니다. 고객님들에게는 매일 다양한 조식이 제공됩니다. 호텔에서 명동성당까지 걸어서 5분이면 가실 수 있습니다. 또한 쉽게 가실 수 있는 거리에 청계천, 종로타워도 있습니다.','admin',0,'나인트리프리미어, 명동호텔','N',to_date('20/12/10','RR/MM/DD'));
Insert into TRIP2REAP.HOTEL (BO_NO,HOTEL_ADDRESS,HOTEL_LOCAL_CODE,HOTEL_SITE,HOTEL_TEL,HOTEL_REVIEW_SCORE,HOTEL_RANK,HOTEL_OPEN_TIME,HOTEL_CLOSE_TIME,HOTEL_OPTION,CHECK_IN,CHECK_OUT) values ( SEQ_BO_NO.CURRVAL ,'서울 중구 마른내로 28',9,'http://www.ninetreehotels.com/nth2/','02-6967-0999',0,4,0,23,'와이파이, 조식, 레스토랑, 세탁, 24시간 리셉션, 수하물 보관, 피트니스, 카페, 비즈니스 시설, 주차, 공항셔틀, 장애인 편의시설, 바/라운지, 주방',15,12);

Insert into TRIP2REAP.IMG_FILE (FILE_NO,BO_NO,ORIGIN_NAME,CHANGE_NAME,FILE_LEVEL,FILE_PATH,FILE_DELETE_YN) values (SEQ_FILE_NO.NEXTVAL , SEQ_BO_NO.CURRVAL ,'썸네일.jpeg','hotel_thumbnail_202012102250400453.jpeg',1,'/Users/ek/Documents/GitHub/Spring-Project-Trip2Reap/Spring-Final-Trip2Reap/src/main/webapp/resources/buploadFiles/hotel_thumbnail_202012102250400453.jpeg','N');
Insert into TRIP2REAP.IMG_FILE (FILE_NO,BO_NO,ORIGIN_NAME,CHANGE_NAME,FILE_LEVEL,FILE_PATH,FILE_DELETE_YN) values (SEQ_FILE_NO.NEXTVAL , SEQ_BO_NO.CURRVAL ,'디테일1.jpeg','hotel_detail_202012102250400460.jpeg',2,'/Users/ek/Documents/GitHub/Spring-Project-Trip2Reap/Spring-Final-Trip2Reap/src/main/webapp/resources/buploadFiles/hotel_detail_202012102250400460.jpeg','N');
Insert into TRIP2REAP.IMG_FILE (FILE_NO,BO_NO,ORIGIN_NAME,CHANGE_NAME,FILE_LEVEL,FILE_PATH,FILE_DELETE_YN) values (SEQ_FILE_NO.NEXTVAL , SEQ_BO_NO.CURRVAL ,'디테일2.jpeg','hotel_detail_202012102250400467.jpeg',2,'/Users/ek/Documents/GitHub/Spring-Project-Trip2Reap/Spring-Final-Trip2Reap/src/main/webapp/resources/buploadFiles/hotel_detail_202012102250400467.jpeg','N');
Insert into TRIP2REAP.IMG_FILE (FILE_NO,BO_NO,ORIGIN_NAME,CHANGE_NAME,FILE_LEVEL,FILE_PATH,FILE_DELETE_YN) values (SEQ_FILE_NO.NEXTVAL , SEQ_BO_NO.CURRVAL ,'디테일3.jpeg','hotel_detail_202012102250400473.jpeg',2,'/Users/ek/Documents/GitHub/Spring-Project-Trip2Reap/Spring-Final-Trip2Reap/src/main/webapp/resources/buploadFiles/hotel_detail_202012102250400473.jpeg','N');
Insert into TRIP2REAP.IMG_FILE (FILE_NO,BO_NO,ORIGIN_NAME,CHANGE_NAME,FILE_LEVEL,FILE_PATH,FILE_DELETE_YN) values (SEQ_FILE_NO.NEXTVAL , SEQ_BO_NO.CURRVAL ,'디테일4.jpeg','hotel_detail_202012102250400478.jpeg',2,'/Users/ek/Documents/GitHub/Spring-Project-Trip2Reap/Spring-Final-Trip2Reap/src/main/webapp/resources/buploadFiles/hotel_detail_202012102250400478.jpeg','N');
Insert into TRIP2REAP.IMG_FILE (FILE_NO,BO_NO,ORIGIN_NAME,CHANGE_NAME,FILE_LEVEL,FILE_PATH,FILE_DELETE_YN) values (SEQ_FILE_NO.NEXTVAL , SEQ_BO_NO.CURRVAL ,'디테일5.jpeg','hotel_detail_202012102250400485.jpeg',2,'/Users/ek/Documents/GitHub/Spring-Project-Trip2Reap/Spring-Final-Trip2Reap/src/main/webapp/resources/buploadFiles/hotel_detail_202012102250400485.jpeg','N');
Insert into TRIP2REAP.IMG_FILE (FILE_NO,BO_NO,ORIGIN_NAME,CHANGE_NAME,FILE_LEVEL,FILE_PATH,FILE_DELETE_YN) values (SEQ_FILE_NO.NEXTVAL , SEQ_BO_NO.CURRVAL ,'디테일6.jpeg','hotel_detail_202012102250400493.jpeg',2,'/Users/ek/Documents/GitHub/Spring-Project-Trip2Reap/Spring-Final-Trip2Reap/src/main/webapp/resources/buploadFiles/hotel_detail_202012102250400493.jpeg','N');
Insert into TRIP2REAP.IMG_FILE (FILE_NO,BO_NO,ORIGIN_NAME,CHANGE_NAME,FILE_LEVEL,FILE_PATH,FILE_DELETE_YN) values (SEQ_FILE_NO.NEXTVAL , SEQ_BO_NO.CURRVAL ,'썸네일.jpeg','hotel_detail_202012102250400500.jpeg',2,'/Users/ek/Documents/GitHub/Spring-Project-Trip2Reap/Spring-Final-Trip2Reap/src/main/webapp/resources/buploadFiles/hotel_detail_202012102250400500.jpeg','N');

Insert into TRIP2REAP.ROOM (ROOM_NO,BO_NO,ROOM_TYPE,ROOM_NAME,PRICE_PER_DAY) values ( SEQ_ROOM_NO.NEXTVAL , SEQ_BO_NO.CURRVAL ,'트윈룸','스탠다드 트윈룸',56700);
Insert into TRIP2REAP.ROOM (ROOM_NO,BO_NO,ROOM_TYPE,ROOM_NAME,PRICE_PER_DAY) values ( SEQ_ROOM_NO.NEXTVAL , SEQ_BO_NO.CURRVAL ,'스탠다드룸','스탠다드 트윈룸',56700);
Insert into TRIP2REAP.ROOM (ROOM_NO,BO_NO,ROOM_TYPE,ROOM_NAME,PRICE_PER_DAY) values ( SEQ_ROOM_NO.NEXTVAL , SEQ_BO_NO.CURRVAL ,'스탠다드룸','스탠다드 더블룸- 와이파이, 피트니스',56900);
Insert into TRIP2REAP.ROOM (ROOM_NO,BO_NO,ROOM_TYPE,ROOM_NAME,PRICE_PER_DAY) values ( SEQ_ROOM_NO.NEXTVAL , SEQ_BO_NO.CURRVAL ,'더블룸','스탠다드 더블룸- 와이파이, 피트니스',56900);
Insert into TRIP2REAP.ROOM (ROOM_NO,BO_NO,ROOM_TYPE,ROOM_NAME,PRICE_PER_DAY) values ( SEQ_ROOM_NO.NEXTVAL , SEQ_BO_NO.CURRVAL ,'더블룸','스카이뷰 더블(금연룸)',61900);
Insert into TRIP2REAP.ROOM (ROOM_NO,BO_NO,ROOM_TYPE,ROOM_NAME,PRICE_PER_DAY) values ( SEQ_ROOM_NO.NEXTVAL , SEQ_BO_NO.CURRVAL ,'트윈룸','패밀리 트윈룸',64800);
Insert into TRIP2REAP.ROOM (ROOM_NO,BO_NO,ROOM_TYPE,ROOM_NAME,PRICE_PER_DAY) values ( SEQ_ROOM_NO.NEXTVAL , SEQ_BO_NO.CURRVAL ,'패밀리룸','패밀리 트윈룸',64800);
Insert into TRIP2REAP.ROOM (ROOM_NO,BO_NO,ROOM_TYPE,ROOM_NAME,PRICE_PER_DAY) values ( SEQ_ROOM_NO.NEXTVAL , SEQ_BO_NO.CURRVAL ,'더블룸','파노라믹 더블룸(환불불가)',65100);
Insert into TRIP2REAP.ROOM (ROOM_NO,BO_NO,ROOM_TYPE,ROOM_NAME,PRICE_PER_DAY) values ( SEQ_ROOM_NO.NEXTVAL , SEQ_BO_NO.CURRVAL ,'더블룸','스카이 더블룸(환불불가)',65100);



-------30
Insert into TRIP2REAP.BOARD (BO_NO,CA_CODE,BO_TITLE,BO_CONTENT,MEMBER_ID,BO_COUNT,BO_TAG,BO_DELETE_YN,REGDATE) values (SEQ_BO_NO.NEXTVAL ,5,'신라스테이 마포','신라 스테이 마포 - <3성급:한국관광공사 인증> - 신라스테이 마포는 5, 6호선, 중앙선, 공항철도를 이용하실 수 있는 공덕역 1번 출구에서 도보 2분 거리에 있습니다. 차로 10분 거리에 여의도 IFC, 국회의사당, 금융사 등이 있어 비즈니스 여행객에게 편리한 위치를 자랑합니다. 또한, 차로 15분이면 홍대 거리와 63빌딩까지 가실 수 있습니다. 호텔 내에 미팅룸, 컴퓨터와 프린터가 마련된 비즈니스 코너, 유/무산소 기구가 완비된 피트니스 센터 등이 있습니다. 프런트 데스크에서는 Wi-Fi 에그 대여, 세탁 서비스 등을 유료로 제공하고 있습니다. 또한, 지하 주차장도 보유하고 있습니다. 전체 383개의 객실을 보유하고 있으며 모든 객실에는 LED TV와 유니버설 어댑터가 있으며 거위 털 이불과 오리털 베개 등을 비롯한 고급 침구가 기분 좋은 숙면을 돕습니다. 욕실에는 아베다 욕실용품, 비데, 샤워 가운 등이 준비되어 있습니다. 또한, 객실 유형에 따라, 샤워부스, 욕조, 샤워부스 및 욕조가 있습니다. 지하 2층에 위치한 카페에서는 각국의 다양한 요리를 조식, 중식, 석식 뷔페로 맛보실 수 있으며 별도의 요금이 발생합니다.','admin',0,'신라스테이마포, 신라스테이, 신라호텔','N',to_date('20/12/10','RR/MM/DD'));
Insert into TRIP2REAP.HOTEL (BO_NO,HOTEL_ADDRESS,HOTEL_LOCAL_CODE,HOTEL_SITE,HOTEL_TEL,HOTEL_REVIEW_SCORE,HOTEL_RANK,HOTEL_OPEN_TIME,HOTEL_CLOSE_TIME,HOTEL_OPTION,CHECK_IN,CHECK_OUT) values ( SEQ_BO_NO.CURRVAL ,'서울 마포구 마포대로 83',9,'https://www.shillastay.com/mapo/index.do?lang=ko','02-6979-9000',0,3,9,23,null,14,12);

Insert into TRIP2REAP.IMG_FILE (FILE_NO,BO_NO,ORIGIN_NAME,CHANGE_NAME,FILE_LEVEL,FILE_PATH,FILE_DELETE_YN) values (SEQ_FILE_NO.NEXTVAL , SEQ_BO_NO.CURRVAL ,'썸네일.jpeg','hotel_thumbnail_202012102308070553.jpeg',1,'/Users/ek/Documents/GitHub/Spring-Project-Trip2Reap/Spring-Final-Trip2Reap/src/main/webapp/resources/buploadFiles/hotel_thumbnail_202012102308070553.jpeg','N');
Insert into TRIP2REAP.IMG_FILE (FILE_NO,BO_NO,ORIGIN_NAME,CHANGE_NAME,FILE_LEVEL,FILE_PATH,FILE_DELETE_YN) values (SEQ_FILE_NO.NEXTVAL , SEQ_BO_NO.CURRVAL ,'디테일1.jpeg','hotel_detail_202012102308070561.jpeg',2,'/Users/ek/Documents/GitHub/Spring-Project-Trip2Reap/Spring-Final-Trip2Reap/src/main/webapp/resources/buploadFiles/hotel_detail_202012102308070561.jpeg','N');
Insert into TRIP2REAP.IMG_FILE (FILE_NO,BO_NO,ORIGIN_NAME,CHANGE_NAME,FILE_LEVEL,FILE_PATH,FILE_DELETE_YN) values (SEQ_FILE_NO.NEXTVAL , SEQ_BO_NO.CURRVAL ,'디테일2.jpeg','hotel_detail_202012102308070569.jpeg',2,'/Users/ek/Documents/GitHub/Spring-Project-Trip2Reap/Spring-Final-Trip2Reap/src/main/webapp/resources/buploadFiles/hotel_detail_202012102308070569.jpeg','N');
Insert into TRIP2REAP.IMG_FILE (FILE_NO,BO_NO,ORIGIN_NAME,CHANGE_NAME,FILE_LEVEL,FILE_PATH,FILE_DELETE_YN) values (SEQ_FILE_NO.NEXTVAL , SEQ_BO_NO.CURRVAL ,'디테일3.jpeg','hotel_detail_202012102308070577.jpeg',2,'/Users/ek/Documents/GitHub/Spring-Project-Trip2Reap/Spring-Final-Trip2Reap/src/main/webapp/resources/buploadFiles/hotel_detail_202012102308070577.jpeg','N');
Insert into TRIP2REAP.IMG_FILE (FILE_NO,BO_NO,ORIGIN_NAME,CHANGE_NAME,FILE_LEVEL,FILE_PATH,FILE_DELETE_YN) values (SEQ_FILE_NO.NEXTVAL , SEQ_BO_NO.CURRVAL ,'디테일4.jpeg','hotel_detail_202012102308070584.jpeg',2,'/Users/ek/Documents/GitHub/Spring-Project-Trip2Reap/Spring-Final-Trip2Reap/src/main/webapp/resources/buploadFiles/hotel_detail_202012102308070584.jpeg','N');
Insert into TRIP2REAP.IMG_FILE (FILE_NO,BO_NO,ORIGIN_NAME,CHANGE_NAME,FILE_LEVEL,FILE_PATH,FILE_DELETE_YN) values (SEQ_FILE_NO.NEXTVAL , SEQ_BO_NO.CURRVAL ,'디테일5.jpeg','hotel_detail_202012102308070591.jpeg',2,'/Users/ek/Documents/GitHub/Spring-Project-Trip2Reap/Spring-Final-Trip2Reap/src/main/webapp/resources/buploadFiles/hotel_detail_202012102308070591.jpeg','N');
Insert into TRIP2REAP.IMG_FILE (FILE_NO,BO_NO,ORIGIN_NAME,CHANGE_NAME,FILE_LEVEL,FILE_PATH,FILE_DELETE_YN) values (SEQ_FILE_NO.NEXTVAL , SEQ_BO_NO.CURRVAL ,'썸네일.jpeg','hotel_detail_202012102308070597.jpeg',2,'/Users/ek/Documents/GitHub/Spring-Project-Trip2Reap/Spring-Final-Trip2Reap/src/main/webapp/resources/buploadFiles/hotel_detail_202012102308070597.jpeg','N');

Insert into TRIP2REAP.ROOM (ROOM_NO,BO_NO,ROOM_TYPE,ROOM_NAME,PRICE_PER_DAY) values ( SEQ_ROOM_NO.NEXTVAL , SEQ_BO_NO.CURRVAL ,'스탠다드룸','스탠다드 더블룸',61100);
Insert into TRIP2REAP.ROOM (ROOM_NO,BO_NO,ROOM_TYPE,ROOM_NAME,PRICE_PER_DAY) values ( SEQ_ROOM_NO.NEXTVAL , SEQ_BO_NO.CURRVAL ,'더블룸','스탠다드 더블룸',61100);
Insert into TRIP2REAP.ROOM (ROOM_NO,BO_NO,ROOM_TYPE,ROOM_NAME,PRICE_PER_DAY) values ( SEQ_ROOM_NO.NEXTVAL , SEQ_BO_NO.CURRVAL ,'스탠다드룸','스탠다드 트윈룸',61100);
Insert into TRIP2REAP.ROOM (ROOM_NO,BO_NO,ROOM_TYPE,ROOM_NAME,PRICE_PER_DAY) values ( SEQ_ROOM_NO.NEXTVAL , SEQ_BO_NO.CURRVAL ,'트윈룸','스탠다드 트윈룸',61100);
Insert into TRIP2REAP.ROOM (ROOM_NO,BO_NO,ROOM_TYPE,ROOM_NAME,PRICE_PER_DAY) values ( SEQ_ROOM_NO.NEXTVAL , SEQ_BO_NO.CURRVAL ,'패밀리룸','패밀리 트윈룸',61100);
Insert into TRIP2REAP.ROOM (ROOM_NO,BO_NO,ROOM_TYPE,ROOM_NAME,PRICE_PER_DAY) values ( SEQ_ROOM_NO.NEXTVAL , SEQ_BO_NO.CURRVAL ,'트윈룸','패밀리 트윈룸',61100);
Insert into TRIP2REAP.ROOM (ROOM_NO,BO_NO,ROOM_TYPE,ROOM_NAME,PRICE_PER_DAY) values ( SEQ_ROOM_NO.NEXTVAL , SEQ_BO_NO.CURRVAL ,'디럭스룸','디럭스 더블룸',63450);
Insert into TRIP2REAP.ROOM (ROOM_NO,BO_NO,ROOM_TYPE,ROOM_NAME,PRICE_PER_DAY) values ( SEQ_ROOM_NO.NEXTVAL , SEQ_BO_NO.CURRVAL ,'더블룸','디럭스 더블룸',63450);
Insert into TRIP2REAP.ROOM (ROOM_NO,BO_NO,ROOM_TYPE,ROOM_NAME,PRICE_PER_DAY) values ( SEQ_ROOM_NO.NEXTVAL , SEQ_BO_NO.CURRVAL ,'디럭스룸','디럭스룸',62800);



--31
Insert into TRIP2REAP.BOARD (BO_NO,CA_CODE,BO_TITLE,BO_CONTENT,MEMBER_ID,BO_COUNT,BO_TAG,BO_DELETE_YN,REGDATE) values (SEQ_BO_NO.NEXTVAL ,5,'신라스테이 역삼','신라스테이 역삼 - <3성급:한국관광공사 인증> - 신라스테이 역삼은 2호선 역삼역과 선릉역에서 도보 10분 거리에 있습니다. 역삼역에서 단 한 정거장이면 강남으로 가실 수 있고, 선릉역에서 한 정거장이면 코엑스 몰까지 가실 수 있습니다. 걸어서 10분이면 테헤란로까지 가실 수 있고, 자동차로 10분이면 압구정 로데오거리, 가로수길 등을 가실 수 있습니다. 이 3성급 호텔에는 카페, 회의실, 24시간 리셉션 등이 갖춰져 있습니다. 필요하신 경우, 공항 탑승 서비스, 세탁 서비스 등의 서비스를 요청하실 수 있습니다. 그 밖에도 내부 어디에서든 무료로 인터넷에 접속하실 수 있습니다. 객실에는 에어컨이 완비되어 있으며 고급 세면 용품, 평면 TV 등의 최고급 시설을 제공하고 있습니다. 모든 객실에 전용 욕실, 커피/차 메이커, 냉장고 등이 완비되어 있습니다. 매일 아침 현지 관광을 위해 출발하시기 전에 호텔에서 제공하는 아침 식사를 드실 수 있습니다.','admin',3,'신라스테이, 신라호텔, 역삼동호텔','N',to_date('20/12/10','RR/MM/DD'));
Insert into TRIP2REAP.HOTEL (BO_NO,HOTEL_ADDRESS,HOTEL_LOCAL_CODE,HOTEL_SITE,HOTEL_TEL,HOTEL_REVIEW_SCORE,HOTEL_RANK,HOTEL_OPEN_TIME,HOTEL_CLOSE_TIME,HOTEL_OPTION,CHECK_IN,CHECK_OUT) values ( SEQ_BO_NO.CURRVAL ,'서울 강남구 언주로 517',9,'https://www.shillastay.com/yeoksam/index.do?lang=ko','02-2054-9000',0,3,6,23,'와이파이, 조식, 레스토랑, 세탁, 24시간 리셉션, 수하물 보관, 피트니스, 카페, 비즈니스 시설, 주차, 바/라운지, 주방',15,12);

Insert into TRIP2REAP.IMG_FILE (FILE_NO,BO_NO,ORIGIN_NAME,CHANGE_NAME,FILE_LEVEL,FILE_PATH,FILE_DELETE_YN) values (SEQ_FILE_NO.NEXTVAL , SEQ_BO_NO.CURRVAL ,'썸네일.jpeg','hotel_thumbnail_202012102314030277.jpeg',1,'/Users/ek/Documents/GitHub/Spring-Project-Trip2Reap/Spring-Final-Trip2Reap/src/main/webapp/resources/buploadFiles/hotel_thumbnail_202012102314030277.jpeg','N');
Insert into TRIP2REAP.IMG_FILE (FILE_NO,BO_NO,ORIGIN_NAME,CHANGE_NAME,FILE_LEVEL,FILE_PATH,FILE_DELETE_YN) values (SEQ_FILE_NO.NEXTVAL , SEQ_BO_NO.CURRVAL ,'디테일1.jpeg','hotel_detail_202012102314030286.jpeg',2,'/Users/ek/Documents/GitHub/Spring-Project-Trip2Reap/Spring-Final-Trip2Reap/src/main/webapp/resources/buploadFiles/hotel_detail_202012102314030286.jpeg','N');
Insert into TRIP2REAP.IMG_FILE (FILE_NO,BO_NO,ORIGIN_NAME,CHANGE_NAME,FILE_LEVEL,FILE_PATH,FILE_DELETE_YN) values (SEQ_FILE_NO.NEXTVAL , SEQ_BO_NO.CURRVAL ,'디테일2.jpeg','hotel_detail_202012102314030295.jpeg',2,'/Users/ek/Documents/GitHub/Spring-Project-Trip2Reap/Spring-Final-Trip2Reap/src/main/webapp/resources/buploadFiles/hotel_detail_202012102314030295.jpeg','N');
Insert into TRIP2REAP.IMG_FILE (FILE_NO,BO_NO,ORIGIN_NAME,CHANGE_NAME,FILE_LEVEL,FILE_PATH,FILE_DELETE_YN) values (SEQ_FILE_NO.NEXTVAL , SEQ_BO_NO.CURRVAL ,'디테일3.jpeg','hotel_detail_202012102314030308.jpeg',2,'/Users/ek/Documents/GitHub/Spring-Project-Trip2Reap/Spring-Final-Trip2Reap/src/main/webapp/resources/buploadFiles/hotel_detail_202012102314030308.jpeg','N');
Insert into TRIP2REAP.IMG_FILE (FILE_NO,BO_NO,ORIGIN_NAME,CHANGE_NAME,FILE_LEVEL,FILE_PATH,FILE_DELETE_YN) values (SEQ_FILE_NO.NEXTVAL , SEQ_BO_NO.CURRVAL ,'디테일4.jpeg','hotel_detail_202012102314030317.jpeg',2,'/Users/ek/Documents/GitHub/Spring-Project-Trip2Reap/Spring-Final-Trip2Reap/src/main/webapp/resources/buploadFiles/hotel_detail_202012102314030317.jpeg','N');
Insert into TRIP2REAP.IMG_FILE (FILE_NO,BO_NO,ORIGIN_NAME,CHANGE_NAME,FILE_LEVEL,FILE_PATH,FILE_DELETE_YN) values (SEQ_FILE_NO.NEXTVAL , SEQ_BO_NO.CURRVAL ,'디테일5.jpeg','hotel_detail_202012102314030326.jpeg',2,'/Users/ek/Documents/GitHub/Spring-Project-Trip2Reap/Spring-Final-Trip2Reap/src/main/webapp/resources/buploadFiles/hotel_detail_202012102314030326.jpeg','N');
Insert into TRIP2REAP.IMG_FILE (FILE_NO,BO_NO,ORIGIN_NAME,CHANGE_NAME,FILE_LEVEL,FILE_PATH,FILE_DELETE_YN) values (SEQ_FILE_NO.NEXTVAL , SEQ_BO_NO.CURRVAL ,'디테일6.jpeg','hotel_detail_202012102314030335.jpeg',2,'/Users/ek/Documents/GitHub/Spring-Project-Trip2Reap/Spring-Final-Trip2Reap/src/main/webapp/resources/buploadFiles/hotel_detail_202012102314030335.jpeg','N');
Insert into TRIP2REAP.IMG_FILE (FILE_NO,BO_NO,ORIGIN_NAME,CHANGE_NAME,FILE_LEVEL,FILE_PATH,FILE_DELETE_YN) values (SEQ_FILE_NO.NEXTVAL , SEQ_BO_NO.CURRVAL ,'썸네일.jpeg','hotel_detail_202012102314030343.jpeg',2,'/Users/ek/Documents/GitHub/Spring-Project-Trip2Reap/Spring-Final-Trip2Reap/src/main/webapp/resources/buploadFiles/hotel_detail_202012102314030343.jpeg','N');

Insert into TRIP2REAP.ROOM (ROOM_NO,BO_NO,ROOM_TYPE,ROOM_NAME,PRICE_PER_DAY) values ( SEQ_ROOM_NO.NEXTVAL , SEQ_BO_NO.CURRVAL ,'트윈룸','스탠다드 트윈룸',82600);
Insert into TRIP2REAP.ROOM (ROOM_NO,BO_NO,ROOM_TYPE,ROOM_NAME,PRICE_PER_DAY) values ( SEQ_ROOM_NO.NEXTVAL , SEQ_BO_NO.CURRVAL ,'스탠다드룸','스탠다드 트윈룸',82600);
Insert into TRIP2REAP.ROOM (ROOM_NO,BO_NO,ROOM_TYPE,ROOM_NAME,PRICE_PER_DAY) values ( SEQ_ROOM_NO.NEXTVAL , SEQ_BO_NO.CURRVAL ,'더블룸','스탠다드 더블룸',82600);
Insert into TRIP2REAP.ROOM (ROOM_NO,BO_NO,ROOM_TYPE,ROOM_NAME,PRICE_PER_DAY) values ( SEQ_ROOM_NO.NEXTVAL , SEQ_BO_NO.CURRVAL ,'스탠다드룸','스탠다드 더블룸',82600);
Insert into TRIP2REAP.ROOM (ROOM_NO,BO_NO,ROOM_TYPE,ROOM_NAME,PRICE_PER_DAY) values ( SEQ_ROOM_NO.NEXTVAL , SEQ_BO_NO.CURRVAL ,'더블룸','디럭스 더블룸',91450);
Insert into TRIP2REAP.ROOM (ROOM_NO,BO_NO,ROOM_TYPE,ROOM_NAME,PRICE_PER_DAY) values ( SEQ_ROOM_NO.NEXTVAL , SEQ_BO_NO.CURRVAL ,'디럭스룸','디럭스 더블룸',91450);



--32
Insert into TRIP2REAP.BOARD (BO_NO,CA_CODE,BO_TITLE,BO_CONTENT,MEMBER_ID,BO_COUNT,BO_TAG,BO_DELETE_YN,REGDATE) values (SEQ_BO_NO.NEXTVAL ,5,'쉐라톤 서울 디큐브시티 호텔','쉐라톤 서울 디큐브시티 호텔 - <5성급:한국관광공사 인증> - 쉐라톤 서울 디큐브 시티 호텔은 1, 2호선 신도림역 5번 출구에서 도보로 단 5분 거리에 있습니다. 호텔에서 아주 가까이에 현대백화점 디큐브시티점, 테크노마트 신도림점, 홈플러스 신도림점 등이 있어 편리하게 이용하실 수 있습니다. 차로 15분이면 영등포 타임스퀘어몰까지 가실 수 있습니다. 서울의 이 호텔에서는 실내 수영장 등을 이용하실 수 있을 뿐만 아니라, 내부 어디에서든 무료로 인터넷에 접속하실 수 있습니다. 또한 스크린 골프장과 피트니스 센터에서 액티비티를 즐길 수 있으며, 도심 속 전경이 내다보이는 사우나에서 휴식도 취하실 수 있습니다. 이 호텔의 모던한 객실에는 무선 인터넷과 금고, 전화기를 비롯해 평면 TV와 에어컨, 미니 바가 갖춰져 있습니다. 38층부터 40층에 위치한 클럽 룸에 투숙하시는 분들께서는 비즈니스 전용 공간인 38층 라운지에서 다양한 서비스를 누리실 수 있습니다. 호텔 내부에 마련된 피스트(Feast)는 도심 전망이 바라다보이는 시그니처 레스토랑으로, 파스타 스테이션과 그릴 스테이션, 해산물 스테이션, 디저트 스테이션으로 구성되어 있어 다양한 메뉴를 즐기실 수 있습니다. 41층에 위치한 로비 라운지.바(Lobby Lounge.Bar)에서는 오후에는 에프터눈 티세트를, 저녁에는 와인과 시그니처 칵테일을 맛보실 수 있습니다. 핏 카페(Fit Café)에서는 무선 인터넷과 무제한 커피, 무료 쿠키가 제공됩니다.','admin',0,'쉐라톤서울디큐브시티, 도시전망뷰','N',to_date('20/12/10','RR/MM/DD'));
Insert into TRIP2REAP.HOTEL (BO_NO,HOTEL_ADDRESS,HOTEL_LOCAL_CODE,HOTEL_SITE,HOTEL_TEL,HOTEL_REVIEW_SCORE,HOTEL_RANK,HOTEL_OPEN_TIME,HOTEL_CLOSE_TIME,HOTEL_OPTION,CHECK_IN,CHECK_OUT) values ( SEQ_BO_NO.CURRVAL ,'서울 구로구 경인로 662',9,'https://www.marriott.co.kr/hotels/travel/seldi-sheraton-seoul-d-cube-city-hotel/','02-2211-2000',0,5,0,23,'와이파이, 조식, 레스토랑, 세탁, 24시간 리셉션, 수하물 보관, 수영장, 피트니스, 스파/사우나, 카페, 비즈니스 시설, 주차, 바/라운지, 주방',16,12);

Insert into TRIP2REAP.IMG_FILE (FILE_NO,BO_NO,ORIGIN_NAME,CHANGE_NAME,FILE_LEVEL,FILE_PATH,FILE_DELETE_YN) values (SEQ_FILE_NO.NEXTVAL , SEQ_BO_NO.CURRVAL ,'썸네일.jpeg','hotel_thumbnail_202012102330000217.jpeg',1,'/Users/ek/Documents/GitHub/Spring-Project-Trip2Reap/Spring-Final-Trip2Reap/src/main/webapp/resources/buploadFiles/hotel_thumbnail_202012102330000217.jpeg','N');
Insert into TRIP2REAP.IMG_FILE (FILE_NO,BO_NO,ORIGIN_NAME,CHANGE_NAME,FILE_LEVEL,FILE_PATH,FILE_DELETE_YN) values (SEQ_FILE_NO.NEXTVAL , SEQ_BO_NO.CURRVAL ,'디테일1.jpeg','hotel_detail_202012102330000232.jpeg',2,'/Users/ek/Documents/GitHub/Spring-Project-Trip2Reap/Spring-Final-Trip2Reap/src/main/webapp/resources/buploadFiles/hotel_detail_202012102330000232.jpeg','N');
Insert into TRIP2REAP.IMG_FILE (FILE_NO,BO_NO,ORIGIN_NAME,CHANGE_NAME,FILE_LEVEL,FILE_PATH,FILE_DELETE_YN) values (SEQ_FILE_NO.NEXTVAL , SEQ_BO_NO.CURRVAL ,'디테일2.jpeg','hotel_detail_202012102330000238.jpeg',2,'/Users/ek/Documents/GitHub/Spring-Project-Trip2Reap/Spring-Final-Trip2Reap/src/main/webapp/resources/buploadFiles/hotel_detail_202012102330000238.jpeg','N');
Insert into TRIP2REAP.IMG_FILE (FILE_NO,BO_NO,ORIGIN_NAME,CHANGE_NAME,FILE_LEVEL,FILE_PATH,FILE_DELETE_YN) values (SEQ_FILE_NO.NEXTVAL , SEQ_BO_NO.CURRVAL ,'디테일3.jpeg','hotel_detail_202012102330000252.jpeg',2,'/Users/ek/Documents/GitHub/Spring-Project-Trip2Reap/Spring-Final-Trip2Reap/src/main/webapp/resources/buploadFiles/hotel_detail_202012102330000252.jpeg','N');
Insert into TRIP2REAP.IMG_FILE (FILE_NO,BO_NO,ORIGIN_NAME,CHANGE_NAME,FILE_LEVEL,FILE_PATH,FILE_DELETE_YN) values (SEQ_FILE_NO.NEXTVAL , SEQ_BO_NO.CURRVAL ,'디테일4.jpeg','hotel_detail_202012102330000261.jpeg',2,'/Users/ek/Documents/GitHub/Spring-Project-Trip2Reap/Spring-Final-Trip2Reap/src/main/webapp/resources/buploadFiles/hotel_detail_202012102330000261.jpeg','N');
Insert into TRIP2REAP.IMG_FILE (FILE_NO,BO_NO,ORIGIN_NAME,CHANGE_NAME,FILE_LEVEL,FILE_PATH,FILE_DELETE_YN) values (SEQ_FILE_NO.NEXTVAL , SEQ_BO_NO.CURRVAL ,'디테일5.jpeg','hotel_detail_202012102330000268.jpeg',2,'/Users/ek/Documents/GitHub/Spring-Project-Trip2Reap/Spring-Final-Trip2Reap/src/main/webapp/resources/buploadFiles/hotel_detail_202012102330000268.jpeg','N');
Insert into TRIP2REAP.IMG_FILE (FILE_NO,BO_NO,ORIGIN_NAME,CHANGE_NAME,FILE_LEVEL,FILE_PATH,FILE_DELETE_YN) values (SEQ_FILE_NO.NEXTVAL , SEQ_BO_NO.CURRVAL ,'디테일6.jpeg','hotel_detail_202012102330000278.jpeg',2,'/Users/ek/Documents/GitHub/Spring-Project-Trip2Reap/Spring-Final-Trip2Reap/src/main/webapp/resources/buploadFiles/hotel_detail_202012102330000278.jpeg','N');
Insert into TRIP2REAP.IMG_FILE (FILE_NO,BO_NO,ORIGIN_NAME,CHANGE_NAME,FILE_LEVEL,FILE_PATH,FILE_DELETE_YN) values (SEQ_FILE_NO.NEXTVAL , SEQ_BO_NO.CURRVAL ,'디테일7.jpeg','hotel_detail_202012102330000285.jpeg',2,'/Users/ek/Documents/GitHub/Spring-Project-Trip2Reap/Spring-Final-Trip2Reap/src/main/webapp/resources/buploadFiles/hotel_detail_202012102330000285.jpeg','N');
Insert into TRIP2REAP.IMG_FILE (FILE_NO,BO_NO,ORIGIN_NAME,CHANGE_NAME,FILE_LEVEL,FILE_PATH,FILE_DELETE_YN) values (SEQ_FILE_NO.NEXTVAL , SEQ_BO_NO.CURRVAL ,'디테일8.jpeg','hotel_detail_202012102330000292.jpeg',2,'/Users/ek/Documents/GitHub/Spring-Project-Trip2Reap/Spring-Final-Trip2Reap/src/main/webapp/resources/buploadFiles/hotel_detail_202012102330000292.jpeg','N');
Insert into TRIP2REAP.IMG_FILE (FILE_NO,BO_NO,ORIGIN_NAME,CHANGE_NAME,FILE_LEVEL,FILE_PATH,FILE_DELETE_YN) values (SEQ_FILE_NO.NEXTVAL , SEQ_BO_NO.CURRVAL ,'디테일9.jpeg','hotel_detail_202012102330000300.jpeg',2,'/Users/ek/Documents/GitHub/Spring-Project-Trip2Reap/Spring-Final-Trip2Reap/src/main/webapp/resources/buploadFiles/hotel_detail_202012102330000300.jpeg','N');
Insert into TRIP2REAP.IMG_FILE (FILE_NO,BO_NO,ORIGIN_NAME,CHANGE_NAME,FILE_LEVEL,FILE_PATH,FILE_DELETE_YN) values (SEQ_FILE_NO.NEXTVAL , SEQ_BO_NO.CURRVAL ,'썸네일.jpeg','hotel_detail_202012102330000307.jpeg',2,'/Users/ek/Documents/GitHub/Spring-Project-Trip2Reap/Spring-Final-Trip2Reap/src/main/webapp/resources/buploadFiles/hotel_detail_202012102330000307.jpeg','N');

Insert into TRIP2REAP.ROOM (ROOM_NO,BO_NO,ROOM_TYPE,ROOM_NAME,PRICE_PER_DAY) values ( SEQ_ROOM_NO.NEXTVAL , SEQ_BO_NO.CURRVAL ,'디럭스룸','디럭스 킹룸',126000);
Insert into TRIP2REAP.ROOM (ROOM_NO,BO_NO,ROOM_TYPE,ROOM_NAME,PRICE_PER_DAY) values ( SEQ_ROOM_NO.NEXTVAL , SEQ_BO_NO.CURRVAL ,'디럭스룸','디럭스 트윈룸- 29층이상 전망뷰',126000);
Insert into TRIP2REAP.ROOM (ROOM_NO,BO_NO,ROOM_TYPE,ROOM_NAME,PRICE_PER_DAY) values ( SEQ_ROOM_NO.NEXTVAL , SEQ_BO_NO.CURRVAL ,'트윈룸','디럭스 트윈룸-29층 이상 전망뷰',126000);
Insert into TRIP2REAP.ROOM (ROOM_NO,BO_NO,ROOM_TYPE,ROOM_NAME,PRICE_PER_DAY) values ( SEQ_ROOM_NO.NEXTVAL , SEQ_BO_NO.CURRVAL ,'더블룸','게스트룸 - 2더블 도시전망',126000);
Insert into TRIP2REAP.ROOM (ROOM_NO,BO_NO,ROOM_TYPE,ROOM_NAME,PRICE_PER_DAY) values ( SEQ_ROOM_NO.NEXTVAL , SEQ_BO_NO.CURRVAL ,'디럭스룸','디럭스룸- 더블침대2개 금연, 시내전망',126000);
Insert into TRIP2REAP.ROOM (ROOM_NO,BO_NO,ROOM_TYPE,ROOM_NAME,PRICE_PER_DAY) values ( SEQ_ROOM_NO.NEXTVAL , SEQ_BO_NO.CURRVAL ,'디럭스룸','디럭스 시티뷰룸(더블베드2개)',126000);
Insert into TRIP2REAP.ROOM (ROOM_NO,BO_NO,ROOM_TYPE,ROOM_NAME,PRICE_PER_DAY) values ( SEQ_ROOM_NO.NEXTVAL , SEQ_BO_NO.CURRVAL ,'디럭스룸','디럭스 코너룸- 도시전망, 수영장이용',140000);


--33
Insert into TRIP2REAP.BOARD (BO_NO,CA_CODE,BO_TITLE,BO_CONTENT,MEMBER_ID,BO_COUNT,BO_TAG,BO_DELETE_YN,REGDATE) values (SEQ_BO_NO.NEXTVAL ,5,'인터컨티넨탈 서울 코엑스 호텔','인터컨티넨탈 서울 코엑스 - <5성급:한국관광공사 인증> - 인터컨티넨탈 서울 코엑스는 9호선 봉은사역 7번 출구에서 도보 5분 거리에 있습니다. 호텔과 코엑스몰, 현대백화점 무역센터점이 연결되어 있어 쇼핑을 즐기기 편리합니다. 또한, 차로 15분이면 롯데월드까지 가실 수 있습니다. 호텔 내 사우나, 스파, 이규제큐티브 층 등이 있어 편리하게 이용하실 수 있습니다. 뿐만 아니라, 피트니스 센터와 실내 수영장 등도 마련되어 있어 운동을 즐기실 수 있습니다. 프런트 데스크를 24시간 운영하고 있으며 룸서비스, 아이 돌봄, 드라이클리닝 서비스 등을 이용하실 수 있습니다. 또한, 객실당 1대까지 무료로 주차하실 수 있습니다. 클럽 인터컨티넨탈 139개 객실을 포함하여 전체 656개 객실이 있으며 객실에 따라 한강, 선릉, 봉은사 전망 등을 감상하실 수 있습니다. 모던하고 세련된 인테리어를 자랑하는 모든 객실에는 최신식 스마트폰, 평면 LCD TV, 미니바 등이 있으며 욕실에는 목욕 가운, 독립 샤워부스, 욕실용품 등이 있습니다. 클럽 객실 이용 시에는 클럽 라운지 이용 혜택이 제공됩니다. 올데이 다이닝 레스토랑인 브래서리, 아름다운 야경을 자랑하는 30층에 자리한 스카이라운지, 여러 아시아 국가 요리를 선보이는 아시안 라이브, 라이브 음악을 들을 수 있는 로비라운지, 편안한 분위기의 로비 바 등 총 5개의 레스토랑과 바가 준비되어 있어 선택의 폭이 넓습니다.','admin',0,'인터컨티넨탈코엑스, 봉은사호텔','N',to_date('20/12/10','RR/MM/DD'));
Insert into TRIP2REAP.HOTEL (BO_NO,HOTEL_ADDRESS,HOTEL_LOCAL_CODE,HOTEL_SITE,HOTEL_TEL,HOTEL_REVIEW_SCORE,HOTEL_RANK,HOTEL_OPEN_TIME,HOTEL_CLOSE_TIME,HOTEL_OPTION,CHECK_IN,CHECK_OUT) values ( SEQ_BO_NO.CURRVAL ,'서울 강남구 봉은사로 524',9,'https://seoul.intercontinental.com/iccoex/','02-3452-2500',0,5,0,23,'레스토랑, 세탁, 24시간 리셉션, 수하물 보관, 수영장, 피트니스, 스파/사우나, 비즈니스 시설, 주차, 공항셔틀, 바/라운지, 주방, 아이돌봄 서비스, 룸서비스',14,12);

Insert into TRIP2REAP.IMG_FILE (FILE_NO,BO_NO,ORIGIN_NAME,CHANGE_NAME,FILE_LEVEL,FILE_PATH,FILE_DELETE_YN) values (SEQ_FILE_NO.NEXTVAL , SEQ_BO_NO.CURRVAL ,'썸네일.jpeg','hotel_thumbnail_202012102338030786.jpeg',1,'/Users/ek/Documents/GitHub/Spring-Project-Trip2Reap/Spring-Final-Trip2Reap/src/main/webapp/resources/buploadFiles/hotel_thumbnail_202012102338030786.jpeg','N');
Insert into TRIP2REAP.IMG_FILE (FILE_NO,BO_NO,ORIGIN_NAME,CHANGE_NAME,FILE_LEVEL,FILE_PATH,FILE_DELETE_YN) values (SEQ_FILE_NO.NEXTVAL , SEQ_BO_NO.CURRVAL ,'디테일1.jpeg','hotel_detail_202012102338030798.jpeg',2,'/Users/ek/Documents/GitHub/Spring-Project-Trip2Reap/Spring-Final-Trip2Reap/src/main/webapp/resources/buploadFiles/hotel_detail_202012102338030798.jpeg','N');
Insert into TRIP2REAP.IMG_FILE (FILE_NO,BO_NO,ORIGIN_NAME,CHANGE_NAME,FILE_LEVEL,FILE_PATH,FILE_DELETE_YN) values (SEQ_FILE_NO.NEXTVAL , SEQ_BO_NO.CURRVAL ,'디테일2.jpeg','hotel_detail_202012102338030808.jpeg',2,'/Users/ek/Documents/GitHub/Spring-Project-Trip2Reap/Spring-Final-Trip2Reap/src/main/webapp/resources/buploadFiles/hotel_detail_202012102338030808.jpeg','N');
Insert into TRIP2REAP.IMG_FILE (FILE_NO,BO_NO,ORIGIN_NAME,CHANGE_NAME,FILE_LEVEL,FILE_PATH,FILE_DELETE_YN) values (SEQ_FILE_NO.NEXTVAL , SEQ_BO_NO.CURRVAL ,'디테일3.jpeg','hotel_detail_202012102338030818.jpeg',2,'/Users/ek/Documents/GitHub/Spring-Project-Trip2Reap/Spring-Final-Trip2Reap/src/main/webapp/resources/buploadFiles/hotel_detail_202012102338030818.jpeg','N');
Insert into TRIP2REAP.IMG_FILE (FILE_NO,BO_NO,ORIGIN_NAME,CHANGE_NAME,FILE_LEVEL,FILE_PATH,FILE_DELETE_YN) values (SEQ_FILE_NO.NEXTVAL , SEQ_BO_NO.CURRVAL ,'디테일4.jpeg','hotel_detail_202012102338030884.jpeg',2,'/Users/ek/Documents/GitHub/Spring-Project-Trip2Reap/Spring-Final-Trip2Reap/src/main/webapp/resources/buploadFiles/hotel_detail_202012102338030884.jpeg','N');
Insert into TRIP2REAP.IMG_FILE (FILE_NO,BO_NO,ORIGIN_NAME,CHANGE_NAME,FILE_LEVEL,FILE_PATH,FILE_DELETE_YN) values (SEQ_FILE_NO.NEXTVAL , SEQ_BO_NO.CURRVAL ,'디테일5.jpeg','hotel_detail_202012102338030900.jpeg',2,'/Users/ek/Documents/GitHub/Spring-Project-Trip2Reap/Spring-Final-Trip2Reap/src/main/webapp/resources/buploadFiles/hotel_detail_202012102338030900.jpeg','N');
Insert into TRIP2REAP.IMG_FILE (FILE_NO,BO_NO,ORIGIN_NAME,CHANGE_NAME,FILE_LEVEL,FILE_PATH,FILE_DELETE_YN) values (SEQ_FILE_NO.NEXTVAL , SEQ_BO_NO.CURRVAL ,'디테일6.jpeg','hotel_detail_202012102338030915.jpeg',2,'/Users/ek/Documents/GitHub/Spring-Project-Trip2Reap/Spring-Final-Trip2Reap/src/main/webapp/resources/buploadFiles/hotel_detail_202012102338030915.jpeg','N');
Insert into TRIP2REAP.IMG_FILE (FILE_NO,BO_NO,ORIGIN_NAME,CHANGE_NAME,FILE_LEVEL,FILE_PATH,FILE_DELETE_YN) values (SEQ_FILE_NO.NEXTVAL , SEQ_BO_NO.CURRVAL ,'디테일7.jpeg','hotel_detail_202012102338030934.jpeg',2,'/Users/ek/Documents/GitHub/Spring-Project-Trip2Reap/Spring-Final-Trip2Reap/src/main/webapp/resources/buploadFiles/hotel_detail_202012102338030934.jpeg','N');
Insert into TRIP2REAP.IMG_FILE (FILE_NO,BO_NO,ORIGIN_NAME,CHANGE_NAME,FILE_LEVEL,FILE_PATH,FILE_DELETE_YN) values (SEQ_FILE_NO.NEXTVAL , SEQ_BO_NO.CURRVAL ,'디테일8.jpeg','hotel_detail_202012102338030943.jpeg',2,'/Users/ek/Documents/GitHub/Spring-Project-Trip2Reap/Spring-Final-Trip2Reap/src/main/webapp/resources/buploadFiles/hotel_detail_202012102338030943.jpeg','N');
Insert into TRIP2REAP.IMG_FILE (FILE_NO,BO_NO,ORIGIN_NAME,CHANGE_NAME,FILE_LEVEL,FILE_PATH,FILE_DELETE_YN) values (SEQ_FILE_NO.NEXTVAL , SEQ_BO_NO.CURRVAL ,'디테일9.jpeg','hotel_detail_202012102338030950.jpeg',2,'/Users/ek/Documents/GitHub/Spring-Project-Trip2Reap/Spring-Final-Trip2Reap/src/main/webapp/resources/buploadFiles/hotel_detail_202012102338030950.jpeg','N');
Insert into TRIP2REAP.IMG_FILE (FILE_NO,BO_NO,ORIGIN_NAME,CHANGE_NAME,FILE_LEVEL,FILE_PATH,FILE_DELETE_YN) values (SEQ_FILE_NO.NEXTVAL , SEQ_BO_NO.CURRVAL ,'디테일10.jpeg','hotel_detail_202012102338030959.jpeg',2,'/Users/ek/Documents/GitHub/Spring-Project-Trip2Reap/Spring-Final-Trip2Reap/src/main/webapp/resources/buploadFiles/hotel_detail_202012102338030959.jpeg','N');
Insert into TRIP2REAP.IMG_FILE (FILE_NO,BO_NO,ORIGIN_NAME,CHANGE_NAME,FILE_LEVEL,FILE_PATH,FILE_DELETE_YN) values (SEQ_FILE_NO.NEXTVAL , SEQ_BO_NO.CURRVAL ,'디테일11.jpeg','hotel_detail_202012102338030969.jpeg',2,'/Users/ek/Documents/GitHub/Spring-Project-Trip2Reap/Spring-Final-Trip2Reap/src/main/webapp/resources/buploadFiles/hotel_detail_202012102338030969.jpeg','N');
Insert into TRIP2REAP.IMG_FILE (FILE_NO,BO_NO,ORIGIN_NAME,CHANGE_NAME,FILE_LEVEL,FILE_PATH,FILE_DELETE_YN) values (SEQ_FILE_NO.NEXTVAL , SEQ_BO_NO.CURRVAL ,'썸네일.jpeg','hotel_detail_202012102338030981.jpeg',2,'/Users/ek/Documents/GitHub/Spring-Project-Trip2Reap/Spring-Final-Trip2Reap/src/main/webapp/resources/buploadFiles/hotel_detail_202012102338030981.jpeg','N');

Insert into TRIP2REAP.ROOM (ROOM_NO,BO_NO,ROOM_TYPE,ROOM_NAME,PRICE_PER_DAY) values ( SEQ_ROOM_NO.NEXTVAL , SEQ_BO_NO.CURRVAL ,'슈페리어룸','슈페리어 킹룸',126000);
Insert into TRIP2REAP.ROOM (ROOM_NO,BO_NO,ROOM_TYPE,ROOM_NAME,PRICE_PER_DAY) values ( SEQ_ROOM_NO.NEXTVAL , SEQ_BO_NO.CURRVAL ,'슈페리어룸','슈페리어 트윈룸',126000);
Insert into TRIP2REAP.ROOM (ROOM_NO,BO_NO,ROOM_TYPE,ROOM_NAME,PRICE_PER_DAY) values ( SEQ_ROOM_NO.NEXTVAL , SEQ_BO_NO.CURRVAL ,'트윈룸','슈페리어 트윈룸',126000);
Insert into TRIP2REAP.ROOM (ROOM_NO,BO_NO,ROOM_TYPE,ROOM_NAME,PRICE_PER_DAY) values ( SEQ_ROOM_NO.NEXTVAL , SEQ_BO_NO.CURRVAL ,'슈페리어룸','슈페리어 싱글침대2개',138600);
Insert into TRIP2REAP.ROOM (ROOM_NO,BO_NO,ROOM_TYPE,ROOM_NAME,PRICE_PER_DAY) values ( SEQ_ROOM_NO.NEXTVAL , SEQ_BO_NO.CURRVAL ,'스탠다드룸','스탠다드룸',147700);


--34
Insert into TRIP2REAP.BOARD (BO_NO,CA_CODE,BO_TITLE,BO_CONTENT,MEMBER_ID,BO_COUNT,BO_TAG,BO_DELETE_YN,REGDATE) values (SEQ_BO_NO.NEXTVAL ,5,'라마다 속초호텔','속초에 위치한 편안하고 아늑한 이 호텔에서는 무료 무선인터넷과 24시간 리셉션 및 회의실 등을 이용하실 수 있습니다. 또한, 무료 구내 전용 주차장, 장애인 주차 시설도 제공하고 있으며, 차로 10분만 가시면 속초 엑스포공원까지 가실 수 있습니다. 이 호텔에서는 24시간 경비시설, 모닝콜 서비스, 현금 지급기 외에도 다양한 서비스를 제공하고 있습니다. 편하게 휴식을 취할 수 있는 좋은 야외 테라스도 마련되어 있습니다. 또한, 스파 및 웰니스센터 La SPA에서 품격있는 휴식을 취할 수 있습니다. 이 호텔에는 556개의 객실이 있으며 파워 샤워 시설, 케이블/위성 채널 및 여행용 어댑터도 완비되어 있습니다. 전용 발코니, 커피/차 메이커, 슬리퍼도 이용하실 수 있습니다. 고객님들에게는 매일 다양한 조식이 제공됩니다. 호텔에서 양양 국제공항까지는 채 30분도 소요되지 않습니다. 차로 가까운 거리에 낙산사, 낙산해수욕장도 있습니다.','admin',2,'바다전망뷰, 바다앞호텔, 가성비좋은호텔','N',to_date('20/12/10','RR/MM/DD'));
Insert into TRIP2REAP.HOTEL (BO_NO,HOTEL_ADDRESS,HOTEL_LOCAL_CODE,HOTEL_SITE,HOTEL_TEL,HOTEL_REVIEW_SCORE,HOTEL_RANK,HOTEL_OPEN_TIME,HOTEL_CLOSE_TIME,HOTEL_OPTION,CHECK_IN,CHECK_OUT) values ( SEQ_BO_NO.CURRVAL ,'강원 속초시 대포항희망길 106',1,'https://www.ramadasc.co.kr/','033-630-6803',0,4,0,23,'와이파이, 조식, 레스토랑, 세탁, 24시간 리셉션, 수하물 보관, 피트니스, 스파/사우나, 비즈니스 시설, 주차, 장애인 편의시설, 주방',15,11);

Insert into TRIP2REAP.IMG_FILE (FILE_NO,BO_NO,ORIGIN_NAME,CHANGE_NAME,FILE_LEVEL,FILE_PATH,FILE_DELETE_YN) values (SEQ_FILE_NO.NEXTVAL , SEQ_BO_NO.CURRVAL ,'라마다속초호텔썸네일.jpeg','hotel_thumbnail_202012102348550326.jpeg',1,'/Users/ek/Documents/GitHub/Spring-Project-Trip2Reap/Spring-Final-Trip2Reap/src/main/webapp/resources/buploadFiles/hotel_thumbnail_202012102348550326.jpeg','N');
Insert into TRIP2REAP.IMG_FILE (FILE_NO,BO_NO,ORIGIN_NAME,CHANGE_NAME,FILE_LEVEL,FILE_PATH,FILE_DELETE_YN) values (SEQ_FILE_NO.NEXTVAL , SEQ_BO_NO.CURRVAL ,'라마다속초디테일2.jpeg','hotel_detail_202012102348550335.jpeg',2,'/Users/ek/Documents/GitHub/Spring-Project-Trip2Reap/Spring-Final-Trip2Reap/src/main/webapp/resources/buploadFiles/hotel_detail_202012102348550335.jpeg','N');
Insert into TRIP2REAP.IMG_FILE (FILE_NO,BO_NO,ORIGIN_NAME,CHANGE_NAME,FILE_LEVEL,FILE_PATH,FILE_DELETE_YN) values (SEQ_FILE_NO.NEXTVAL , SEQ_BO_NO.CURRVAL ,'라마다속초디테일3.jpeg','hotel_detail_202012102348550346.jpeg',2,'/Users/ek/Documents/GitHub/Spring-Project-Trip2Reap/Spring-Final-Trip2Reap/src/main/webapp/resources/buploadFiles/hotel_detail_202012102348550346.jpeg','N');
Insert into TRIP2REAP.IMG_FILE (FILE_NO,BO_NO,ORIGIN_NAME,CHANGE_NAME,FILE_LEVEL,FILE_PATH,FILE_DELETE_YN) values (SEQ_FILE_NO.NEXTVAL , SEQ_BO_NO.CURRVAL ,'라마다속초디테일4.jpeg','hotel_detail_202012102348550356.jpeg',2,'/Users/ek/Documents/GitHub/Spring-Project-Trip2Reap/Spring-Final-Trip2Reap/src/main/webapp/resources/buploadFiles/hotel_detail_202012102348550356.jpeg','N');
Insert into TRIP2REAP.IMG_FILE (FILE_NO,BO_NO,ORIGIN_NAME,CHANGE_NAME,FILE_LEVEL,FILE_PATH,FILE_DELETE_YN) values (SEQ_FILE_NO.NEXTVAL , SEQ_BO_NO.CURRVAL ,'라마다속초디테일5.jpeg','hotel_detail_202012102348550366.jpeg',2,'/Users/ek/Documents/GitHub/Spring-Project-Trip2Reap/Spring-Final-Trip2Reap/src/main/webapp/resources/buploadFiles/hotel_detail_202012102348550366.jpeg','N');
Insert into TRIP2REAP.IMG_FILE (FILE_NO,BO_NO,ORIGIN_NAME,CHANGE_NAME,FILE_LEVEL,FILE_PATH,FILE_DELETE_YN) values (SEQ_FILE_NO.NEXTVAL , SEQ_BO_NO.CURRVAL ,'라마다속초디테일6.jpeg','hotel_detail_202012102348550378.jpeg',2,'/Users/ek/Documents/GitHub/Spring-Project-Trip2Reap/Spring-Final-Trip2Reap/src/main/webapp/resources/buploadFiles/hotel_detail_202012102348550378.jpeg','N');
Insert into TRIP2REAP.IMG_FILE (FILE_NO,BO_NO,ORIGIN_NAME,CHANGE_NAME,FILE_LEVEL,FILE_PATH,FILE_DELETE_YN) values (SEQ_FILE_NO.NEXTVAL , SEQ_BO_NO.CURRVAL ,'라마다속초디테일7.jpeg','hotel_detail_202012102348550386.jpeg',2,'/Users/ek/Documents/GitHub/Spring-Project-Trip2Reap/Spring-Final-Trip2Reap/src/main/webapp/resources/buploadFiles/hotel_detail_202012102348550386.jpeg','N');
Insert into TRIP2REAP.IMG_FILE (FILE_NO,BO_NO,ORIGIN_NAME,CHANGE_NAME,FILE_LEVEL,FILE_PATH,FILE_DELETE_YN) values (SEQ_FILE_NO.NEXTVAL , SEQ_BO_NO.CURRVAL ,'라마다속초호텔디테일1.jpeg','hotel_detail_202012102348550396.jpeg',2,'/Users/ek/Documents/GitHub/Spring-Project-Trip2Reap/Spring-Final-Trip2Reap/src/main/webapp/resources/buploadFiles/hotel_detail_202012102348550396.jpeg','N');
Insert into TRIP2REAP.IMG_FILE (FILE_NO,BO_NO,ORIGIN_NAME,CHANGE_NAME,FILE_LEVEL,FILE_PATH,FILE_DELETE_YN) values (SEQ_FILE_NO.NEXTVAL , SEQ_BO_NO.CURRVAL ,'라마다속초호텔썸네일.jpeg','hotel_detail_202012102348550405.jpeg',2,'/Users/ek/Documents/GitHub/Spring-Project-Trip2Reap/Spring-Final-Trip2Reap/src/main/webapp/resources/buploadFiles/hotel_detail_202012102348550405.jpeg','N');

Insert into TRIP2REAP.ROOM (ROOM_NO,BO_NO,ROOM_TYPE,ROOM_NAME,PRICE_PER_DAY) values ( SEQ_ROOM_NO.NEXTVAL , SEQ_BO_NO.CURRVAL ,'더블룸','디럭스 더블룸',79400);


--35
Insert into TRIP2REAP.BOARD (BO_NO,CA_CODE,BO_TITLE,BO_CONTENT,MEMBER_ID,BO_COUNT,BO_TAG,BO_DELETE_YN,REGDATE) values (SEQ_BO_NO.NEXTVAL ,5,'롯데리조트 속초','롯데 리조트 속초 - <4성급:한국관광공사 인증> - 롯데 리조트 속초는 속초시외버스터미널에서 차로 약 15분 소요됩니다. 주변 관광지로는 속초 8경 중 하나로 꼽히는 아름다운 영랑호와 시내 풍경과 바다를 한눈에 즐길 수 있는 속초등대전망대가 있으며, 차로 약 15분 거리에 있습니다. 또한, 중앙 시장도 차로 약 15분이면 갈 수 있습니다. 호텔 내부에는 워터파크, 인피니티 풀, 게임존, 노래방이 있어 즐길 거리가 풍부합니다. 뿐만 아니라 피트니스센터, 테라피 샵, 기프트 샵, 편의점, 미팅룸이 있어 다양한 시설을 이용하실 수 있습니다. 객실은 호텔형과 콘도형으로 나뉘어있습니다. 내부에는 에어컨, TV, 냉장고, 커피포트 등이 갖춰져 있으며 욕실에는 비데, 욕실용품, 헤어드라이어가 구비되어 있습니다. 내부에는 뷔페 레스토랑, 푸드 마켓이 있어 식사하실 수 있습니다. 라운지, 루프탑 바에서는 휴식을 취하실 수 있습니다.','admin',1,'바다전망, 오션뷰, 롯데리조트','N',to_date('20/12/10','RR/MM/DD'));
Insert into TRIP2REAP.HOTEL (BO_NO,HOTEL_ADDRESS,HOTEL_LOCAL_CODE,HOTEL_SITE,HOTEL_TEL,HOTEL_REVIEW_SCORE,HOTEL_RANK,HOTEL_OPEN_TIME,HOTEL_CLOSE_TIME,HOTEL_OPTION,CHECK_IN,CHECK_OUT) values ( SEQ_BO_NO.CURRVAL ,'강원 속초시 대포항길 186',1,'https://www.lotteresort.com/main/ko/index','033-634-1000',0,4,7,22,'와이파이, 조식, 레스토랑, 세탁, 24시간 리셉션, 수하물 보관, 수영장, 피트니스, 스파/사우나, 카페, 비즈니스 시설, 주차, 바/라운지, 주방',15,12);

Insert into TRIP2REAP.IMG_FILE (FILE_NO,BO_NO,ORIGIN_NAME,CHANGE_NAME,FILE_LEVEL,FILE_PATH,FILE_DELETE_YN) values (SEQ_FILE_NO.NEXTVAL , SEQ_BO_NO.CURRVAL ,'롯데리조트속초썸네일.jpeg','hotel_thumbnail_202012102359310498.jpeg',1,'/Users/ek/Documents/GitHub/Spring-Project-Trip2Reap/Spring-Final-Trip2Reap/src/main/webapp/resources/buploadFiles/hotel_thumbnail_202012102359310498.jpeg','N');
Insert into TRIP2REAP.IMG_FILE (FILE_NO,BO_NO,ORIGIN_NAME,CHANGE_NAME,FILE_LEVEL,FILE_PATH,FILE_DELETE_YN) values (SEQ_FILE_NO.NEXTVAL , SEQ_BO_NO.CURRVAL ,'롯데리조트속초디테일1.jpeg','hotel_detail_202012102359310507.jpeg',2,'/Users/ek/Documents/GitHub/Spring-Project-Trip2Reap/Spring-Final-Trip2Reap/src/main/webapp/resources/buploadFiles/hotel_detail_202012102359310507.jpeg','N');
Insert into TRIP2REAP.IMG_FILE (FILE_NO,BO_NO,ORIGIN_NAME,CHANGE_NAME,FILE_LEVEL,FILE_PATH,FILE_DELETE_YN) values (SEQ_FILE_NO.NEXTVAL , SEQ_BO_NO.CURRVAL ,'롯데리조트속초디테일2.jpeg','hotel_detail_202012102359310513.jpeg',2,'/Users/ek/Documents/GitHub/Spring-Project-Trip2Reap/Spring-Final-Trip2Reap/src/main/webapp/resources/buploadFiles/hotel_detail_202012102359310513.jpeg','N');
Insert into TRIP2REAP.IMG_FILE (FILE_NO,BO_NO,ORIGIN_NAME,CHANGE_NAME,FILE_LEVEL,FILE_PATH,FILE_DELETE_YN) values (SEQ_FILE_NO.NEXTVAL , SEQ_BO_NO.CURRVAL ,'롯데리조트속초디테일3.jpeg','hotel_detail_202012102359310519.jpeg',2,'/Users/ek/Documents/GitHub/Spring-Project-Trip2Reap/Spring-Final-Trip2Reap/src/main/webapp/resources/buploadFiles/hotel_detail_202012102359310519.jpeg','N');
Insert into TRIP2REAP.IMG_FILE (FILE_NO,BO_NO,ORIGIN_NAME,CHANGE_NAME,FILE_LEVEL,FILE_PATH,FILE_DELETE_YN) values (SEQ_FILE_NO.NEXTVAL , SEQ_BO_NO.CURRVAL ,'롯데리조트속초썸네일.jpeg','hotel_detail_202012102359310525.jpeg',2,'/Users/ek/Documents/GitHub/Spring-Project-Trip2Reap/Spring-Final-Trip2Reap/src/main/webapp/resources/buploadFiles/hotel_detail_202012102359310525.jpeg','N');

Insert into TRIP2REAP.ROOM (ROOM_NO,BO_NO,ROOM_TYPE,ROOM_NAME,PRICE_PER_DAY) values ( SEQ_ROOM_NO.NEXTVAL , SEQ_BO_NO.CURRVAL ,'더블룸','디럭스 더블룸-바다전망',180000);
Insert into TRIP2REAP.ROOM (ROOM_NO,BO_NO,ROOM_TYPE,ROOM_NAME,PRICE_PER_DAY) values ( SEQ_ROOM_NO.NEXTVAL , SEQ_BO_NO.CURRVAL ,'디럭스룸','디럭스 더블룸-바다전망',180000);
Insert into TRIP2REAP.ROOM (ROOM_NO,BO_NO,ROOM_TYPE,ROOM_NAME,PRICE_PER_DAY) values ( SEQ_ROOM_NO.NEXTVAL , SEQ_BO_NO.CURRVAL ,'디럭스룸','디럭스 트윈룸',208600);
Insert into TRIP2REAP.ROOM (ROOM_NO,BO_NO,ROOM_TYPE,ROOM_NAME,PRICE_PER_DAY) values ( SEQ_ROOM_NO.NEXTVAL , SEQ_BO_NO.CURRVAL ,'트윈룸','디럭스 트윈룸',208600);
Insert into TRIP2REAP.ROOM (ROOM_NO,BO_NO,ROOM_TYPE,ROOM_NAME,PRICE_PER_DAY) values ( SEQ_ROOM_NO.NEXTVAL , SEQ_BO_NO.CURRVAL ,'더블룸','그랜드 디럭스 더블룸',217600);
Insert into TRIP2REAP.ROOM (ROOM_NO,BO_NO,ROOM_TYPE,ROOM_NAME,PRICE_PER_DAY) values ( SEQ_ROOM_NO.NEXTVAL , SEQ_BO_NO.CURRVAL ,'디럭스룸','그랜드 디럭스 더블룸',217600);


--36
Insert into TRIP2REAP.BOARD (BO_NO,CA_CODE,BO_TITLE,BO_CONTENT,MEMBER_ID,BO_COUNT,BO_TAG,BO_DELETE_YN,REGDATE) values (SEQ_BO_NO.NEXTVAL ,5,'씨크루즈 호텔 속초','속초 청학동에 위치한 씨크루즈호텔속초는 동해바다와 설악산을 포함한 강원도의 주요 명소로의 이동이 용이한 호텔입니다. 호텔에서 10분 정도 걸으시면 속초 중앙시장과 청초호 호수공원에 가실 수 있고 차로 약 10분을 가시면 속초엑스포월드랜드도 둘러보실 수 있습니다. 또한 속초 시외버스터미널과 고속버스터미널은 차로 약 10분 안에, 양양국제공항은 약 30분 안에 가실 수 있습니다. 호텔에서는 수하물 보관과 컨시어지 서비스, 객실 청소 서비스가 제공되며 편의시설로는 코인 세탁실, 컴퓨터와 프린터를 이용할 수 있는 비즈니스 센터, 편의점과 현금인출기, 그리고 수유실이 마련되어 있습니다. 또한 대규모 행사를 진행할 수 있는 연회장도 이용하실 수 있습니다. 호텔에는 총 443개의 객실이 갖춰져 있으며 스탠다드 ,디럭스, 스위트로 이루어져 있습니다. 심플하고 모던하게 디자인된 각 객실에는 TV, 냉난방 시스템, 냉장고 등이 갖춰져 있으며 전용 욕실에는 욕실용품과 타월, 그리고 객실 유형에 따라 월풀 욕조 또는 샤워 부스가 구비되어 있습니다. 또한 장애인도 이용 가능한 객실도 별도로 준비되어 있습니다. 호텔의 뷔페 레스토랑 고메팔레스(Gourmet Palace)에서는 해산물과 파스타 등 명셰프가 준비한 다양한 요리를 맛보실 수 있고 1층에 마련된 카페에서는 커피와 케이크 또는 샌드위치를 드실 수 있습니다.','admin',1,'속초호텔, 오션뷰, 가성비좋은호텔','N',to_date('20/12/10','RR/MM/DD'));
Insert into TRIP2REAP.HOTEL (BO_NO,HOTEL_ADDRESS,HOTEL_LOCAL_CODE,HOTEL_SITE,HOTEL_TEL,HOTEL_REVIEW_SCORE,HOTEL_RANK,HOTEL_OPEN_TIME,HOTEL_CLOSE_TIME,HOTEL_OPTION,CHECK_IN,CHECK_OUT) values ( SEQ_BO_NO.CURRVAL ,'강원 속초시 청초호반로 273',1,'http://www.seacruisehotel.com/index.php','지역번호 선택16448810',0,0,0,23,'와이파이, 24시간 리셉션',15,12);

Insert into TRIP2REAP.IMG_FILE (FILE_NO,BO_NO,ORIGIN_NAME,CHANGE_NAME,FILE_LEVEL,FILE_PATH,FILE_DELETE_YN) values (SEQ_FILE_NO.NEXTVAL , SEQ_BO_NO.CURRVAL ,'씨크루즈호텔속초썸네일.jpeg','hotel_thumbnail_202012110020540186.jpeg',1,'/Users/ek/Documents/GitHub/Spring-Project-Trip2Reap/Spring-Final-Trip2Reap/src/main/webapp/resources/buploadFiles/hotel_thumbnail_202012110020540186.jpeg','N');
Insert into TRIP2REAP.IMG_FILE (FILE_NO,BO_NO,ORIGIN_NAME,CHANGE_NAME,FILE_LEVEL,FILE_PATH,FILE_DELETE_YN) values (SEQ_FILE_NO.NEXTVAL , SEQ_BO_NO.CURRVAL ,'씨크루즈호텔디테일1.jpeg','hotel_detail_202012110020540201.jpeg',2,'/Users/ek/Documents/GitHub/Spring-Project-Trip2Reap/Spring-Final-Trip2Reap/src/main/webapp/resources/buploadFiles/hotel_detail_202012110020540201.jpeg','N');
Insert into TRIP2REAP.IMG_FILE (FILE_NO,BO_NO,ORIGIN_NAME,CHANGE_NAME,FILE_LEVEL,FILE_PATH,FILE_DELETE_YN) values (SEQ_FILE_NO.NEXTVAL , SEQ_BO_NO.CURRVAL ,'씨크루즈호텔디테일2.jpeg','hotel_detail_202012110020540213.jpeg',2,'/Users/ek/Documents/GitHub/Spring-Project-Trip2Reap/Spring-Final-Trip2Reap/src/main/webapp/resources/buploadFiles/hotel_detail_202012110020540213.jpeg','N');
Insert into TRIP2REAP.IMG_FILE (FILE_NO,BO_NO,ORIGIN_NAME,CHANGE_NAME,FILE_LEVEL,FILE_PATH,FILE_DELETE_YN) values (SEQ_FILE_NO.NEXTVAL , SEQ_BO_NO.CURRVAL ,'씨크루즈호텔디테일3.jpeg','hotel_detail_202012110020540223.jpeg',2,'/Users/ek/Documents/GitHub/Spring-Project-Trip2Reap/Spring-Final-Trip2Reap/src/main/webapp/resources/buploadFiles/hotel_detail_202012110020540223.jpeg','N');
Insert into TRIP2REAP.IMG_FILE (FILE_NO,BO_NO,ORIGIN_NAME,CHANGE_NAME,FILE_LEVEL,FILE_PATH,FILE_DELETE_YN) values (SEQ_FILE_NO.NEXTVAL , SEQ_BO_NO.CURRVAL ,'씨크루즈호텔디테일4.jpeg','hotel_detail_202012110020540235.jpeg',2,'/Users/ek/Documents/GitHub/Spring-Project-Trip2Reap/Spring-Final-Trip2Reap/src/main/webapp/resources/buploadFiles/hotel_detail_202012110020540235.jpeg','N');
Insert into TRIP2REAP.IMG_FILE (FILE_NO,BO_NO,ORIGIN_NAME,CHANGE_NAME,FILE_LEVEL,FILE_PATH,FILE_DELETE_YN) values (SEQ_FILE_NO.NEXTVAL , SEQ_BO_NO.CURRVAL ,'씨크루즈호텔속초썸네일.jpeg','hotel_detail_202012110020540246.jpeg',2,'/Users/ek/Documents/GitHub/Spring-Project-Trip2Reap/Spring-Final-Trip2Reap/src/main/webapp/resources/buploadFiles/hotel_detail_202012110020540246.jpeg','N');

Insert into TRIP2REAP.ROOM (ROOM_NO,BO_NO,ROOM_TYPE,ROOM_NAME,PRICE_PER_DAY) values ( SEQ_ROOM_NO.NEXTVAL , SEQ_BO_NO.CURRVAL ,'더블룸','스탠다드 더블룸',58400);
Insert into TRIP2REAP.ROOM (ROOM_NO,BO_NO,ROOM_TYPE,ROOM_NAME,PRICE_PER_DAY) values ( SEQ_ROOM_NO.NEXTVAL , SEQ_BO_NO.CURRVAL ,'스탠다드룸','스탠다드 더블룸',58400);
Insert into TRIP2REAP.ROOM (ROOM_NO,BO_NO,ROOM_TYPE,ROOM_NAME,PRICE_PER_DAY) values ( SEQ_ROOM_NO.NEXTVAL , SEQ_BO_NO.CURRVAL ,'스탠다드룸','스탠다드 트윈룸',58400);
Insert into TRIP2REAP.ROOM (ROOM_NO,BO_NO,ROOM_TYPE,ROOM_NAME,PRICE_PER_DAY) values ( SEQ_ROOM_NO.NEXTVAL , SEQ_BO_NO.CURRVAL ,'트윈룸','스탠다드 트윈룸',58400);
Insert into TRIP2REAP.ROOM (ROOM_NO,BO_NO,ROOM_TYPE,ROOM_NAME,PRICE_PER_DAY) values ( SEQ_ROOM_NO.NEXTVAL , SEQ_BO_NO.CURRVAL ,'스탠다드룸','스탠다드 하프옵션 트윈룸',65800);
Insert into TRIP2REAP.ROOM (ROOM_NO,BO_NO,ROOM_TYPE,ROOM_NAME,PRICE_PER_DAY) values ( SEQ_ROOM_NO.NEXTVAL , SEQ_BO_NO.CURRVAL ,'트윈룸','스탠다드 하프옵션 트윈룸',65800);
Insert into TRIP2REAP.ROOM (ROOM_NO,BO_NO,ROOM_TYPE,ROOM_NAME,PRICE_PER_DAY) values ( SEQ_ROOM_NO.NEXTVAL , SEQ_BO_NO.CURRVAL ,'더블룸','더블룸',73400);


--37
Insert into TRIP2REAP.BOARD (BO_NO,CA_CODE,BO_TITLE,BO_CONTENT,MEMBER_ID,BO_COUNT,BO_TAG,BO_DELETE_YN,REGDATE) values (SEQ_BO_NO.NEXTVAL ,5,'속초 마레몬스 호텔','속초 마레몬스 호텔 - <4성급:한국관광공사 인증> - 속초 마레몬스 호텔은 속초고속버스터미널에서 차로 15분 거리에 있습니다. 또한, 주변 관광지로는 차로 5분 거리에는 설악해맞이공원과 대포항이 있으며 호텔에서 차로 15분 거리에는 속초해수욕장과 낙산사가 있습니다. 차로 20분만 가시면 중앙시장과 아바이마을에서 다양한 먹거리를 즐기실 수 있습니다. 호텔 내에 피트니스 센터, 스파, 가라오케 등이 모두 있어 여유로운 시간을 보내실 수 있습니다. 또한, 비즈니스 고객님들을 위한 미팅룸과 비즈니스 센터가 있습니다. 뿐만 아니라, 프런트 데스크에서 세탁 및 룸서비스를 이용하실 수 있으며 야외 주차장을 무료로 제공하고 있습니다. 총 148개의 객실을 보유하고 있으며 134개의 객실에서 오션 뷰를 감상하실 수 있습니다. Wi-Fi가 완비된 모든 객실에서는 LED TV, 커피포트, 냉장고 등이 있으며 욕실에는 샤워 가운, 욕실용품, 비데 등이 구비되어 있습니다. 1층 조식당에서는 조식 뷔페를 제공하고 있으며 별도의 요금이 발생합니다. 또한, 11층에 위치한 스카이라운지 레스토랑에서는 동해 바다를 조망하며 샐러드 뷔페와 스테이크 등을 즐기실 수 있습니다.','admin',0,'속초호텔, 바다전망','N',to_date('20/12/10','RR/MM/DD'));
Insert into TRIP2REAP.HOTEL (BO_NO,HOTEL_ADDRESS,HOTEL_LOCAL_CODE,HOTEL_SITE,HOTEL_TEL,HOTEL_REVIEW_SCORE,HOTEL_RANK,HOTEL_OPEN_TIME,HOTEL_CLOSE_TIME,HOTEL_OPTION,CHECK_IN,CHECK_OUT) values ( SEQ_BO_NO.CURRVAL ,'강원 속초시 동해대로 3705',1,'https://www.hotelmaremons.com/','033-630-7000',0,4,6,22,'와이파이, 조식, 레스토랑, 세탁, 24시간 리셉션, 수하물 보관, 수영장, 피트니스, 스파/사우나, 비즈니스 시설, 주차, 장애인 편의시설, 주방',15,11);

Insert into TRIP2REAP.IMG_FILE (FILE_NO,BO_NO,ORIGIN_NAME,CHANGE_NAME,FILE_LEVEL,FILE_PATH,FILE_DELETE_YN) values (SEQ_FILE_NO.NEXTVAL , SEQ_BO_NO.CURRVAL ,'썸네일1.jpeg','hotel_thumbnail_202012110033240216.jpeg',1,'/Users/ek/Documents/GitHub/Spring-Project-Trip2Reap/Spring-Final-Trip2Reap/src/main/webapp/resources/buploadFiles/hotel_thumbnail_202012110033240216.jpeg','N');
Insert into TRIP2REAP.IMG_FILE (FILE_NO,BO_NO,ORIGIN_NAME,CHANGE_NAME,FILE_LEVEL,FILE_PATH,FILE_DELETE_YN) values (SEQ_FILE_NO.NEXTVAL , SEQ_BO_NO.CURRVAL ,'디테일3.jpeg','hotel_detail_202012110033240234.jpeg',2,'/Users/ek/Documents/GitHub/Spring-Project-Trip2Reap/Spring-Final-Trip2Reap/src/main/webapp/resources/buploadFiles/hotel_detail_202012110033240234.jpeg','N');
Insert into TRIP2REAP.IMG_FILE (FILE_NO,BO_NO,ORIGIN_NAME,CHANGE_NAME,FILE_LEVEL,FILE_PATH,FILE_DELETE_YN) values (SEQ_FILE_NO.NEXTVAL , SEQ_BO_NO.CURRVAL ,'디테일4.jpeg','hotel_detail_202012110033240243.jpeg',2,'/Users/ek/Documents/GitHub/Spring-Project-Trip2Reap/Spring-Final-Trip2Reap/src/main/webapp/resources/buploadFiles/hotel_detail_202012110033240243.jpeg','N');
Insert into TRIP2REAP.IMG_FILE (FILE_NO,BO_NO,ORIGIN_NAME,CHANGE_NAME,FILE_LEVEL,FILE_PATH,FILE_DELETE_YN) values (SEQ_FILE_NO.NEXTVAL , SEQ_BO_NO.CURRVAL ,'디테일5.jpeg','hotel_detail_202012110033240253.jpeg',2,'/Users/ek/Documents/GitHub/Spring-Project-Trip2Reap/Spring-Final-Trip2Reap/src/main/webapp/resources/buploadFiles/hotel_detail_202012110033240253.jpeg','N');
Insert into TRIP2REAP.IMG_FILE (FILE_NO,BO_NO,ORIGIN_NAME,CHANGE_NAME,FILE_LEVEL,FILE_PATH,FILE_DELETE_YN) values (SEQ_FILE_NO.NEXTVAL , SEQ_BO_NO.CURRVAL ,'디테일6.jpeg','hotel_detail_202012110033240263.jpeg',2,'/Users/ek/Documents/GitHub/Spring-Project-Trip2Reap/Spring-Final-Trip2Reap/src/main/webapp/resources/buploadFiles/hotel_detail_202012110033240263.jpeg','N');
Insert into TRIP2REAP.IMG_FILE (FILE_NO,BO_NO,ORIGIN_NAME,CHANGE_NAME,FILE_LEVEL,FILE_PATH,FILE_DELETE_YN) values (SEQ_FILE_NO.NEXTVAL , SEQ_BO_NO.CURRVAL ,'디테일7.jpeg','hotel_detail_202012110033240272.jpeg',2,'/Users/ek/Documents/GitHub/Spring-Project-Trip2Reap/Spring-Final-Trip2Reap/src/main/webapp/resources/buploadFiles/hotel_detail_202012110033240272.jpeg','N');
Insert into TRIP2REAP.IMG_FILE (FILE_NO,BO_NO,ORIGIN_NAME,CHANGE_NAME,FILE_LEVEL,FILE_PATH,FILE_DELETE_YN) values (SEQ_FILE_NO.NEXTVAL , SEQ_BO_NO.CURRVAL ,'디테일8.jpeg','hotel_detail_202012110033240290.jpeg',2,'/Users/ek/Documents/GitHub/Spring-Project-Trip2Reap/Spring-Final-Trip2Reap/src/main/webapp/resources/buploadFiles/hotel_detail_202012110033240290.jpeg','N');
Insert into TRIP2REAP.IMG_FILE (FILE_NO,BO_NO,ORIGIN_NAME,CHANGE_NAME,FILE_LEVEL,FILE_PATH,FILE_DELETE_YN) values (SEQ_FILE_NO.NEXTVAL , SEQ_BO_NO.CURRVAL ,'디테일9.jpeg','hotel_detail_202012110033240309.jpeg',2,'/Users/ek/Documents/GitHub/Spring-Project-Trip2Reap/Spring-Final-Trip2Reap/src/main/webapp/resources/buploadFiles/hotel_detail_202012110033240309.jpeg','N');
Insert into TRIP2REAP.IMG_FILE (FILE_NO,BO_NO,ORIGIN_NAME,CHANGE_NAME,FILE_LEVEL,FILE_PATH,FILE_DELETE_YN) values (SEQ_FILE_NO.NEXTVAL , SEQ_BO_NO.CURRVAL ,'디테일10.jpeg','hotel_detail_202012110033240337.jpeg',2,'/Users/ek/Documents/GitHub/Spring-Project-Trip2Reap/Spring-Final-Trip2Reap/src/main/webapp/resources/buploadFiles/hotel_detail_202012110033240337.jpeg','N');
Insert into TRIP2REAP.IMG_FILE (FILE_NO,BO_NO,ORIGIN_NAME,CHANGE_NAME,FILE_LEVEL,FILE_PATH,FILE_DELETE_YN) values (SEQ_FILE_NO.NEXTVAL , SEQ_BO_NO.CURRVAL ,'디테일11.jpeg','hotel_detail_202012110033240359.jpeg',2,'/Users/ek/Documents/GitHub/Spring-Project-Trip2Reap/Spring-Final-Trip2Reap/src/main/webapp/resources/buploadFiles/hotel_detail_202012110033240359.jpeg','N');
Insert into TRIP2REAP.IMG_FILE (FILE_NO,BO_NO,ORIGIN_NAME,CHANGE_NAME,FILE_LEVEL,FILE_PATH,FILE_DELETE_YN) values (SEQ_FILE_NO.NEXTVAL , SEQ_BO_NO.CURRVAL ,'디테일12.jpeg','hotel_detail_202012110033240374.jpeg',2,'/Users/ek/Documents/GitHub/Spring-Project-Trip2Reap/Spring-Final-Trip2Reap/src/main/webapp/resources/buploadFiles/hotel_detail_202012110033240374.jpeg','N');
Insert into TRIP2REAP.IMG_FILE (FILE_NO,BO_NO,ORIGIN_NAME,CHANGE_NAME,FILE_LEVEL,FILE_PATH,FILE_DELETE_YN) values (SEQ_FILE_NO.NEXTVAL , SEQ_BO_NO.CURRVAL ,'디테일13.jpeg','hotel_detail_202012110033240382.jpeg',2,'/Users/ek/Documents/GitHub/Spring-Project-Trip2Reap/Spring-Final-Trip2Reap/src/main/webapp/resources/buploadFiles/hotel_detail_202012110033240382.jpeg','N');
Insert into TRIP2REAP.IMG_FILE (FILE_NO,BO_NO,ORIGIN_NAME,CHANGE_NAME,FILE_LEVEL,FILE_PATH,FILE_DELETE_YN) values (SEQ_FILE_NO.NEXTVAL , SEQ_BO_NO.CURRVAL ,'디테일14.jpeg','hotel_detail_202012110033240393.jpeg',2,'/Users/ek/Documents/GitHub/Spring-Project-Trip2Reap/Spring-Final-Trip2Reap/src/main/webapp/resources/buploadFiles/hotel_detail_202012110033240393.jpeg','N');
Insert into TRIP2REAP.IMG_FILE (FILE_NO,BO_NO,ORIGIN_NAME,CHANGE_NAME,FILE_LEVEL,FILE_PATH,FILE_DELETE_YN) values (SEQ_FILE_NO.NEXTVAL , SEQ_BO_NO.CURRVAL ,'디테일15.jpeg','hotel_detail_202012110033240400.jpeg',2,'/Users/ek/Documents/GitHub/Spring-Project-Trip2Reap/Spring-Final-Trip2Reap/src/main/webapp/resources/buploadFiles/hotel_detail_202012110033240400.jpeg','N');
Insert into TRIP2REAP.IMG_FILE (FILE_NO,BO_NO,ORIGIN_NAME,CHANGE_NAME,FILE_LEVEL,FILE_PATH,FILE_DELETE_YN) values (SEQ_FILE_NO.NEXTVAL , SEQ_BO_NO.CURRVAL ,'썸네일1.jpeg','hotel_detail_202012110033240408.jpeg',2,'/Users/ek/Documents/GitHub/Spring-Project-Trip2Reap/Spring-Final-Trip2Reap/src/main/webapp/resources/buploadFiles/hotel_detail_202012110033240408.jpeg','N');
Insert into TRIP2REAP.IMG_FILE (FILE_NO,BO_NO,ORIGIN_NAME,CHANGE_NAME,FILE_LEVEL,FILE_PATH,FILE_DELETE_YN) values (SEQ_FILE_NO.NEXTVAL , SEQ_BO_NO.CURRVAL ,'디테일1.jpeg','hotel_detail_202012110033240415.jpeg',2,'/Users/ek/Documents/GitHub/Spring-Project-Trip2Reap/Spring-Final-Trip2Reap/src/main/webapp/resources/buploadFiles/hotel_detail_202012110033240415.jpeg','N');
Insert into TRIP2REAP.IMG_FILE (FILE_NO,BO_NO,ORIGIN_NAME,CHANGE_NAME,FILE_LEVEL,FILE_PATH,FILE_DELETE_YN) values (SEQ_FILE_NO.NEXTVAL , SEQ_BO_NO.CURRVAL ,'디테일2.jpeg','hotel_detail_202012110033240422.jpeg',2,'/Users/ek/Documents/GitHub/Spring-Project-Trip2Reap/Spring-Final-Trip2Reap/src/main/webapp/resources/buploadFiles/hotel_detail_202012110033240422.jpeg','N');

Insert into TRIP2REAP.ROOM (ROOM_NO,BO_NO,ROOM_TYPE,ROOM_NAME,PRICE_PER_DAY) values ( SEQ_ROOM_NO.NEXTVAL , SEQ_BO_NO.CURRVAL ,'더블룸','스탠다드 마운틴뷰 더블룸',60400);
Insert into TRIP2REAP.ROOM (ROOM_NO,BO_NO,ROOM_TYPE,ROOM_NAME,PRICE_PER_DAY) values ( SEQ_ROOM_NO.NEXTVAL , SEQ_BO_NO.CURRVAL ,'스탠다드룸','스탠다드 마운틴뷰 더블룸',60400);
Insert into TRIP2REAP.ROOM (ROOM_NO,BO_NO,ROOM_TYPE,ROOM_NAME,PRICE_PER_DAY) values ( SEQ_ROOM_NO.NEXTVAL , SEQ_BO_NO.CURRVAL ,'더블룸','더블룸 산전망',68000);
Insert into TRIP2REAP.ROOM (ROOM_NO,BO_NO,ROOM_TYPE,ROOM_NAME,PRICE_PER_DAY) values ( SEQ_ROOM_NO.NEXTVAL , SEQ_BO_NO.CURRVAL ,'트윈룸','트윈룸 바다전망',69700);
Insert into TRIP2REAP.ROOM (ROOM_NO,BO_NO,ROOM_TYPE,ROOM_NAME,PRICE_PER_DAY) values ( SEQ_ROOM_NO.NEXTVAL , SEQ_BO_NO.CURRVAL ,'디럭스룸','디럭스 트윈룸',79000);
Insert into TRIP2REAP.ROOM (ROOM_NO,BO_NO,ROOM_TYPE,ROOM_NAME,PRICE_PER_DAY) values ( SEQ_ROOM_NO.NEXTVAL , SEQ_BO_NO.CURRVAL ,'트윈룸','디럭스 트윈룸',79000);
Insert into TRIP2REAP.ROOM (ROOM_NO,BO_NO,ROOM_TYPE,ROOM_NAME,PRICE_PER_DAY) values ( SEQ_ROOM_NO.NEXTVAL , SEQ_BO_NO.CURRVAL ,'디럭스룸','디럭스 온돌룸',80800);
Insert into TRIP2REAP.ROOM (ROOM_NO,BO_NO,ROOM_TYPE,ROOM_NAME,PRICE_PER_DAY) values ( SEQ_ROOM_NO.NEXTVAL , SEQ_BO_NO.CURRVAL ,'온돌룸','디럭스 온돌룸',80800);


--38
Insert into TRIP2REAP.BOARD (BO_NO,CA_CODE,BO_TITLE,BO_CONTENT,MEMBER_ID,BO_COUNT,BO_TAG,BO_DELETE_YN,REGDATE) values (SEQ_BO_NO.NEXTVAL ,5,'속초 썬라이즈 호텔','청초호와 동해의 조망권을 갖춘 썬라이즈호텔은 속초 고속버스터미널에서 차로 약 10분, 양양 국제공항에서 차로 약 35분 걸립니다. 주변 명소인 청초호, 엑스포타워, 영금정은 차로 모두 6분이면 갈 수 있습니다. 이처럼 관광하시기에 좋은 최적의 장소에 위치해있습니다. 호텔에는 여유로운 공간을 갖춘 회의실이 있어 비즈니스 업무를 진행하실 수 있습니다. 편의점도 있어 자유롭게 이용하실 수 있습니다. 현대적인 인테리어의 객실 내부에는 에어컨, TV, 냉장고, 전자레인지, 싱크대, 헤어드라이어, 커피포트, 생수가 완비되어 있으며 욕실에는 비데와 욕실용품이 마련되어 있습니다. 호텔 내부의 레스토랑에서는 식사하실 수 있습니다. 펍에서는 간단한 음식과 함께 주류를 즐길 수 있습니다.','admin',0,'바다전망, 동해바다앞호텔','N',to_date('20/12/10','RR/MM/DD'));
Insert into TRIP2REAP.HOTEL (BO_NO,HOTEL_ADDRESS,HOTEL_LOCAL_CODE,HOTEL_SITE,HOTEL_TEL,HOTEL_REVIEW_SCORE,HOTEL_RANK,HOTEL_OPEN_TIME,HOTEL_CLOSE_TIME,HOTEL_OPTION,CHECK_IN,CHECK_OUT) values ( SEQ_BO_NO.CURRVAL ,'강원 속초시 청초호반로 291',1,null,'033-631-0111',0,4,0,23,null,15,11);

Insert into TRIP2REAP.IMG_FILE (FILE_NO,BO_NO,ORIGIN_NAME,CHANGE_NAME,FILE_LEVEL,FILE_PATH,FILE_DELETE_YN) values (SEQ_FILE_NO.NEXTVAL , SEQ_BO_NO.CURRVAL ,'썸네일.jpeg','hotel_thumbnail_202012110047570923.jpeg',1,'/Users/ek/Documents/GitHub/Spring-Project-Trip2Reap/Spring-Final-Trip2Reap/src/main/webapp/resources/buploadFiles/hotel_thumbnail_202012110047570923.jpeg','N');
Insert into TRIP2REAP.IMG_FILE (FILE_NO,BO_NO,ORIGIN_NAME,CHANGE_NAME,FILE_LEVEL,FILE_PATH,FILE_DELETE_YN) values (SEQ_FILE_NO.NEXTVAL , SEQ_BO_NO.CURRVAL ,'디테일3.jpeg','hotel_detail_202012110047570931.jpeg',2,'/Users/ek/Documents/GitHub/Spring-Project-Trip2Reap/Spring-Final-Trip2Reap/src/main/webapp/resources/buploadFiles/hotel_detail_202012110047570931.jpeg','N');
Insert into TRIP2REAP.IMG_FILE (FILE_NO,BO_NO,ORIGIN_NAME,CHANGE_NAME,FILE_LEVEL,FILE_PATH,FILE_DELETE_YN) values (SEQ_FILE_NO.NEXTVAL , SEQ_BO_NO.CURRVAL ,'디테일4.jpeg','hotel_detail_202012110047570939.jpeg',2,'/Users/ek/Documents/GitHub/Spring-Project-Trip2Reap/Spring-Final-Trip2Reap/src/main/webapp/resources/buploadFiles/hotel_detail_202012110047570939.jpeg','N');
Insert into TRIP2REAP.IMG_FILE (FILE_NO,BO_NO,ORIGIN_NAME,CHANGE_NAME,FILE_LEVEL,FILE_PATH,FILE_DELETE_YN) values (SEQ_FILE_NO.NEXTVAL , SEQ_BO_NO.CURRVAL ,'디테일5.jpeg','hotel_detail_202012110047570948.jpeg',2,'/Users/ek/Documents/GitHub/Spring-Project-Trip2Reap/Spring-Final-Trip2Reap/src/main/webapp/resources/buploadFiles/hotel_detail_202012110047570948.jpeg','N');
Insert into TRIP2REAP.IMG_FILE (FILE_NO,BO_NO,ORIGIN_NAME,CHANGE_NAME,FILE_LEVEL,FILE_PATH,FILE_DELETE_YN) values (SEQ_FILE_NO.NEXTVAL , SEQ_BO_NO.CURRVAL ,'디테일6.jpeg','hotel_detail_202012110047570955.jpeg',2,'/Users/ek/Documents/GitHub/Spring-Project-Trip2Reap/Spring-Final-Trip2Reap/src/main/webapp/resources/buploadFiles/hotel_detail_202012110047570955.jpeg','N');
Insert into TRIP2REAP.IMG_FILE (FILE_NO,BO_NO,ORIGIN_NAME,CHANGE_NAME,FILE_LEVEL,FILE_PATH,FILE_DELETE_YN) values (SEQ_FILE_NO.NEXTVAL , SEQ_BO_NO.CURRVAL ,'디테일7.jpeg','hotel_detail_202012110047570967.jpeg',2,'/Users/ek/Documents/GitHub/Spring-Project-Trip2Reap/Spring-Final-Trip2Reap/src/main/webapp/resources/buploadFiles/hotel_detail_202012110047570967.jpeg','N');
Insert into TRIP2REAP.IMG_FILE (FILE_NO,BO_NO,ORIGIN_NAME,CHANGE_NAME,FILE_LEVEL,FILE_PATH,FILE_DELETE_YN) values (SEQ_FILE_NO.NEXTVAL , SEQ_BO_NO.CURRVAL ,'썸네일.jpeg','hotel_detail_202012110047570976.jpeg',2,'/Users/ek/Documents/GitHub/Spring-Project-Trip2Reap/Spring-Final-Trip2Reap/src/main/webapp/resources/buploadFiles/hotel_detail_202012110047570976.jpeg','N');
Insert into TRIP2REAP.IMG_FILE (FILE_NO,BO_NO,ORIGIN_NAME,CHANGE_NAME,FILE_LEVEL,FILE_PATH,FILE_DELETE_YN) values (SEQ_FILE_NO.NEXTVAL , SEQ_BO_NO.CURRVAL ,'디테일1.jpeg','hotel_detail_202012110047570984.jpeg',2,'/Users/ek/Documents/GitHub/Spring-Project-Trip2Reap/Spring-Final-Trip2Reap/src/main/webapp/resources/buploadFiles/hotel_detail_202012110047570984.jpeg','N');
Insert into TRIP2REAP.IMG_FILE (FILE_NO,BO_NO,ORIGIN_NAME,CHANGE_NAME,FILE_LEVEL,FILE_PATH,FILE_DELETE_YN) values (SEQ_FILE_NO.NEXTVAL , SEQ_BO_NO.CURRVAL ,'디테일2.jpeg','hotel_detail_202012110047570992.jpeg',2,'/Users/ek/Documents/GitHub/Spring-Project-Trip2Reap/Spring-Final-Trip2Reap/src/main/webapp/resources/buploadFiles/hotel_detail_202012110047570992.jpeg','N');

Insert into TRIP2REAP.ROOM (ROOM_NO,BO_NO,ROOM_TYPE,ROOM_NAME,PRICE_PER_DAY) values ( SEQ_ROOM_NO.NEXTVAL , SEQ_BO_NO.CURRVAL ,'스탠다드룸','스탠다드 더블룸 -시내전망',71000);
Insert into TRIP2REAP.ROOM (ROOM_NO,BO_NO,ROOM_TYPE,ROOM_NAME,PRICE_PER_DAY) values ( SEQ_ROOM_NO.NEXTVAL , SEQ_BO_NO.CURRVAL ,'더블룸','스탠다드 더블룸-시내전망',71000);
Insert into TRIP2REAP.ROOM (ROOM_NO,BO_NO,ROOM_TYPE,ROOM_NAME,PRICE_PER_DAY) values ( SEQ_ROOM_NO.NEXTVAL , SEQ_BO_NO.CURRVAL ,'패밀리룸','패밀리룸',77200);
Insert into TRIP2REAP.ROOM (ROOM_NO,BO_NO,ROOM_TYPE,ROOM_NAME,PRICE_PER_DAY) values ( SEQ_ROOM_NO.NEXTVAL , SEQ_BO_NO.CURRVAL ,'트윈룸','디럭스 트윈룸',77200);
Insert into TRIP2REAP.ROOM (ROOM_NO,BO_NO,ROOM_TYPE,ROOM_NAME,PRICE_PER_DAY) values ( SEQ_ROOM_NO.NEXTVAL , SEQ_BO_NO.CURRVAL ,'디럭스룸','디럭스 트윈룸',77200);
Insert into TRIP2REAP.ROOM (ROOM_NO,BO_NO,ROOM_TYPE,ROOM_NAME,PRICE_PER_DAY) values ( SEQ_ROOM_NO.NEXTVAL , SEQ_BO_NO.CURRVAL ,'스탠다드룸','스탠다드 더블룸 -부분바다전망',80900);
Insert into TRIP2REAP.ROOM (ROOM_NO,BO_NO,ROOM_TYPE,ROOM_NAME,PRICE_PER_DAY) values ( SEQ_ROOM_NO.NEXTVAL , SEQ_BO_NO.CURRVAL ,'더블룸','스탠다드 더블룸-부분바다전망',80900);
Insert into TRIP2REAP.ROOM (ROOM_NO,BO_NO,ROOM_TYPE,ROOM_NAME,PRICE_PER_DAY) values ( SEQ_ROOM_NO.NEXTVAL , SEQ_BO_NO.CURRVAL ,'패밀리룸','패밀리룸 - 산전망',80900);

--39
Insert into TRIP2REAP.BOARD (BO_NO,CA_CODE,BO_TITLE,BO_CONTENT,MEMBER_ID,BO_COUNT,BO_TAG,BO_DELETE_YN,REGDATE) values (SEQ_BO_NO.NEXTVAL ,5,'켄싱턴 호텔 설악','켄싱턴 호텔 설악 - <4성급:한국관광공사 인증> - 켄싱턴 호텔 설악은 설악산 국립공원 입구에서 차로 단 5분 거리에 있습니다. 또한, 청초호, 속초해수욕장, 대포항 등 속초의 주요 관광지가 차로 약 25분 거리에 있습니다. 또한, 차로 30분 거리의 중앙시장 또는 아바이 마을에서 다양한 먹거리를 즐기실 수 있습니다. 호텔 내에는 PC, 복합기 등을 무료로 이용하실 수 있는 비즈니스 센터가 있으며 1층에 의류 매장도 있어서 편리하게 쇼핑을 하실 수 있습니다. 프런트 데스크에서는 환전 및 세탁 서비스를 제공하고 있습니다. 또한, 투숙객에게 무료로 제공되는 외부 주차장이 있습니다. 전체 108개의 객실이 있으며 31개의 온돌 객실 등 다양한 규모와 유형의 객실이 준비되어 있습니다. 깔끔하게 꾸며진 객실에서는 미니바, 가습기, 슬리퍼 등이 있으며 욕실에는 목욕 가운, 욕실용품, 헤어드라이어 등이 구비되어 있습니다. 뿐만 아니라, 일부 객실에서는 아름다운 설악산 전경을 감상하실 수 있습니다. 호텔의 2층 더퀸에서는 한식 및 스테이크를, 9층 애비로드에서는 피자 및 파스타 메뉴를 선보이고 있습니다. 또한, 별도의 요금을 지불하시면 더퀸 레스토랑에서 조식 뷔페를 드실 수 있습니다.','admin',1,'설악산, 온돌룸, 산전망','N',to_date('20/12/10','RR/MM/DD'));
Insert into TRIP2REAP.HOTEL (BO_NO,HOTEL_ADDRESS,HOTEL_LOCAL_CODE,HOTEL_SITE,HOTEL_TEL,HOTEL_REVIEW_SCORE,HOTEL_RANK,HOTEL_OPEN_TIME,HOTEL_CLOSE_TIME,HOTEL_OPTION,CHECK_IN,CHECK_OUT) values ( SEQ_BO_NO.CURRVAL ,'강원 속초시 설악산로 998',1,'https://www.kensington.co.kr/hsr','033-635-4001',0,4,0,23,'와이파이, 조식, 레스토랑, 세탁, 24시간 리셉션, 수하물 보관, 카페, 비즈니스 시설, 주차, 장애인 편의시설, 룸서비스',15,11);

Insert into TRIP2REAP.IMG_FILE (FILE_NO,BO_NO,ORIGIN_NAME,CHANGE_NAME,FILE_LEVEL,FILE_PATH,FILE_DELETE_YN) values (SEQ_FILE_NO.NEXTVAL , SEQ_BO_NO.CURRVAL ,'썸네일.jpeg','hotel_thumbnail_202012110055120829.jpeg',1,'/Users/ek/Documents/GitHub/Spring-Project-Trip2Reap/Spring-Final-Trip2Reap/src/main/webapp/resources/buploadFiles/hotel_thumbnail_202012110055120829.jpeg','N');
Insert into TRIP2REAP.IMG_FILE (FILE_NO,BO_NO,ORIGIN_NAME,CHANGE_NAME,FILE_LEVEL,FILE_PATH,FILE_DELETE_YN) values (SEQ_FILE_NO.NEXTVAL , SEQ_BO_NO.CURRVAL ,'디테일1.jpeg','hotel_detail_202012110055120838.jpeg',2,'/Users/ek/Documents/GitHub/Spring-Project-Trip2Reap/Spring-Final-Trip2Reap/src/main/webapp/resources/buploadFiles/hotel_detail_202012110055120838.jpeg','N');
Insert into TRIP2REAP.IMG_FILE (FILE_NO,BO_NO,ORIGIN_NAME,CHANGE_NAME,FILE_LEVEL,FILE_PATH,FILE_DELETE_YN) values (SEQ_FILE_NO.NEXTVAL , SEQ_BO_NO.CURRVAL ,'디테일2.jpeg','hotel_detail_202012110055120857.jpeg',2,'/Users/ek/Documents/GitHub/Spring-Project-Trip2Reap/Spring-Final-Trip2Reap/src/main/webapp/resources/buploadFiles/hotel_detail_202012110055120857.jpeg','N');
Insert into TRIP2REAP.IMG_FILE (FILE_NO,BO_NO,ORIGIN_NAME,CHANGE_NAME,FILE_LEVEL,FILE_PATH,FILE_DELETE_YN) values (SEQ_FILE_NO.NEXTVAL , SEQ_BO_NO.CURRVAL ,'디테일3.jpeg','hotel_detail_202012110055120870.jpeg',2,'/Users/ek/Documents/GitHub/Spring-Project-Trip2Reap/Spring-Final-Trip2Reap/src/main/webapp/resources/buploadFiles/hotel_detail_202012110055120870.jpeg','N');
Insert into TRIP2REAP.IMG_FILE (FILE_NO,BO_NO,ORIGIN_NAME,CHANGE_NAME,FILE_LEVEL,FILE_PATH,FILE_DELETE_YN) values (SEQ_FILE_NO.NEXTVAL , SEQ_BO_NO.CURRVAL ,'디테일4.jpeg','hotel_detail_202012110055120887.jpeg',2,'/Users/ek/Documents/GitHub/Spring-Project-Trip2Reap/Spring-Final-Trip2Reap/src/main/webapp/resources/buploadFiles/hotel_detail_202012110055120887.jpeg','N');
Insert into TRIP2REAP.IMG_FILE (FILE_NO,BO_NO,ORIGIN_NAME,CHANGE_NAME,FILE_LEVEL,FILE_PATH,FILE_DELETE_YN) values (SEQ_FILE_NO.NEXTVAL , SEQ_BO_NO.CURRVAL ,'디테일5.jpeg','hotel_detail_202012110055120900.jpeg',2,'/Users/ek/Documents/GitHub/Spring-Project-Trip2Reap/Spring-Final-Trip2Reap/src/main/webapp/resources/buploadFiles/hotel_detail_202012110055120900.jpeg','N');
Insert into TRIP2REAP.IMG_FILE (FILE_NO,BO_NO,ORIGIN_NAME,CHANGE_NAME,FILE_LEVEL,FILE_PATH,FILE_DELETE_YN) values (SEQ_FILE_NO.NEXTVAL , SEQ_BO_NO.CURRVAL ,'디테일6.jpeg','hotel_detail_202012110055120909.jpeg',2,'/Users/ek/Documents/GitHub/Spring-Project-Trip2Reap/Spring-Final-Trip2Reap/src/main/webapp/resources/buploadFiles/hotel_detail_202012110055120909.jpeg','N');
Insert into TRIP2REAP.IMG_FILE (FILE_NO,BO_NO,ORIGIN_NAME,CHANGE_NAME,FILE_LEVEL,FILE_PATH,FILE_DELETE_YN) values (SEQ_FILE_NO.NEXTVAL , SEQ_BO_NO.CURRVAL ,'디테일7.jpeg','hotel_detail_202012110055120919.jpeg',2,'/Users/ek/Documents/GitHub/Spring-Project-Trip2Reap/Spring-Final-Trip2Reap/src/main/webapp/resources/buploadFiles/hotel_detail_202012110055120919.jpeg','N');
Insert into TRIP2REAP.IMG_FILE (FILE_NO,BO_NO,ORIGIN_NAME,CHANGE_NAME,FILE_LEVEL,FILE_PATH,FILE_DELETE_YN) values (SEQ_FILE_NO.NEXTVAL , SEQ_BO_NO.CURRVAL ,'디테일8.jpeg','hotel_detail_202012110055120932.jpeg',2,'/Users/ek/Documents/GitHub/Spring-Project-Trip2Reap/Spring-Final-Trip2Reap/src/main/webapp/resources/buploadFiles/hotel_detail_202012110055120932.jpeg','N');
Insert into TRIP2REAP.IMG_FILE (FILE_NO,BO_NO,ORIGIN_NAME,CHANGE_NAME,FILE_LEVEL,FILE_PATH,FILE_DELETE_YN) values (SEQ_FILE_NO.NEXTVAL , SEQ_BO_NO.CURRVAL ,'썸네일.jpeg','hotel_detail_202012110055120946.jpeg',2,'/Users/ek/Documents/GitHub/Spring-Project-Trip2Reap/Spring-Final-Trip2Reap/src/main/webapp/resources/buploadFiles/hotel_detail_202012110055120946.jpeg','N');

Insert into TRIP2REAP.ROOM (ROOM_NO,BO_NO,ROOM_TYPE,ROOM_NAME,PRICE_PER_DAY) values ( SEQ_ROOM_NO.NEXTVAL , SEQ_BO_NO.CURRVAL ,'스탠다드룸','스탠다드 온돌룸',59800);
Insert into TRIP2REAP.ROOM (ROOM_NO,BO_NO,ROOM_TYPE,ROOM_NAME,PRICE_PER_DAY) values ( SEQ_ROOM_NO.NEXTVAL , SEQ_BO_NO.CURRVAL ,'온돌룸','스탠다드 온돌룸',59800);
Insert into TRIP2REAP.ROOM (ROOM_NO,BO_NO,ROOM_TYPE,ROOM_NAME,PRICE_PER_DAY) values ( SEQ_ROOM_NO.NEXTVAL , SEQ_BO_NO.CURRVAL ,'스탠다드룸','스탠다드 킹룸',67400);
Insert into TRIP2REAP.ROOM (ROOM_NO,BO_NO,ROOM_TYPE,ROOM_NAME,PRICE_PER_DAY) values ( SEQ_ROOM_NO.NEXTVAL , SEQ_BO_NO.CURRVAL ,'트윈룸','클래식 마운틴 트윈룸',82200);


--40
Insert into TRIP2REAP.BOARD (BO_NO,CA_CODE,BO_TITLE,BO_CONTENT,MEMBER_ID,BO_COUNT,BO_TAG,BO_DELETE_YN,REGDATE) values (SEQ_BO_NO.NEXTVAL ,5,'한화리조트 설악 쏘라노','설악산과 동해를 바라보며 골프를 즐길 수 있는 플라자CC설악이 있는 한화 리조트 설악 쏘라노는 설악산 국립공원에서 차로 30분 거리에 있습니다. 주변 관광지로는 차로 25분 거리에 있는 중앙시장과 아바이마을에서 다양한 먹거리를 맛보실 수도 있습니다. 또한, 서울-리조트 간 운행하는 정기운행버스가 있습니다. 속초에 자리한 이 리조트에는 공용 지역 무료 무선 인터넷 등이 완비되어 있습니다. 편안하고 아늑한 객실에는 전용 발코니, 냉장고, 객실내 식사 공간도 갖춰져 있습니다. 이 리조트에서는 고객님들을 위해 카페, 놀이터 등을 포함한 다양한 시설과 서비스를 제공하고 있으며 내부에 골프코스도 있습니다. 친절한 미소로 게스트들을 지원해드릴 직원들이 항시 대기하고 있습니다. 모든 객실에는 에어컨이 완비되어 있고 평면 TV, 케이블/위성 채널 및 샤워 시설도 제공하고 있습니다. 각 객실에 객실 내 앉을 공간, 슬리퍼, 방에 딸린 옷장 등이 완비되어 있습니다.','admin',2,'설악산뷰, 동해바다뷰, 한화리조트','N',to_date('20/12/10','RR/MM/DD'));
Insert into TRIP2REAP.HOTEL (BO_NO,HOTEL_ADDRESS,HOTEL_LOCAL_CODE,HOTEL_SITE,HOTEL_TEL,HOTEL_REVIEW_SCORE,HOTEL_RANK,HOTEL_OPEN_TIME,HOTEL_CLOSE_TIME,HOTEL_OPTION,CHECK_IN,CHECK_OUT) values ( SEQ_BO_NO.CURRVAL ,'강원 속초시 미시령로2983번길 111',1,'https://www.hanwharesort.co.kr/irsweb/resort3/index_.do','033-630-5500',0,4,0,23,'와이파이, 조식, 레스토랑, 세탁, 24시간 리셉션, 수하물 보관, 수영장, 피트니스, 스파/사우나, 카페, 비즈니스 시설, 주차, 장애인 편의시설, 주방, 아이돌봄 서비스',15,11);

Insert into TRIP2REAP.IMG_FILE (FILE_NO,BO_NO,ORIGIN_NAME,CHANGE_NAME,FILE_LEVEL,FILE_PATH,FILE_DELETE_YN) values (SEQ_FILE_NO.NEXTVAL , SEQ_BO_NO.CURRVAL ,'썸네일.jpeg','hotel_thumbnail_202012110113280665.jpeg',1,'/Users/ek/Documents/GitHub/Spring-Project-Trip2Reap/Spring-Final-Trip2Reap/src/main/webapp/resources/buploadFiles/hotel_thumbnail_202012110113280665.jpeg','N');
Insert into TRIP2REAP.IMG_FILE (FILE_NO,BO_NO,ORIGIN_NAME,CHANGE_NAME,FILE_LEVEL,FILE_PATH,FILE_DELETE_YN) values (SEQ_FILE_NO.NEXTVAL , SEQ_BO_NO.CURRVAL ,'디테일1.jpeg','hotel_detail_202012110113280675.jpeg',2,'/Users/ek/Documents/GitHub/Spring-Project-Trip2Reap/Spring-Final-Trip2Reap/src/main/webapp/resources/buploadFiles/hotel_detail_202012110113280675.jpeg','N');
Insert into TRIP2REAP.IMG_FILE (FILE_NO,BO_NO,ORIGIN_NAME,CHANGE_NAME,FILE_LEVEL,FILE_PATH,FILE_DELETE_YN) values (SEQ_FILE_NO.NEXTVAL , SEQ_BO_NO.CURRVAL ,'디테일2.jpeg','hotel_detail_202012110113280688.jpeg',2,'/Users/ek/Documents/GitHub/Spring-Project-Trip2Reap/Spring-Final-Trip2Reap/src/main/webapp/resources/buploadFiles/hotel_detail_202012110113280688.jpeg','N');
Insert into TRIP2REAP.IMG_FILE (FILE_NO,BO_NO,ORIGIN_NAME,CHANGE_NAME,FILE_LEVEL,FILE_PATH,FILE_DELETE_YN) values (SEQ_FILE_NO.NEXTVAL , SEQ_BO_NO.CURRVAL ,'디테일3.jpeg','hotel_detail_202012110113280699.jpeg',2,'/Users/ek/Documents/GitHub/Spring-Project-Trip2Reap/Spring-Final-Trip2Reap/src/main/webapp/resources/buploadFiles/hotel_detail_202012110113280699.jpeg','N');
Insert into TRIP2REAP.IMG_FILE (FILE_NO,BO_NO,ORIGIN_NAME,CHANGE_NAME,FILE_LEVEL,FILE_PATH,FILE_DELETE_YN) values (SEQ_FILE_NO.NEXTVAL , SEQ_BO_NO.CURRVAL ,'디테일4.jpeg','hotel_detail_202012110113280708.jpeg',2,'/Users/ek/Documents/GitHub/Spring-Project-Trip2Reap/Spring-Final-Trip2Reap/src/main/webapp/resources/buploadFiles/hotel_detail_202012110113280708.jpeg','N');
Insert into TRIP2REAP.IMG_FILE (FILE_NO,BO_NO,ORIGIN_NAME,CHANGE_NAME,FILE_LEVEL,FILE_PATH,FILE_DELETE_YN) values (SEQ_FILE_NO.NEXTVAL , SEQ_BO_NO.CURRVAL ,'디테일5.jpeg','hotel_detail_202012110113280720.jpeg',2,'/Users/ek/Documents/GitHub/Spring-Project-Trip2Reap/Spring-Final-Trip2Reap/src/main/webapp/resources/buploadFiles/hotel_detail_202012110113280720.jpeg','N');
Insert into TRIP2REAP.IMG_FILE (FILE_NO,BO_NO,ORIGIN_NAME,CHANGE_NAME,FILE_LEVEL,FILE_PATH,FILE_DELETE_YN) values (SEQ_FILE_NO.NEXTVAL , SEQ_BO_NO.CURRVAL ,'디테일6.jpeg','hotel_detail_202012110113280726.jpeg',2,'/Users/ek/Documents/GitHub/Spring-Project-Trip2Reap/Spring-Final-Trip2Reap/src/main/webapp/resources/buploadFiles/hotel_detail_202012110113280726.jpeg','N');
Insert into TRIP2REAP.IMG_FILE (FILE_NO,BO_NO,ORIGIN_NAME,CHANGE_NAME,FILE_LEVEL,FILE_PATH,FILE_DELETE_YN) values (SEQ_FILE_NO.NEXTVAL , SEQ_BO_NO.CURRVAL ,'디테일7.jpeg','hotel_detail_202012110113280734.jpeg',2,'/Users/ek/Documents/GitHub/Spring-Project-Trip2Reap/Spring-Final-Trip2Reap/src/main/webapp/resources/buploadFiles/hotel_detail_202012110113280734.jpeg','N');
Insert into TRIP2REAP.IMG_FILE (FILE_NO,BO_NO,ORIGIN_NAME,CHANGE_NAME,FILE_LEVEL,FILE_PATH,FILE_DELETE_YN) values (SEQ_FILE_NO.NEXTVAL , SEQ_BO_NO.CURRVAL ,'디테일8.jpeg','hotel_detail_202012110113280740.jpeg',2,'/Users/ek/Documents/GitHub/Spring-Project-Trip2Reap/Spring-Final-Trip2Reap/src/main/webapp/resources/buploadFiles/hotel_detail_202012110113280740.jpeg','N');
Insert into TRIP2REAP.IMG_FILE (FILE_NO,BO_NO,ORIGIN_NAME,CHANGE_NAME,FILE_LEVEL,FILE_PATH,FILE_DELETE_YN) values (SEQ_FILE_NO.NEXTVAL , SEQ_BO_NO.CURRVAL ,'디테일9.jpeg','hotel_detail_202012110113280746.jpeg',2,'/Users/ek/Documents/GitHub/Spring-Project-Trip2Reap/Spring-Final-Trip2Reap/src/main/webapp/resources/buploadFiles/hotel_detail_202012110113280746.jpeg','N');
Insert into TRIP2REAP.IMG_FILE (FILE_NO,BO_NO,ORIGIN_NAME,CHANGE_NAME,FILE_LEVEL,FILE_PATH,FILE_DELETE_YN) values (SEQ_FILE_NO.NEXTVAL , SEQ_BO_NO.CURRVAL ,'디테일10.jpeg','hotel_detail_202012110113280754.jpeg',2,'/Users/ek/Documents/GitHub/Spring-Project-Trip2Reap/Spring-Final-Trip2Reap/src/main/webapp/resources/buploadFiles/hotel_detail_202012110113280754.jpeg','N');
Insert into TRIP2REAP.IMG_FILE (FILE_NO,BO_NO,ORIGIN_NAME,CHANGE_NAME,FILE_LEVEL,FILE_PATH,FILE_DELETE_YN) values (SEQ_FILE_NO.NEXTVAL , SEQ_BO_NO.CURRVAL ,'썸네일.jpeg','hotel_detail_202012110113280762.jpeg',2,'/Users/ek/Documents/GitHub/Spring-Project-Trip2Reap/Spring-Final-Trip2Reap/src/main/webapp/resources/buploadFiles/hotel_detail_202012110113280762.jpeg','N');

Insert into TRIP2REAP.ROOM (ROOM_NO,BO_NO,ROOM_TYPE,ROOM_NAME,PRICE_PER_DAY) values ( SEQ_ROOM_NO.NEXTVAL , SEQ_BO_NO.CURRVAL ,'패밀리룸','패밀리룸',90000);
Insert into TRIP2REAP.ROOM (ROOM_NO,BO_NO,ROOM_TYPE,ROOM_NAME,PRICE_PER_DAY) values ( SEQ_ROOM_NO.NEXTVAL , SEQ_BO_NO.CURRVAL ,'디럭스룸','디럭스룸',90200);
Insert into TRIP2REAP.ROOM (ROOM_NO,BO_NO,ROOM_TYPE,ROOM_NAME,PRICE_PER_DAY) values ( SEQ_ROOM_NO.NEXTVAL , SEQ_BO_NO.CURRVAL ,'디럭스룸','디럭스 온돌룸',100000);
Insert into TRIP2REAP.ROOM (ROOM_NO,BO_NO,ROOM_TYPE,ROOM_NAME,PRICE_PER_DAY) values ( SEQ_ROOM_NO.NEXTVAL , SEQ_BO_NO.CURRVAL ,'온돌룸','디럭스 온돌룸',100000);


--41
Insert into TRIP2REAP.BOARD (BO_NO,CA_CODE,BO_TITLE,BO_CONTENT,MEMBER_ID,BO_COUNT,BO_TAG,BO_DELETE_YN,REGDATE) values (SEQ_BO_NO.NEXTVAL ,5,'더블루마크 호텔 속초','더 블루마크 호텔 속초는 속초고속버스터미널에서 걸어서 약 10분 거리에 있습니다. 주변 관광지인 속초 해수욕장과 외옹치 해수욕장은 도보로 약 8분 걸립니다. 또한, 청초호는 걸어서 약 30분이면 갈 수 있습니다. 호텔에는 주차장과 편의점이 마련되어 있으며, 무선 인터넷 서비스를 제공합니다. 피트니스센터와 인피니티풀이 있어 시간을 보내실 수 있습니다. 속초 바다 전망을 갖춘 객실 내부에는 TV, 에어컨, 화장대, 옷장, 세탁기, 냉장고, 생수, 슬리퍼 등이 완비되어 있으며 욕실에는 비데, 어메니티, 헤어드라이어가 있습니다. 일부 객실은 온돌형으로 되어 있으며, 자녀와 투숙하기에 좋은 구조의 객실도 있습니다. 고층에 위치한 ''블루호라이즌'' 레스토랑에서는 식사와 음료를 함께 즐기실 수 있습니다. 로비의 베이커리 카페에서는 브런치를 드시며 여유를 느끼실 수 있습니다.','admin',0,'동해바다앞','N',to_date('20/12/10','RR/MM/DD'));
Insert into TRIP2REAP.HOTEL (BO_NO,HOTEL_ADDRESS,HOTEL_LOCAL_CODE,HOTEL_SITE,HOTEL_TEL,HOTEL_REVIEW_SCORE,HOTEL_RANK,HOTEL_OPEN_TIME,HOTEL_CLOSE_TIME,HOTEL_OPTION,CHECK_IN,CHECK_OUT) values ( SEQ_BO_NO.CURRVAL ,'강원 속초시 동해대로 3920',1,'http://theblue.hotelthemark.co.kr/','033-800-8710',0,0,0,23,'와이파이, 조식, 레스토랑, 세탁, 24시간 리셉션, 수하물 보관, 수영장, 카페, 주차, 장애인 편의시설, 주방',15,11);

Insert into TRIP2REAP.IMG_FILE (FILE_NO,BO_NO,ORIGIN_NAME,CHANGE_NAME,FILE_LEVEL,FILE_PATH,FILE_DELETE_YN) values (SEQ_FILE_NO.NEXTVAL , SEQ_BO_NO.CURRVAL ,'썸네일.jpeg','hotel_thumbnail_202012110123020859.jpeg',1,'/Users/ek/Documents/GitHub/Spring-Project-Trip2Reap/Spring-Final-Trip2Reap/src/main/webapp/resources/buploadFiles/hotel_thumbnail_202012110123020859.jpeg','N');
Insert into TRIP2REAP.IMG_FILE (FILE_NO,BO_NO,ORIGIN_NAME,CHANGE_NAME,FILE_LEVEL,FILE_PATH,FILE_DELETE_YN) values (SEQ_FILE_NO.NEXTVAL , SEQ_BO_NO.CURRVAL ,'디테일1.jpeg','hotel_detail_202012110123020879.jpeg',2,'/Users/ek/Documents/GitHub/Spring-Project-Trip2Reap/Spring-Final-Trip2Reap/src/main/webapp/resources/buploadFiles/hotel_detail_202012110123020879.jpeg','N');
Insert into TRIP2REAP.IMG_FILE (FILE_NO,BO_NO,ORIGIN_NAME,CHANGE_NAME,FILE_LEVEL,FILE_PATH,FILE_DELETE_YN) values (SEQ_FILE_NO.NEXTVAL , SEQ_BO_NO.CURRVAL ,'디테일2.jpeg','hotel_detail_202012110123020895.jpeg',2,'/Users/ek/Documents/GitHub/Spring-Project-Trip2Reap/Spring-Final-Trip2Reap/src/main/webapp/resources/buploadFiles/hotel_detail_202012110123020895.jpeg','N');
Insert into TRIP2REAP.IMG_FILE (FILE_NO,BO_NO,ORIGIN_NAME,CHANGE_NAME,FILE_LEVEL,FILE_PATH,FILE_DELETE_YN) values (SEQ_FILE_NO.NEXTVAL , SEQ_BO_NO.CURRVAL ,'디테일3.jpeg','hotel_detail_202012110123020905.jpeg',2,'/Users/ek/Documents/GitHub/Spring-Project-Trip2Reap/Spring-Final-Trip2Reap/src/main/webapp/resources/buploadFiles/hotel_detail_202012110123020905.jpeg','N');
Insert into TRIP2REAP.IMG_FILE (FILE_NO,BO_NO,ORIGIN_NAME,CHANGE_NAME,FILE_LEVEL,FILE_PATH,FILE_DELETE_YN) values (SEQ_FILE_NO.NEXTVAL , SEQ_BO_NO.CURRVAL ,'디테일4.jpeg','hotel_detail_202012110123020916.jpeg',2,'/Users/ek/Documents/GitHub/Spring-Project-Trip2Reap/Spring-Final-Trip2Reap/src/main/webapp/resources/buploadFiles/hotel_detail_202012110123020916.jpeg','N');
Insert into TRIP2REAP.IMG_FILE (FILE_NO,BO_NO,ORIGIN_NAME,CHANGE_NAME,FILE_LEVEL,FILE_PATH,FILE_DELETE_YN) values (SEQ_FILE_NO.NEXTVAL , SEQ_BO_NO.CURRVAL ,'디테일5.jpeg','hotel_detail_202012110123020932.jpeg',2,'/Users/ek/Documents/GitHub/Spring-Project-Trip2Reap/Spring-Final-Trip2Reap/src/main/webapp/resources/buploadFiles/hotel_detail_202012110123020932.jpeg','N');
Insert into TRIP2REAP.IMG_FILE (FILE_NO,BO_NO,ORIGIN_NAME,CHANGE_NAME,FILE_LEVEL,FILE_PATH,FILE_DELETE_YN) values (SEQ_FILE_NO.NEXTVAL , SEQ_BO_NO.CURRVAL ,'디테일6.jpeg','hotel_detail_202012110123020945.jpeg',2,'/Users/ek/Documents/GitHub/Spring-Project-Trip2Reap/Spring-Final-Trip2Reap/src/main/webapp/resources/buploadFiles/hotel_detail_202012110123020945.jpeg','N');
Insert into TRIP2REAP.IMG_FILE (FILE_NO,BO_NO,ORIGIN_NAME,CHANGE_NAME,FILE_LEVEL,FILE_PATH,FILE_DELETE_YN) values (SEQ_FILE_NO.NEXTVAL , SEQ_BO_NO.CURRVAL ,'디테일7.jpeg','hotel_detail_202012110123020977.jpeg',2,'/Users/ek/Documents/GitHub/Spring-Project-Trip2Reap/Spring-Final-Trip2Reap/src/main/webapp/resources/buploadFiles/hotel_detail_202012110123020977.jpeg','N');
Insert into TRIP2REAP.IMG_FILE (FILE_NO,BO_NO,ORIGIN_NAME,CHANGE_NAME,FILE_LEVEL,FILE_PATH,FILE_DELETE_YN) values (SEQ_FILE_NO.NEXTVAL , SEQ_BO_NO.CURRVAL ,'디테일8.jpeg','hotel_detail_202012110123020994.jpeg',2,'/Users/ek/Documents/GitHub/Spring-Project-Trip2Reap/Spring-Final-Trip2Reap/src/main/webapp/resources/buploadFiles/hotel_detail_202012110123020994.jpeg','N');
Insert into TRIP2REAP.IMG_FILE (FILE_NO,BO_NO,ORIGIN_NAME,CHANGE_NAME,FILE_LEVEL,FILE_PATH,FILE_DELETE_YN) values (SEQ_FILE_NO.NEXTVAL , SEQ_BO_NO.CURRVAL ,'디테일9.jpeg','hotel_detail_202012110123030015.jpeg',2,'/Users/ek/Documents/GitHub/Spring-Project-Trip2Reap/Spring-Final-Trip2Reap/src/main/webapp/resources/buploadFiles/hotel_detail_202012110123030015.jpeg','N');
Insert into TRIP2REAP.IMG_FILE (FILE_NO,BO_NO,ORIGIN_NAME,CHANGE_NAME,FILE_LEVEL,FILE_PATH,FILE_DELETE_YN) values (SEQ_FILE_NO.NEXTVAL , SEQ_BO_NO.CURRVAL ,'디테일10.jpeg','hotel_detail_202012110123030029.jpeg',2,'/Users/ek/Documents/GitHub/Spring-Project-Trip2Reap/Spring-Final-Trip2Reap/src/main/webapp/resources/buploadFiles/hotel_detail_202012110123030029.jpeg','N');
Insert into TRIP2REAP.IMG_FILE (FILE_NO,BO_NO,ORIGIN_NAME,CHANGE_NAME,FILE_LEVEL,FILE_PATH,FILE_DELETE_YN) values (SEQ_FILE_NO.NEXTVAL , SEQ_BO_NO.CURRVAL ,'썸네일.jpeg','hotel_detail_202012110123030037.jpeg',2,'/Users/ek/Documents/GitHub/Spring-Project-Trip2Reap/Spring-Final-Trip2Reap/src/main/webapp/resources/buploadFiles/hotel_detail_202012110123030037.jpeg','N');

Insert into TRIP2REAP.ROOM (ROOM_NO,BO_NO,ROOM_TYPE,ROOM_NAME,PRICE_PER_DAY) values ( SEQ_ROOM_NO.NEXTVAL , SEQ_BO_NO.CURRVAL ,'스탠다드룸','스탠다드 트윈룸',57400);
Insert into TRIP2REAP.ROOM (ROOM_NO,BO_NO,ROOM_TYPE,ROOM_NAME,PRICE_PER_DAY) values ( SEQ_ROOM_NO.NEXTVAL , SEQ_BO_NO.CURRVAL ,'트윈룸','스탠다드 트윈룸',57400);
Insert into TRIP2REAP.ROOM (ROOM_NO,BO_NO,ROOM_TYPE,ROOM_NAME,PRICE_PER_DAY) values ( SEQ_ROOM_NO.NEXTVAL , SEQ_BO_NO.CURRVAL ,'스탠다드룸','스탠다드 온돌',55800);
Insert into TRIP2REAP.ROOM (ROOM_NO,BO_NO,ROOM_TYPE,ROOM_NAME,PRICE_PER_DAY) values ( SEQ_ROOM_NO.NEXTVAL , SEQ_BO_NO.CURRVAL ,'온돌룸','스탠다드 온돌',55800);
Insert into TRIP2REAP.ROOM (ROOM_NO,BO_NO,ROOM_TYPE,ROOM_NAME,PRICE_PER_DAY) values ( SEQ_ROOM_NO.NEXTVAL , SEQ_BO_NO.CURRVAL ,'스탠다드룸','스탠다드 더블',55800);
Insert into TRIP2REAP.ROOM (ROOM_NO,BO_NO,ROOM_TYPE,ROOM_NAME,PRICE_PER_DAY) values ( SEQ_ROOM_NO.NEXTVAL , SEQ_BO_NO.CURRVAL ,'더블룸','스탠다드 더블',55800);
Insert into TRIP2REAP.ROOM (ROOM_NO,BO_NO,ROOM_TYPE,ROOM_NAME,PRICE_PER_DAY) values ( SEQ_ROOM_NO.NEXTVAL , SEQ_BO_NO.CURRVAL ,'디럭스룸','디럭스 블루키즈',62200);
Insert into TRIP2REAP.ROOM (ROOM_NO,BO_NO,ROOM_TYPE,ROOM_NAME,PRICE_PER_DAY) values ( SEQ_ROOM_NO.NEXTVAL , SEQ_BO_NO.CURRVAL ,'디럭스룸','디럭스 핑크키즈',62200);



--42
Insert into TRIP2REAP.BOARD (BO_NO,CA_CODE,BO_TITLE,BO_CONTENT,MEMBER_ID,BO_COUNT,BO_TAG,BO_DELETE_YN,REGDATE) values (SEQ_BO_NO.NEXTVAL ,5,'마리나베이 속초','편안한 객실과 시설을 제공하는 마리나베이 속초의 경우 여행객과 비즈니스 출장객 모두에게 좋은 숙소입니다. 차량을 가지고 오신 고객님들을 위해 무료 구내 전용 주차장도 제공하고 있습니다. 리셉션은 24시간 열려 있습니다. 모든 객실에는 에어컨이 완비되어 있고 난방 시설, 평면 TV 및 헤어드라이어도 갖추고 있습니다. 각 객실에 슬리퍼 등이 구비된 욕실이 있습니다.','admin',1,null,'N',to_date('20/12/10','RR/MM/DD'));
Insert into TRIP2REAP.HOTEL (BO_NO,HOTEL_ADDRESS,HOTEL_LOCAL_CODE,HOTEL_SITE,HOTEL_TEL,HOTEL_REVIEW_SCORE,HOTEL_RANK,HOTEL_OPEN_TIME,HOTEL_CLOSE_TIME,HOTEL_OPTION,CHECK_IN,CHECK_OUT) values ( SEQ_BO_NO.CURRVAL ,'강원 속초시 청초호반로 28',1,'https://marinabaysokcho.com/#facilities-content','033-637-6600',0,0,7,22,'와이파이, 조식, 레스토랑, 세탁, 24시간 리셉션, 수하물 보관, 수영장, 카페, 비즈니스 시설, 주차, 바/라운지, 주방',15,11);

Insert into TRIP2REAP.IMG_FILE (FILE_NO,BO_NO,ORIGIN_NAME,CHANGE_NAME,FILE_LEVEL,FILE_PATH,FILE_DELETE_YN) values (SEQ_FILE_NO.NEXTVAL , SEQ_BO_NO.CURRVAL ,'썸네일.jpeg','hotel_thumbnail_202012110134110224.jpeg',1,'/Users/ek/Documents/GitHub/Spring-Project-Trip2Reap/Spring-Final-Trip2Reap/src/main/webapp/resources/buploadFiles/hotel_thumbnail_202012110134110224.jpeg','N');
Insert into TRIP2REAP.IMG_FILE (FILE_NO,BO_NO,ORIGIN_NAME,CHANGE_NAME,FILE_LEVEL,FILE_PATH,FILE_DELETE_YN) values (SEQ_FILE_NO.NEXTVAL , SEQ_BO_NO.CURRVAL ,'디테일1.jpeg','hotel_detail_202012110134110233.jpeg',2,'/Users/ek/Documents/GitHub/Spring-Project-Trip2Reap/Spring-Final-Trip2Reap/src/main/webapp/resources/buploadFiles/hotel_detail_202012110134110233.jpeg','N');
Insert into TRIP2REAP.IMG_FILE (FILE_NO,BO_NO,ORIGIN_NAME,CHANGE_NAME,FILE_LEVEL,FILE_PATH,FILE_DELETE_YN) values (SEQ_FILE_NO.NEXTVAL , SEQ_BO_NO.CURRVAL ,'디테일2.jpeg','hotel_detail_202012110134110241.jpeg',2,'/Users/ek/Documents/GitHub/Spring-Project-Trip2Reap/Spring-Final-Trip2Reap/src/main/webapp/resources/buploadFiles/hotel_detail_202012110134110241.jpeg','N');
Insert into TRIP2REAP.IMG_FILE (FILE_NO,BO_NO,ORIGIN_NAME,CHANGE_NAME,FILE_LEVEL,FILE_PATH,FILE_DELETE_YN) values (SEQ_FILE_NO.NEXTVAL , SEQ_BO_NO.CURRVAL ,'디테일3.jpeg','hotel_detail_202012110134110247.jpeg',2,'/Users/ek/Documents/GitHub/Spring-Project-Trip2Reap/Spring-Final-Trip2Reap/src/main/webapp/resources/buploadFiles/hotel_detail_202012110134110247.jpeg','N');
Insert into TRIP2REAP.IMG_FILE (FILE_NO,BO_NO,ORIGIN_NAME,CHANGE_NAME,FILE_LEVEL,FILE_PATH,FILE_DELETE_YN) values (SEQ_FILE_NO.NEXTVAL , SEQ_BO_NO.CURRVAL ,'디테일4.jpeg','hotel_detail_202012110134110256.jpeg',2,'/Users/ek/Documents/GitHub/Spring-Project-Trip2Reap/Spring-Final-Trip2Reap/src/main/webapp/resources/buploadFiles/hotel_detail_202012110134110256.jpeg','N');
Insert into TRIP2REAP.IMG_FILE (FILE_NO,BO_NO,ORIGIN_NAME,CHANGE_NAME,FILE_LEVEL,FILE_PATH,FILE_DELETE_YN) values (SEQ_FILE_NO.NEXTVAL , SEQ_BO_NO.CURRVAL ,'디테일5.jpeg','hotel_detail_202012110134110263.jpeg',2,'/Users/ek/Documents/GitHub/Spring-Project-Trip2Reap/Spring-Final-Trip2Reap/src/main/webapp/resources/buploadFiles/hotel_detail_202012110134110263.jpeg','N');
Insert into TRIP2REAP.IMG_FILE (FILE_NO,BO_NO,ORIGIN_NAME,CHANGE_NAME,FILE_LEVEL,FILE_PATH,FILE_DELETE_YN) values (SEQ_FILE_NO.NEXTVAL , SEQ_BO_NO.CURRVAL ,'디테일6.jpeg','hotel_detail_202012110134110271.jpeg',2,'/Users/ek/Documents/GitHub/Spring-Project-Trip2Reap/Spring-Final-Trip2Reap/src/main/webapp/resources/buploadFiles/hotel_detail_202012110134110271.jpeg','N');
Insert into TRIP2REAP.IMG_FILE (FILE_NO,BO_NO,ORIGIN_NAME,CHANGE_NAME,FILE_LEVEL,FILE_PATH,FILE_DELETE_YN) values (SEQ_FILE_NO.NEXTVAL , SEQ_BO_NO.CURRVAL ,'디테일7.jpeg','hotel_detail_202012110134110279.jpeg',2,'/Users/ek/Documents/GitHub/Spring-Project-Trip2Reap/Spring-Final-Trip2Reap/src/main/webapp/resources/buploadFiles/hotel_detail_202012110134110279.jpeg','N');
Insert into TRIP2REAP.IMG_FILE (FILE_NO,BO_NO,ORIGIN_NAME,CHANGE_NAME,FILE_LEVEL,FILE_PATH,FILE_DELETE_YN) values (SEQ_FILE_NO.NEXTVAL , SEQ_BO_NO.CURRVAL ,'디테일8.jpeg','hotel_detail_202012110134110286.jpeg',2,'/Users/ek/Documents/GitHub/Spring-Project-Trip2Reap/Spring-Final-Trip2Reap/src/main/webapp/resources/buploadFiles/hotel_detail_202012110134110286.jpeg','N');
Insert into TRIP2REAP.IMG_FILE (FILE_NO,BO_NO,ORIGIN_NAME,CHANGE_NAME,FILE_LEVEL,FILE_PATH,FILE_DELETE_YN) values (SEQ_FILE_NO.NEXTVAL , SEQ_BO_NO.CURRVAL ,'썸네일.jpeg','hotel_detail_202012110134110293.jpeg',2,'/Users/ek/Documents/GitHub/Spring-Project-Trip2Reap/Spring-Final-Trip2Reap/src/main/webapp/resources/buploadFiles/hotel_detail_202012110134110293.jpeg','N');

Insert into TRIP2REAP.ROOM (ROOM_NO,BO_NO,ROOM_TYPE,ROOM_NAME,PRICE_PER_DAY) values ( SEQ_ROOM_NO.NEXTVAL , SEQ_BO_NO.CURRVAL ,'더블룸','스탠다드 더블룸',73500);
Insert into TRIP2REAP.ROOM (ROOM_NO,BO_NO,ROOM_TYPE,ROOM_NAME,PRICE_PER_DAY) values ( SEQ_ROOM_NO.NEXTVAL , SEQ_BO_NO.CURRVAL ,'스탠다드룸','스탠다드 더블룸',73500);
Insert into TRIP2REAP.ROOM (ROOM_NO,BO_NO,ROOM_TYPE,ROOM_NAME,PRICE_PER_DAY) values ( SEQ_ROOM_NO.NEXTVAL , SEQ_BO_NO.CURRVAL ,'스탠다드룸','스탠다드 온돌룸',73500);
Insert into TRIP2REAP.ROOM (ROOM_NO,BO_NO,ROOM_TYPE,ROOM_NAME,PRICE_PER_DAY) values ( SEQ_ROOM_NO.NEXTVAL , SEQ_BO_NO.CURRVAL ,'온돌룸','스탠다드 온돌룸',73500);
Insert into TRIP2REAP.ROOM (ROOM_NO,BO_NO,ROOM_TYPE,ROOM_NAME,PRICE_PER_DAY) values ( SEQ_ROOM_NO.NEXTVAL , SEQ_BO_NO.CURRVAL ,'더블룸','슈페리어 더블',81800);
Insert into TRIP2REAP.ROOM (ROOM_NO,BO_NO,ROOM_TYPE,ROOM_NAME,PRICE_PER_DAY) values ( SEQ_ROOM_NO.NEXTVAL , SEQ_BO_NO.CURRVAL ,'슈페리어룸','슈페리어 더블',81800);
Insert into TRIP2REAP.ROOM (ROOM_NO,BO_NO,ROOM_TYPE,ROOM_NAME,PRICE_PER_DAY) values ( SEQ_ROOM_NO.NEXTVAL , SEQ_BO_NO.CURRVAL ,'디럭스룸','디럭스 트윈룸',98300);
Insert into TRIP2REAP.ROOM (ROOM_NO,BO_NO,ROOM_TYPE,ROOM_NAME,PRICE_PER_DAY) values ( SEQ_ROOM_NO.NEXTVAL , SEQ_BO_NO.CURRVAL ,'트윈룸','디럭스 트윈룸',98300);


--43
Insert into TRIP2REAP.BOARD (BO_NO,CA_CODE,BO_TITLE,BO_CONTENT,MEMBER_ID,BO_COUNT,BO_TAG,BO_DELETE_YN,REGDATE) values (SEQ_BO_NO.NEXTVAL ,5,'더클래스 300 콘도','더 클래스 300 콘도 - <3성급:한국관광공사 인증> - 더 클래스 300 콘도는 속초고속버스터미널에서 단 775m 거리에 있습니다. 주변 관광지로는 속초 해수욕장, 외옹치항, 대포항 등이 가까운 차로 5분 거리에 있으며 차로 10분 이내 거리에 있는 중앙시장과 아바이마을에서 다양한 먹거리를 즐기실 수 있습니다. 속초에 자리한 이 호텔은 편안한 4성급 숙소입니다. 뿐만 아니라 카페, 발렛 파킹, 귀빈층도 완비되어 있습니다. 넓은 객실은 에어컨이 완비되어 있으며 주문형 영화 서비스, 미니 바, 커피/차 메이커 등이 구비되어 있습니다. 객실 내 인터넷, 생수, 평면 TV도 갖춰져 있습니다. 고객님들은 저녁에 호텔 내 레스토랑 및 바에서 휴식을 취하실 수 있습니다.','admin',0,'안락한호텔, 최고의뷔페','N',to_date('20/12/10','RR/MM/DD'));
Insert into TRIP2REAP.HOTEL (BO_NO,HOTEL_ADDRESS,HOTEL_LOCAL_CODE,HOTEL_SITE,HOTEL_TEL,HOTEL_REVIEW_SCORE,HOTEL_RANK,HOTEL_OPEN_TIME,HOTEL_CLOSE_TIME,HOTEL_OPTION,CHECK_IN,CHECK_OUT) values ( SEQ_BO_NO.CURRVAL ,'강원 속초시 동해대로 3915',1,'http://www.theclass300.com/','033-630-9000',0,3,9,21,'와이파이, 조식, 레스토랑, 세탁, 24시간 리셉션, 수하물 보관, 비즈니스 시설, 주차, 주방, 아이돌봄 서비스, 룸서비스',14,11);

Insert into TRIP2REAP.IMG_FILE (FILE_NO,BO_NO,ORIGIN_NAME,CHANGE_NAME,FILE_LEVEL,FILE_PATH,FILE_DELETE_YN) values (SEQ_FILE_NO.NEXTVAL , SEQ_BO_NO.CURRVAL ,'썸네일.jpeg','hotel_thumbnail_202012110145550285.jpeg',1,'/Users/ek/Documents/GitHub/Spring-Project-Trip2Reap/Spring-Final-Trip2Reap/src/main/webapp/resources/buploadFiles/hotel_thumbnail_202012110145550285.jpeg','N');
Insert into TRIP2REAP.IMG_FILE (FILE_NO,BO_NO,ORIGIN_NAME,CHANGE_NAME,FILE_LEVEL,FILE_PATH,FILE_DELETE_YN) values (SEQ_FILE_NO.NEXTVAL , SEQ_BO_NO.CURRVAL ,'디테일4.jpeg','hotel_detail_202012110145550296.jpeg',2,'/Users/ek/Documents/GitHub/Spring-Project-Trip2Reap/Spring-Final-Trip2Reap/src/main/webapp/resources/buploadFiles/hotel_detail_202012110145550296.jpeg','N');
Insert into TRIP2REAP.IMG_FILE (FILE_NO,BO_NO,ORIGIN_NAME,CHANGE_NAME,FILE_LEVEL,FILE_PATH,FILE_DELETE_YN) values (SEQ_FILE_NO.NEXTVAL , SEQ_BO_NO.CURRVAL ,'디테일5.jpeg','hotel_detail_202012110145550310.jpeg',2,'/Users/ek/Documents/GitHub/Spring-Project-Trip2Reap/Spring-Final-Trip2Reap/src/main/webapp/resources/buploadFiles/hotel_detail_202012110145550310.jpeg','N');
Insert into TRIP2REAP.IMG_FILE (FILE_NO,BO_NO,ORIGIN_NAME,CHANGE_NAME,FILE_LEVEL,FILE_PATH,FILE_DELETE_YN) values (SEQ_FILE_NO.NEXTVAL , SEQ_BO_NO.CURRVAL ,'디테일6.jpeg','hotel_detail_202012110145550319.jpeg',2,'/Users/ek/Documents/GitHub/Spring-Project-Trip2Reap/Spring-Final-Trip2Reap/src/main/webapp/resources/buploadFiles/hotel_detail_202012110145550319.jpeg','N');
Insert into TRIP2REAP.IMG_FILE (FILE_NO,BO_NO,ORIGIN_NAME,CHANGE_NAME,FILE_LEVEL,FILE_PATH,FILE_DELETE_YN) values (SEQ_FILE_NO.NEXTVAL , SEQ_BO_NO.CURRVAL ,'디테일7.jpeg','hotel_detail_202012110145550329.jpeg',2,'/Users/ek/Documents/GitHub/Spring-Project-Trip2Reap/Spring-Final-Trip2Reap/src/main/webapp/resources/buploadFiles/hotel_detail_202012110145550329.jpeg','N');
Insert into TRIP2REAP.IMG_FILE (FILE_NO,BO_NO,ORIGIN_NAME,CHANGE_NAME,FILE_LEVEL,FILE_PATH,FILE_DELETE_YN) values (SEQ_FILE_NO.NEXTVAL , SEQ_BO_NO.CURRVAL ,'디테일8.jpeg','hotel_detail_202012110145550338.jpeg',2,'/Users/ek/Documents/GitHub/Spring-Project-Trip2Reap/Spring-Final-Trip2Reap/src/main/webapp/resources/buploadFiles/hotel_detail_202012110145550338.jpeg','N');
Insert into TRIP2REAP.IMG_FILE (FILE_NO,BO_NO,ORIGIN_NAME,CHANGE_NAME,FILE_LEVEL,FILE_PATH,FILE_DELETE_YN) values (SEQ_FILE_NO.NEXTVAL , SEQ_BO_NO.CURRVAL ,'디테일9.jpg','hotel_detail_202012110145550353.jpg',2,'/Users/ek/Documents/GitHub/Spring-Project-Trip2Reap/Spring-Final-Trip2Reap/src/main/webapp/resources/buploadFiles/hotel_detail_202012110145550353.jpg','N');
Insert into TRIP2REAP.IMG_FILE (FILE_NO,BO_NO,ORIGIN_NAME,CHANGE_NAME,FILE_LEVEL,FILE_PATH,FILE_DELETE_YN) values (SEQ_FILE_NO.NEXTVAL , SEQ_BO_NO.CURRVAL ,'썸네일.jpeg','hotel_detail_202012110145550364.jpeg',2,'/Users/ek/Documents/GitHub/Spring-Project-Trip2Reap/Spring-Final-Trip2Reap/src/main/webapp/resources/buploadFiles/hotel_detail_202012110145550364.jpeg','N');
Insert into TRIP2REAP.IMG_FILE (FILE_NO,BO_NO,ORIGIN_NAME,CHANGE_NAME,FILE_LEVEL,FILE_PATH,FILE_DELETE_YN) values (SEQ_FILE_NO.NEXTVAL , SEQ_BO_NO.CURRVAL ,'디테일1.jpeg','hotel_detail_202012110145550373.jpeg',2,'/Users/ek/Documents/GitHub/Spring-Project-Trip2Reap/Spring-Final-Trip2Reap/src/main/webapp/resources/buploadFiles/hotel_detail_202012110145550373.jpeg','N');
Insert into TRIP2REAP.IMG_FILE (FILE_NO,BO_NO,ORIGIN_NAME,CHANGE_NAME,FILE_LEVEL,FILE_PATH,FILE_DELETE_YN) values (SEQ_FILE_NO.NEXTVAL , SEQ_BO_NO.CURRVAL ,'디테일2.jpeg','hotel_detail_202012110145550401.jpeg',2,'/Users/ek/Documents/GitHub/Spring-Project-Trip2Reap/Spring-Final-Trip2Reap/src/main/webapp/resources/buploadFiles/hotel_detail_202012110145550401.jpeg','N');
Insert into TRIP2REAP.IMG_FILE (FILE_NO,BO_NO,ORIGIN_NAME,CHANGE_NAME,FILE_LEVEL,FILE_PATH,FILE_DELETE_YN) values (SEQ_FILE_NO.NEXTVAL , SEQ_BO_NO.CURRVAL ,'디테일3.jpeg','hotel_detail_202012110145550409.jpeg',2,'/Users/ek/Documents/GitHub/Spring-Project-Trip2Reap/Spring-Final-Trip2Reap/src/main/webapp/resources/buploadFiles/hotel_detail_202012110145550409.jpeg','N');

Insert into TRIP2REAP.ROOM (ROOM_NO,BO_NO,ROOM_TYPE,ROOM_NAME,PRICE_PER_DAY) values ( SEQ_ROOM_NO.NEXTVAL , SEQ_BO_NO.CURRVAL ,'트윈룸','슈페리어 트윈',51200);
Insert into TRIP2REAP.ROOM (ROOM_NO,BO_NO,ROOM_TYPE,ROOM_NAME,PRICE_PER_DAY) values ( SEQ_ROOM_NO.NEXTVAL , SEQ_BO_NO.CURRVAL ,'슈페리어룸','슈페리어 트윈',51200);
Insert into TRIP2REAP.ROOM (ROOM_NO,BO_NO,ROOM_TYPE,ROOM_NAME,PRICE_PER_DAY) values ( SEQ_ROOM_NO.NEXTVAL , SEQ_BO_NO.CURRVAL ,'패밀리룸','슈페리어 패밀리룸',51200);
Insert into TRIP2REAP.ROOM (ROOM_NO,BO_NO,ROOM_TYPE,ROOM_NAME,PRICE_PER_DAY) values ( SEQ_ROOM_NO.NEXTVAL , SEQ_BO_NO.CURRVAL ,'슈페리어룸','슈페리어 패밀리룸',51200);
Insert into TRIP2REAP.ROOM (ROOM_NO,BO_NO,ROOM_TYPE,ROOM_NAME,PRICE_PER_DAY) values ( SEQ_ROOM_NO.NEXTVAL , SEQ_BO_NO.CURRVAL ,'온돌룸','코리안 전통 온돌객실A',51200);
Insert into TRIP2REAP.ROOM (ROOM_NO,BO_NO,ROOM_TYPE,ROOM_NAME,PRICE_PER_DAY) values ( SEQ_ROOM_NO.NEXTVAL , SEQ_BO_NO.CURRVAL ,'트윈룸','스탠다드트윈(시티뷰/룸온리)',55500);
Insert into TRIP2REAP.ROOM (ROOM_NO,BO_NO,ROOM_TYPE,ROOM_NAME,PRICE_PER_DAY) values ( SEQ_ROOM_NO.NEXTVAL , SEQ_BO_NO.CURRVAL ,'스탠다드룸','스탠다드트윈(시티뷰/룸온리)',55500);
Insert into TRIP2REAP.ROOM (ROOM_NO,BO_NO,ROOM_TYPE,ROOM_NAME,PRICE_PER_DAY) values ( SEQ_ROOM_NO.NEXTVAL , SEQ_BO_NO.CURRVAL ,'디럭스룸','디럭스 트윈룸(하프오션뷰/룸온리)',56500);
Insert into TRIP2REAP.ROOM (ROOM_NO,BO_NO,ROOM_TYPE,ROOM_NAME,PRICE_PER_DAY) values ( SEQ_ROOM_NO.NEXTVAL , SEQ_BO_NO.CURRVAL ,'트윈룸','디럭스 트윈룸(하프오션뷰/룸온리)',56500);
Insert into TRIP2REAP.ROOM (ROOM_NO,BO_NO,ROOM_TYPE,ROOM_NAME,PRICE_PER_DAY) values ( SEQ_ROOM_NO.NEXTVAL , SEQ_BO_NO.CURRVAL ,'스탠다드룸','스탠다드더블/온돌(시티뷰/룸온리)',56500);
Insert into TRIP2REAP.ROOM (ROOM_NO,BO_NO,ROOM_TYPE,ROOM_NAME,PRICE_PER_DAY) values ( SEQ_ROOM_NO.NEXTVAL , SEQ_BO_NO.CURRVAL ,'더블룸','스탠다드더블/온돌(시티뷰/룸온리)',56500);
Insert into TRIP2REAP.ROOM (ROOM_NO,BO_NO,ROOM_TYPE,ROOM_NAME,PRICE_PER_DAY) values ( SEQ_ROOM_NO.NEXTVAL , SEQ_BO_NO.CURRVAL ,'온돌룸','스탠다드더블/온돌(시티뷰/룸온리)',56500);


--44
Insert into TRIP2REAP.BOARD (BO_NO,CA_CODE,BO_TITLE,BO_CONTENT,MEMBER_ID,BO_COUNT,BO_TAG,BO_DELETE_YN,REGDATE) values (SEQ_BO_NO.NEXTVAL ,5,'팜파스 리조트','최근 리뉴얼을 마친 팜파스 리조트는 속초고속버스터미널에서 도보 5분 거리에 있습니다. 주변 관광지로는 속초 해수욕장이 가까운 도보 거리에 있으며 대포항은 차로 약 10분 거리에 있습니다. 또한, 차로 10분 이내 거리에 있는 중앙시장과 아바이마을에서 다양한 먹거리를 즐기실 수 있습니다. 리조트 내에는 세미나실과 편의점도 있어 편리하게 이용하실 수 있습니다. 또한, 야외 바베큐장도 마련되어 있습니다. 전체 71개의 객실이 있으며 객실에 따라 오션 또는 마운틴 뷰를 감상하실 수 있습니다. 모든 객실 내에는 전자레인지, 평면 TV, 에어컨 등이 갖춰져 있으며 욕실에는 헤어드라이어, 슬리퍼 등이 있습니다. 리조트 내 구내 식당이 마련되어 있어 간단한 조식을 제공하고 있습니다.','admin',0,'속초고속터미널5분, 속초해수욕장앞','N',to_date('20/12/10','RR/MM/DD'));
Insert into TRIP2REAP.HOTEL (BO_NO,HOTEL_ADDRESS,HOTEL_LOCAL_CODE,HOTEL_SITE,HOTEL_TEL,HOTEL_REVIEW_SCORE,HOTEL_RANK,HOTEL_OPEN_TIME,HOTEL_CLOSE_TIME,HOTEL_OPTION,CHECK_IN,CHECK_OUT) values ( SEQ_BO_NO.CURRVAL ,'강원 속초시 동해대로 3964',1,null,'033-635-3261',0,3,8,21,'와이파이, 조식, 레스토랑, 24시간 리셉션, 피트니스, 주차, 주방',15,11);

Insert into TRIP2REAP.IMG_FILE (FILE_NO,BO_NO,ORIGIN_NAME,CHANGE_NAME,FILE_LEVEL,FILE_PATH,FILE_DELETE_YN) values (SEQ_FILE_NO.NEXTVAL , SEQ_BO_NO.CURRVAL ,'썸네일.jpeg','hotel_thumbnail_202012110153520756.jpeg',1,'/Users/ek/Documents/GitHub/Spring-Project-Trip2Reap/Spring-Final-Trip2Reap/src/main/webapp/resources/buploadFiles/hotel_thumbnail_202012110153520756.jpeg','N');
Insert into TRIP2REAP.IMG_FILE (FILE_NO,BO_NO,ORIGIN_NAME,CHANGE_NAME,FILE_LEVEL,FILE_PATH,FILE_DELETE_YN) values (SEQ_FILE_NO.NEXTVAL , SEQ_BO_NO.CURRVAL ,'디테일1.jpeg','hotel_detail_202012110153520790.jpeg',2,'/Users/ek/Documents/GitHub/Spring-Project-Trip2Reap/Spring-Final-Trip2Reap/src/main/webapp/resources/buploadFiles/hotel_detail_202012110153520790.jpeg','N');
Insert into TRIP2REAP.IMG_FILE (FILE_NO,BO_NO,ORIGIN_NAME,CHANGE_NAME,FILE_LEVEL,FILE_PATH,FILE_DELETE_YN) values (SEQ_FILE_NO.NEXTVAL , SEQ_BO_NO.CURRVAL ,'디테일2.jpeg','hotel_detail_202012110153520823.jpeg',2,'/Users/ek/Documents/GitHub/Spring-Project-Trip2Reap/Spring-Final-Trip2Reap/src/main/webapp/resources/buploadFiles/hotel_detail_202012110153520823.jpeg','N');
Insert into TRIP2REAP.IMG_FILE (FILE_NO,BO_NO,ORIGIN_NAME,CHANGE_NAME,FILE_LEVEL,FILE_PATH,FILE_DELETE_YN) values (SEQ_FILE_NO.NEXTVAL , SEQ_BO_NO.CURRVAL ,'디테일3.jpeg','hotel_detail_202012110153520836.jpeg',2,'/Users/ek/Documents/GitHub/Spring-Project-Trip2Reap/Spring-Final-Trip2Reap/src/main/webapp/resources/buploadFiles/hotel_detail_202012110153520836.jpeg','N');
Insert into TRIP2REAP.IMG_FILE (FILE_NO,BO_NO,ORIGIN_NAME,CHANGE_NAME,FILE_LEVEL,FILE_PATH,FILE_DELETE_YN) values (SEQ_FILE_NO.NEXTVAL , SEQ_BO_NO.CURRVAL ,'디테일4.jpeg','hotel_detail_202012110153520891.jpeg',2,'/Users/ek/Documents/GitHub/Spring-Project-Trip2Reap/Spring-Final-Trip2Reap/src/main/webapp/resources/buploadFiles/hotel_detail_202012110153520891.jpeg','N');
Insert into TRIP2REAP.IMG_FILE (FILE_NO,BO_NO,ORIGIN_NAME,CHANGE_NAME,FILE_LEVEL,FILE_PATH,FILE_DELETE_YN) values (SEQ_FILE_NO.NEXTVAL , SEQ_BO_NO.CURRVAL ,'디테일5.jpeg','hotel_detail_202012110153520905.jpeg',2,'/Users/ek/Documents/GitHub/Spring-Project-Trip2Reap/Spring-Final-Trip2Reap/src/main/webapp/resources/buploadFiles/hotel_detail_202012110153520905.jpeg','N');
Insert into TRIP2REAP.IMG_FILE (FILE_NO,BO_NO,ORIGIN_NAME,CHANGE_NAME,FILE_LEVEL,FILE_PATH,FILE_DELETE_YN) values (SEQ_FILE_NO.NEXTVAL , SEQ_BO_NO.CURRVAL ,'디테일6.jpeg','hotel_detail_202012110153520920.jpeg',2,'/Users/ek/Documents/GitHub/Spring-Project-Trip2Reap/Spring-Final-Trip2Reap/src/main/webapp/resources/buploadFiles/hotel_detail_202012110153520920.jpeg','N');
Insert into TRIP2REAP.IMG_FILE (FILE_NO,BO_NO,ORIGIN_NAME,CHANGE_NAME,FILE_LEVEL,FILE_PATH,FILE_DELETE_YN) values (SEQ_FILE_NO.NEXTVAL , SEQ_BO_NO.CURRVAL ,'디테일7.jpeg','hotel_detail_202012110153520981.jpeg',2,'/Users/ek/Documents/GitHub/Spring-Project-Trip2Reap/Spring-Final-Trip2Reap/src/main/webapp/resources/buploadFiles/hotel_detail_202012110153520981.jpeg','N');
Insert into TRIP2REAP.IMG_FILE (FILE_NO,BO_NO,ORIGIN_NAME,CHANGE_NAME,FILE_LEVEL,FILE_PATH,FILE_DELETE_YN) values (SEQ_FILE_NO.NEXTVAL , SEQ_BO_NO.CURRVAL ,'썸네일.jpeg','hotel_detail_202012110153530003.jpeg',2,'/Users/ek/Documents/GitHub/Spring-Project-Trip2Reap/Spring-Final-Trip2Reap/src/main/webapp/resources/buploadFiles/hotel_detail_202012110153530003.jpeg','N');

Insert into TRIP2REAP.ROOM (ROOM_NO,BO_NO,ROOM_TYPE,ROOM_NAME,PRICE_PER_DAY) values ( SEQ_ROOM_NO.NEXTVAL , SEQ_BO_NO.CURRVAL ,'스탠다드룸','스탠다드룸',54500);
Insert into TRIP2REAP.ROOM (ROOM_NO,BO_NO,ROOM_TYPE,ROOM_NAME,PRICE_PER_DAY) values ( SEQ_ROOM_NO.NEXTVAL , SEQ_BO_NO.CURRVAL ,'스탠다드룸','스탠다드 더블룸',60000);
Insert into TRIP2REAP.ROOM (ROOM_NO,BO_NO,ROOM_TYPE,ROOM_NAME,PRICE_PER_DAY) values ( SEQ_ROOM_NO.NEXTVAL , SEQ_BO_NO.CURRVAL ,'더블룸','스탠다드 더블룸',60000);
Insert into TRIP2REAP.ROOM (ROOM_NO,BO_NO,ROOM_TYPE,ROOM_NAME,PRICE_PER_DAY) values ( SEQ_ROOM_NO.NEXTVAL , SEQ_BO_NO.CURRVAL ,'패밀리룸','패밀리 골드룸',64600);


--45
Insert into TRIP2REAP.BOARD (BO_NO,CA_CODE,BO_TITLE,BO_CONTENT,MEMBER_ID,BO_COUNT,BO_TAG,BO_DELETE_YN,REGDATE) values (SEQ_BO_NO.NEXTVAL ,5,'신라스테이 해운대','신라스테이 해운대 - <4성급:한국관광공사 인증> - 해운대 전망을 자랑하는 루프탑 바가 있는 신라 스테이 해운대는 부산 2호선 해운대역 5번 또는 7번에서 도보 6분 거리에 있으며 KTX 부산역까지는 차로 25분이 소요됩니다. 주변 관광지로는 해운대 해수욕장이 도보 5분, 해동 용궁사가 차로 25분, 누리마루와 광안대교가 차로 각 15분 거리에 있습니다. 또한, 신세계 백화점 센텀시티점과 롯데백화점이 차로 약 10분 거리에 있어 쇼핑을 즐기기에도 좋습니다. 24시간 이용 가능한 비즈니스 코너와 셀프 세탁이 가능한 세탁실이 마련되어 있어서 편리하게 이용하실 수 있습니다. 또한, 비즈니스 고객님을 위해 5층에는 3개의 회의실과 3층에는 1개의 보드룸이 마련되어 있습니다. 그 밖에도 다양한 유산소 운동 기구가 구비된 피트니스 센터도 무료로 이용하실 수 있습니다. 전체 407개의 객실이 있으며 스탠다드, 디럭스, 프리미어 디럭스, 스위트 등 다양한 유형의 객실이 마련되어 있습니다. 객실에 따라 도시 또는 바다 전망을 감상하실 수 있습니다. 모던한 인테리어가 돋보이는 모든 객실 내에는 40인치 LED TV, 냉장고, 책상 등이 있으며 욕실에는 고급 어메니티와 목욕가운이 구비되어 있습니다. 호텔 2층에 위한 레스토랑 카페에서는 조식, 브런치, 중식, 석식 뷔페를 운영하고 있으며 바에서는 와인, 위스키, 칵테일, 맥주 등 다양한 주류를 판매하고 있습니다. 또한, 18층에는 위치한 루프탑 바에서는 해운대 전망을 감상하며 미니풀에서 맥주와 와인 등을 즐기실 수 있습니다.','admin',0,'신라호텔, 신라스테이해운대, 해운대앞','N',to_date('20/12/10','RR/MM/DD'));
Insert into TRIP2REAP.HOTEL (BO_NO,HOTEL_ADDRESS,HOTEL_LOCAL_CODE,HOTEL_SITE,HOTEL_TEL,HOTEL_REVIEW_SCORE,HOTEL_RANK,HOTEL_OPEN_TIME,HOTEL_CLOSE_TIME,HOTEL_OPTION,CHECK_IN,CHECK_OUT) values ( SEQ_BO_NO.CURRVAL ,'부산 해운대구 해운대로570번길 46',8,'https://www.shillastay.com/haeundae/index.do?lang=ko','051-912-9000',0,4,6,23,'와이파이, 조식, 레스토랑, 세탁, 24시간 리셉션, 수하물 보관, 수영장, 피트니스, 스파/사우나, 비즈니스 시설, 주차, 바/라운지, 주방',15,12);

Insert into TRIP2REAP.IMG_FILE (FILE_NO,BO_NO,ORIGIN_NAME,CHANGE_NAME,FILE_LEVEL,FILE_PATH,FILE_DELETE_YN) values (SEQ_FILE_NO.NEXTVAL , SEQ_BO_NO.CURRVAL ,'신라스테이해운대.jpeg','hotel_thumbnail_202012110233500675.jpeg',1,'/Users/ek/Documents/GitHub/Spring-Project-Trip2Reap/Spring-Final-Trip2Reap/src/main/webapp/resources/buploadFiles/hotel_thumbnail_202012110233500675.jpeg','N');
Insert into TRIP2REAP.IMG_FILE (FILE_NO,BO_NO,ORIGIN_NAME,CHANGE_NAME,FILE_LEVEL,FILE_PATH,FILE_DELETE_YN) values (SEQ_FILE_NO.NEXTVAL , SEQ_BO_NO.CURRVAL ,'신라스테이부산디테일1.jpeg','hotel_detail_202012110233500689.jpeg',2,'/Users/ek/Documents/GitHub/Spring-Project-Trip2Reap/Spring-Final-Trip2Reap/src/main/webapp/resources/buploadFiles/hotel_detail_202012110233500689.jpeg','N');
Insert into TRIP2REAP.IMG_FILE (FILE_NO,BO_NO,ORIGIN_NAME,CHANGE_NAME,FILE_LEVEL,FILE_PATH,FILE_DELETE_YN) values (SEQ_FILE_NO.NEXTVAL , SEQ_BO_NO.CURRVAL ,'신라스테이부산디테일2.jpeg','hotel_detail_202012110233500699.jpeg',2,'/Users/ek/Documents/GitHub/Spring-Project-Trip2Reap/Spring-Final-Trip2Reap/src/main/webapp/resources/buploadFiles/hotel_detail_202012110233500699.jpeg','N');
Insert into TRIP2REAP.IMG_FILE (FILE_NO,BO_NO,ORIGIN_NAME,CHANGE_NAME,FILE_LEVEL,FILE_PATH,FILE_DELETE_YN) values (SEQ_FILE_NO.NEXTVAL , SEQ_BO_NO.CURRVAL ,'신라스테이부산디테일3.jpeg','hotel_detail_202012110233500711.jpeg',2,'/Users/ek/Documents/GitHub/Spring-Project-Trip2Reap/Spring-Final-Trip2Reap/src/main/webapp/resources/buploadFiles/hotel_detail_202012110233500711.jpeg','N');
Insert into TRIP2REAP.IMG_FILE (FILE_NO,BO_NO,ORIGIN_NAME,CHANGE_NAME,FILE_LEVEL,FILE_PATH,FILE_DELETE_YN) values (SEQ_FILE_NO.NEXTVAL , SEQ_BO_NO.CURRVAL ,'신라스테이부산디테일4.jpeg','hotel_detail_202012110233500721.jpeg',2,'/Users/ek/Documents/GitHub/Spring-Project-Trip2Reap/Spring-Final-Trip2Reap/src/main/webapp/resources/buploadFiles/hotel_detail_202012110233500721.jpeg','N');
Insert into TRIP2REAP.IMG_FILE (FILE_NO,BO_NO,ORIGIN_NAME,CHANGE_NAME,FILE_LEVEL,FILE_PATH,FILE_DELETE_YN) values (SEQ_FILE_NO.NEXTVAL , SEQ_BO_NO.CURRVAL ,'신라스테이부산디테일5.jpeg','hotel_detail_202012110233500732.jpeg',2,'/Users/ek/Documents/GitHub/Spring-Project-Trip2Reap/Spring-Final-Trip2Reap/src/main/webapp/resources/buploadFiles/hotel_detail_202012110233500732.jpeg','N');
Insert into TRIP2REAP.IMG_FILE (FILE_NO,BO_NO,ORIGIN_NAME,CHANGE_NAME,FILE_LEVEL,FILE_PATH,FILE_DELETE_YN) values (SEQ_FILE_NO.NEXTVAL , SEQ_BO_NO.CURRVAL ,'신라스테이부산디테일6.jpeg','hotel_detail_202012110233500741.jpeg',2,'/Users/ek/Documents/GitHub/Spring-Project-Trip2Reap/Spring-Final-Trip2Reap/src/main/webapp/resources/buploadFiles/hotel_detail_202012110233500741.jpeg','N');
Insert into TRIP2REAP.IMG_FILE (FILE_NO,BO_NO,ORIGIN_NAME,CHANGE_NAME,FILE_LEVEL,FILE_PATH,FILE_DELETE_YN) values (SEQ_FILE_NO.NEXTVAL , SEQ_BO_NO.CURRVAL ,'신라스테이부산디테일7.jpeg','hotel_detail_202012110233500750.jpeg',2,'/Users/ek/Documents/GitHub/Spring-Project-Trip2Reap/Spring-Final-Trip2Reap/src/main/webapp/resources/buploadFiles/hotel_detail_202012110233500750.jpeg','N');
Insert into TRIP2REAP.IMG_FILE (FILE_NO,BO_NO,ORIGIN_NAME,CHANGE_NAME,FILE_LEVEL,FILE_PATH,FILE_DELETE_YN) values (SEQ_FILE_NO.NEXTVAL , SEQ_BO_NO.CURRVAL ,'신라스테이부산디테일8.jpeg','hotel_detail_202012110233500759.jpeg',2,'/Users/ek/Documents/GitHub/Spring-Project-Trip2Reap/Spring-Final-Trip2Reap/src/main/webapp/resources/buploadFiles/hotel_detail_202012110233500759.jpeg','N');
Insert into TRIP2REAP.IMG_FILE (FILE_NO,BO_NO,ORIGIN_NAME,CHANGE_NAME,FILE_LEVEL,FILE_PATH,FILE_DELETE_YN) values (SEQ_FILE_NO.NEXTVAL , SEQ_BO_NO.CURRVAL ,'신라스테이해운대.jpeg','hotel_detail_202012110233500771.jpeg',2,'/Users/ek/Documents/GitHub/Spring-Project-Trip2Reap/Spring-Final-Trip2Reap/src/main/webapp/resources/buploadFiles/hotel_detail_202012110233500771.jpeg','N');

Insert into TRIP2REAP.ROOM (ROOM_NO,BO_NO,ROOM_TYPE,ROOM_NAME,PRICE_PER_DAY) values ( SEQ_ROOM_NO.NEXTVAL , SEQ_BO_NO.CURRVAL ,'스탠다드룸','스탠다드 트윈 시티뷰',87900);
Insert into TRIP2REAP.ROOM (ROOM_NO,BO_NO,ROOM_TYPE,ROOM_NAME,PRICE_PER_DAY) values ( SEQ_ROOM_NO.NEXTVAL , SEQ_BO_NO.CURRVAL ,'트윈룸','스탠다드 트윈 시티뷰',87900);
Insert into TRIP2REAP.ROOM (ROOM_NO,BO_NO,ROOM_TYPE,ROOM_NAME,PRICE_PER_DAY) values ( SEQ_ROOM_NO.NEXTVAL , SEQ_BO_NO.CURRVAL ,'더블룸','스탠다드 더블 시티뷰',87900);
Insert into TRIP2REAP.ROOM (ROOM_NO,BO_NO,ROOM_TYPE,ROOM_NAME,PRICE_PER_DAY) values ( SEQ_ROOM_NO.NEXTVAL , SEQ_BO_NO.CURRVAL ,'스탠다드룸','스탠다드 더블 시티뷰',87900);
Insert into TRIP2REAP.ROOM (ROOM_NO,BO_NO,ROOM_TYPE,ROOM_NAME,PRICE_PER_DAY) values ( SEQ_ROOM_NO.NEXTVAL , SEQ_BO_NO.CURRVAL ,'패밀리룸','디럭스 패밀리 시티뷰',97000);
Insert into TRIP2REAP.ROOM (ROOM_NO,BO_NO,ROOM_TYPE,ROOM_NAME,PRICE_PER_DAY) values ( SEQ_ROOM_NO.NEXTVAL , SEQ_BO_NO.CURRVAL ,'디럭스룸','디럭스 패밀리 시티뷰',97000);


--46
Insert into TRIP2REAP.BOARD (BO_NO,CA_CODE,BO_TITLE,BO_CONTENT,MEMBER_ID,BO_COUNT,BO_TAG,BO_DELETE_YN,REGDATE) values (SEQ_BO_NO.NEXTVAL ,5,'파라다이스 호텔 부산','파라다이스 호텔 부산 - <5성급:한국관광공사 인증> - 해운대 조망의 파라다이스 호텔 부산은 해운대 해수욕장 바로 앞에 있습니다. 지하철 이용 시, 부산 2호선 해운대역 3번 출구에서 도보로 약 10분 걸립니다. 주변 명소인 누리마루APEC하우스는 차로 약 5분 거리에 있습니다. 또한, 해동 용궁사까지는 차로 약 20분이 소요됩니다. 야외에는 ''오션 스파 씨메르''가 있으며 많은 노천탕과 어린이 놀이 공간도 있어 온 가족이 즐기시기에 좋습니다. 또한, 인피니티 풀장에서도 시간을 보낼 수 있습니다. 실내에는 옥돌 베드, 자쿠지탕, 건식 및 습식 공간을 갖춘 사우나가 있으며, 피트니스 클럽과 실내 골프장도 마련되어 있습니다. ''리트리트 스파''에서는 천연 성분을 함유한 브랜드 순다리를 사용합니다. 자녀와 즐길 수 있는 ''키즈 빌리지''에는 BMW 키즈 드라이빙, 플레이스테이션, 하바 키즈 라운지, 웅진 북클럽 및 가족형 키즈카페 ''키즈앤 패밀리''로 구성되어 여러 체험을 할 수 있습니다. 이외에도 인원에 따라 예식과 연회를 진행 할 수 있는 컨벤션 시설도 갖춰져 있습니다. 신관 1층에서 3층까지 위치한 카지노에서는 다양한 게임 체험할 수 있습니다. 객실은 디럭스, 프리미엄 디럭스, 스위트와 스페셜 스위트로 구성되어 있습니다. 전 객실에는 에어컨, TV, 소파, 테이블, 냉장고 금고, 커피/티 메이커, 생수 등이 있으며 욕실에는 욕실용품, 가운 및 헤어드라이어 등이 완비되어 있습니다. ''온 더 플레이트''는 올데이 뷔페 식사를 제공합니다. 유러피안 레스토랑인 ''닉스 그릴닉스그릴''에서는 이탈리안, 프렌치, 아메리칸 등의 색다른 요리를 드실 수 있습니다. 중식당인 ''남풍''에서는 각종 모임 식사를 할 수 있는 여러 규모의 다이닝 룸이 마련되어 있어 다 같이 음식을 즐길 수 있습니다. 일식당 ''사까에''에서는 신선한 재료의 음식을 맛 볼 수 있습니다. 로비에는 ''크리스탈 가든''에서는 통유리 창을 통해 탁 트인 전경을 감상하며 다양한 음료 또는 칵테일을 마실 수 있습니다. ''찰리스'' 바에서는 간단한 스낵과 함께 주류를 드시며 일과를 마무리 할 수 있습니다. 야외의 ''아쿠아 바''와 ''풀 사이드풀사이드 바''에서는 스파와 물놀이 후에 간단한 음식과 음료로 노곤함을 떨쳐버릴 수 있습니다. 다양한 디저트와 빵이 진열된 베이커리도 있어 들려보시기에 좋습니다. ''이그제큐티브 라운지'' 에서는 라이브러리, 다이닝, 컨퍼런스의 세 공간으로 구성되어 있으며 특별한 서비스를 느낄 수 있습니다. ''라운지 파라다이스''에서는 온종일 스낵과 음료와 함께 휴식을 취할 수 있습니다.','admin',2,'파라다이스, 부산해운대호텔','N',to_date('20/12/10','RR/MM/DD'));
Insert into TRIP2REAP.HOTEL (BO_NO,HOTEL_ADDRESS,HOTEL_LOCAL_CODE,HOTEL_SITE,HOTEL_TEL,HOTEL_REVIEW_SCORE,HOTEL_RANK,HOTEL_OPEN_TIME,HOTEL_CLOSE_TIME,HOTEL_OPTION,CHECK_IN,CHECK_OUT) values ( SEQ_BO_NO.CURRVAL ,'부산 해운대구 해운대해변로 296',8,'https://www.busanparadisehotel.co.kr/front','051-742-2121',0,5,8,23,'와이파이, 조식, 레스토랑, 세탁, 24시간 리셉션, 수하물 보관, 수영장, 피트니스, 스파/사우나, 비즈니스 시설, 주차, 공항셔틀, 장애인 편의시설, 바/라운지, 주방, 아이돌봄 서비스, 룸서비스',15,11);

Insert into TRIP2REAP.IMG_FILE (FILE_NO,BO_NO,ORIGIN_NAME,CHANGE_NAME,FILE_LEVEL,FILE_PATH,FILE_DELETE_YN) values (SEQ_FILE_NO.NEXTVAL , SEQ_BO_NO.CURRVAL ,'파라다이스호텔부산썸네일.jpeg','hotel_thumbnail_202012110259570545.jpeg',1,'/Users/ek/Documents/GitHub/Spring-Project-Trip2Reap/Spring-Final-Trip2Reap/src/main/webapp/resources/buploadFiles/hotel_thumbnail_202012110259570545.jpeg','N');
Insert into TRIP2REAP.IMG_FILE (FILE_NO,BO_NO,ORIGIN_NAME,CHANGE_NAME,FILE_LEVEL,FILE_PATH,FILE_DELETE_YN) values (SEQ_FILE_NO.NEXTVAL , SEQ_BO_NO.CURRVAL ,'파라다이스부산디테일1.jpeg','hotel_detail_202012110259570566.jpeg',2,'/Users/ek/Documents/GitHub/Spring-Project-Trip2Reap/Spring-Final-Trip2Reap/src/main/webapp/resources/buploadFiles/hotel_detail_202012110259570566.jpeg','N');
Insert into TRIP2REAP.IMG_FILE (FILE_NO,BO_NO,ORIGIN_NAME,CHANGE_NAME,FILE_LEVEL,FILE_PATH,FILE_DELETE_YN) values (SEQ_FILE_NO.NEXTVAL , SEQ_BO_NO.CURRVAL ,'파라다이스부산디테일2.jpeg','hotel_detail_202012110259570578.jpeg',2,'/Users/ek/Documents/GitHub/Spring-Project-Trip2Reap/Spring-Final-Trip2Reap/src/main/webapp/resources/buploadFiles/hotel_detail_202012110259570578.jpeg','N');
Insert into TRIP2REAP.IMG_FILE (FILE_NO,BO_NO,ORIGIN_NAME,CHANGE_NAME,FILE_LEVEL,FILE_PATH,FILE_DELETE_YN) values (SEQ_FILE_NO.NEXTVAL , SEQ_BO_NO.CURRVAL ,'파라다이스부산디테일3.jpeg','hotel_detail_202012110259570587.jpeg',2,'/Users/ek/Documents/GitHub/Spring-Project-Trip2Reap/Spring-Final-Trip2Reap/src/main/webapp/resources/buploadFiles/hotel_detail_202012110259570587.jpeg','N');
Insert into TRIP2REAP.IMG_FILE (FILE_NO,BO_NO,ORIGIN_NAME,CHANGE_NAME,FILE_LEVEL,FILE_PATH,FILE_DELETE_YN) values (SEQ_FILE_NO.NEXTVAL , SEQ_BO_NO.CURRVAL ,'파라다이스부산디테일4.jpeg','hotel_detail_202012110259570600.jpeg',2,'/Users/ek/Documents/GitHub/Spring-Project-Trip2Reap/Spring-Final-Trip2Reap/src/main/webapp/resources/buploadFiles/hotel_detail_202012110259570600.jpeg','N');
Insert into TRIP2REAP.IMG_FILE (FILE_NO,BO_NO,ORIGIN_NAME,CHANGE_NAME,FILE_LEVEL,FILE_PATH,FILE_DELETE_YN) values (SEQ_FILE_NO.NEXTVAL , SEQ_BO_NO.CURRVAL ,'파라다이스부산디테일5.jpeg','hotel_detail_202012110259570615.jpeg',2,'/Users/ek/Documents/GitHub/Spring-Project-Trip2Reap/Spring-Final-Trip2Reap/src/main/webapp/resources/buploadFiles/hotel_detail_202012110259570615.jpeg','N');
Insert into TRIP2REAP.IMG_FILE (FILE_NO,BO_NO,ORIGIN_NAME,CHANGE_NAME,FILE_LEVEL,FILE_PATH,FILE_DELETE_YN) values (SEQ_FILE_NO.NEXTVAL , SEQ_BO_NO.CURRVAL ,'파라다이스부산디테일6.jpeg','hotel_detail_202012110259570631.jpeg',2,'/Users/ek/Documents/GitHub/Spring-Project-Trip2Reap/Spring-Final-Trip2Reap/src/main/webapp/resources/buploadFiles/hotel_detail_202012110259570631.jpeg','N');
Insert into TRIP2REAP.IMG_FILE (FILE_NO,BO_NO,ORIGIN_NAME,CHANGE_NAME,FILE_LEVEL,FILE_PATH,FILE_DELETE_YN) values (SEQ_FILE_NO.NEXTVAL , SEQ_BO_NO.CURRVAL ,'파라다이스부산디테일7.jpeg','hotel_detail_202012110259570650.jpeg',2,'/Users/ek/Documents/GitHub/Spring-Project-Trip2Reap/Spring-Final-Trip2Reap/src/main/webapp/resources/buploadFiles/hotel_detail_202012110259570650.jpeg','N');
Insert into TRIP2REAP.IMG_FILE (FILE_NO,BO_NO,ORIGIN_NAME,CHANGE_NAME,FILE_LEVEL,FILE_PATH,FILE_DELETE_YN) values (SEQ_FILE_NO.NEXTVAL , SEQ_BO_NO.CURRVAL ,'파라다이스부산디테일8.jpeg','hotel_detail_202012110259570664.jpeg',2,'/Users/ek/Documents/GitHub/Spring-Project-Trip2Reap/Spring-Final-Trip2Reap/src/main/webapp/resources/buploadFiles/hotel_detail_202012110259570664.jpeg','N');
Insert into TRIP2REAP.IMG_FILE (FILE_NO,BO_NO,ORIGIN_NAME,CHANGE_NAME,FILE_LEVEL,FILE_PATH,FILE_DELETE_YN) values (SEQ_FILE_NO.NEXTVAL , SEQ_BO_NO.CURRVAL ,'파라다이스부산디테일9.jpeg','hotel_detail_202012110259570676.jpeg',2,'/Users/ek/Documents/GitHub/Spring-Project-Trip2Reap/Spring-Final-Trip2Reap/src/main/webapp/resources/buploadFiles/hotel_detail_202012110259570676.jpeg','N');
Insert into TRIP2REAP.IMG_FILE (FILE_NO,BO_NO,ORIGIN_NAME,CHANGE_NAME,FILE_LEVEL,FILE_PATH,FILE_DELETE_YN) values (SEQ_FILE_NO.NEXTVAL , SEQ_BO_NO.CURRVAL ,'파라다이스부산디테일10.jpeg','hotel_detail_202012110259570684.jpeg',2,'/Users/ek/Documents/GitHub/Spring-Project-Trip2Reap/Spring-Final-Trip2Reap/src/main/webapp/resources/buploadFiles/hotel_detail_202012110259570684.jpeg','N');
Insert into TRIP2REAP.IMG_FILE (FILE_NO,BO_NO,ORIGIN_NAME,CHANGE_NAME,FILE_LEVEL,FILE_PATH,FILE_DELETE_YN) values (SEQ_FILE_NO.NEXTVAL , SEQ_BO_NO.CURRVAL ,'파라다이스부산디테일11.jpeg','hotel_detail_202012110259570693.jpeg',2,'/Users/ek/Documents/GitHub/Spring-Project-Trip2Reap/Spring-Final-Trip2Reap/src/main/webapp/resources/buploadFiles/hotel_detail_202012110259570693.jpeg','N');
Insert into TRIP2REAP.IMG_FILE (FILE_NO,BO_NO,ORIGIN_NAME,CHANGE_NAME,FILE_LEVEL,FILE_PATH,FILE_DELETE_YN) values (SEQ_FILE_NO.NEXTVAL , SEQ_BO_NO.CURRVAL ,'파라다이스부산디테일12.jpeg','hotel_detail_202012110259570701.jpeg',2,'/Users/ek/Documents/GitHub/Spring-Project-Trip2Reap/Spring-Final-Trip2Reap/src/main/webapp/resources/buploadFiles/hotel_detail_202012110259570701.jpeg','N');
Insert into TRIP2REAP.IMG_FILE (FILE_NO,BO_NO,ORIGIN_NAME,CHANGE_NAME,FILE_LEVEL,FILE_PATH,FILE_DELETE_YN) values (SEQ_FILE_NO.NEXTVAL , SEQ_BO_NO.CURRVAL ,'파라다이스부산디테일13.jpeg','hotel_detail_202012110259570712.jpeg',2,'/Users/ek/Documents/GitHub/Spring-Project-Trip2Reap/Spring-Final-Trip2Reap/src/main/webapp/resources/buploadFiles/hotel_detail_202012110259570712.jpeg','N');
Insert into TRIP2REAP.IMG_FILE (FILE_NO,BO_NO,ORIGIN_NAME,CHANGE_NAME,FILE_LEVEL,FILE_PATH,FILE_DELETE_YN) values (SEQ_FILE_NO.NEXTVAL , SEQ_BO_NO.CURRVAL ,'파라다이스호텔부산썸네일.jpeg','hotel_detail_202012110259570718.jpeg',2,'/Users/ek/Documents/GitHub/Spring-Project-Trip2Reap/Spring-Final-Trip2Reap/src/main/webapp/resources/buploadFiles/hotel_detail_202012110259570718.jpeg','N');

Insert into TRIP2REAP.ROOM (ROOM_NO,BO_NO,ROOM_TYPE,ROOM_NAME,PRICE_PER_DAY) values ( SEQ_ROOM_NO.NEXTVAL , SEQ_BO_NO.CURRVAL ,'트윈룸','디럭스트윈(도시전망)+씨메르+오션풀-본관',180000);
Insert into TRIP2REAP.ROOM (ROOM_NO,BO_NO,ROOM_TYPE,ROOM_NAME,PRICE_PER_DAY) values ( SEQ_ROOM_NO.NEXTVAL , SEQ_BO_NO.CURRVAL ,'디럭스룸','디럭스트윈(도시전망)+씨메르+오션풀-본관',180000);
Insert into TRIP2REAP.ROOM (ROOM_NO,BO_NO,ROOM_TYPE,ROOM_NAME,PRICE_PER_DAY) values ( SEQ_ROOM_NO.NEXTVAL , SEQ_BO_NO.CURRVAL ,'더블룸','디럭스더블(도시전망)+씨메르+오션풀-신관',198000);
Insert into TRIP2REAP.ROOM (ROOM_NO,BO_NO,ROOM_TYPE,ROOM_NAME,PRICE_PER_DAY) values ( SEQ_ROOM_NO.NEXTVAL , SEQ_BO_NO.CURRVAL ,'디럭스룸','디럭스더블(도시전망)+씨메르+오션풀-신관',198000);
Insert into TRIP2REAP.ROOM (ROOM_NO,BO_NO,ROOM_TYPE,ROOM_NAME,PRICE_PER_DAY) values ( SEQ_ROOM_NO.NEXTVAL , SEQ_BO_NO.CURRVAL ,'디럭스룸','디럭스(시티뷰)+씨메르+오션풀+키즈빌리지',200000);


--47
Insert into TRIP2REAP.BOARD (BO_NO,CA_CODE,BO_TITLE,BO_CONTENT,MEMBER_ID,BO_COUNT,BO_TAG,BO_DELETE_YN,REGDATE) values (SEQ_BO_NO.NEXTVAL ,5,'라발스 호텔부산','라발스호텔은 2호선 남포역 6번 및 8번 출구에서 차로 약 3분, 경부선 KTX 부산역에서 차로 약 10분가량 떨어져 있습니다. 또한 김해 국제공항에서 차로 약 40분 거리에 위치해 있습니다. 주변 관광지로는 광안리 해수욕장이 차로 약 20분, 벡스코가 차로 약 25분, 동백공원이 차로 약 30분, 해운대 해수욕장이 차로 약 35분가량 정도 소요됩니다. 호텔에는 와인 클래스와 요가 클래스 등을 운영하는 클래스룸이 마련되어 있으며, 부산 도심의 전경을 감상할 수 있는 29층에 마련된 루프탑과 각종 행사 진행이 가능한 연회장도 준비되어 있습니다. 또한 코인 세탁실과 피트니스센터, 사우나는 물론, 비즈니스 센터와 편의점도 이용하실 수 있습니다. 호텔은 모던하고 안락한 분위기의 객실 총 389개를 보유하고 있습니다. 각 객실에는 무선 커피포트와 커피 및 차, 안전 금고 등이 준비되어 있으며 욕실에는 기본 욕실용품과 비데, 욕실 가운 등이 마련되어 있습니다. 호텔 28층에는 오션뷰를 감상하며 커피와 빵을 즐길 수 있는 카페가 마련되어 있으며, 다양한 요리를 맛보실 수 있는 뷔페 레스토랑도 준비되어 있습니다.','admin',1,'뷰캉스, 코너스윗패키지, 나이트오션피크닉','N',to_date('20/12/10','RR/MM/DD'));
Insert into TRIP2REAP.HOTEL (BO_NO,HOTEL_ADDRESS,HOTEL_LOCAL_CODE,HOTEL_SITE,HOTEL_TEL,HOTEL_REVIEW_SCORE,HOTEL_RANK,HOTEL_OPEN_TIME,HOTEL_CLOSE_TIME,HOTEL_OPTION,CHECK_IN,CHECK_OUT) values ( SEQ_BO_NO.CURRVAL ,'부산 영도구 봉래나루로 82',8,'https://www.lavalsehotel.co.kr/','051-790-1500',0,4,6,22,'와이파이, 조식, 레스토랑, 세탁, 24시간 리셉션, 수하물 보관, 수영장, 피트니스, 스파/사우나, 카페, 비즈니스 시설, 주차, 주방',15,11);

Insert into TRIP2REAP.IMG_FILE (FILE_NO,BO_NO,ORIGIN_NAME,CHANGE_NAME,FILE_LEVEL,FILE_PATH,FILE_DELETE_YN) values (SEQ_FILE_NO.NEXTVAL , SEQ_BO_NO.CURRVAL ,'썸네일.jpeg','hotel_thumbnail_202012110314330993.jpeg',1,'/Users/ek/Documents/GitHub/Spring-Project-Trip2Reap/Spring-Final-Trip2Reap/src/main/webapp/resources/buploadFiles/hotel_thumbnail_202012110314330993.jpeg','N');
Insert into TRIP2REAP.IMG_FILE (FILE_NO,BO_NO,ORIGIN_NAME,CHANGE_NAME,FILE_LEVEL,FILE_PATH,FILE_DELETE_YN) values (SEQ_FILE_NO.NEXTVAL , SEQ_BO_NO.CURRVAL ,'디테일1.jpeg','hotel_detail_202012110314340001.jpeg',2,'/Users/ek/Documents/GitHub/Spring-Project-Trip2Reap/Spring-Final-Trip2Reap/src/main/webapp/resources/buploadFiles/hotel_detail_202012110314340001.jpeg','N');
Insert into TRIP2REAP.IMG_FILE (FILE_NO,BO_NO,ORIGIN_NAME,CHANGE_NAME,FILE_LEVEL,FILE_PATH,FILE_DELETE_YN) values (SEQ_FILE_NO.NEXTVAL , SEQ_BO_NO.CURRVAL ,'디테일2.jpeg','hotel_detail_202012110314340008.jpeg',2,'/Users/ek/Documents/GitHub/Spring-Project-Trip2Reap/Spring-Final-Trip2Reap/src/main/webapp/resources/buploadFiles/hotel_detail_202012110314340008.jpeg','N');
Insert into TRIP2REAP.IMG_FILE (FILE_NO,BO_NO,ORIGIN_NAME,CHANGE_NAME,FILE_LEVEL,FILE_PATH,FILE_DELETE_YN) values (SEQ_FILE_NO.NEXTVAL , SEQ_BO_NO.CURRVAL ,'디테일3.jpeg','hotel_detail_202012110314340018.jpeg',2,'/Users/ek/Documents/GitHub/Spring-Project-Trip2Reap/Spring-Final-Trip2Reap/src/main/webapp/resources/buploadFiles/hotel_detail_202012110314340018.jpeg','N');
Insert into TRIP2REAP.IMG_FILE (FILE_NO,BO_NO,ORIGIN_NAME,CHANGE_NAME,FILE_LEVEL,FILE_PATH,FILE_DELETE_YN) values (SEQ_FILE_NO.NEXTVAL , SEQ_BO_NO.CURRVAL ,'디테일4.jpeg','hotel_detail_202012110314340023.jpeg',2,'/Users/ek/Documents/GitHub/Spring-Project-Trip2Reap/Spring-Final-Trip2Reap/src/main/webapp/resources/buploadFiles/hotel_detail_202012110314340023.jpeg','N');
Insert into TRIP2REAP.IMG_FILE (FILE_NO,BO_NO,ORIGIN_NAME,CHANGE_NAME,FILE_LEVEL,FILE_PATH,FILE_DELETE_YN) values (SEQ_FILE_NO.NEXTVAL , SEQ_BO_NO.CURRVAL ,'디테일5.jpeg','hotel_detail_202012110314340029.jpeg',2,'/Users/ek/Documents/GitHub/Spring-Project-Trip2Reap/Spring-Final-Trip2Reap/src/main/webapp/resources/buploadFiles/hotel_detail_202012110314340029.jpeg','N');
Insert into TRIP2REAP.IMG_FILE (FILE_NO,BO_NO,ORIGIN_NAME,CHANGE_NAME,FILE_LEVEL,FILE_PATH,FILE_DELETE_YN) values (SEQ_FILE_NO.NEXTVAL , SEQ_BO_NO.CURRVAL ,'디테일6.jpeg','hotel_detail_202012110314340035.jpeg',2,'/Users/ek/Documents/GitHub/Spring-Project-Trip2Reap/Spring-Final-Trip2Reap/src/main/webapp/resources/buploadFiles/hotel_detail_202012110314340035.jpeg','N');
Insert into TRIP2REAP.IMG_FILE (FILE_NO,BO_NO,ORIGIN_NAME,CHANGE_NAME,FILE_LEVEL,FILE_PATH,FILE_DELETE_YN) values (SEQ_FILE_NO.NEXTVAL , SEQ_BO_NO.CURRVAL ,'디테일7.jpeg','hotel_detail_202012110314340044.jpeg',2,'/Users/ek/Documents/GitHub/Spring-Project-Trip2Reap/Spring-Final-Trip2Reap/src/main/webapp/resources/buploadFiles/hotel_detail_202012110314340044.jpeg','N');
Insert into TRIP2REAP.IMG_FILE (FILE_NO,BO_NO,ORIGIN_NAME,CHANGE_NAME,FILE_LEVEL,FILE_PATH,FILE_DELETE_YN) values (SEQ_FILE_NO.NEXTVAL , SEQ_BO_NO.CURRVAL ,'디테일8.jpeg','hotel_detail_202012110314340051.jpeg',2,'/Users/ek/Documents/GitHub/Spring-Project-Trip2Reap/Spring-Final-Trip2Reap/src/main/webapp/resources/buploadFiles/hotel_detail_202012110314340051.jpeg','N');
Insert into TRIP2REAP.IMG_FILE (FILE_NO,BO_NO,ORIGIN_NAME,CHANGE_NAME,FILE_LEVEL,FILE_PATH,FILE_DELETE_YN) values (SEQ_FILE_NO.NEXTVAL , SEQ_BO_NO.CURRVAL ,'디테일9.jpeg','hotel_detail_202012110314340057.jpeg',2,'/Users/ek/Documents/GitHub/Spring-Project-Trip2Reap/Spring-Final-Trip2Reap/src/main/webapp/resources/buploadFiles/hotel_detail_202012110314340057.jpeg','N');
Insert into TRIP2REAP.IMG_FILE (FILE_NO,BO_NO,ORIGIN_NAME,CHANGE_NAME,FILE_LEVEL,FILE_PATH,FILE_DELETE_YN) values (SEQ_FILE_NO.NEXTVAL , SEQ_BO_NO.CURRVAL ,'디테일10.jpeg','hotel_detail_202012110314340064.jpeg',2,'/Users/ek/Documents/GitHub/Spring-Project-Trip2Reap/Spring-Final-Trip2Reap/src/main/webapp/resources/buploadFiles/hotel_detail_202012110314340064.jpeg','N');
Insert into TRIP2REAP.IMG_FILE (FILE_NO,BO_NO,ORIGIN_NAME,CHANGE_NAME,FILE_LEVEL,FILE_PATH,FILE_DELETE_YN) values (SEQ_FILE_NO.NEXTVAL , SEQ_BO_NO.CURRVAL ,'디테일11.jpeg','hotel_detail_202012110314340076.jpeg',2,'/Users/ek/Documents/GitHub/Spring-Project-Trip2Reap/Spring-Final-Trip2Reap/src/main/webapp/resources/buploadFiles/hotel_detail_202012110314340076.jpeg','N');
Insert into TRIP2REAP.IMG_FILE (FILE_NO,BO_NO,ORIGIN_NAME,CHANGE_NAME,FILE_LEVEL,FILE_PATH,FILE_DELETE_YN) values (SEQ_FILE_NO.NEXTVAL , SEQ_BO_NO.CURRVAL ,'디테일12.jpeg','hotel_detail_202012110314340085.jpeg',2,'/Users/ek/Documents/GitHub/Spring-Project-Trip2Reap/Spring-Final-Trip2Reap/src/main/webapp/resources/buploadFiles/hotel_detail_202012110314340085.jpeg','N');
Insert into TRIP2REAP.IMG_FILE (FILE_NO,BO_NO,ORIGIN_NAME,CHANGE_NAME,FILE_LEVEL,FILE_PATH,FILE_DELETE_YN) values (SEQ_FILE_NO.NEXTVAL , SEQ_BO_NO.CURRVAL ,'디테일13.jpeg','hotel_detail_202012110314340095.jpeg',2,'/Users/ek/Documents/GitHub/Spring-Project-Trip2Reap/Spring-Final-Trip2Reap/src/main/webapp/resources/buploadFiles/hotel_detail_202012110314340095.jpeg','N');
Insert into TRIP2REAP.IMG_FILE (FILE_NO,BO_NO,ORIGIN_NAME,CHANGE_NAME,FILE_LEVEL,FILE_PATH,FILE_DELETE_YN) values (SEQ_FILE_NO.NEXTVAL , SEQ_BO_NO.CURRVAL ,'디테일14.jpeg','hotel_detail_202012110314340106.jpeg',2,'/Users/ek/Documents/GitHub/Spring-Project-Trip2Reap/Spring-Final-Trip2Reap/src/main/webapp/resources/buploadFiles/hotel_detail_202012110314340106.jpeg','N');
Insert into TRIP2REAP.IMG_FILE (FILE_NO,BO_NO,ORIGIN_NAME,CHANGE_NAME,FILE_LEVEL,FILE_PATH,FILE_DELETE_YN) values (SEQ_FILE_NO.NEXTVAL , SEQ_BO_NO.CURRVAL ,'썸네일.jpeg','hotel_detail_202012110314340120.jpeg',2,'/Users/ek/Documents/GitHub/Spring-Project-Trip2Reap/Spring-Final-Trip2Reap/src/main/webapp/resources/buploadFiles/hotel_detail_202012110314340120.jpeg','N');

Insert into TRIP2REAP.ROOM (ROOM_NO,BO_NO,ROOM_TYPE,ROOM_NAME,PRICE_PER_DAY) values ( SEQ_ROOM_NO.NEXTVAL , SEQ_BO_NO.CURRVAL ,'스탠다드룸','스탠다드 더블룸(도시전망)',80300);
Insert into TRIP2REAP.ROOM (ROOM_NO,BO_NO,ROOM_TYPE,ROOM_NAME,PRICE_PER_DAY) values ( SEQ_ROOM_NO.NEXTVAL , SEQ_BO_NO.CURRVAL ,'더블룸','스탠다드 더블룸(도시전망)',80300);
Insert into TRIP2REAP.ROOM (ROOM_NO,BO_NO,ROOM_TYPE,ROOM_NAME,PRICE_PER_DAY) values ( SEQ_ROOM_NO.NEXTVAL , SEQ_BO_NO.CURRVAL ,'스탠다드룸','스탠다드 트윈룸(도시전망)',82700);
Insert into TRIP2REAP.ROOM (ROOM_NO,BO_NO,ROOM_TYPE,ROOM_NAME,PRICE_PER_DAY) values ( SEQ_ROOM_NO.NEXTVAL , SEQ_BO_NO.CURRVAL ,'트윈룸','스탠다드 트윈룸(도시전망)',82700);
Insert into TRIP2REAP.ROOM (ROOM_NO,BO_NO,ROOM_TYPE,ROOM_NAME,PRICE_PER_DAY) values ( SEQ_ROOM_NO.NEXTVAL , SEQ_BO_NO.CURRVAL ,'스탠다드룸','스탠다드 오션 트윈룸(바다전망)',98200);
Insert into TRIP2REAP.ROOM (ROOM_NO,BO_NO,ROOM_TYPE,ROOM_NAME,PRICE_PER_DAY) values ( SEQ_ROOM_NO.NEXTVAL , SEQ_BO_NO.CURRVAL ,'트윈룸','스탠다드 오션 트윈룸(바다전망)',98200);


--48
Insert into TRIP2REAP.BOARD (BO_NO,CA_CODE,BO_TITLE,BO_CONTENT,MEMBER_ID,BO_COUNT,BO_TAG,BO_DELETE_YN,REGDATE) values (SEQ_BO_NO.NEXTVAL ,5,'라마다 앙코르 바이 윈덤 부산 해운대','라마다 앙코르 바이 윈덤 부산 해운대는 2017년 7월에 신축 오픈하였으며 부산 지하철 2호선 해운대역 3번 출구에서 도보 1분 거리에 있습니다. 뿐만 아니라, 해운대 해수욕장과 부산 아쿠아리움에서 도보로 단 5분 거리에 있으며 달맞이길과 센텀시티까지는 차로 10분이 소요됩니다. 호텔 내부에는 코인 세탁실, 피트니스 스튜디오, 비즈니스 코너 등을 운영하고 있어 편리하게 이용하실 수 있습니다. 뿐만 아니라, 편히 휴식을 취하실 수 있는 공용 라운지가 있으며 24시간 리셉션 서비스를 이용하실 수 있습니다. 추가 요금을 내시면 회의실과 드라이클리닝 서비스를 이용하실 수 있습니다. 여름에는 루프탑 바&가든을 운영하여 멋진 해운다 바다 전경을 감상하실 수 있습니다. 전체 402개의 객실을 보유하고 있으며 슈페리어 더블부터 퍼스트 스위트 객실까지 다양한 유형의 객실을 보유하고 있습니다. 깔끔하고 모던한 인테리어를 자랑하는 객실 내에는 최고급 포켓 스프링 매트리스, 블루투스 스테레오 시스템 등이 갖춰져 있습니다. 욕실에는 헤어드라이어, 어메니티, 목욕가운 등이 있습니다. 3층에 위치한 올데이 다이닝 레스토랑에서는 조식부터 석식까지 다양한 메뉴를 선보이고 있습니다.','admin',1,'해운대역앞호텔, 해운대와가까운','N',to_date('20/12/10','RR/MM/DD'));
Insert into TRIP2REAP.HOTEL (BO_NO,HOTEL_ADDRESS,HOTEL_LOCAL_CODE,HOTEL_SITE,HOTEL_TEL,HOTEL_REVIEW_SCORE,HOTEL_RANK,HOTEL_OPEN_TIME,HOTEL_CLOSE_TIME,HOTEL_OPTION,CHECK_IN,CHECK_OUT) values ( SEQ_BO_NO.CURRVAL ,'부산 해운대구 구남로 9',8,'http://www.ramadaencorehaeundae.com/','051-610-3000',0,4,9,21,'와이파이, 조식, 레스토랑, 세탁, 24시간 리셉션, 수하물 보관, 카페, 비즈니스 시설, 주차, 장애인 편의시설, 주방',15,11);

Insert into TRIP2REAP.IMG_FILE (FILE_NO,BO_NO,ORIGIN_NAME,CHANGE_NAME,FILE_LEVEL,FILE_PATH,FILE_DELETE_YN) values (SEQ_FILE_NO.NEXTVAL , SEQ_BO_NO.CURRVAL ,'썸네일.jpeg','hotel_thumbnail_202012110325120623.jpeg',1,'/Users/ek/Documents/GitHub/Spring-Project-Trip2Reap/Spring-Final-Trip2Reap/src/main/webapp/resources/buploadFiles/hotel_thumbnail_202012110325120623.jpeg','N');
Insert into TRIP2REAP.IMG_FILE (FILE_NO,BO_NO,ORIGIN_NAME,CHANGE_NAME,FILE_LEVEL,FILE_PATH,FILE_DELETE_YN) values (SEQ_FILE_NO.NEXTVAL , SEQ_BO_NO.CURRVAL ,'디테일1.jpeg','hotel_detail_202012110325120631.jpeg',2,'/Users/ek/Documents/GitHub/Spring-Project-Trip2Reap/Spring-Final-Trip2Reap/src/main/webapp/resources/buploadFiles/hotel_detail_202012110325120631.jpeg','N');
Insert into TRIP2REAP.IMG_FILE (FILE_NO,BO_NO,ORIGIN_NAME,CHANGE_NAME,FILE_LEVEL,FILE_PATH,FILE_DELETE_YN) values (SEQ_FILE_NO.NEXTVAL , SEQ_BO_NO.CURRVAL ,'디테일2.jpeg','hotel_detail_202012110325120637.jpeg',2,'/Users/ek/Documents/GitHub/Spring-Project-Trip2Reap/Spring-Final-Trip2Reap/src/main/webapp/resources/buploadFiles/hotel_detail_202012110325120637.jpeg','N');
Insert into TRIP2REAP.IMG_FILE (FILE_NO,BO_NO,ORIGIN_NAME,CHANGE_NAME,FILE_LEVEL,FILE_PATH,FILE_DELETE_YN) values (SEQ_FILE_NO.NEXTVAL , SEQ_BO_NO.CURRVAL ,'디테일3.jpeg','hotel_detail_202012110325120644.jpeg',2,'/Users/ek/Documents/GitHub/Spring-Project-Trip2Reap/Spring-Final-Trip2Reap/src/main/webapp/resources/buploadFiles/hotel_detail_202012110325120644.jpeg','N');
Insert into TRIP2REAP.IMG_FILE (FILE_NO,BO_NO,ORIGIN_NAME,CHANGE_NAME,FILE_LEVEL,FILE_PATH,FILE_DELETE_YN) values (SEQ_FILE_NO.NEXTVAL , SEQ_BO_NO.CURRVAL ,'디테일4.jpeg','hotel_detail_202012110325120651.jpeg',2,'/Users/ek/Documents/GitHub/Spring-Project-Trip2Reap/Spring-Final-Trip2Reap/src/main/webapp/resources/buploadFiles/hotel_detail_202012110325120651.jpeg','N');
Insert into TRIP2REAP.IMG_FILE (FILE_NO,BO_NO,ORIGIN_NAME,CHANGE_NAME,FILE_LEVEL,FILE_PATH,FILE_DELETE_YN) values (SEQ_FILE_NO.NEXTVAL , SEQ_BO_NO.CURRVAL ,'디테일5.jpeg','hotel_detail_202012110325120658.jpeg',2,'/Users/ek/Documents/GitHub/Spring-Project-Trip2Reap/Spring-Final-Trip2Reap/src/main/webapp/resources/buploadFiles/hotel_detail_202012110325120658.jpeg','N');
Insert into TRIP2REAP.IMG_FILE (FILE_NO,BO_NO,ORIGIN_NAME,CHANGE_NAME,FILE_LEVEL,FILE_PATH,FILE_DELETE_YN) values (SEQ_FILE_NO.NEXTVAL , SEQ_BO_NO.CURRVAL ,'디테일6.jpeg','hotel_detail_202012110325120667.jpeg',2,'/Users/ek/Documents/GitHub/Spring-Project-Trip2Reap/Spring-Final-Trip2Reap/src/main/webapp/resources/buploadFiles/hotel_detail_202012110325120667.jpeg','N');
Insert into TRIP2REAP.IMG_FILE (FILE_NO,BO_NO,ORIGIN_NAME,CHANGE_NAME,FILE_LEVEL,FILE_PATH,FILE_DELETE_YN) values (SEQ_FILE_NO.NEXTVAL , SEQ_BO_NO.CURRVAL ,'디테일7.jpeg','hotel_detail_202012110325120677.jpeg',2,'/Users/ek/Documents/GitHub/Spring-Project-Trip2Reap/Spring-Final-Trip2Reap/src/main/webapp/resources/buploadFiles/hotel_detail_202012110325120677.jpeg','N');
Insert into TRIP2REAP.IMG_FILE (FILE_NO,BO_NO,ORIGIN_NAME,CHANGE_NAME,FILE_LEVEL,FILE_PATH,FILE_DELETE_YN) values (SEQ_FILE_NO.NEXTVAL , SEQ_BO_NO.CURRVAL ,'썸네일.jpeg','hotel_detail_202012110325120682.jpeg',2,'/Users/ek/Documents/GitHub/Spring-Project-Trip2Reap/Spring-Final-Trip2Reap/src/main/webapp/resources/buploadFiles/hotel_detail_202012110325120682.jpeg','N');

Insert into TRIP2REAP.ROOM (ROOM_NO,BO_NO,ROOM_TYPE,ROOM_NAME,PRICE_PER_DAY) values ( SEQ_ROOM_NO.NEXTVAL , SEQ_BO_NO.CURRVAL ,'트윈룸','디럭스 트윈룸',62100);
Insert into TRIP2REAP.ROOM (ROOM_NO,BO_NO,ROOM_TYPE,ROOM_NAME,PRICE_PER_DAY) values ( SEQ_ROOM_NO.NEXTVAL , SEQ_BO_NO.CURRVAL ,'디럭스룸','디럭스 트윈룸',62100);
Insert into TRIP2REAP.ROOM (ROOM_NO,BO_NO,ROOM_TYPE,ROOM_NAME,PRICE_PER_DAY) values ( SEQ_ROOM_NO.NEXTVAL , SEQ_BO_NO.CURRVAL ,'더블룸','슈페리어 더블룸',63400);
Insert into TRIP2REAP.ROOM (ROOM_NO,BO_NO,ROOM_TYPE,ROOM_NAME,PRICE_PER_DAY) values ( SEQ_ROOM_NO.NEXTVAL , SEQ_BO_NO.CURRVAL ,'슈페리어룸','슈페리어 더블룸',63400);
Insert into TRIP2REAP.ROOM (ROOM_NO,BO_NO,ROOM_TYPE,ROOM_NAME,PRICE_PER_DAY) values ( SEQ_ROOM_NO.NEXTVAL , SEQ_BO_NO.CURRVAL ,'슈페리어룸','슈페리어 퀸사이즈침대 (금연)',63700);
Insert into TRIP2REAP.ROOM (ROOM_NO,BO_NO,ROOM_TYPE,ROOM_NAME,PRICE_PER_DAY) values ( SEQ_ROOM_NO.NEXTVAL , SEQ_BO_NO.CURRVAL ,'트윈룸','패밀리 트윈룸',93000);
Insert into TRIP2REAP.ROOM (ROOM_NO,BO_NO,ROOM_TYPE,ROOM_NAME,PRICE_PER_DAY) values ( SEQ_ROOM_NO.NEXTVAL , SEQ_BO_NO.CURRVAL ,'패밀리룸','패밀리 트윈룸',93000);


--49
Insert into TRIP2REAP.BOARD (BO_NO,CA_CODE,BO_TITLE,BO_CONTENT,MEMBER_ID,BO_COUNT,BO_TAG,BO_DELETE_YN,REGDATE) values (SEQ_BO_NO.NEXTVAL ,5,'그랜드 조선 부산','그랜드 조선 부산은 해운대 해수욕장 바로 앞에 위치하고 있으며, 부산 지하철 2호선 해운대역 3번 출구에서 도보 5분 거리에 있습니다. 주변 명소인 SEA LIFE 부산 아쿠아리움은 도보 1분, 누리마루APEC하우스는 차로 약 5분 거리에 있습니다. 지하철로 세 정거장 거리에는 신세계 백화점 센텀시티점이 있습니다. 지상 16층, 지하 4층 규모의 총 330객실을 비롯해 4개의 식음(F&B) 업장, 수영장, 피트니스와 스파, 연회 이벤트룸 등 각종 부대시설로 구성되어 있습니다. 가족 동반 고객을 위한 키즈 전용 플로어가 있고, 키즈 서비스 프로그램인 조선 주니어는 가족과의 여행을 더욱 즐겁게 만들어 줄 수 있도록 웰컴 기프트부터, 키즈 어메니티(물컵, 가운, 슬리퍼, 배스), 키즈 생일 이벤트 등이 마련되어 있습니다. 디럭스 객실의 시티뷰에서는 아름다운 도시의 야경을 감상할 수 있으며, 오션뷰에서는 탁 트인 통유리를 통해 따스한 햇살과 바다 조망을 누릴 수 있습니다. 또한, 여행의 목적에 따라 고객이 선택할 수 있도록 온돌 스위트 객실도 준비되어 있습니다. 스위트 이용 시 사우나 2인 무료 이용과 함께 그랑제이 프라이빗 라운지 입장이 가능하여 모닝타임의 커피와 티, 데이타임 스낵, 나잇타임의 해피아워를 즐길 수 있으며, 런던 명품 브랜드 조말론(Jo Malone) 제품 어메니티를 제공합니다. 투숙객을 위해 무료 Wi-Fi, 모닝콜 서비스, 룸서비스도 제공됩니다. 모든 객실에는 평면TV와 개인 금고, 개별 냉난방 조절기, 냉장고, 커피머신 등이 갖춰져 있습니다.','admin',1,'신세계조선호텔, 그랜드조선호텔','N',to_date('20/12/10','RR/MM/DD'));
Insert into TRIP2REAP.HOTEL (BO_NO,HOTEL_ADDRESS,HOTEL_LOCAL_CODE,HOTEL_SITE,HOTEL_TEL,HOTEL_REVIEW_SCORE,HOTEL_RANK,HOTEL_OPEN_TIME,HOTEL_CLOSE_TIME,HOTEL_OPTION,CHECK_IN,CHECK_OUT) values ( SEQ_BO_NO.CURRVAL ,'부산 해운대구 해운대해변로 292',8,'https://gjb.josunhotel.com/main.do','051-922-5000',0,5,6,23,'와이파이, 조식, 레스토랑, 세탁, 24시간 리셉션, 수하물 보관, 수영장, 피트니스, 스파/사우나, 비즈니스 시설, 주차, 장애인 편의시설, 바/라운지, 주방, 아이돌봄 서비스, 룸서비스',15,12);

Insert into TRIP2REAP.IMG_FILE (FILE_NO,BO_NO,ORIGIN_NAME,CHANGE_NAME,FILE_LEVEL,FILE_PATH,FILE_DELETE_YN) values (SEQ_FILE_NO.NEXTVAL , SEQ_BO_NO.CURRVAL ,'썸네일.jpeg','hotel_thumbnail_202012110341590716.jpeg',1,'/Users/ek/Documents/GitHub/Spring-Project-Trip2Reap/Spring-Final-Trip2Reap/src/main/webapp/resources/buploadFiles/hotel_thumbnail_202012110341590716.jpeg','N');
Insert into TRIP2REAP.IMG_FILE (FILE_NO,BO_NO,ORIGIN_NAME,CHANGE_NAME,FILE_LEVEL,FILE_PATH,FILE_DELETE_YN) values (SEQ_FILE_NO.NEXTVAL , SEQ_BO_NO.CURRVAL ,'디테일1.jpeg','hotel_detail_202012110341590724.jpeg',2,'/Users/ek/Documents/GitHub/Spring-Project-Trip2Reap/Spring-Final-Trip2Reap/src/main/webapp/resources/buploadFiles/hotel_detail_202012110341590724.jpeg','N');
Insert into TRIP2REAP.IMG_FILE (FILE_NO,BO_NO,ORIGIN_NAME,CHANGE_NAME,FILE_LEVEL,FILE_PATH,FILE_DELETE_YN) values (SEQ_FILE_NO.NEXTVAL , SEQ_BO_NO.CURRVAL ,'디테일2.jpeg','hotel_detail_202012110341590733.jpeg',2,'/Users/ek/Documents/GitHub/Spring-Project-Trip2Reap/Spring-Final-Trip2Reap/src/main/webapp/resources/buploadFiles/hotel_detail_202012110341590733.jpeg','N');
Insert into TRIP2REAP.IMG_FILE (FILE_NO,BO_NO,ORIGIN_NAME,CHANGE_NAME,FILE_LEVEL,FILE_PATH,FILE_DELETE_YN) values (SEQ_FILE_NO.NEXTVAL , SEQ_BO_NO.CURRVAL ,'디테일3.jpeg','hotel_detail_202012110341590739.jpeg',2,'/Users/ek/Documents/GitHub/Spring-Project-Trip2Reap/Spring-Final-Trip2Reap/src/main/webapp/resources/buploadFiles/hotel_detail_202012110341590739.jpeg','N');
Insert into TRIP2REAP.IMG_FILE (FILE_NO,BO_NO,ORIGIN_NAME,CHANGE_NAME,FILE_LEVEL,FILE_PATH,FILE_DELETE_YN) values (SEQ_FILE_NO.NEXTVAL , SEQ_BO_NO.CURRVAL ,'디테일4.jpeg','hotel_detail_202012110341590747.jpeg',2,'/Users/ek/Documents/GitHub/Spring-Project-Trip2Reap/Spring-Final-Trip2Reap/src/main/webapp/resources/buploadFiles/hotel_detail_202012110341590747.jpeg','N');
Insert into TRIP2REAP.IMG_FILE (FILE_NO,BO_NO,ORIGIN_NAME,CHANGE_NAME,FILE_LEVEL,FILE_PATH,FILE_DELETE_YN) values (SEQ_FILE_NO.NEXTVAL , SEQ_BO_NO.CURRVAL ,'디테일5.jpeg','hotel_detail_202012110341590754.jpeg',2,'/Users/ek/Documents/GitHub/Spring-Project-Trip2Reap/Spring-Final-Trip2Reap/src/main/webapp/resources/buploadFiles/hotel_detail_202012110341590754.jpeg','N');
Insert into TRIP2REAP.IMG_FILE (FILE_NO,BO_NO,ORIGIN_NAME,CHANGE_NAME,FILE_LEVEL,FILE_PATH,FILE_DELETE_YN) values (SEQ_FILE_NO.NEXTVAL , SEQ_BO_NO.CURRVAL ,'디테일6.jpeg','hotel_detail_202012110341590759.jpeg',2,'/Users/ek/Documents/GitHub/Spring-Project-Trip2Reap/Spring-Final-Trip2Reap/src/main/webapp/resources/buploadFiles/hotel_detail_202012110341590759.jpeg','N');
Insert into TRIP2REAP.IMG_FILE (FILE_NO,BO_NO,ORIGIN_NAME,CHANGE_NAME,FILE_LEVEL,FILE_PATH,FILE_DELETE_YN) values (SEQ_FILE_NO.NEXTVAL , SEQ_BO_NO.CURRVAL ,'디테일7.jpeg','hotel_detail_202012110341590765.jpeg',2,'/Users/ek/Documents/GitHub/Spring-Project-Trip2Reap/Spring-Final-Trip2Reap/src/main/webapp/resources/buploadFiles/hotel_detail_202012110341590765.jpeg','N');
Insert into TRIP2REAP.IMG_FILE (FILE_NO,BO_NO,ORIGIN_NAME,CHANGE_NAME,FILE_LEVEL,FILE_PATH,FILE_DELETE_YN) values (SEQ_FILE_NO.NEXTVAL , SEQ_BO_NO.CURRVAL ,'디테일8.jpeg','hotel_detail_202012110341590773.jpeg',2,'/Users/ek/Documents/GitHub/Spring-Project-Trip2Reap/Spring-Final-Trip2Reap/src/main/webapp/resources/buploadFiles/hotel_detail_202012110341590773.jpeg','N');
Insert into TRIP2REAP.IMG_FILE (FILE_NO,BO_NO,ORIGIN_NAME,CHANGE_NAME,FILE_LEVEL,FILE_PATH,FILE_DELETE_YN) values (SEQ_FILE_NO.NEXTVAL , SEQ_BO_NO.CURRVAL ,'디테일9.jpeg','hotel_detail_202012110341590780.jpeg',2,'/Users/ek/Documents/GitHub/Spring-Project-Trip2Reap/Spring-Final-Trip2Reap/src/main/webapp/resources/buploadFiles/hotel_detail_202012110341590780.jpeg','N');
Insert into TRIP2REAP.IMG_FILE (FILE_NO,BO_NO,ORIGIN_NAME,CHANGE_NAME,FILE_LEVEL,FILE_PATH,FILE_DELETE_YN) values (SEQ_FILE_NO.NEXTVAL , SEQ_BO_NO.CURRVAL ,'디테일10.jpeg','hotel_detail_202012110341590787.jpeg',2,'/Users/ek/Documents/GitHub/Spring-Project-Trip2Reap/Spring-Final-Trip2Reap/src/main/webapp/resources/buploadFiles/hotel_detail_202012110341590787.jpeg','N');
Insert into TRIP2REAP.IMG_FILE (FILE_NO,BO_NO,ORIGIN_NAME,CHANGE_NAME,FILE_LEVEL,FILE_PATH,FILE_DELETE_YN) values (SEQ_FILE_NO.NEXTVAL , SEQ_BO_NO.CURRVAL ,'썸네일.jpeg','hotel_detail_202012110341590793.jpeg',2,'/Users/ek/Documents/GitHub/Spring-Project-Trip2Reap/Spring-Final-Trip2Reap/src/main/webapp/resources/buploadFiles/hotel_detail_202012110341590793.jpeg','N');

Insert into TRIP2REAP.ROOM (ROOM_NO,BO_NO,ROOM_TYPE,ROOM_NAME,PRICE_PER_DAY) values ( SEQ_ROOM_NO.NEXTVAL , SEQ_BO_NO.CURRVAL ,'더블룸','슈페리어 더블룸 - 도시전망+피트니스+수영장',161500);
Insert into TRIP2REAP.ROOM (ROOM_NO,BO_NO,ROOM_TYPE,ROOM_NAME,PRICE_PER_DAY) values ( SEQ_ROOM_NO.NEXTVAL , SEQ_BO_NO.CURRVAL ,'슈페리어룸','슈페리어 더블룸 -도시전망+피트니스+수영장',161500);
Insert into TRIP2REAP.ROOM (ROOM_NO,BO_NO,ROOM_TYPE,ROOM_NAME,PRICE_PER_DAY) values ( SEQ_ROOM_NO.NEXTVAL , SEQ_BO_NO.CURRVAL ,'디럭스룸','디럭스 패밀리룸 - 도시전망+피트니스+수영장',187000);
Insert into TRIP2REAP.ROOM (ROOM_NO,BO_NO,ROOM_TYPE,ROOM_NAME,PRICE_PER_DAY) values ( SEQ_ROOM_NO.NEXTVAL , SEQ_BO_NO.CURRVAL ,'패밀리룸','디럭스 패밀리룸 - 도시전망+피트니스+수영장',187000);
Insert into TRIP2REAP.ROOM (ROOM_NO,BO_NO,ROOM_TYPE,ROOM_NAME,PRICE_PER_DAY) values ( SEQ_ROOM_NO.NEXTVAL , SEQ_BO_NO.CURRVAL ,'트윈룸','디럭스 트윈룸',187000);
Insert into TRIP2REAP.ROOM (ROOM_NO,BO_NO,ROOM_TYPE,ROOM_NAME,PRICE_PER_DAY) values ( SEQ_ROOM_NO.NEXTVAL , SEQ_BO_NO.CURRVAL ,'디럭스룸','디럭스 트윈룸',187000);
Insert into TRIP2REAP.ROOM (ROOM_NO,BO_NO,ROOM_TYPE,ROOM_NAME,PRICE_PER_DAY) values ( SEQ_ROOM_NO.NEXTVAL , SEQ_BO_NO.CURRVAL ,'디럭스룸','디럭스 킹룸',187000);
Insert into TRIP2REAP.ROOM (ROOM_NO,BO_NO,ROOM_TYPE,ROOM_NAME,PRICE_PER_DAY) values ( SEQ_ROOM_NO.NEXTVAL , SEQ_BO_NO.CURRVAL ,'트윈룸','키즈 디럭스 트윈룸',255000);
Insert into TRIP2REAP.ROOM (ROOM_NO,BO_NO,ROOM_TYPE,ROOM_NAME,PRICE_PER_DAY) values ( SEQ_ROOM_NO.NEXTVAL , SEQ_BO_NO.CURRVAL ,'디럭스룸','키즈 디럭스 트윈룸',255000);
Insert into TRIP2REAP.ROOM (ROOM_NO,BO_NO,ROOM_TYPE,ROOM_NAME,PRICE_PER_DAY) values ( SEQ_ROOM_NO.NEXTVAL , SEQ_BO_NO.CURRVAL ,'디럭스룸','디럭스 오션뷰+ 킹침대',272000);
Insert into TRIP2REAP.ROOM (ROOM_NO,BO_NO,ROOM_TYPE,ROOM_NAME,PRICE_PER_DAY) values ( SEQ_ROOM_NO.NEXTVAL , SEQ_BO_NO.CURRVAL ,'프리미어룸','프리미어 시티뷰 킹룸 -피트니스+수영장+사우나',289000);


--50
Insert into TRIP2REAP.BOARD (BO_NO,CA_CODE,BO_TITLE,BO_CONTENT,MEMBER_ID,BO_COUNT,BO_TAG,BO_DELETE_YN,REGDATE) values (SEQ_BO_NO.NEXTVAL ,5,'시그니엘 부산','시그니엘 부산 - <5성급:한국관광공사 인증> - 시그니엘 부산은 엘시티(LCT) 타워 3층에서 19층까지 위치한 럭셔리 호텔입니다. 지하철을 이용하실 시에는 부산 2호선 중동역 7번 출구에서 도보로 약 13분, 2호선 해운대역 1번 출구에서 도보로 약 15분이면 갈 수 있습니다. 차로 이동 시에는 김해공항에서 약 50분이 소요됩니다. 주변 관광지인 해운대 해수욕장은 걸어서 약 10분이 걸립니다. 해운대 달맞이길과 광안대교는 차로 약 10분 이내에 갈 수 있습니다. 이처럼 주요 명소에 인접해 있어 최상의 위치를 자랑합니다. 호텔의 야외 수영장은 메인 인피니티 풀, 키즈 풀, 플런지 풀, 선라운저 존으로 색다르게 구성되어있습니다. 탈의 공간도 있어 편리하게 이용할 수 있습니다. 반면, 실내 수영장은 메인, 플런지 및 선라운저 풀로 구성되어있습니다. 스파에서는 친환경 고급 브랜드인 ''샹테카이''를 국내에서 최초로 선보여 새로운 경험을 선사합니다. 피트니스센터에는 40여 종의 프리미엄 운동 기구가 갖춰져 있으며 개인 관리를 위한 PT 스튜디오도 마련되어 있습니다. 사우나는 건식 및 습식 공간이 있으며 냉탕, 온탕, 열탕 등이 있습니다. 자녀를 위한 키즈 라운지는 유행하는 Color Tree와 Color leaf로 구성된 놀이 공간을 제공하며 라이브러리 & 블럭 존과 액티비티 플레이 존으로 나누어져 있습니다. 다양한 시설로 개인 여행자나 가족 여행자도 여가를 보내기에 좋습니다. 출장자에게는 비즈니스 센터가 있어 업무를 효율적으로 진행할 수 있습니다. 이외에도 다목적 연회장, 예식장 및 야외 테라스가 있어 맞춤식 행사를 계획하기에 적합합니다. 260실 규모의 바다를 테마로 한 고급스러운 객실에는 그랜드 디럭스, 프리미어, 시그니엘 프리미어, 스위트 룸이 있습니다. 이 중 스위트 룸은 디럭스, 프리미어, 프레지덴셜 및 로얄 스위트으로 구성되어 있습니다. 모든 침구는 고급 브랜드 프레떼로 갖춰져 있으며, 별도로 맞춤형 베개와 턴다운 서비스, 신문, 다림질 서비스, 슈 폴리싱 서비스, 유무선 인터넷 서비스를 제공합니다. 내부에는 TV, 에어컨, 금고, 데스크, 전화기, 냉장고, 미니바, 커피/티 메이커, 생수, 우산, 구둣주걱 등이 있으며 욕실에는 욕조, 비데, 욕실용품, 가운, 슬리퍼, 헤어드라이어 등이 완비되어 있습니다. 탁 트인 바다 전망을 자랑하는 ''더 뷰''에서는 올 데이 뷔페 식사가 가능합니다. 모던 차이니즈 타파스 & 바 로 불리는 ''차오란''에서는 미쉐린 스타 쉐프가 요리하는 다양한 중식 음식을 먹을 수 있으며 저녁에는 시그니처 칵테일을 드실 수 있습니다. 투숙객 전용 라운지인 ''살롱 드 시그니엘''에서는 아침, 낮, 저녁에 정해진 시간에 맞춰 간단한 스낵과 음료를 제공합니다. ''더 라운지''에서는 낮에는 애프터눈 티와 커피를 마시며 저녁에는 일몰을 바라보며 주류를 즐길 수 있습니다. 야외 수영장 옆에 위치한 ''풀 바''에서는 치킨, 버거 등의 스낵과 함께 음료를 드시며 휴식을 취할 수 있습니다. ''페이스트리 살롱''에서는 미쉐린 스타 쉐프가 만든 디저트와 커피를 함께하며 여유를 느낄 수 있습니다.','admin',2,'롯데시그니엘, 롯데호텔, 해운대럭셔리호텔','N',to_date('20/12/10','RR/MM/DD'));
Insert into TRIP2REAP.HOTEL (BO_NO,HOTEL_ADDRESS,HOTEL_LOCAL_CODE,HOTEL_SITE,HOTEL_TEL,HOTEL_REVIEW_SCORE,HOTEL_RANK,HOTEL_OPEN_TIME,HOTEL_CLOSE_TIME,HOTEL_OPTION,CHECK_IN,CHECK_OUT) values ( SEQ_BO_NO.CURRVAL ,'부산 해운대구 달맞이길 30',8,'https://www.lottehotel.com/busan-signiel/ko.html','051-922-1111',0,5,0,23,'와이파이, 조식, 레스토랑, 세탁, 24시간 리셉션, 수하물 보관, 수영장, 피트니스, 스파/사우나, 카페, 비즈니스 시설, 주차, 바/라운지, 주방, 아이돌봄 서비스, 룸서비스',15,11);

Insert into TRIP2REAP.IMG_FILE (FILE_NO,BO_NO,ORIGIN_NAME,CHANGE_NAME,FILE_LEVEL,FILE_PATH,FILE_DELETE_YN) values (SEQ_FILE_NO.NEXTVAL , SEQ_BO_NO.CURRVAL ,'썸네일.jpeg','hotel_thumbnail_202012110353450494.jpeg',1,'/Users/ek/Documents/GitHub/Spring-Project-Trip2Reap/Spring-Final-Trip2Reap/src/main/webapp/resources/buploadFiles/hotel_thumbnail_202012110353450494.jpeg','N');
Insert into TRIP2REAP.IMG_FILE (FILE_NO,BO_NO,ORIGIN_NAME,CHANGE_NAME,FILE_LEVEL,FILE_PATH,FILE_DELETE_YN) values (SEQ_FILE_NO.NEXTVAL , SEQ_BO_NO.CURRVAL ,'디테일1.jpeg','hotel_detail_202012110353450502.jpeg',2,'/Users/ek/Documents/GitHub/Spring-Project-Trip2Reap/Spring-Final-Trip2Reap/src/main/webapp/resources/buploadFiles/hotel_detail_202012110353450502.jpeg','N');
Insert into TRIP2REAP.IMG_FILE (FILE_NO,BO_NO,ORIGIN_NAME,CHANGE_NAME,FILE_LEVEL,FILE_PATH,FILE_DELETE_YN) values (SEQ_FILE_NO.NEXTVAL , SEQ_BO_NO.CURRVAL ,'디테일2.jpeg','hotel_detail_202012110353450509.jpeg',2,'/Users/ek/Documents/GitHub/Spring-Project-Trip2Reap/Spring-Final-Trip2Reap/src/main/webapp/resources/buploadFiles/hotel_detail_202012110353450509.jpeg','N');
Insert into TRIP2REAP.IMG_FILE (FILE_NO,BO_NO,ORIGIN_NAME,CHANGE_NAME,FILE_LEVEL,FILE_PATH,FILE_DELETE_YN) values (SEQ_FILE_NO.NEXTVAL , SEQ_BO_NO.CURRVAL ,'디테일3.jpeg','hotel_detail_202012110353450523.jpeg',2,'/Users/ek/Documents/GitHub/Spring-Project-Trip2Reap/Spring-Final-Trip2Reap/src/main/webapp/resources/buploadFiles/hotel_detail_202012110353450523.jpeg','N');
Insert into TRIP2REAP.IMG_FILE (FILE_NO,BO_NO,ORIGIN_NAME,CHANGE_NAME,FILE_LEVEL,FILE_PATH,FILE_DELETE_YN) values (SEQ_FILE_NO.NEXTVAL , SEQ_BO_NO.CURRVAL ,'디테일4.jpeg','hotel_detail_202012110353450539.jpeg',2,'/Users/ek/Documents/GitHub/Spring-Project-Trip2Reap/Spring-Final-Trip2Reap/src/main/webapp/resources/buploadFiles/hotel_detail_202012110353450539.jpeg','N');
Insert into TRIP2REAP.IMG_FILE (FILE_NO,BO_NO,ORIGIN_NAME,CHANGE_NAME,FILE_LEVEL,FILE_PATH,FILE_DELETE_YN) values (SEQ_FILE_NO.NEXTVAL , SEQ_BO_NO.CURRVAL ,'디테일5.jpeg','hotel_detail_202012110353450549.jpeg',2,'/Users/ek/Documents/GitHub/Spring-Project-Trip2Reap/Spring-Final-Trip2Reap/src/main/webapp/resources/buploadFiles/hotel_detail_202012110353450549.jpeg','N');
Insert into TRIP2REAP.IMG_FILE (FILE_NO,BO_NO,ORIGIN_NAME,CHANGE_NAME,FILE_LEVEL,FILE_PATH,FILE_DELETE_YN) values (SEQ_FILE_NO.NEXTVAL , SEQ_BO_NO.CURRVAL ,'디테일6.jpeg','hotel_detail_202012110353450559.jpeg',2,'/Users/ek/Documents/GitHub/Spring-Project-Trip2Reap/Spring-Final-Trip2Reap/src/main/webapp/resources/buploadFiles/hotel_detail_202012110353450559.jpeg','N');
Insert into TRIP2REAP.IMG_FILE (FILE_NO,BO_NO,ORIGIN_NAME,CHANGE_NAME,FILE_LEVEL,FILE_PATH,FILE_DELETE_YN) values (SEQ_FILE_NO.NEXTVAL , SEQ_BO_NO.CURRVAL ,'디테일7.jpeg','hotel_detail_202012110353450569.jpeg',2,'/Users/ek/Documents/GitHub/Spring-Project-Trip2Reap/Spring-Final-Trip2Reap/src/main/webapp/resources/buploadFiles/hotel_detail_202012110353450569.jpeg','N');
Insert into TRIP2REAP.IMG_FILE (FILE_NO,BO_NO,ORIGIN_NAME,CHANGE_NAME,FILE_LEVEL,FILE_PATH,FILE_DELETE_YN) values (SEQ_FILE_NO.NEXTVAL , SEQ_BO_NO.CURRVAL ,'디테일8.jpeg','hotel_detail_202012110353450575.jpeg',2,'/Users/ek/Documents/GitHub/Spring-Project-Trip2Reap/Spring-Final-Trip2Reap/src/main/webapp/resources/buploadFiles/hotel_detail_202012110353450575.jpeg','N');
Insert into TRIP2REAP.IMG_FILE (FILE_NO,BO_NO,ORIGIN_NAME,CHANGE_NAME,FILE_LEVEL,FILE_PATH,FILE_DELETE_YN) values (SEQ_FILE_NO.NEXTVAL , SEQ_BO_NO.CURRVAL ,'디테일9.jpeg','hotel_detail_202012110353450584.jpeg',2,'/Users/ek/Documents/GitHub/Spring-Project-Trip2Reap/Spring-Final-Trip2Reap/src/main/webapp/resources/buploadFiles/hotel_detail_202012110353450584.jpeg','N');
Insert into TRIP2REAP.IMG_FILE (FILE_NO,BO_NO,ORIGIN_NAME,CHANGE_NAME,FILE_LEVEL,FILE_PATH,FILE_DELETE_YN) values (SEQ_FILE_NO.NEXTVAL , SEQ_BO_NO.CURRVAL ,'디테일10.jpeg','hotel_detail_202012110353450593.jpeg',2,'/Users/ek/Documents/GitHub/Spring-Project-Trip2Reap/Spring-Final-Trip2Reap/src/main/webapp/resources/buploadFiles/hotel_detail_202012110353450593.jpeg','N');
Insert into TRIP2REAP.IMG_FILE (FILE_NO,BO_NO,ORIGIN_NAME,CHANGE_NAME,FILE_LEVEL,FILE_PATH,FILE_DELETE_YN) values (SEQ_FILE_NO.NEXTVAL , SEQ_BO_NO.CURRVAL ,'디테일11.jpeg','hotel_detail_202012110353450599.jpeg',2,'/Users/ek/Documents/GitHub/Spring-Project-Trip2Reap/Spring-Final-Trip2Reap/src/main/webapp/resources/buploadFiles/hotel_detail_202012110353450599.jpeg','N');
Insert into TRIP2REAP.IMG_FILE (FILE_NO,BO_NO,ORIGIN_NAME,CHANGE_NAME,FILE_LEVEL,FILE_PATH,FILE_DELETE_YN) values (SEQ_FILE_NO.NEXTVAL , SEQ_BO_NO.CURRVAL ,'디테일12.jpeg','hotel_detail_202012110353450609.jpeg',2,'/Users/ek/Documents/GitHub/Spring-Project-Trip2Reap/Spring-Final-Trip2Reap/src/main/webapp/resources/buploadFiles/hotel_detail_202012110353450609.jpeg','N');
Insert into TRIP2REAP.IMG_FILE (FILE_NO,BO_NO,ORIGIN_NAME,CHANGE_NAME,FILE_LEVEL,FILE_PATH,FILE_DELETE_YN) values (SEQ_FILE_NO.NEXTVAL , SEQ_BO_NO.CURRVAL ,'디테일13.jpeg','hotel_detail_202012110353450618.jpeg',2,'/Users/ek/Documents/GitHub/Spring-Project-Trip2Reap/Spring-Final-Trip2Reap/src/main/webapp/resources/buploadFiles/hotel_detail_202012110353450618.jpeg','N');
Insert into TRIP2REAP.IMG_FILE (FILE_NO,BO_NO,ORIGIN_NAME,CHANGE_NAME,FILE_LEVEL,FILE_PATH,FILE_DELETE_YN) values (SEQ_FILE_NO.NEXTVAL , SEQ_BO_NO.CURRVAL ,'디테일14.jpeg','hotel_detail_202012110353450627.jpeg',2,'/Users/ek/Documents/GitHub/Spring-Project-Trip2Reap/Spring-Final-Trip2Reap/src/main/webapp/resources/buploadFiles/hotel_detail_202012110353450627.jpeg','N');
Insert into TRIP2REAP.IMG_FILE (FILE_NO,BO_NO,ORIGIN_NAME,CHANGE_NAME,FILE_LEVEL,FILE_PATH,FILE_DELETE_YN) values (SEQ_FILE_NO.NEXTVAL , SEQ_BO_NO.CURRVAL ,'디테일15.jpeg','hotel_detail_202012110353450635.jpeg',2,'/Users/ek/Documents/GitHub/Spring-Project-Trip2Reap/Spring-Final-Trip2Reap/src/main/webapp/resources/buploadFiles/hotel_detail_202012110353450635.jpeg','N');
Insert into TRIP2REAP.IMG_FILE (FILE_NO,BO_NO,ORIGIN_NAME,CHANGE_NAME,FILE_LEVEL,FILE_PATH,FILE_DELETE_YN) values (SEQ_FILE_NO.NEXTVAL , SEQ_BO_NO.CURRVAL ,'썸네일.jpeg','hotel_detail_202012110353450646.jpeg',2,'/Users/ek/Documents/GitHub/Spring-Project-Trip2Reap/Spring-Final-Trip2Reap/src/main/webapp/resources/buploadFiles/hotel_detail_202012110353450646.jpeg','N');

Insert into TRIP2REAP.ROOM (ROOM_NO,BO_NO,ROOM_TYPE,ROOM_NAME,PRICE_PER_DAY) values ( SEQ_ROOM_NO.NEXTVAL , SEQ_BO_NO.CURRVAL ,'더블룸','그랜드 디럭스 더블룸-문탠로드',261000);
Insert into TRIP2REAP.ROOM (ROOM_NO,BO_NO,ROOM_TYPE,ROOM_NAME,PRICE_PER_DAY) values ( SEQ_ROOM_NO.NEXTVAL , SEQ_BO_NO.CURRVAL ,'디럭스룸','그랜드 디럭스 더블룸-문탠로드',261000);
Insert into TRIP2REAP.ROOM (ROOM_NO,BO_NO,ROOM_TYPE,ROOM_NAME,PRICE_PER_DAY) values ( SEQ_ROOM_NO.NEXTVAL , SEQ_BO_NO.CURRVAL ,'트윈룸','프리미어 트윈룸-라운지이용+수영장이용',297000);
Insert into TRIP2REAP.ROOM (ROOM_NO,BO_NO,ROOM_TYPE,ROOM_NAME,PRICE_PER_DAY) values ( SEQ_ROOM_NO.NEXTVAL , SEQ_BO_NO.CURRVAL ,'프리미어룸','프리미어 트윈룸-라운지이용+수영장이용',297000);
Insert into TRIP2REAP.ROOM (ROOM_NO,BO_NO,ROOM_TYPE,ROOM_NAME,PRICE_PER_DAY) values ( SEQ_ROOM_NO.NEXTVAL , SEQ_BO_NO.CURRVAL ,'트윈룸','프리미어 트윈룸-오션뷰',294300);
Insert into TRIP2REAP.ROOM (ROOM_NO,BO_NO,ROOM_TYPE,ROOM_NAME,PRICE_PER_DAY) values ( SEQ_ROOM_NO.NEXTVAL , SEQ_BO_NO.CURRVAL ,'프리미어룸','프리미어 트윈룸-오션뷰',294300);
Insert into TRIP2REAP.ROOM (ROOM_NO,BO_NO,ROOM_TYPE,ROOM_NAME,PRICE_PER_DAY) values ( SEQ_ROOM_NO.NEXTVAL , SEQ_BO_NO.CURRVAL ,'더블룸','프리미어 더블룸-오션뷰+라운지이용+수영장이용',324000);
Insert into TRIP2REAP.ROOM (ROOM_NO,BO_NO,ROOM_TYPE,ROOM_NAME,PRICE_PER_DAY) values ( SEQ_ROOM_NO.NEXTVAL , SEQ_BO_NO.CURRVAL ,'프리미어룸','프리미어 더블룸-오션뷰+라운지이용+수영장이용',324000);
Insert into TRIP2REAP.ROOM (ROOM_NO,BO_NO,ROOM_TYPE,ROOM_NAME,PRICE_PER_DAY) values ( SEQ_ROOM_NO.NEXTVAL , SEQ_BO_NO.CURRVAL ,'트윈룸','프리미어 패밀리 트윈룸-오션뷰',324000);
Insert into TRIP2REAP.ROOM (ROOM_NO,BO_NO,ROOM_TYPE,ROOM_NAME,PRICE_PER_DAY) values ( SEQ_ROOM_NO.NEXTVAL , SEQ_BO_NO.CURRVAL ,'패밀리룸','프리미어 패밀리 트윈룸',324000);
Insert into TRIP2REAP.ROOM (ROOM_NO,BO_NO,ROOM_TYPE,ROOM_NAME,PRICE_PER_DAY) values ( SEQ_ROOM_NO.NEXTVAL , SEQ_BO_NO.CURRVAL ,'프리미어룸','프리미어 패밀리 트윈룸',324000);


--51
Insert into TRIP2REAP.BOARD (BO_NO,CA_CODE,BO_TITLE,BO_CONTENT,MEMBER_ID,BO_COUNT,BO_TAG,BO_DELETE_YN,REGDATE) values (SEQ_BO_NO.NEXTVAL ,5,'아난티 힐튼','아난티 힐튼- <5성급:한국관광공사 인증> - 부산의 아름다운 해변을 품은 기장에 위치한 아난티 힐튼에서는 “도심 속 완벽한 휴식처”라는 차별화된 컨셉과 규모, 서비스를 자랑합니다. 아난티 힐튼은 부산 KTX역에서 차로 35분, 김해국제공항에서 차로 1시간 거리에 있습니다. 뿐만 아니라, 해동용궁사까지 차로 5분, 해운대까지 차로 20분 거리에 있으며 센텀시티와 신세계 프리미엄 아울렛까지 차로 20분이면 가실 수 있어 관광과 쇼핑을 즐기기에도 편리합니다. 호텔 내에는 해안 경관이 파노라믹 뷰로 펼쳐지는 야외 인피니티 풀, 성인 전용 인피니티풀, 키즈 풀, 자쿠지 등 해외 리조트 못지않은 럭셔리 수영장과 피트니스와 사우나, 테라피 룸 등의 부대시설들이 함께 마련되어 있어 사계절 내내 완벽한 휴식을 선사합니다. 또한, 비즈니스 고객님들을 위한 7개의 미팅룸도 마련되어 있습니다. 탁 트인 오션뷰를 마음껏 감상할 수 있는 약 21평의 넓고 여유로운 객실에는 프라이빗 발코니가 마련되어, 휴식을 즐기기에 더없이 좋은 시설을 자랑합니다. 객실 내에는 50인치 LED HDTV, 에스프레소 머신, 힐튼 세레니티 베드 등이 있으며 욕실에는 고급 어메니티, 헤어 드라이어 등이 있습니다. 올데이 다이닝 레스토랑인 다모임에서는 루이브 무대를 감상하며 오프키친에서 조리된 양식, 한식, 중식 메뉴를 즐기실 수 있습니다. 호텔 최상층에 위치한 맥퀸즈 라운지에서는 바다 절경을 감상하며 식사를 즐기실 수 있습니다. 그 밖에도 맥퀸즈 바와 스위트 코너 베이커리도 운영하고 있습니다.','admin',0,'아난티코브, 부산아난티, 펜트하우스','N',to_date('20/12/10','RR/MM/DD'));
Insert into TRIP2REAP.HOTEL (BO_NO,HOTEL_ADDRESS,HOTEL_LOCAL_CODE,HOTEL_SITE,HOTEL_TEL,HOTEL_REVIEW_SCORE,HOTEL_RANK,HOTEL_OPEN_TIME,HOTEL_CLOSE_TIME,HOTEL_OPTION,CHECK_IN,CHECK_OUT) values ( SEQ_BO_NO.CURRVAL ,'부산 기장군 기장읍 기장해안로 268-32',8,'https://hiltonbusan.co.kr/kor/?ref=aHR0cHM6Ly93d3cuYW5hbnRpLmtyLw%3D%3D','051-604-7000',0,5,9,21,'와이파이, 조식, 레스토랑, 세탁, 24시간 리셉션, 수하물 보관, 수영장, 스파/사우나, 카페, 비즈니스 시설, 주차, 장애인 편의시설, 주방, 룸서비스',15,11);

Insert into TRIP2REAP.IMG_FILE (FILE_NO,BO_NO,ORIGIN_NAME,CHANGE_NAME,FILE_LEVEL,FILE_PATH,FILE_DELETE_YN) values (SEQ_FILE_NO.NEXTVAL , SEQ_BO_NO.CURRVAL ,'썸네일.jpeg','hotel_thumbnail_202012110408560396.jpeg',1,'/Users/ek/Documents/GitHub/Spring-Project-Trip2Reap/Spring-Final-Trip2Reap/src/main/webapp/resources/buploadFiles/hotel_thumbnail_202012110408560396.jpeg','N');
Insert into TRIP2REAP.IMG_FILE (FILE_NO,BO_NO,ORIGIN_NAME,CHANGE_NAME,FILE_LEVEL,FILE_PATH,FILE_DELETE_YN) values (SEQ_FILE_NO.NEXTVAL , SEQ_BO_NO.CURRVAL ,'디테일5.jpeg','hotel_detail_202012110408560413.jpeg',2,'/Users/ek/Documents/GitHub/Spring-Project-Trip2Reap/Spring-Final-Trip2Reap/src/main/webapp/resources/buploadFiles/hotel_detail_202012110408560413.jpeg','N');
Insert into TRIP2REAP.IMG_FILE (FILE_NO,BO_NO,ORIGIN_NAME,CHANGE_NAME,FILE_LEVEL,FILE_PATH,FILE_DELETE_YN) values (SEQ_FILE_NO.NEXTVAL , SEQ_BO_NO.CURRVAL ,'디테일6.jpeg','hotel_detail_202012110408560432.jpeg',2,'/Users/ek/Documents/GitHub/Spring-Project-Trip2Reap/Spring-Final-Trip2Reap/src/main/webapp/resources/buploadFiles/hotel_detail_202012110408560432.jpeg','N');
Insert into TRIP2REAP.IMG_FILE (FILE_NO,BO_NO,ORIGIN_NAME,CHANGE_NAME,FILE_LEVEL,FILE_PATH,FILE_DELETE_YN) values (SEQ_FILE_NO.NEXTVAL , SEQ_BO_NO.CURRVAL ,'디테일7.jpeg','hotel_detail_202012110408560451.jpeg',2,'/Users/ek/Documents/GitHub/Spring-Project-Trip2Reap/Spring-Final-Trip2Reap/src/main/webapp/resources/buploadFiles/hotel_detail_202012110408560451.jpeg','N');
Insert into TRIP2REAP.IMG_FILE (FILE_NO,BO_NO,ORIGIN_NAME,CHANGE_NAME,FILE_LEVEL,FILE_PATH,FILE_DELETE_YN) values (SEQ_FILE_NO.NEXTVAL , SEQ_BO_NO.CURRVAL ,'디테일8.jpeg','hotel_detail_202012110408560465.jpeg',2,'/Users/ek/Documents/GitHub/Spring-Project-Trip2Reap/Spring-Final-Trip2Reap/src/main/webapp/resources/buploadFiles/hotel_detail_202012110408560465.jpeg','N');
Insert into TRIP2REAP.IMG_FILE (FILE_NO,BO_NO,ORIGIN_NAME,CHANGE_NAME,FILE_LEVEL,FILE_PATH,FILE_DELETE_YN) values (SEQ_FILE_NO.NEXTVAL , SEQ_BO_NO.CURRVAL ,'디테일9.jpeg','hotel_detail_202012110408560474.jpeg',2,'/Users/ek/Documents/GitHub/Spring-Project-Trip2Reap/Spring-Final-Trip2Reap/src/main/webapp/resources/buploadFiles/hotel_detail_202012110408560474.jpeg','N');
Insert into TRIP2REAP.IMG_FILE (FILE_NO,BO_NO,ORIGIN_NAME,CHANGE_NAME,FILE_LEVEL,FILE_PATH,FILE_DELETE_YN) values (SEQ_FILE_NO.NEXTVAL , SEQ_BO_NO.CURRVAL ,'디테일10.jpeg','hotel_detail_202012110408560489.jpeg',2,'/Users/ek/Documents/GitHub/Spring-Project-Trip2Reap/Spring-Final-Trip2Reap/src/main/webapp/resources/buploadFiles/hotel_detail_202012110408560489.jpeg','N');
Insert into TRIP2REAP.IMG_FILE (FILE_NO,BO_NO,ORIGIN_NAME,CHANGE_NAME,FILE_LEVEL,FILE_PATH,FILE_DELETE_YN) values (SEQ_FILE_NO.NEXTVAL , SEQ_BO_NO.CURRVAL ,'디테일11.jpeg','hotel_detail_202012110408560516.jpeg',2,'/Users/ek/Documents/GitHub/Spring-Project-Trip2Reap/Spring-Final-Trip2Reap/src/main/webapp/resources/buploadFiles/hotel_detail_202012110408560516.jpeg','N');
Insert into TRIP2REAP.IMG_FILE (FILE_NO,BO_NO,ORIGIN_NAME,CHANGE_NAME,FILE_LEVEL,FILE_PATH,FILE_DELETE_YN) values (SEQ_FILE_NO.NEXTVAL , SEQ_BO_NO.CURRVAL ,'디테일12.jpeg','hotel_detail_202012110408560525.jpeg',2,'/Users/ek/Documents/GitHub/Spring-Project-Trip2Reap/Spring-Final-Trip2Reap/src/main/webapp/resources/buploadFiles/hotel_detail_202012110408560525.jpeg','N');
Insert into TRIP2REAP.IMG_FILE (FILE_NO,BO_NO,ORIGIN_NAME,CHANGE_NAME,FILE_LEVEL,FILE_PATH,FILE_DELETE_YN) values (SEQ_FILE_NO.NEXTVAL , SEQ_BO_NO.CURRVAL ,'디테일13.jpeg','hotel_detail_202012110408560534.jpeg',2,'/Users/ek/Documents/GitHub/Spring-Project-Trip2Reap/Spring-Final-Trip2Reap/src/main/webapp/resources/buploadFiles/hotel_detail_202012110408560534.jpeg','N');
Insert into TRIP2REAP.IMG_FILE (FILE_NO,BO_NO,ORIGIN_NAME,CHANGE_NAME,FILE_LEVEL,FILE_PATH,FILE_DELETE_YN) values (SEQ_FILE_NO.NEXTVAL , SEQ_BO_NO.CURRVAL ,'썸네일.jpeg','hotel_detail_202012110408560545.jpeg',2,'/Users/ek/Documents/GitHub/Spring-Project-Trip2Reap/Spring-Final-Trip2Reap/src/main/webapp/resources/buploadFiles/hotel_detail_202012110408560545.jpeg','N');
Insert into TRIP2REAP.IMG_FILE (FILE_NO,BO_NO,ORIGIN_NAME,CHANGE_NAME,FILE_LEVEL,FILE_PATH,FILE_DELETE_YN) values (SEQ_FILE_NO.NEXTVAL , SEQ_BO_NO.CURRVAL ,'디테일1.jpeg','hotel_detail_202012110408560557.jpeg',2,'/Users/ek/Documents/GitHub/Spring-Project-Trip2Reap/Spring-Final-Trip2Reap/src/main/webapp/resources/buploadFiles/hotel_detail_202012110408560557.jpeg','N');
Insert into TRIP2REAP.IMG_FILE (FILE_NO,BO_NO,ORIGIN_NAME,CHANGE_NAME,FILE_LEVEL,FILE_PATH,FILE_DELETE_YN) values (SEQ_FILE_NO.NEXTVAL , SEQ_BO_NO.CURRVAL ,'디테일2.jpeg','hotel_detail_202012110408560569.jpeg',2,'/Users/ek/Documents/GitHub/Spring-Project-Trip2Reap/Spring-Final-Trip2Reap/src/main/webapp/resources/buploadFiles/hotel_detail_202012110408560569.jpeg','N');
Insert into TRIP2REAP.IMG_FILE (FILE_NO,BO_NO,ORIGIN_NAME,CHANGE_NAME,FILE_LEVEL,FILE_PATH,FILE_DELETE_YN) values (SEQ_FILE_NO.NEXTVAL , SEQ_BO_NO.CURRVAL ,'디테일3.jpeg','hotel_detail_202012110408560582.jpeg',2,'/Users/ek/Documents/GitHub/Spring-Project-Trip2Reap/Spring-Final-Trip2Reap/src/main/webapp/resources/buploadFiles/hotel_detail_202012110408560582.jpeg','N');
Insert into TRIP2REAP.IMG_FILE (FILE_NO,BO_NO,ORIGIN_NAME,CHANGE_NAME,FILE_LEVEL,FILE_PATH,FILE_DELETE_YN) values (SEQ_FILE_NO.NEXTVAL , SEQ_BO_NO.CURRVAL ,'디테일4.jpeg','hotel_detail_202012110408560591.jpeg',2,'/Users/ek/Documents/GitHub/Spring-Project-Trip2Reap/Spring-Final-Trip2Reap/src/main/webapp/resources/buploadFiles/hotel_detail_202012110408560591.jpeg','N');

Insert into TRIP2REAP.ROOM (ROOM_NO,BO_NO,ROOM_TYPE,ROOM_NAME,PRICE_PER_DAY) values ( SEQ_ROOM_NO.NEXTVAL , SEQ_BO_NO.CURRVAL ,'프리미어룸','프리미어 킹룸',243000);
Insert into TRIP2REAP.ROOM (ROOM_NO,BO_NO,ROOM_TYPE,ROOM_NAME,PRICE_PER_DAY) values ( SEQ_ROOM_NO.NEXTVAL , SEQ_BO_NO.CURRVAL ,'프리미어룸','프리미어 트윈룸',243000);
Insert into TRIP2REAP.ROOM (ROOM_NO,BO_NO,ROOM_TYPE,ROOM_NAME,PRICE_PER_DAY) values ( SEQ_ROOM_NO.NEXTVAL , SEQ_BO_NO.CURRVAL ,'트윈룸','프리미어 트윈룸',243000);
Insert into TRIP2REAP.ROOM (ROOM_NO,BO_NO,ROOM_TYPE,ROOM_NAME,PRICE_PER_DAY) values ( SEQ_ROOM_NO.NEXTVAL , SEQ_BO_NO.CURRVAL ,'더블룸','마운틴뷰 프리미엄 더블룸',267000);
Insert into TRIP2REAP.ROOM (ROOM_NO,BO_NO,ROOM_TYPE,ROOM_NAME,PRICE_PER_DAY) values ( SEQ_ROOM_NO.NEXTVAL , SEQ_BO_NO.CURRVAL ,'디럭스룸','디럭스킹룸 바다전망',306000);


--52
Insert into TRIP2REAP.BOARD (BO_NO,CA_CODE,BO_TITLE,BO_CONTENT,MEMBER_ID,BO_COUNT,BO_TAG,BO_DELETE_YN,REGDATE) values (SEQ_BO_NO.NEXTVAL ,5,'파크 하얏트 부산','파크 하얏트 부산 - <5성급:한국관광공사 인증> - 돛 모양을 형상화한 외관이 인상적인 파크 하얏트 부산은 부산 요트 경기장 바로 옆에 자리하고 있습니다. 부산 지하철 동백역 3번 출구에서 약 1km 거리에 있습니다. 해운대 해수욕장과 SEA LIFE 부산아쿠아리움운 지하철로 한 정거장 거리에 있습니다. 또한, 차로 30분 거리에 해동 용궁사가 있습니다. 내부에는 실내 골프 시설, 피트니스 수업 등이 갖춰진 290평방 미터 규모의 피트니스 센터가 24시간 운영되고 있습니다. 비즈니스 고객을 위한 다양한 규모의 미팅룸도 이용하실 수 있습니다. 또한, 루미 스파에서 맞춤형 관리를 받으실 수 있습니다. 총 269개의 객실을 보유하고 있으며 그중 69개는 스위트룸으로 구성되어 있습니다. 건물 전체가 유리로 되어 있어 통유리창을 통해 해운대 바다와 광안 대교 전망을 감상하실 수 있습니다. 베이지톤의 목재로 꾸며진 객실 내에는 미니바, TV, 금고 등이 있으며 욕실에는 레인 샤워 시설과 욕조가 있습니다. 32층에 자리한 다이닝룸에서는 광안대교 야경을 감상하며 스테이크 또는 스시를 즐기실 수 있으며 33층에 자리한 리빙룸에서는 멋진 야경과 함께 프렌치 메뉴를 선보이고 있습니다. 뿐만 아니라 통유리창을 통해 반짝이는 야경을 감상하실 수 있는 30층 라운지도 있습니다.','admin',0,'파크하얏트, 하얏트부산','N',to_date('20/12/10','RR/MM/DD'));
Insert into TRIP2REAP.HOTEL (BO_NO,HOTEL_ADDRESS,HOTEL_LOCAL_CODE,HOTEL_SITE,HOTEL_TEL,HOTEL_REVIEW_SCORE,HOTEL_RANK,HOTEL_OPEN_TIME,HOTEL_CLOSE_TIME,HOTEL_OPTION,CHECK_IN,CHECK_OUT) values ( SEQ_BO_NO.CURRVAL ,'부산 해운대구 마린시티1로 51',8,'https://www.hyatt.com/ko-KR/hotel/south-korea/park-hyatt-busan/busph','051-990-1234',0,5,0,23,'와이파이, 조식, 레스토랑, 세탁, 24시간 리셉션, 수하물 보관, 수영장, 피트니스, 스파/사우나, 비즈니스 시설, 주차, 장애인 편의시설, 주방, 룸서비스',15,11);

Insert into TRIP2REAP.IMG_FILE (FILE_NO,BO_NO,ORIGIN_NAME,CHANGE_NAME,FILE_LEVEL,FILE_PATH,FILE_DELETE_YN) values (SEQ_FILE_NO.NEXTVAL , SEQ_BO_NO.CURRVAL ,'썸네일.jpeg','hotel_thumbnail_202012110420170129.jpeg',1,'/Users/ek/Documents/GitHub/Spring-Project-Trip2Reap/Spring-Final-Trip2Reap/src/main/webapp/resources/buploadFiles/hotel_thumbnail_202012110420170129.jpeg','N');
Insert into TRIP2REAP.IMG_FILE (FILE_NO,BO_NO,ORIGIN_NAME,CHANGE_NAME,FILE_LEVEL,FILE_PATH,FILE_DELETE_YN) values (SEQ_FILE_NO.NEXTVAL , SEQ_BO_NO.CURRVAL ,'디테일9.jpeg','hotel_detail_202012110420170138.jpeg',2,'/Users/ek/Documents/GitHub/Spring-Project-Trip2Reap/Spring-Final-Trip2Reap/src/main/webapp/resources/buploadFiles/hotel_detail_202012110420170138.jpeg','N');
Insert into TRIP2REAP.IMG_FILE (FILE_NO,BO_NO,ORIGIN_NAME,CHANGE_NAME,FILE_LEVEL,FILE_PATH,FILE_DELETE_YN) values (SEQ_FILE_NO.NEXTVAL , SEQ_BO_NO.CURRVAL ,'디테일10.jpeg','hotel_detail_202012110420170149.jpeg',2,'/Users/ek/Documents/GitHub/Spring-Project-Trip2Reap/Spring-Final-Trip2Reap/src/main/webapp/resources/buploadFiles/hotel_detail_202012110420170149.jpeg','N');
Insert into TRIP2REAP.IMG_FILE (FILE_NO,BO_NO,ORIGIN_NAME,CHANGE_NAME,FILE_LEVEL,FILE_PATH,FILE_DELETE_YN) values (SEQ_FILE_NO.NEXTVAL , SEQ_BO_NO.CURRVAL ,'디테일11.jpeg','hotel_detail_202012110420170157.jpeg',2,'/Users/ek/Documents/GitHub/Spring-Project-Trip2Reap/Spring-Final-Trip2Reap/src/main/webapp/resources/buploadFiles/hotel_detail_202012110420170157.jpeg','N');
Insert into TRIP2REAP.IMG_FILE (FILE_NO,BO_NO,ORIGIN_NAME,CHANGE_NAME,FILE_LEVEL,FILE_PATH,FILE_DELETE_YN) values (SEQ_FILE_NO.NEXTVAL , SEQ_BO_NO.CURRVAL ,'디테일12.jpeg','hotel_detail_202012110420170169.jpeg',2,'/Users/ek/Documents/GitHub/Spring-Project-Trip2Reap/Spring-Final-Trip2Reap/src/main/webapp/resources/buploadFiles/hotel_detail_202012110420170169.jpeg','N');
Insert into TRIP2REAP.IMG_FILE (FILE_NO,BO_NO,ORIGIN_NAME,CHANGE_NAME,FILE_LEVEL,FILE_PATH,FILE_DELETE_YN) values (SEQ_FILE_NO.NEXTVAL , SEQ_BO_NO.CURRVAL ,'디테일13.jpeg','hotel_detail_202012110420170177.jpeg',2,'/Users/ek/Documents/GitHub/Spring-Project-Trip2Reap/Spring-Final-Trip2Reap/src/main/webapp/resources/buploadFiles/hotel_detail_202012110420170177.jpeg','N');
Insert into TRIP2REAP.IMG_FILE (FILE_NO,BO_NO,ORIGIN_NAME,CHANGE_NAME,FILE_LEVEL,FILE_PATH,FILE_DELETE_YN) values (SEQ_FILE_NO.NEXTVAL , SEQ_BO_NO.CURRVAL ,'디테일14.jpeg','hotel_detail_202012110420170186.jpeg',2,'/Users/ek/Documents/GitHub/Spring-Project-Trip2Reap/Spring-Final-Trip2Reap/src/main/webapp/resources/buploadFiles/hotel_detail_202012110420170186.jpeg','N');
Insert into TRIP2REAP.IMG_FILE (FILE_NO,BO_NO,ORIGIN_NAME,CHANGE_NAME,FILE_LEVEL,FILE_PATH,FILE_DELETE_YN) values (SEQ_FILE_NO.NEXTVAL , SEQ_BO_NO.CURRVAL ,'디테일15.jpeg','hotel_detail_202012110420170193.jpeg',2,'/Users/ek/Documents/GitHub/Spring-Project-Trip2Reap/Spring-Final-Trip2Reap/src/main/webapp/resources/buploadFiles/hotel_detail_202012110420170193.jpeg','N');
Insert into TRIP2REAP.IMG_FILE (FILE_NO,BO_NO,ORIGIN_NAME,CHANGE_NAME,FILE_LEVEL,FILE_PATH,FILE_DELETE_YN) values (SEQ_FILE_NO.NEXTVAL , SEQ_BO_NO.CURRVAL ,'디테일16.jpeg','hotel_detail_202012110420170203.jpeg',2,'/Users/ek/Documents/GitHub/Spring-Project-Trip2Reap/Spring-Final-Trip2Reap/src/main/webapp/resources/buploadFiles/hotel_detail_202012110420170203.jpeg','N');
Insert into TRIP2REAP.IMG_FILE (FILE_NO,BO_NO,ORIGIN_NAME,CHANGE_NAME,FILE_LEVEL,FILE_PATH,FILE_DELETE_YN) values (SEQ_FILE_NO.NEXTVAL , SEQ_BO_NO.CURRVAL ,'썸네일.jpeg','hotel_detail_202012110420170213.jpeg',2,'/Users/ek/Documents/GitHub/Spring-Project-Trip2Reap/Spring-Final-Trip2Reap/src/main/webapp/resources/buploadFiles/hotel_detail_202012110420170213.jpeg','N');
Insert into TRIP2REAP.IMG_FILE (FILE_NO,BO_NO,ORIGIN_NAME,CHANGE_NAME,FILE_LEVEL,FILE_PATH,FILE_DELETE_YN) values (SEQ_FILE_NO.NEXTVAL , SEQ_BO_NO.CURRVAL ,'디테일1.jpeg','hotel_detail_202012110420170221.jpeg',2,'/Users/ek/Documents/GitHub/Spring-Project-Trip2Reap/Spring-Final-Trip2Reap/src/main/webapp/resources/buploadFiles/hotel_detail_202012110420170221.jpeg','N');
Insert into TRIP2REAP.IMG_FILE (FILE_NO,BO_NO,ORIGIN_NAME,CHANGE_NAME,FILE_LEVEL,FILE_PATH,FILE_DELETE_YN) values (SEQ_FILE_NO.NEXTVAL , SEQ_BO_NO.CURRVAL ,'디테일2.jpeg','hotel_detail_202012110420170228.jpeg',2,'/Users/ek/Documents/GitHub/Spring-Project-Trip2Reap/Spring-Final-Trip2Reap/src/main/webapp/resources/buploadFiles/hotel_detail_202012110420170228.jpeg','N');
Insert into TRIP2REAP.IMG_FILE (FILE_NO,BO_NO,ORIGIN_NAME,CHANGE_NAME,FILE_LEVEL,FILE_PATH,FILE_DELETE_YN) values (SEQ_FILE_NO.NEXTVAL , SEQ_BO_NO.CURRVAL ,'디테일3.jpeg','hotel_detail_202012110420170236.jpeg',2,'/Users/ek/Documents/GitHub/Spring-Project-Trip2Reap/Spring-Final-Trip2Reap/src/main/webapp/resources/buploadFiles/hotel_detail_202012110420170236.jpeg','N');
Insert into TRIP2REAP.IMG_FILE (FILE_NO,BO_NO,ORIGIN_NAME,CHANGE_NAME,FILE_LEVEL,FILE_PATH,FILE_DELETE_YN) values (SEQ_FILE_NO.NEXTVAL , SEQ_BO_NO.CURRVAL ,'디테일4.jpeg','hotel_detail_202012110420170243.jpeg',2,'/Users/ek/Documents/GitHub/Spring-Project-Trip2Reap/Spring-Final-Trip2Reap/src/main/webapp/resources/buploadFiles/hotel_detail_202012110420170243.jpeg','N');
Insert into TRIP2REAP.IMG_FILE (FILE_NO,BO_NO,ORIGIN_NAME,CHANGE_NAME,FILE_LEVEL,FILE_PATH,FILE_DELETE_YN) values (SEQ_FILE_NO.NEXTVAL , SEQ_BO_NO.CURRVAL ,'디테일5.jpeg','hotel_detail_202012110420170252.jpeg',2,'/Users/ek/Documents/GitHub/Spring-Project-Trip2Reap/Spring-Final-Trip2Reap/src/main/webapp/resources/buploadFiles/hotel_detail_202012110420170252.jpeg','N');
Insert into TRIP2REAP.IMG_FILE (FILE_NO,BO_NO,ORIGIN_NAME,CHANGE_NAME,FILE_LEVEL,FILE_PATH,FILE_DELETE_YN) values (SEQ_FILE_NO.NEXTVAL , SEQ_BO_NO.CURRVAL ,'디테일6.jpeg','hotel_detail_202012110420170260.jpeg',2,'/Users/ek/Documents/GitHub/Spring-Project-Trip2Reap/Spring-Final-Trip2Reap/src/main/webapp/resources/buploadFiles/hotel_detail_202012110420170260.jpeg','N');
Insert into TRIP2REAP.IMG_FILE (FILE_NO,BO_NO,ORIGIN_NAME,CHANGE_NAME,FILE_LEVEL,FILE_PATH,FILE_DELETE_YN) values (SEQ_FILE_NO.NEXTVAL , SEQ_BO_NO.CURRVAL ,'디테일7.jpeg','hotel_detail_202012110420170269.jpeg',2,'/Users/ek/Documents/GitHub/Spring-Project-Trip2Reap/Spring-Final-Trip2Reap/src/main/webapp/resources/buploadFiles/hotel_detail_202012110420170269.jpeg','N');
Insert into TRIP2REAP.IMG_FILE (FILE_NO,BO_NO,ORIGIN_NAME,CHANGE_NAME,FILE_LEVEL,FILE_PATH,FILE_DELETE_YN) values (SEQ_FILE_NO.NEXTVAL , SEQ_BO_NO.CURRVAL ,'디테일8.jpeg','hotel_detail_202012110420170278.jpeg',2,'/Users/ek/Documents/GitHub/Spring-Project-Trip2Reap/Spring-Final-Trip2Reap/src/main/webapp/resources/buploadFiles/hotel_detail_202012110420170278.jpeg','N');

Insert into TRIP2REAP.ROOM (ROOM_NO,BO_NO,ROOM_TYPE,ROOM_NAME,PRICE_PER_DAY) values ( SEQ_ROOM_NO.NEXTVAL , SEQ_BO_NO.CURRVAL ,'싱글룸','싱글룸 킹사이즈 침대1개',270000);
Insert into TRIP2REAP.ROOM (ROOM_NO,BO_NO,ROOM_TYPE,ROOM_NAME,PRICE_PER_DAY) values ( SEQ_ROOM_NO.NEXTVAL , SEQ_BO_NO.CURRVAL ,'디럭스룸','디럭스룸 - 싱글배드2개+수영장이용',300000);
Insert into TRIP2REAP.ROOM (ROOM_NO,BO_NO,ROOM_TYPE,ROOM_NAME,PRICE_PER_DAY) values ( SEQ_ROOM_NO.NEXTVAL , SEQ_BO_NO.CURRVAL ,'스탠다드룸','스탠다드 킹배드+뷔페조식+수영장',340000);
Insert into TRIP2REAP.ROOM (ROOM_NO,BO_NO,ROOM_TYPE,ROOM_NAME,PRICE_PER_DAY) values ( SEQ_ROOM_NO.NEXTVAL , SEQ_BO_NO.CURRVAL ,'싱글룸','오션전망 싱글룸+킹베드',360000);
Insert into TRIP2REAP.ROOM (ROOM_NO,BO_NO,ROOM_TYPE,ROOM_NAME,PRICE_PER_DAY) values ( SEQ_ROOM_NO.NEXTVAL , SEQ_BO_NO.CURRVAL ,'디럭스룸','디럭스룸+킹베드1개',370000);
Insert into TRIP2REAP.ROOM (ROOM_NO,BO_NO,ROOM_TYPE,ROOM_NAME,PRICE_PER_DAY) values ( SEQ_ROOM_NO.NEXTVAL , SEQ_BO_NO.CURRVAL ,'트윈룸','하이플로어 오션뷰 트윈룸',380000);
Insert into TRIP2REAP.ROOM (ROOM_NO,BO_NO,ROOM_TYPE,ROOM_NAME,PRICE_PER_DAY) values ( SEQ_ROOM_NO.NEXTVAL , SEQ_BO_NO.CURRVAL ,'스위트룸','파크 패밀리 스위트+수영장이용',390000);
Insert into TRIP2REAP.ROOM (ROOM_NO,BO_NO,ROOM_TYPE,ROOM_NAME,PRICE_PER_DAY) values ( SEQ_ROOM_NO.NEXTVAL , SEQ_BO_NO.CURRVAL ,'패밀리룸','파크 패밀리 스위트+수영장이용',390000);
Insert into TRIP2REAP.ROOM (ROOM_NO,BO_NO,ROOM_TYPE,ROOM_NAME,PRICE_PER_DAY) values ( SEQ_ROOM_NO.NEXTVAL , SEQ_BO_NO.CURRVAL ,'디럭스룸','하이플로어 오션 디럭스룸 킹침대2개',417300);



--53
Insert into TRIP2REAP.BOARD (BO_NO,CA_CODE,BO_TITLE,BO_CONTENT,MEMBER_ID,BO_COUNT,BO_TAG,BO_DELETE_YN,REGDATE) values (SEQ_BO_NO.NEXTVAL ,5,'해운대 센텀 호텔','해운대센텀호텔은 부산전시컨벤션센터(BEXCO)와 가장 가까이 위치(도보 1분)하고 있으며, 해운대해수욕장과 광안리해수욕장까지는 각 3.5km 떨어져 있습니다. 호텔 정문 바로 앞에서 공항리무진버스 승ㆍ하차가 가능하며, 도시철도 2호선 센텀시티역에서 도보 1분 거리로 교통이 매우 편리합니다. 호텔 주변에는 세계 최대규모를 자랑하는 신세계백화점을 비롯하여 신세계면세점, 신세계몰, 롯데백화점, 대형마트 등 다양한 쇼핑 시설이 3분 거리에 있으며 부산시립미술관, 영화의전당, 멀티플렉스 영화관이 있어 다양한 문화생활을 누릴 수 있습니다. 해운대센텀호텔은 수준 높은 비즈니스호텔로 뷔페 레스토랑 및 다양한 상가(아케이드)가 입점 되어 있습니다. 투숙객은 객실 내 WIFI와 유선 인터넷, 넓은 주차장을 무료로 이용 할 수 있습니다. 같은 지역의 타 호텔에 비해 객실이 넓으며 전 객실 금연실 및 욕조를 갖추고 있고, 거실과 주방, 침실의 공간이 구분되어 있어 투숙 시 안락함을 드립니다.','admin',1,'벡스코1분거리','N',to_date('20/12/10','RR/MM/DD'));
Insert into TRIP2REAP.HOTEL (BO_NO,HOTEL_ADDRESS,HOTEL_LOCAL_CODE,HOTEL_SITE,HOTEL_TEL,HOTEL_REVIEW_SCORE,HOTEL_RANK,HOTEL_OPEN_TIME,HOTEL_CLOSE_TIME,HOTEL_OPTION,CHECK_IN,CHECK_OUT) values ( SEQ_BO_NO.CURRVAL ,'부산 해운대구 센텀3로 20',8,'https://www.ecentumhotel.com/','051-720-9000',0,4,6,21,'와이파이, 조식, 레스토랑, 세탁, 24시간 리셉션, 수하물 보관, 피트니스, 스파/사우나, 카페, 비즈니스 시설, 주차, 공항셔틀, 장애인 편의시설, 주방, 룸서비스',15,11);

Insert into TRIP2REAP.IMG_FILE (FILE_NO,BO_NO,ORIGIN_NAME,CHANGE_NAME,FILE_LEVEL,FILE_PATH,FILE_DELETE_YN) values (SEQ_FILE_NO.NEXTVAL , SEQ_BO_NO.CURRVAL ,'썸네일.jpeg','hotel_thumbnail_202012110436180652.jpeg',1,'/Users/ek/Documents/GitHub/Spring-Project-Trip2Reap/Spring-Final-Trip2Reap/src/main/webapp/resources/buploadFiles/hotel_thumbnail_202012110436180652.jpeg','N');
Insert into TRIP2REAP.IMG_FILE (FILE_NO,BO_NO,ORIGIN_NAME,CHANGE_NAME,FILE_LEVEL,FILE_PATH,FILE_DELETE_YN) values (SEQ_FILE_NO.NEXTVAL , SEQ_BO_NO.CURRVAL ,'디테일8.jpeg','hotel_detail_202012110436180661.jpeg',2,'/Users/ek/Documents/GitHub/Spring-Project-Trip2Reap/Spring-Final-Trip2Reap/src/main/webapp/resources/buploadFiles/hotel_detail_202012110436180661.jpeg','N');
Insert into TRIP2REAP.IMG_FILE (FILE_NO,BO_NO,ORIGIN_NAME,CHANGE_NAME,FILE_LEVEL,FILE_PATH,FILE_DELETE_YN) values (SEQ_FILE_NO.NEXTVAL , SEQ_BO_NO.CURRVAL ,'디테일9.jpeg','hotel_detail_202012110436180672.jpeg',2,'/Users/ek/Documents/GitHub/Spring-Project-Trip2Reap/Spring-Final-Trip2Reap/src/main/webapp/resources/buploadFiles/hotel_detail_202012110436180672.jpeg','N');
Insert into TRIP2REAP.IMG_FILE (FILE_NO,BO_NO,ORIGIN_NAME,CHANGE_NAME,FILE_LEVEL,FILE_PATH,FILE_DELETE_YN) values (SEQ_FILE_NO.NEXTVAL , SEQ_BO_NO.CURRVAL ,'디테일10.jpeg','hotel_detail_202012110436180681.jpeg',2,'/Users/ek/Documents/GitHub/Spring-Project-Trip2Reap/Spring-Final-Trip2Reap/src/main/webapp/resources/buploadFiles/hotel_detail_202012110436180681.jpeg','N');
Insert into TRIP2REAP.IMG_FILE (FILE_NO,BO_NO,ORIGIN_NAME,CHANGE_NAME,FILE_LEVEL,FILE_PATH,FILE_DELETE_YN) values (SEQ_FILE_NO.NEXTVAL , SEQ_BO_NO.CURRVAL ,'디테일11.jpeg','hotel_detail_202012110436180691.jpeg',2,'/Users/ek/Documents/GitHub/Spring-Project-Trip2Reap/Spring-Final-Trip2Reap/src/main/webapp/resources/buploadFiles/hotel_detail_202012110436180691.jpeg','N');
Insert into TRIP2REAP.IMG_FILE (FILE_NO,BO_NO,ORIGIN_NAME,CHANGE_NAME,FILE_LEVEL,FILE_PATH,FILE_DELETE_YN) values (SEQ_FILE_NO.NEXTVAL , SEQ_BO_NO.CURRVAL ,'디테일12.jpeg','hotel_detail_202012110436180705.jpeg',2,'/Users/ek/Documents/GitHub/Spring-Project-Trip2Reap/Spring-Final-Trip2Reap/src/main/webapp/resources/buploadFiles/hotel_detail_202012110436180705.jpeg','N');
Insert into TRIP2REAP.IMG_FILE (FILE_NO,BO_NO,ORIGIN_NAME,CHANGE_NAME,FILE_LEVEL,FILE_PATH,FILE_DELETE_YN) values (SEQ_FILE_NO.NEXTVAL , SEQ_BO_NO.CURRVAL ,'디테일13.jpeg','hotel_detail_202012110436180718.jpeg',2,'/Users/ek/Documents/GitHub/Spring-Project-Trip2Reap/Spring-Final-Trip2Reap/src/main/webapp/resources/buploadFiles/hotel_detail_202012110436180718.jpeg','N');
Insert into TRIP2REAP.IMG_FILE (FILE_NO,BO_NO,ORIGIN_NAME,CHANGE_NAME,FILE_LEVEL,FILE_PATH,FILE_DELETE_YN) values (SEQ_FILE_NO.NEXTVAL , SEQ_BO_NO.CURRVAL ,'썸네일.jpeg','hotel_detail_202012110436180737.jpeg',2,'/Users/ek/Documents/GitHub/Spring-Project-Trip2Reap/Spring-Final-Trip2Reap/src/main/webapp/resources/buploadFiles/hotel_detail_202012110436180737.jpeg','N');
Insert into TRIP2REAP.IMG_FILE (FILE_NO,BO_NO,ORIGIN_NAME,CHANGE_NAME,FILE_LEVEL,FILE_PATH,FILE_DELETE_YN) values (SEQ_FILE_NO.NEXTVAL , SEQ_BO_NO.CURRVAL ,'디테일1.jpeg','hotel_detail_202012110436180748.jpeg',2,'/Users/ek/Documents/GitHub/Spring-Project-Trip2Reap/Spring-Final-Trip2Reap/src/main/webapp/resources/buploadFiles/hotel_detail_202012110436180748.jpeg','N');
Insert into TRIP2REAP.IMG_FILE (FILE_NO,BO_NO,ORIGIN_NAME,CHANGE_NAME,FILE_LEVEL,FILE_PATH,FILE_DELETE_YN) values (SEQ_FILE_NO.NEXTVAL , SEQ_BO_NO.CURRVAL ,'디테일2.jpeg','hotel_detail_202012110436180761.jpeg',2,'/Users/ek/Documents/GitHub/Spring-Project-Trip2Reap/Spring-Final-Trip2Reap/src/main/webapp/resources/buploadFiles/hotel_detail_202012110436180761.jpeg','N');
Insert into TRIP2REAP.IMG_FILE (FILE_NO,BO_NO,ORIGIN_NAME,CHANGE_NAME,FILE_LEVEL,FILE_PATH,FILE_DELETE_YN) values (SEQ_FILE_NO.NEXTVAL , SEQ_BO_NO.CURRVAL ,'디테일3.jpeg','hotel_detail_202012110436180772.jpeg',2,'/Users/ek/Documents/GitHub/Spring-Project-Trip2Reap/Spring-Final-Trip2Reap/src/main/webapp/resources/buploadFiles/hotel_detail_202012110436180772.jpeg','N');
Insert into TRIP2REAP.IMG_FILE (FILE_NO,BO_NO,ORIGIN_NAME,CHANGE_NAME,FILE_LEVEL,FILE_PATH,FILE_DELETE_YN) values (SEQ_FILE_NO.NEXTVAL , SEQ_BO_NO.CURRVAL ,'디테일4.jpeg','hotel_detail_202012110436180779.jpeg',2,'/Users/ek/Documents/GitHub/Spring-Project-Trip2Reap/Spring-Final-Trip2Reap/src/main/webapp/resources/buploadFiles/hotel_detail_202012110436180779.jpeg','N');
Insert into TRIP2REAP.IMG_FILE (FILE_NO,BO_NO,ORIGIN_NAME,CHANGE_NAME,FILE_LEVEL,FILE_PATH,FILE_DELETE_YN) values (SEQ_FILE_NO.NEXTVAL , SEQ_BO_NO.CURRVAL ,'디테일5.jpeg','hotel_detail_202012110436180789.jpeg',2,'/Users/ek/Documents/GitHub/Spring-Project-Trip2Reap/Spring-Final-Trip2Reap/src/main/webapp/resources/buploadFiles/hotel_detail_202012110436180789.jpeg','N');
Insert into TRIP2REAP.IMG_FILE (FILE_NO,BO_NO,ORIGIN_NAME,CHANGE_NAME,FILE_LEVEL,FILE_PATH,FILE_DELETE_YN) values (SEQ_FILE_NO.NEXTVAL , SEQ_BO_NO.CURRVAL ,'디테일6.jpeg','hotel_detail_202012110436180797.jpeg',2,'/Users/ek/Documents/GitHub/Spring-Project-Trip2Reap/Spring-Final-Trip2Reap/src/main/webapp/resources/buploadFiles/hotel_detail_202012110436180797.jpeg','N');
Insert into TRIP2REAP.IMG_FILE (FILE_NO,BO_NO,ORIGIN_NAME,CHANGE_NAME,FILE_LEVEL,FILE_PATH,FILE_DELETE_YN) values (SEQ_FILE_NO.NEXTVAL , SEQ_BO_NO.CURRVAL ,'디테일7.jpeg','hotel_detail_202012110436180806.jpeg',2,'/Users/ek/Documents/GitHub/Spring-Project-Trip2Reap/Spring-Final-Trip2Reap/src/main/webapp/resources/buploadFiles/hotel_detail_202012110436180806.jpeg','N');

Insert into TRIP2REAP.ROOM (ROOM_NO,BO_NO,ROOM_TYPE,ROOM_NAME,PRICE_PER_DAY) values ( SEQ_ROOM_NO.NEXTVAL , SEQ_BO_NO.CURRVAL ,'스탠다드룸','스탠다드 트윈',62200);
Insert into TRIP2REAP.ROOM (ROOM_NO,BO_NO,ROOM_TYPE,ROOM_NAME,PRICE_PER_DAY) values ( SEQ_ROOM_NO.NEXTVAL , SEQ_BO_NO.CURRVAL ,'트윈룸','스탠다드 트윈',62200);
Insert into TRIP2REAP.ROOM (ROOM_NO,BO_NO,ROOM_TYPE,ROOM_NAME,PRICE_PER_DAY) values ( SEQ_ROOM_NO.NEXTVAL , SEQ_BO_NO.CURRVAL ,'더블룸','디럭스 더블',64000);
Insert into TRIP2REAP.ROOM (ROOM_NO,BO_NO,ROOM_TYPE,ROOM_NAME,PRICE_PER_DAY) values ( SEQ_ROOM_NO.NEXTVAL , SEQ_BO_NO.CURRVAL ,'디럭스룸','디럭스 더블',64000);
Insert into TRIP2REAP.ROOM (ROOM_NO,BO_NO,ROOM_TYPE,ROOM_NAME,PRICE_PER_DAY) values ( SEQ_ROOM_NO.NEXTVAL , SEQ_BO_NO.CURRVAL ,'더블룸','레지던스 더블룸',72700);
Insert into TRIP2REAP.ROOM (ROOM_NO,BO_NO,ROOM_TYPE,ROOM_NAME,PRICE_PER_DAY) values ( SEQ_ROOM_NO.NEXTVAL , SEQ_BO_NO.CURRVAL ,'스탠다드룸','스탠다드 트윈룸+치킨패키지',76000);
Insert into TRIP2REAP.ROOM (ROOM_NO,BO_NO,ROOM_TYPE,ROOM_NAME,PRICE_PER_DAY) values ( SEQ_ROOM_NO.NEXTVAL , SEQ_BO_NO.CURRVAL ,'트윈룸','스탠다드 트윈룸+치킨패키지',76000);
Insert into TRIP2REAP.ROOM (ROOM_NO,BO_NO,ROOM_TYPE,ROOM_NAME,PRICE_PER_DAY) values ( SEQ_ROOM_NO.NEXTVAL , SEQ_BO_NO.CURRVAL ,'패밀리룸','패밀리룸',81100);
Insert into TRIP2REAP.ROOM (ROOM_NO,BO_NO,ROOM_TYPE,ROOM_NAME,PRICE_PER_DAY) values ( SEQ_ROOM_NO.NEXTVAL , SEQ_BO_NO.CURRVAL ,'패밀리룸','패밀리 트리플룸',89100);


--54
Insert into TRIP2REAP.BOARD (BO_NO,CA_CODE,BO_TITLE,BO_CONTENT,MEMBER_ID,BO_COUNT,BO_TAG,BO_DELETE_YN,REGDATE) values (SEQ_BO_NO.NEXTVAL ,5,'센텀 프리미어 호텔','해운대구에 위치한 센텀프리미어호텔은 스파랜드 센텀시티, 신세계백화점 센텀시티점 , 신세계 센텀시티 스파랜드에서 걸어서 5분 거리에 있습니다. 무료 무선 인터넷 및 피트니스센터를 이용하실 수 있습니다. 또한 도보로 10분이면 부산 전시컨벤션센터까지 가실 수 있습니다. 이 호텔에서는 리셉션을 24시간 운영하고 있고 회의실, 환전, 컨시어지 서비스도 마련되어 있습니다. 차량을 가지고 오신 고객님들을 위해 무료 구내 전용 주차장도 제공하고 있습니다. 객실에는 에어컨이 완비되어 있으며 대리석 욕실, 평면 TV, 슬리퍼 등의 프리미엄 시설이 갖춰져 있습니다. 전 객실에서는 냉장고, 커피/차 메이커 등을 사용하실 수 있으며 전용 욕실에는 목욕 가운도 구비되어 있습니다. 호텔의 고객님들은 내부에 있는 레스토랑에서 식사를 드실 수 있습니다. 이 호텔에서 김해 국제공항까지 차로 35분이면 도착하실 수 있으며 부산 2호선 시립미술관역까지 도보로 가실 수 있습니다. 차로 조금만 운전하면 해운대해수욕장까지 가실 수 있습니다.','admin',0,'센텀프리미어','N',to_date('20/12/10','RR/MM/DD'));
Insert into TRIP2REAP.HOTEL (BO_NO,HOTEL_ADDRESS,HOTEL_LOCAL_CODE,HOTEL_SITE,HOTEL_TEL,HOTEL_REVIEW_SCORE,HOTEL_RANK,HOTEL_OPEN_TIME,HOTEL_CLOSE_TIME,HOTEL_OPTION,CHECK_IN,CHECK_OUT) values ( SEQ_BO_NO.CURRVAL ,'부산 해운대구 센텀1로 17',8,'https://www.premierhotel.co.kr/','051-755-9010',0,4,0,23,null,15,11);

Insert into TRIP2REAP.IMG_FILE (FILE_NO,BO_NO,ORIGIN_NAME,CHANGE_NAME,FILE_LEVEL,FILE_PATH,FILE_DELETE_YN) values (SEQ_FILE_NO.NEXTVAL , SEQ_BO_NO.CURRVAL ,'썸네일.jpeg','hotel_thumbnail_202012110447580883.jpeg',1,'/Users/ek/Documents/GitHub/Spring-Project-Trip2Reap/Spring-Final-Trip2Reap/src/main/webapp/resources/buploadFiles/hotel_thumbnail_202012110447580883.jpeg','N');
Insert into TRIP2REAP.IMG_FILE (FILE_NO,BO_NO,ORIGIN_NAME,CHANGE_NAME,FILE_LEVEL,FILE_PATH,FILE_DELETE_YN) values (SEQ_FILE_NO.NEXTVAL , SEQ_BO_NO.CURRVAL ,'디테일4.jpeg','hotel_detail_202012110447580893.jpeg',2,'/Users/ek/Documents/GitHub/Spring-Project-Trip2Reap/Spring-Final-Trip2Reap/src/main/webapp/resources/buploadFiles/hotel_detail_202012110447580893.jpeg','N');
Insert into TRIP2REAP.IMG_FILE (FILE_NO,BO_NO,ORIGIN_NAME,CHANGE_NAME,FILE_LEVEL,FILE_PATH,FILE_DELETE_YN) values (SEQ_FILE_NO.NEXTVAL , SEQ_BO_NO.CURRVAL ,'디테일5.jpeg','hotel_detail_202012110447580903.jpeg',2,'/Users/ek/Documents/GitHub/Spring-Project-Trip2Reap/Spring-Final-Trip2Reap/src/main/webapp/resources/buploadFiles/hotel_detail_202012110447580903.jpeg','N');
Insert into TRIP2REAP.IMG_FILE (FILE_NO,BO_NO,ORIGIN_NAME,CHANGE_NAME,FILE_LEVEL,FILE_PATH,FILE_DELETE_YN) values (SEQ_FILE_NO.NEXTVAL , SEQ_BO_NO.CURRVAL ,'디테일6.jpeg','hotel_detail_202012110447580911.jpeg',2,'/Users/ek/Documents/GitHub/Spring-Project-Trip2Reap/Spring-Final-Trip2Reap/src/main/webapp/resources/buploadFiles/hotel_detail_202012110447580911.jpeg','N');
Insert into TRIP2REAP.IMG_FILE (FILE_NO,BO_NO,ORIGIN_NAME,CHANGE_NAME,FILE_LEVEL,FILE_PATH,FILE_DELETE_YN) values (SEQ_FILE_NO.NEXTVAL , SEQ_BO_NO.CURRVAL ,'디테일7.jpeg','hotel_detail_202012110447580924.jpeg',2,'/Users/ek/Documents/GitHub/Spring-Project-Trip2Reap/Spring-Final-Trip2Reap/src/main/webapp/resources/buploadFiles/hotel_detail_202012110447580924.jpeg','N');
Insert into TRIP2REAP.IMG_FILE (FILE_NO,BO_NO,ORIGIN_NAME,CHANGE_NAME,FILE_LEVEL,FILE_PATH,FILE_DELETE_YN) values (SEQ_FILE_NO.NEXTVAL , SEQ_BO_NO.CURRVAL ,'디테일8.jpeg','hotel_detail_202012110447580933.jpeg',2,'/Users/ek/Documents/GitHub/Spring-Project-Trip2Reap/Spring-Final-Trip2Reap/src/main/webapp/resources/buploadFiles/hotel_detail_202012110447580933.jpeg','N');
Insert into TRIP2REAP.IMG_FILE (FILE_NO,BO_NO,ORIGIN_NAME,CHANGE_NAME,FILE_LEVEL,FILE_PATH,FILE_DELETE_YN) values (SEQ_FILE_NO.NEXTVAL , SEQ_BO_NO.CURRVAL ,'디테일9.jpeg','hotel_detail_202012110447580948.jpeg',2,'/Users/ek/Documents/GitHub/Spring-Project-Trip2Reap/Spring-Final-Trip2Reap/src/main/webapp/resources/buploadFiles/hotel_detail_202012110447580948.jpeg','N');
Insert into TRIP2REAP.IMG_FILE (FILE_NO,BO_NO,ORIGIN_NAME,CHANGE_NAME,FILE_LEVEL,FILE_PATH,FILE_DELETE_YN) values (SEQ_FILE_NO.NEXTVAL , SEQ_BO_NO.CURRVAL ,'디테일10.jpeg','hotel_detail_202012110447580963.jpeg',2,'/Users/ek/Documents/GitHub/Spring-Project-Trip2Reap/Spring-Final-Trip2Reap/src/main/webapp/resources/buploadFiles/hotel_detail_202012110447580963.jpeg','N');
Insert into TRIP2REAP.IMG_FILE (FILE_NO,BO_NO,ORIGIN_NAME,CHANGE_NAME,FILE_LEVEL,FILE_PATH,FILE_DELETE_YN) values (SEQ_FILE_NO.NEXTVAL , SEQ_BO_NO.CURRVAL ,'디테일11.jpeg','hotel_detail_202012110447580971.jpeg',2,'/Users/ek/Documents/GitHub/Spring-Project-Trip2Reap/Spring-Final-Trip2Reap/src/main/webapp/resources/buploadFiles/hotel_detail_202012110447580971.jpeg','N');
Insert into TRIP2REAP.IMG_FILE (FILE_NO,BO_NO,ORIGIN_NAME,CHANGE_NAME,FILE_LEVEL,FILE_PATH,FILE_DELETE_YN) values (SEQ_FILE_NO.NEXTVAL , SEQ_BO_NO.CURRVAL ,'썸네일.jpeg','hotel_detail_202012110447580984.jpeg',2,'/Users/ek/Documents/GitHub/Spring-Project-Trip2Reap/Spring-Final-Trip2Reap/src/main/webapp/resources/buploadFiles/hotel_detail_202012110447580984.jpeg','N');
Insert into TRIP2REAP.IMG_FILE (FILE_NO,BO_NO,ORIGIN_NAME,CHANGE_NAME,FILE_LEVEL,FILE_PATH,FILE_DELETE_YN) values (SEQ_FILE_NO.NEXTVAL , SEQ_BO_NO.CURRVAL ,'디테일1.jpeg','hotel_detail_202012110447590001.jpeg',2,'/Users/ek/Documents/GitHub/Spring-Project-Trip2Reap/Spring-Final-Trip2Reap/src/main/webapp/resources/buploadFiles/hotel_detail_202012110447590001.jpeg','N');
Insert into TRIP2REAP.IMG_FILE (FILE_NO,BO_NO,ORIGIN_NAME,CHANGE_NAME,FILE_LEVEL,FILE_PATH,FILE_DELETE_YN) values (SEQ_FILE_NO.NEXTVAL , SEQ_BO_NO.CURRVAL ,'디테일2.jpeg','hotel_detail_202012110447590017.jpeg',2,'/Users/ek/Documents/GitHub/Spring-Project-Trip2Reap/Spring-Final-Trip2Reap/src/main/webapp/resources/buploadFiles/hotel_detail_202012110447590017.jpeg','N');
Insert into TRIP2REAP.IMG_FILE (FILE_NO,BO_NO,ORIGIN_NAME,CHANGE_NAME,FILE_LEVEL,FILE_PATH,FILE_DELETE_YN) values (SEQ_FILE_NO.NEXTVAL , SEQ_BO_NO.CURRVAL ,'디테일3.jpeg','hotel_detail_202012110447590033.jpeg',2,'/Users/ek/Documents/GitHub/Spring-Project-Trip2Reap/Spring-Final-Trip2Reap/src/main/webapp/resources/buploadFiles/hotel_detail_202012110447590033.jpeg','N');

Insert into TRIP2REAP.ROOM (ROOM_NO,BO_NO,ROOM_TYPE,ROOM_NAME,PRICE_PER_DAY) values ( SEQ_ROOM_NO.NEXTVAL , SEQ_BO_NO.CURRVAL ,'더블룸','슈페리어 더블',56900);
Insert into TRIP2REAP.ROOM (ROOM_NO,BO_NO,ROOM_TYPE,ROOM_NAME,PRICE_PER_DAY) values ( SEQ_ROOM_NO.NEXTVAL , SEQ_BO_NO.CURRVAL ,'슈페리어룸','슈페리어 더블',56900);
Insert into TRIP2REAP.ROOM (ROOM_NO,BO_NO,ROOM_TYPE,ROOM_NAME,PRICE_PER_DAY) values ( SEQ_ROOM_NO.NEXTVAL , SEQ_BO_NO.CURRVAL ,'슈페리어룸','슈페리어 트윈',66200);
Insert into TRIP2REAP.ROOM (ROOM_NO,BO_NO,ROOM_TYPE,ROOM_NAME,PRICE_PER_DAY) values ( SEQ_ROOM_NO.NEXTVAL , SEQ_BO_NO.CURRVAL ,'트윈룸','슈페리어 트윈',66200);
Insert into TRIP2REAP.ROOM (ROOM_NO,BO_NO,ROOM_TYPE,ROOM_NAME,PRICE_PER_DAY) values ( SEQ_ROOM_NO.NEXTVAL , SEQ_BO_NO.CURRVAL ,'디럭스룸','디럭스 더블룸',72700);
Insert into TRIP2REAP.ROOM (ROOM_NO,BO_NO,ROOM_TYPE,ROOM_NAME,PRICE_PER_DAY) values ( SEQ_ROOM_NO.NEXTVAL , SEQ_BO_NO.CURRVAL ,'더블룸','디럭스 더블룸',72700);
Insert into TRIP2REAP.ROOM (ROOM_NO,BO_NO,ROOM_TYPE,ROOM_NAME,PRICE_PER_DAY) values ( SEQ_ROOM_NO.NEXTVAL , SEQ_BO_NO.CURRVAL ,'디럭스룸','디럭스 트윈룸',77000);
Insert into TRIP2REAP.ROOM (ROOM_NO,BO_NO,ROOM_TYPE,ROOM_NAME,PRICE_PER_DAY) values ( SEQ_ROOM_NO.NEXTVAL , SEQ_BO_NO.CURRVAL ,'트윈룸','디럭스 트윈룸',77000);


--55
Insert into TRIP2REAP.BOARD (BO_NO,CA_CODE,BO_TITLE,BO_CONTENT,MEMBER_ID,BO_COUNT,BO_TAG,BO_DELETE_YN,REGDATE) values (SEQ_BO_NO.NEXTVAL ,5,'펠릭스 호텔 바이 STX','펠릭스 호텔 바이 STX는 부산 2호선 해운대역과 연결되어있으며 42층 규모의 우뚝 선 건물로 아름다운 해운대 전망을 자랑합니다. 걸어서 약 10분이면 해운대 해수욕장과 SEA LIFE 부산아쿠아리움까지 가실 수 있습니다. 또한 산책하기 좋은 달맞이길은 차로 약 10분 거리에 있습니다. 호텔 내에는 피트니스 센터, 코인 세탁실, 주차장 등이 있으며 비즈니스 고객을 위한 미팅룸과 비즈니스 센터가 마련되어 있습니다. 또한, 24시간 리셉션에서는 세탁 및 드라이클리닝 서비스 등 다양한 서비스를 제공하고 있습니다. 편의점과 영화관도 같은 건물 내에 있어 편리하게 이용하실 수 있습니다. 총 478개의 객실이 있으며 모든 객실에는 Wi-Fi와 개별 냉난방 시스템이 완비되어 있으며 TV, 금고, 다리미판, IDD 전화기 등도 있습니다. 욕실에는 헤어드라이어, 타월, 세면도구가 비치되어 있습니다. 또한, 냉장고, 전기밥솥, 전기 포트, 토스터기 등 완비된 주방에서 간단한 요리를 하실 수도 있습니다. 5층에 마련된 구내 레스토랑에서 별도의 요금을 내시면 컨티넨탈식 조식을 즐기실 수 있습니다.','admin',1,null,'N',to_date('20/12/10','RR/MM/DD'));
Insert into TRIP2REAP.HOTEL (BO_NO,HOTEL_ADDRESS,HOTEL_LOCAL_CODE,HOTEL_SITE,HOTEL_TEL,HOTEL_REVIEW_SCORE,HOTEL_RANK,HOTEL_OPEN_TIME,HOTEL_CLOSE_TIME,HOTEL_OPTION,CHECK_IN,CHECK_OUT) values ( SEQ_BO_NO.CURRVAL ,'부산 해운대구 해운대로 620',8,null,'051-969-5000',0,4,0,23,'와이파이, 조식, 레스토랑, 24시간 리셉션, 주차, 주방',15,11);

Insert into TRIP2REAP.IMG_FILE (FILE_NO,BO_NO,ORIGIN_NAME,CHANGE_NAME,FILE_LEVEL,FILE_PATH,FILE_DELETE_YN) values (SEQ_FILE_NO.NEXTVAL , SEQ_BO_NO.CURRVAL ,'썸네일.jpeg','hotel_thumbnail_202012110452580407.jpeg',1,'/Users/ek/Documents/GitHub/Spring-Project-Trip2Reap/Spring-Final-Trip2Reap/src/main/webapp/resources/buploadFiles/hotel_thumbnail_202012110452580407.jpeg','N');
Insert into TRIP2REAP.IMG_FILE (FILE_NO,BO_NO,ORIGIN_NAME,CHANGE_NAME,FILE_LEVEL,FILE_PATH,FILE_DELETE_YN) values (SEQ_FILE_NO.NEXTVAL , SEQ_BO_NO.CURRVAL ,'디테일1.jpeg','hotel_detail_202012110452580436.jpeg',2,'/Users/ek/Documents/GitHub/Spring-Project-Trip2Reap/Spring-Final-Trip2Reap/src/main/webapp/resources/buploadFiles/hotel_detail_202012110452580436.jpeg','N');
Insert into TRIP2REAP.IMG_FILE (FILE_NO,BO_NO,ORIGIN_NAME,CHANGE_NAME,FILE_LEVEL,FILE_PATH,FILE_DELETE_YN) values (SEQ_FILE_NO.NEXTVAL , SEQ_BO_NO.CURRVAL ,'디테일2.jpeg','hotel_detail_202012110452580445.jpeg',2,'/Users/ek/Documents/GitHub/Spring-Project-Trip2Reap/Spring-Final-Trip2Reap/src/main/webapp/resources/buploadFiles/hotel_detail_202012110452580445.jpeg','N');
Insert into TRIP2REAP.IMG_FILE (FILE_NO,BO_NO,ORIGIN_NAME,CHANGE_NAME,FILE_LEVEL,FILE_PATH,FILE_DELETE_YN) values (SEQ_FILE_NO.NEXTVAL , SEQ_BO_NO.CURRVAL ,'디테일3.jpeg','hotel_detail_202012110452580464.jpeg',2,'/Users/ek/Documents/GitHub/Spring-Project-Trip2Reap/Spring-Final-Trip2Reap/src/main/webapp/resources/buploadFiles/hotel_detail_202012110452580464.jpeg','N');
Insert into TRIP2REAP.IMG_FILE (FILE_NO,BO_NO,ORIGIN_NAME,CHANGE_NAME,FILE_LEVEL,FILE_PATH,FILE_DELETE_YN) values (SEQ_FILE_NO.NEXTVAL , SEQ_BO_NO.CURRVAL ,'디테일4.jpeg','hotel_detail_202012110452580478.jpeg',2,'/Users/ek/Documents/GitHub/Spring-Project-Trip2Reap/Spring-Final-Trip2Reap/src/main/webapp/resources/buploadFiles/hotel_detail_202012110452580478.jpeg','N');
Insert into TRIP2REAP.IMG_FILE (FILE_NO,BO_NO,ORIGIN_NAME,CHANGE_NAME,FILE_LEVEL,FILE_PATH,FILE_DELETE_YN) values (SEQ_FILE_NO.NEXTVAL , SEQ_BO_NO.CURRVAL ,'디테일5.jpeg','hotel_detail_202012110452580488.jpeg',2,'/Users/ek/Documents/GitHub/Spring-Project-Trip2Reap/Spring-Final-Trip2Reap/src/main/webapp/resources/buploadFiles/hotel_detail_202012110452580488.jpeg','N');
Insert into TRIP2REAP.IMG_FILE (FILE_NO,BO_NO,ORIGIN_NAME,CHANGE_NAME,FILE_LEVEL,FILE_PATH,FILE_DELETE_YN) values (SEQ_FILE_NO.NEXTVAL , SEQ_BO_NO.CURRVAL ,'디테일6.jpeg','hotel_detail_202012110452580502.jpeg',2,'/Users/ek/Documents/GitHub/Spring-Project-Trip2Reap/Spring-Final-Trip2Reap/src/main/webapp/resources/buploadFiles/hotel_detail_202012110452580502.jpeg','N');
Insert into TRIP2REAP.IMG_FILE (FILE_NO,BO_NO,ORIGIN_NAME,CHANGE_NAME,FILE_LEVEL,FILE_PATH,FILE_DELETE_YN) values (SEQ_FILE_NO.NEXTVAL , SEQ_BO_NO.CURRVAL ,'디테일7.jpeg','hotel_detail_202012110452580513.jpeg',2,'/Users/ek/Documents/GitHub/Spring-Project-Trip2Reap/Spring-Final-Trip2Reap/src/main/webapp/resources/buploadFiles/hotel_detail_202012110452580513.jpeg','N');
Insert into TRIP2REAP.IMG_FILE (FILE_NO,BO_NO,ORIGIN_NAME,CHANGE_NAME,FILE_LEVEL,FILE_PATH,FILE_DELETE_YN) values (SEQ_FILE_NO.NEXTVAL , SEQ_BO_NO.CURRVAL ,'디테일8.jpeg','hotel_detail_202012110452580524.jpeg',2,'/Users/ek/Documents/GitHub/Spring-Project-Trip2Reap/Spring-Final-Trip2Reap/src/main/webapp/resources/buploadFiles/hotel_detail_202012110452580524.jpeg','N');
Insert into TRIP2REAP.IMG_FILE (FILE_NO,BO_NO,ORIGIN_NAME,CHANGE_NAME,FILE_LEVEL,FILE_PATH,FILE_DELETE_YN) values (SEQ_FILE_NO.NEXTVAL , SEQ_BO_NO.CURRVAL ,'디테일9.jpeg','hotel_detail_202012110452580542.jpeg',2,'/Users/ek/Documents/GitHub/Spring-Project-Trip2Reap/Spring-Final-Trip2Reap/src/main/webapp/resources/buploadFiles/hotel_detail_202012110452580542.jpeg','N');
Insert into TRIP2REAP.IMG_FILE (FILE_NO,BO_NO,ORIGIN_NAME,CHANGE_NAME,FILE_LEVEL,FILE_PATH,FILE_DELETE_YN) values (SEQ_FILE_NO.NEXTVAL , SEQ_BO_NO.CURRVAL ,'디테일10.jpeg','hotel_detail_202012110452580563.jpeg',2,'/Users/ek/Documents/GitHub/Spring-Project-Trip2Reap/Spring-Final-Trip2Reap/src/main/webapp/resources/buploadFiles/hotel_detail_202012110452580563.jpeg','N');
Insert into TRIP2REAP.IMG_FILE (FILE_NO,BO_NO,ORIGIN_NAME,CHANGE_NAME,FILE_LEVEL,FILE_PATH,FILE_DELETE_YN) values (SEQ_FILE_NO.NEXTVAL , SEQ_BO_NO.CURRVAL ,'디테일11.jpeg','hotel_detail_202012110452580572.jpeg',2,'/Users/ek/Documents/GitHub/Spring-Project-Trip2Reap/Spring-Final-Trip2Reap/src/main/webapp/resources/buploadFiles/hotel_detail_202012110452580572.jpeg','N');
Insert into TRIP2REAP.IMG_FILE (FILE_NO,BO_NO,ORIGIN_NAME,CHANGE_NAME,FILE_LEVEL,FILE_PATH,FILE_DELETE_YN) values (SEQ_FILE_NO.NEXTVAL , SEQ_BO_NO.CURRVAL ,'디테일12.jpeg','hotel_detail_202012110452580584.jpeg',2,'/Users/ek/Documents/GitHub/Spring-Project-Trip2Reap/Spring-Final-Trip2Reap/src/main/webapp/resources/buploadFiles/hotel_detail_202012110452580584.jpeg','N');
Insert into TRIP2REAP.IMG_FILE (FILE_NO,BO_NO,ORIGIN_NAME,CHANGE_NAME,FILE_LEVEL,FILE_PATH,FILE_DELETE_YN) values (SEQ_FILE_NO.NEXTVAL , SEQ_BO_NO.CURRVAL ,'디테일13.jpeg','hotel_detail_202012110452580590.jpeg',2,'/Users/ek/Documents/GitHub/Spring-Project-Trip2Reap/Spring-Final-Trip2Reap/src/main/webapp/resources/buploadFiles/hotel_detail_202012110452580590.jpeg','N');
Insert into TRIP2REAP.IMG_FILE (FILE_NO,BO_NO,ORIGIN_NAME,CHANGE_NAME,FILE_LEVEL,FILE_PATH,FILE_DELETE_YN) values (SEQ_FILE_NO.NEXTVAL , SEQ_BO_NO.CURRVAL ,'디테일14.jpeg','hotel_detail_202012110452580603.jpeg',2,'/Users/ek/Documents/GitHub/Spring-Project-Trip2Reap/Spring-Final-Trip2Reap/src/main/webapp/resources/buploadFiles/hotel_detail_202012110452580603.jpeg','N');
Insert into TRIP2REAP.IMG_FILE (FILE_NO,BO_NO,ORIGIN_NAME,CHANGE_NAME,FILE_LEVEL,FILE_PATH,FILE_DELETE_YN) values (SEQ_FILE_NO.NEXTVAL , SEQ_BO_NO.CURRVAL ,'디테일15.jpeg','hotel_detail_202012110452580613.jpeg',2,'/Users/ek/Documents/GitHub/Spring-Project-Trip2Reap/Spring-Final-Trip2Reap/src/main/webapp/resources/buploadFiles/hotel_detail_202012110452580613.jpeg','N');
Insert into TRIP2REAP.IMG_FILE (FILE_NO,BO_NO,ORIGIN_NAME,CHANGE_NAME,FILE_LEVEL,FILE_PATH,FILE_DELETE_YN) values (SEQ_FILE_NO.NEXTVAL , SEQ_BO_NO.CURRVAL ,'디테일16.jpeg','hotel_detail_202012110452580622.jpeg',2,'/Users/ek/Documents/GitHub/Spring-Project-Trip2Reap/Spring-Final-Trip2Reap/src/main/webapp/resources/buploadFiles/hotel_detail_202012110452580622.jpeg','N');

Insert into TRIP2REAP.ROOM (ROOM_NO,BO_NO,ROOM_TYPE,ROOM_NAME,PRICE_PER_DAY) values ( SEQ_ROOM_NO.NEXTVAL , SEQ_BO_NO.CURRVAL ,'스튜디오룸','스튜디오 디럭스',69800);
Insert into TRIP2REAP.ROOM (ROOM_NO,BO_NO,ROOM_TYPE,ROOM_NAME,PRICE_PER_DAY) values ( SEQ_ROOM_NO.NEXTVAL , SEQ_BO_NO.CURRVAL ,'디럭스룸','스튜디오 디럭스',69800);
Insert into TRIP2REAP.ROOM (ROOM_NO,BO_NO,ROOM_TYPE,ROOM_NAME,PRICE_PER_DAY) values ( SEQ_ROOM_NO.NEXTVAL , SEQ_BO_NO.CURRVAL ,'더블룸','스튜디오 디럭스 더블',69800);
Insert into TRIP2REAP.ROOM (ROOM_NO,BO_NO,ROOM_TYPE,ROOM_NAME,PRICE_PER_DAY) values ( SEQ_ROOM_NO.NEXTVAL , SEQ_BO_NO.CURRVAL ,'스위트룸','사이드 오션 스위트',114000);
Insert into TRIP2REAP.ROOM (ROOM_NO,BO_NO,ROOM_TYPE,ROOM_NAME,PRICE_PER_DAY) values ( SEQ_ROOM_NO.NEXTVAL , SEQ_BO_NO.CURRVAL ,'스위트룸','디럭스 스위트',108000);
Insert into TRIP2REAP.ROOM (ROOM_NO,BO_NO,ROOM_TYPE,ROOM_NAME,PRICE_PER_DAY) values ( SEQ_ROOM_NO.NEXTVAL , SEQ_BO_NO.CURRVAL ,'디럭스룸','디럭스 스위트',108000);



--56
Insert into TRIP2REAP.BOARD (BO_NO,CA_CODE,BO_TITLE,BO_CONTENT,MEMBER_ID,BO_COUNT,BO_TAG,BO_DELETE_YN,REGDATE) values (SEQ_BO_NO.NEXTVAL ,5,'호텔 난타','호텔 난타 - <4성급> - 2017년 3월 오픈한 호텔 난타는 제주국제공항에서 차로 약 30분 거리에 있습니다. 제주의 상징 한라산국립공원까지 차로 약 20분, 맛집이 많아 인기가 많은 애월읍까지 차로 약 40분이면 갈 수 있습니다. 이 호텔은 260석 규모의 회의 공간 그랜드볼룸, 난타 공연과 다양한 국제회의를 열 수 있는 700석 규모의 컨퍼런스 룸, 비즈니스 센터, 피트니스 센터, 편의점 등의 편의시설이 마련되어 있습니다. 총 204개의 객실은 스탠다드 트윈, 디럭스 킹, 프리미엄 트윈, 스위트 주니어, 스위트 이그제큐티브 등으로 다양하게 구성되어 있으며, 각 객실 내에는 TV, 개인금고, 냉장고, 전기 포트, 무료 커피, 목욕가운, 욕실용품, 헤어드라이어, 비데 등이 갖춰져 있습니다. 로비 층에 위치한 ‘쿠킨’에서 제주도만의 특색 있는 식재료가 가득한 뷔페를 이용할 수 있으며, 2층에 자리한 ‘카페 블루’에서는 가족 혹은 친구들과 여유로운 시간을 보내기 좋습니다.','admin',0,'호텔난타, 한라산뷰','N',to_date('20/12/11','RR/MM/DD'));
Insert into TRIP2REAP.HOTEL (BO_NO,HOTEL_ADDRESS,HOTEL_LOCAL_CODE,HOTEL_SITE,HOTEL_TEL,HOTEL_REVIEW_SCORE,HOTEL_RANK,HOTEL_OPEN_TIME,HOTEL_CLOSE_TIME,HOTEL_OPTION,CHECK_IN,CHECK_OUT) values ( SEQ_BO_NO.CURRVAL ,'제주특별자치도 제주시 선돌목동길 56-26',15,'http://www.hotelnanta.com/kr/','064-727-0602',0,4,6,22,'와이파이, 조식, 레스토랑, 세탁, 24시간 리셉션, 수하물 보관, 피트니스, 카페, 비즈니스 시설, 주차, 장애인 편의시설, 주방, 룸서비스',14,11);

Insert into TRIP2REAP.IMG_FILE (FILE_NO,BO_NO,ORIGIN_NAME,CHANGE_NAME,FILE_LEVEL,FILE_PATH,FILE_DELETE_YN) values (SEQ_FILE_NO.NEXTVAL , SEQ_BO_NO.CURRVAL ,'썸네일2.jpeg','hotel_thumbnail_202012110948200685.jpeg',1,'/Users/ek/Documents/GitHub/Spring-Project-Trip2Reap/Spring-Final-Trip2Reap/src/main/webapp/resources/buploadFiles/hotel_thumbnail_202012110948200685.jpeg','N');
Insert into TRIP2REAP.IMG_FILE (FILE_NO,BO_NO,ORIGIN_NAME,CHANGE_NAME,FILE_LEVEL,FILE_PATH,FILE_DELETE_YN) values (SEQ_FILE_NO.NEXTVAL , SEQ_BO_NO.CURRVAL ,'디테일4.jpeg','hotel_detail_202012110948200696.jpeg',2,'/Users/ek/Documents/GitHub/Spring-Project-Trip2Reap/Spring-Final-Trip2Reap/src/main/webapp/resources/buploadFiles/hotel_detail_202012110948200696.jpeg','N');
Insert into TRIP2REAP.IMG_FILE (FILE_NO,BO_NO,ORIGIN_NAME,CHANGE_NAME,FILE_LEVEL,FILE_PATH,FILE_DELETE_YN) values (SEQ_FILE_NO.NEXTVAL , SEQ_BO_NO.CURRVAL ,'디테일5.jpeg','hotel_detail_202012110948200706.jpeg',2,'/Users/ek/Documents/GitHub/Spring-Project-Trip2Reap/Spring-Final-Trip2Reap/src/main/webapp/resources/buploadFiles/hotel_detail_202012110948200706.jpeg','N');
Insert into TRIP2REAP.IMG_FILE (FILE_NO,BO_NO,ORIGIN_NAME,CHANGE_NAME,FILE_LEVEL,FILE_PATH,FILE_DELETE_YN) values (SEQ_FILE_NO.NEXTVAL , SEQ_BO_NO.CURRVAL ,'디테일6.jpeg','hotel_detail_202012110948200720.jpeg',2,'/Users/ek/Documents/GitHub/Spring-Project-Trip2Reap/Spring-Final-Trip2Reap/src/main/webapp/resources/buploadFiles/hotel_detail_202012110948200720.jpeg','N');
Insert into TRIP2REAP.IMG_FILE (FILE_NO,BO_NO,ORIGIN_NAME,CHANGE_NAME,FILE_LEVEL,FILE_PATH,FILE_DELETE_YN) values (SEQ_FILE_NO.NEXTVAL , SEQ_BO_NO.CURRVAL ,'디테일7.jpeg','hotel_detail_202012110948200734.jpeg',2,'/Users/ek/Documents/GitHub/Spring-Project-Trip2Reap/Spring-Final-Trip2Reap/src/main/webapp/resources/buploadFiles/hotel_detail_202012110948200734.jpeg','N');
Insert into TRIP2REAP.IMG_FILE (FILE_NO,BO_NO,ORIGIN_NAME,CHANGE_NAME,FILE_LEVEL,FILE_PATH,FILE_DELETE_YN) values (SEQ_FILE_NO.NEXTVAL , SEQ_BO_NO.CURRVAL ,'디테일8.jpeg','hotel_detail_202012110948200744.jpeg',2,'/Users/ek/Documents/GitHub/Spring-Project-Trip2Reap/Spring-Final-Trip2Reap/src/main/webapp/resources/buploadFiles/hotel_detail_202012110948200744.jpeg','N');
Insert into TRIP2REAP.IMG_FILE (FILE_NO,BO_NO,ORIGIN_NAME,CHANGE_NAME,FILE_LEVEL,FILE_PATH,FILE_DELETE_YN) values (SEQ_FILE_NO.NEXTVAL , SEQ_BO_NO.CURRVAL ,'디테일9.jpeg','hotel_detail_202012110948200753.jpeg',2,'/Users/ek/Documents/GitHub/Spring-Project-Trip2Reap/Spring-Final-Trip2Reap/src/main/webapp/resources/buploadFiles/hotel_detail_202012110948200753.jpeg','N');
Insert into TRIP2REAP.IMG_FILE (FILE_NO,BO_NO,ORIGIN_NAME,CHANGE_NAME,FILE_LEVEL,FILE_PATH,FILE_DELETE_YN) values (SEQ_FILE_NO.NEXTVAL , SEQ_BO_NO.CURRVAL ,'디테일10.jpeg','hotel_detail_202012110948200763.jpeg',2,'/Users/ek/Documents/GitHub/Spring-Project-Trip2Reap/Spring-Final-Trip2Reap/src/main/webapp/resources/buploadFiles/hotel_detail_202012110948200763.jpeg','N');
Insert into TRIP2REAP.IMG_FILE (FILE_NO,BO_NO,ORIGIN_NAME,CHANGE_NAME,FILE_LEVEL,FILE_PATH,FILE_DELETE_YN) values (SEQ_FILE_NO.NEXTVAL , SEQ_BO_NO.CURRVAL ,'디테일11.jpeg','hotel_detail_202012110948200773.jpeg',2,'/Users/ek/Documents/GitHub/Spring-Project-Trip2Reap/Spring-Final-Trip2Reap/src/main/webapp/resources/buploadFiles/hotel_detail_202012110948200773.jpeg','N');
Insert into TRIP2REAP.IMG_FILE (FILE_NO,BO_NO,ORIGIN_NAME,CHANGE_NAME,FILE_LEVEL,FILE_PATH,FILE_DELETE_YN) values (SEQ_FILE_NO.NEXTVAL , SEQ_BO_NO.CURRVAL ,'썸네일.jpeg','hotel_detail_202012110948200788.jpeg',2,'/Users/ek/Documents/GitHub/Spring-Project-Trip2Reap/Spring-Final-Trip2Reap/src/main/webapp/resources/buploadFiles/hotel_detail_202012110948200788.jpeg','N');
Insert into TRIP2REAP.IMG_FILE (FILE_NO,BO_NO,ORIGIN_NAME,CHANGE_NAME,FILE_LEVEL,FILE_PATH,FILE_DELETE_YN) values (SEQ_FILE_NO.NEXTVAL , SEQ_BO_NO.CURRVAL ,'썸네일2.jpeg','hotel_detail_202012110948200799.jpeg',2,'/Users/ek/Documents/GitHub/Spring-Project-Trip2Reap/Spring-Final-Trip2Reap/src/main/webapp/resources/buploadFiles/hotel_detail_202012110948200799.jpeg','N');
Insert into TRIP2REAP.IMG_FILE (FILE_NO,BO_NO,ORIGIN_NAME,CHANGE_NAME,FILE_LEVEL,FILE_PATH,FILE_DELETE_YN) values (SEQ_FILE_NO.NEXTVAL , SEQ_BO_NO.CURRVAL ,'디테일1.jpeg','hotel_detail_202012110948200807.jpeg',2,'/Users/ek/Documents/GitHub/Spring-Project-Trip2Reap/Spring-Final-Trip2Reap/src/main/webapp/resources/buploadFiles/hotel_detail_202012110948200807.jpeg','N');
Insert into TRIP2REAP.IMG_FILE (FILE_NO,BO_NO,ORIGIN_NAME,CHANGE_NAME,FILE_LEVEL,FILE_PATH,FILE_DELETE_YN) values (SEQ_FILE_NO.NEXTVAL , SEQ_BO_NO.CURRVAL ,'디테일2.jpeg','hotel_detail_202012110948200817.jpeg',2,'/Users/ek/Documents/GitHub/Spring-Project-Trip2Reap/Spring-Final-Trip2Reap/src/main/webapp/resources/buploadFiles/hotel_detail_202012110948200817.jpeg','N');
Insert into TRIP2REAP.IMG_FILE (FILE_NO,BO_NO,ORIGIN_NAME,CHANGE_NAME,FILE_LEVEL,FILE_PATH,FILE_DELETE_YN) values (SEQ_FILE_NO.NEXTVAL , SEQ_BO_NO.CURRVAL ,'디테일3.jpeg','hotel_detail_202012110948200826.jpeg',2,'/Users/ek/Documents/GitHub/Spring-Project-Trip2Reap/Spring-Final-Trip2Reap/src/main/webapp/resources/buploadFiles/hotel_detail_202012110948200826.jpeg','N');

Insert into TRIP2REAP.ROOM (ROOM_NO,BO_NO,ROOM_TYPE,ROOM_NAME,PRICE_PER_DAY) values ( SEQ_ROOM_NO.NEXTVAL , SEQ_BO_NO.CURRVAL ,'트윈룸','스탠다드 트윈룸',57800);
Insert into TRIP2REAP.ROOM (ROOM_NO,BO_NO,ROOM_TYPE,ROOM_NAME,PRICE_PER_DAY) values ( SEQ_ROOM_NO.NEXTVAL , SEQ_BO_NO.CURRVAL ,'스탠다드룸','스탠다드 트윈룸',57800);
Insert into TRIP2REAP.ROOM (ROOM_NO,BO_NO,ROOM_TYPE,ROOM_NAME,PRICE_PER_DAY) values ( SEQ_ROOM_NO.NEXTVAL , SEQ_BO_NO.CURRVAL ,'트윈룸','스탠다드 트윈룸-18시이후 체크인가능',59300);
Insert into TRIP2REAP.ROOM (ROOM_NO,BO_NO,ROOM_TYPE,ROOM_NAME,PRICE_PER_DAY) values ( SEQ_ROOM_NO.NEXTVAL , SEQ_BO_NO.CURRVAL ,'스탠다드룸','스탠다드 트윈룸-18시이후 체크인가능',59300);
Insert into TRIP2REAP.ROOM (ROOM_NO,BO_NO,ROOM_TYPE,ROOM_NAME,PRICE_PER_DAY) values ( SEQ_ROOM_NO.NEXTVAL , SEQ_BO_NO.CURRVAL ,'디럭스룸','디럭스 트윈룸-18시이후 체크인가능',72700);
Insert into TRIP2REAP.ROOM (ROOM_NO,BO_NO,ROOM_TYPE,ROOM_NAME,PRICE_PER_DAY) values ( SEQ_ROOM_NO.NEXTVAL , SEQ_BO_NO.CURRVAL ,'트윈룸','디럭스 트윈룸-18시이후 체크인가능',72700);
Insert into TRIP2REAP.ROOM (ROOM_NO,BO_NO,ROOM_TYPE,ROOM_NAME,PRICE_PER_DAY) values ( SEQ_ROOM_NO.NEXTVAL , SEQ_BO_NO.CURRVAL ,'디럭스룸','디럭스 트리플룸',78300);



--57
Insert into TRIP2REAP.BOARD (BO_NO,CA_CODE,BO_TITLE,BO_CONTENT,MEMBER_ID,BO_COUNT,BO_TAG,BO_DELETE_YN,REGDATE) values (SEQ_BO_NO.NEXTVAL ,5,'라마다 제주시티 호텔','라마다 제주 시티 호텔은 제주국제공항에서 차로 15분 거리에 자리잡고 있습니다. 주변의 관광 명소로는 용연 계곡과 용의 머리를 닮은 용두암이 차로 15분 거리에 있으며 제주도 원주민의 발상지인 삼성혈이 차로 5분 거리에 자리해 있습니다. 또한, 반짝이는 검은 모래가 특징인 삼양 검은모래해변까지 차로 20분이면 도착하며 제주도를 대표하는 명소인 한라산까지 차로 35분이 소요됩니다. 제주에 머무시는 동안 이 호텔에서 아늑한 객실 및 시설을 이용하실 수 있습니다. 또한 세탁 시설, 비즈니스 센터 등도 이용하실 수 있습니다. 모든 객실에는 에어컨, 방음 시설이 갖춰져 있으며, 커피 메이커, 냉장고, 슬리퍼 또한 구비되어 있습니다. 욕실에는 샤워 시설 시설이 구비되어 있으며 목욕 가운, 헤어드라이어 등이 준비되어 있습니다.','admin',1,'라마다호텔, 제주민속자연사박물관','N',to_date('20/12/11','RR/MM/DD'));
Insert into TRIP2REAP.HOTEL (BO_NO,HOTEL_ADDRESS,HOTEL_LOCAL_CODE,HOTEL_SITE,HOTEL_TEL,HOTEL_REVIEW_SCORE,HOTEL_RANK,HOTEL_OPEN_TIME,HOTEL_CLOSE_TIME,HOTEL_OPTION,CHECK_IN,CHECK_OUT) values ( SEQ_BO_NO.CURRVAL ,'제주특별자치도 제주시 중앙로 304',15,'http://ramadajejucity.com/index.php','064-759-8831',0,4,0,23,'와이파이, 조식, 레스토랑, 세탁, 24시간 리셉션, 수하물 보관, 피트니스, 스파/사우나, 카페, 비즈니스 시설, 주차, 장애인 편의시설, 바/라운지, 주방',14,11);

Insert into TRIP2REAP.IMG_FILE (FILE_NO,BO_NO,ORIGIN_NAME,CHANGE_NAME,FILE_LEVEL,FILE_PATH,FILE_DELETE_YN) values (SEQ_FILE_NO.NEXTVAL , SEQ_BO_NO.CURRVAL ,'라마다제주시티호텔썸네일.jpeg','hotel_thumbnail_202012111104580290.jpeg',1,'/Users/ek/Documents/GitHub/Spring-Project-Trip2Reap/Spring-Final-Trip2Reap/src/main/webapp/resources/buploadFiles/hotel_thumbnail_202012111104580290.jpeg','N');
Insert into TRIP2REAP.IMG_FILE (FILE_NO,BO_NO,ORIGIN_NAME,CHANGE_NAME,FILE_LEVEL,FILE_PATH,FILE_DELETE_YN) values (SEQ_FILE_NO.NEXTVAL , SEQ_BO_NO.CURRVAL ,'라마다제주시티호텔디테일1.jpeg','hotel_detail_202012111104580308.jpeg',2,'/Users/ek/Documents/GitHub/Spring-Project-Trip2Reap/Spring-Final-Trip2Reap/src/main/webapp/resources/buploadFiles/hotel_detail_202012111104580308.jpeg','N');
Insert into TRIP2REAP.IMG_FILE (FILE_NO,BO_NO,ORIGIN_NAME,CHANGE_NAME,FILE_LEVEL,FILE_PATH,FILE_DELETE_YN) values (SEQ_FILE_NO.NEXTVAL , SEQ_BO_NO.CURRVAL ,'라마다제주시티호텔디테일2.jpeg','hotel_detail_202012111104580318.jpeg',2,'/Users/ek/Documents/GitHub/Spring-Project-Trip2Reap/Spring-Final-Trip2Reap/src/main/webapp/resources/buploadFiles/hotel_detail_202012111104580318.jpeg','N');
Insert into TRIP2REAP.IMG_FILE (FILE_NO,BO_NO,ORIGIN_NAME,CHANGE_NAME,FILE_LEVEL,FILE_PATH,FILE_DELETE_YN) values (SEQ_FILE_NO.NEXTVAL , SEQ_BO_NO.CURRVAL ,'라마다제주시티호텔디테일3.jpeg','hotel_detail_202012111104580328.jpeg',2,'/Users/ek/Documents/GitHub/Spring-Project-Trip2Reap/Spring-Final-Trip2Reap/src/main/webapp/resources/buploadFiles/hotel_detail_202012111104580328.jpeg','N');
Insert into TRIP2REAP.IMG_FILE (FILE_NO,BO_NO,ORIGIN_NAME,CHANGE_NAME,FILE_LEVEL,FILE_PATH,FILE_DELETE_YN) values (SEQ_FILE_NO.NEXTVAL , SEQ_BO_NO.CURRVAL ,'라마다제주시티호텔디테일4.jpeg','hotel_detail_202012111104580336.jpeg',2,'/Users/ek/Documents/GitHub/Spring-Project-Trip2Reap/Spring-Final-Trip2Reap/src/main/webapp/resources/buploadFiles/hotel_detail_202012111104580336.jpeg','N');
Insert into TRIP2REAP.IMG_FILE (FILE_NO,BO_NO,ORIGIN_NAME,CHANGE_NAME,FILE_LEVEL,FILE_PATH,FILE_DELETE_YN) values (SEQ_FILE_NO.NEXTVAL , SEQ_BO_NO.CURRVAL ,'라마다제주시티호텔디테일5.jpeg','hotel_detail_202012111104580350.jpeg',2,'/Users/ek/Documents/GitHub/Spring-Project-Trip2Reap/Spring-Final-Trip2Reap/src/main/webapp/resources/buploadFiles/hotel_detail_202012111104580350.jpeg','N');
Insert into TRIP2REAP.IMG_FILE (FILE_NO,BO_NO,ORIGIN_NAME,CHANGE_NAME,FILE_LEVEL,FILE_PATH,FILE_DELETE_YN) values (SEQ_FILE_NO.NEXTVAL , SEQ_BO_NO.CURRVAL ,'라마다제주시티호텔디테일6.jpeg','hotel_detail_202012111104580360.jpeg',2,'/Users/ek/Documents/GitHub/Spring-Project-Trip2Reap/Spring-Final-Trip2Reap/src/main/webapp/resources/buploadFiles/hotel_detail_202012111104580360.jpeg','N');
Insert into TRIP2REAP.IMG_FILE (FILE_NO,BO_NO,ORIGIN_NAME,CHANGE_NAME,FILE_LEVEL,FILE_PATH,FILE_DELETE_YN) values (SEQ_FILE_NO.NEXTVAL , SEQ_BO_NO.CURRVAL ,'라마다제주시티호텔썸네일.jpeg','hotel_detail_202012111104580372.jpeg',2,'/Users/ek/Documents/GitHub/Spring-Project-Trip2Reap/Spring-Final-Trip2Reap/src/main/webapp/resources/buploadFiles/hotel_detail_202012111104580372.jpeg','N');

Insert into TRIP2REAP.ROOM (ROOM_NO,BO_NO,ROOM_TYPE,ROOM_NAME,PRICE_PER_DAY) values ( SEQ_ROOM_NO.NEXTVAL , SEQ_BO_NO.CURRVAL ,'더블룸','스탠다드 더블룸',49600);
Insert into TRIP2REAP.ROOM (ROOM_NO,BO_NO,ROOM_TYPE,ROOM_NAME,PRICE_PER_DAY) values ( SEQ_ROOM_NO.NEXTVAL , SEQ_BO_NO.CURRVAL ,'스탠다드룸','스탠다드 더블룸',49600);
Insert into TRIP2REAP.ROOM (ROOM_NO,BO_NO,ROOM_TYPE,ROOM_NAME,PRICE_PER_DAY) values ( SEQ_ROOM_NO.NEXTVAL , SEQ_BO_NO.CURRVAL ,'트윈룸','스탠다드 트윈룸',52000);
Insert into TRIP2REAP.ROOM (ROOM_NO,BO_NO,ROOM_TYPE,ROOM_NAME,PRICE_PER_DAY) values ( SEQ_ROOM_NO.NEXTVAL , SEQ_BO_NO.CURRVAL ,'스탠다드룸','스탠다드 트윈룸',52000);
Insert into TRIP2REAP.ROOM (ROOM_NO,BO_NO,ROOM_TYPE,ROOM_NAME,PRICE_PER_DAY) values ( SEQ_ROOM_NO.NEXTVAL , SEQ_BO_NO.CURRVAL ,'디럭스룸','디럭스 패밀리룸',61800);
Insert into TRIP2REAP.ROOM (ROOM_NO,BO_NO,ROOM_TYPE,ROOM_NAME,PRICE_PER_DAY) values ( SEQ_ROOM_NO.NEXTVAL , SEQ_BO_NO.CURRVAL ,'패밀리룸','디럭스 패밀리룸',61800);



--58
Insert into TRIP2REAP.BOARD (BO_NO,CA_CODE,BO_TITLE,BO_CONTENT,MEMBER_ID,BO_COUNT,BO_TAG,BO_DELETE_YN,REGDATE) values (SEQ_BO_NO.NEXTVAL ,5,'메종 글래드 제주','40여 년의 역사와 전통을 자랑하는 메종 글래드 제주는 제주 관광의 랜드마크로서 제주 고유의 매력을 경험할 수 있는 호텔입니다. 제주 국제공항에서 차로 약 10분 거리에 위치하여 교통이 편리하며, 공항과 호텔간 무료 셔틀버스를 이용하실 수 있습니다. 호텔 주변 관광지로는 차로 20분 거리에 용두암, 삼성혈, 민속 자연사 박물관 등이 있습니다. 또한, 두 마리의 조랑말 등대가 유명한 이호테우해변까지는 차로 15분이 소요됩니다. 호텔 내에는 올데이 스위밍을 즐길 수 있는 인피니티 풀과 패밀리 풀, 제주시 최대 규모의 컨벤션홀, 피트니스&사우나 등의 편의 시설을 선보이고 있습니다. 뿐만 아니라 생기 넘치는 에너지를 고스란히 담은 ‘쥴라이 스파’, 세계적인 패션 스타일과 제주 유명 작가 소품의 콜라보레이션을 만날 수 있는 멀티샵 ‘피렌체’, 아베다 정품만을 사용하는 아베다 공식 파트너 헤어 살롱 ‘메종드누보 아베다살롱’, 호텔 침구 및 제주 기념품을 구매할 수 있는 ''글래드샵'' 등 다양한 부대시설을 운영하고 있어 문화생활을 즐길 수 있습니다. 513개의 객실은 스탠다드, 디럭스, 프리미엄, 스위트로 나누어져 있으며 인기 있는 브랜드와 콜라보레이션을 한 객실도 있습니다. 각 객실 내에는 Wi-Fi가 완비되어 있으며 스마트 TV, 미니바, 무료 생수 등이 구비되어 있습니다. 욕실에는 비데, 헤어드라이어, 욕실용품이 구비되어 있습니다. 제주의 맛집으로 정평 난 프리미엄 뷔페레스토랑 ''삼다정'', 고품격 갓포요리 전문 레스토랑 ''갓포아키'', 청담동 앨리스 바에서 새롭게 런칭하는 라운지 바 ‘정글북by앨리스바’, 유기농 우유와 원두를 사용한 ‘1964백미당’ 카페, 베이커리 전문점 ‘카페 아티제’, 풀사이드 바‘자왈'' 이 있어 여러 음식을 맛볼 수 있습니다. 또한, 놀이시설과 최고급 이탈리안 레스토랑이 결합된 프리미엄 키즈 카페 ‘릴리펏’이 있어 가족 여행자가 이용하시기에 좋습니다.','admin',1,'메종글래드, 40년호텔, 명품호텔','N',to_date('20/12/11','RR/MM/DD'));
Insert into TRIP2REAP.HOTEL (BO_NO,HOTEL_ADDRESS,HOTEL_LOCAL_CODE,HOTEL_SITE,HOTEL_TEL,HOTEL_REVIEW_SCORE,HOTEL_RANK,HOTEL_OPEN_TIME,HOTEL_CLOSE_TIME,HOTEL_OPTION,CHECK_IN,CHECK_OUT) values ( SEQ_BO_NO.CURRVAL ,'제주특별자치도 제주시 노연로 80',15,'https://maisongladjeju-hotels.com/web/maison','064-747-4900',0,5,7,21,'와이파이, 조식, 레스토랑, 세탁, 24시간 리셉션, 수하물 보관, 수영장, 피트니스, 스파/사우나, 카페, 비즈니스 시설, 주차, 공항셔틀, 장애인 편의시설, 바/라운지, 주방, 아이돌봄 서비스, 룸서비스',14,12);

Insert into TRIP2REAP.IMG_FILE (FILE_NO,BO_NO,ORIGIN_NAME,CHANGE_NAME,FILE_LEVEL,FILE_PATH,FILE_DELETE_YN) values (SEQ_FILE_NO.NEXTVAL , SEQ_BO_NO.CURRVAL ,'썸네일.jpeg','hotel_thumbnail_202012111125460013.jpeg',1,'/Users/ek/Documents/GitHub/Spring-Project-Trip2Reap/Spring-Final-Trip2Reap/src/main/webapp/resources/buploadFiles/hotel_thumbnail_202012111125460013.jpeg','N');
Insert into TRIP2REAP.IMG_FILE (FILE_NO,BO_NO,ORIGIN_NAME,CHANGE_NAME,FILE_LEVEL,FILE_PATH,FILE_DELETE_YN) values (SEQ_FILE_NO.NEXTVAL , SEQ_BO_NO.CURRVAL ,'디테일1.jpeg','hotel_detail_202012111125460027.jpeg',2,'/Users/ek/Documents/GitHub/Spring-Project-Trip2Reap/Spring-Final-Trip2Reap/src/main/webapp/resources/buploadFiles/hotel_detail_202012111125460027.jpeg','N');
Insert into TRIP2REAP.IMG_FILE (FILE_NO,BO_NO,ORIGIN_NAME,CHANGE_NAME,FILE_LEVEL,FILE_PATH,FILE_DELETE_YN) values (SEQ_FILE_NO.NEXTVAL , SEQ_BO_NO.CURRVAL ,'디테일2.jpeg','hotel_detail_202012111125460053.jpeg',2,'/Users/ek/Documents/GitHub/Spring-Project-Trip2Reap/Spring-Final-Trip2Reap/src/main/webapp/resources/buploadFiles/hotel_detail_202012111125460053.jpeg','N');
Insert into TRIP2REAP.IMG_FILE (FILE_NO,BO_NO,ORIGIN_NAME,CHANGE_NAME,FILE_LEVEL,FILE_PATH,FILE_DELETE_YN) values (SEQ_FILE_NO.NEXTVAL , SEQ_BO_NO.CURRVAL ,'디테일3.jpeg','hotel_detail_202012111125460071.jpeg',2,'/Users/ek/Documents/GitHub/Spring-Project-Trip2Reap/Spring-Final-Trip2Reap/src/main/webapp/resources/buploadFiles/hotel_detail_202012111125460071.jpeg','N');
Insert into TRIP2REAP.IMG_FILE (FILE_NO,BO_NO,ORIGIN_NAME,CHANGE_NAME,FILE_LEVEL,FILE_PATH,FILE_DELETE_YN) values (SEQ_FILE_NO.NEXTVAL , SEQ_BO_NO.CURRVAL ,'디테일4.jpeg','hotel_detail_202012111125460087.jpeg',2,'/Users/ek/Documents/GitHub/Spring-Project-Trip2Reap/Spring-Final-Trip2Reap/src/main/webapp/resources/buploadFiles/hotel_detail_202012111125460087.jpeg','N');
Insert into TRIP2REAP.IMG_FILE (FILE_NO,BO_NO,ORIGIN_NAME,CHANGE_NAME,FILE_LEVEL,FILE_PATH,FILE_DELETE_YN) values (SEQ_FILE_NO.NEXTVAL , SEQ_BO_NO.CURRVAL ,'디테일5.jpeg','hotel_detail_202012111125460094.jpeg',2,'/Users/ek/Documents/GitHub/Spring-Project-Trip2Reap/Spring-Final-Trip2Reap/src/main/webapp/resources/buploadFiles/hotel_detail_202012111125460094.jpeg','N');
Insert into TRIP2REAP.IMG_FILE (FILE_NO,BO_NO,ORIGIN_NAME,CHANGE_NAME,FILE_LEVEL,FILE_PATH,FILE_DELETE_YN) values (SEQ_FILE_NO.NEXTVAL , SEQ_BO_NO.CURRVAL ,'디테일6.jpeg','hotel_detail_202012111125460108.jpeg',2,'/Users/ek/Documents/GitHub/Spring-Project-Trip2Reap/Spring-Final-Trip2Reap/src/main/webapp/resources/buploadFiles/hotel_detail_202012111125460108.jpeg','N');
Insert into TRIP2REAP.IMG_FILE (FILE_NO,BO_NO,ORIGIN_NAME,CHANGE_NAME,FILE_LEVEL,FILE_PATH,FILE_DELETE_YN) values (SEQ_FILE_NO.NEXTVAL , SEQ_BO_NO.CURRVAL ,'썸네일.jpeg','hotel_detail_202012111125460116.jpeg',2,'/Users/ek/Documents/GitHub/Spring-Project-Trip2Reap/Spring-Final-Trip2Reap/src/main/webapp/resources/buploadFiles/hotel_detail_202012111125460116.jpeg','N');

Insert into TRIP2REAP.ROOM (ROOM_NO,BO_NO,ROOM_TYPE,ROOM_NAME,PRICE_PER_DAY) values ( SEQ_ROOM_NO.NEXTVAL , SEQ_BO_NO.CURRVAL ,'트윈룸','스탠다드 트윈룸',98200);
Insert into TRIP2REAP.ROOM (ROOM_NO,BO_NO,ROOM_TYPE,ROOM_NAME,PRICE_PER_DAY) values ( SEQ_ROOM_NO.NEXTVAL , SEQ_BO_NO.CURRVAL ,'스탠다드룸','스탠다드 트윈룸',98200);
Insert into TRIP2REAP.ROOM (ROOM_NO,BO_NO,ROOM_TYPE,ROOM_NAME,PRICE_PER_DAY) values ( SEQ_ROOM_NO.NEXTVAL , SEQ_BO_NO.CURRVAL ,'더블룸','스탠다드 더블룸',104800);
Insert into TRIP2REAP.ROOM (ROOM_NO,BO_NO,ROOM_TYPE,ROOM_NAME,PRICE_PER_DAY) values ( SEQ_ROOM_NO.NEXTVAL , SEQ_BO_NO.CURRVAL ,'스탠다드룸','스탠다드 더블룸',104800);
Insert into TRIP2REAP.ROOM (ROOM_NO,BO_NO,ROOM_TYPE,ROOM_NAME,PRICE_PER_DAY) values ( SEQ_ROOM_NO.NEXTVAL , SEQ_BO_NO.CURRVAL ,'트윈룸','디럭스 트윈룸',112200);
Insert into TRIP2REAP.ROOM (ROOM_NO,BO_NO,ROOM_TYPE,ROOM_NAME,PRICE_PER_DAY) values ( SEQ_ROOM_NO.NEXTVAL , SEQ_BO_NO.CURRVAL ,'디럭스룸','디럭스 트윈룸',112200);
Insert into TRIP2REAP.ROOM (ROOM_NO,BO_NO,ROOM_TYPE,ROOM_NAME,PRICE_PER_DAY) values ( SEQ_ROOM_NO.NEXTVAL , SEQ_BO_NO.CURRVAL ,'더블룸','디럭스 더블룸',117500);
Insert into TRIP2REAP.ROOM (ROOM_NO,BO_NO,ROOM_TYPE,ROOM_NAME,PRICE_PER_DAY) values ( SEQ_ROOM_NO.NEXTVAL , SEQ_BO_NO.CURRVAL ,'디럭스룸','디럭스 더블룸',117500);



--59
Insert into TRIP2REAP.BOARD (BO_NO,CA_CODE,BO_TITLE,BO_CONTENT,MEMBER_ID,BO_COUNT,BO_TAG,BO_DELETE_YN,REGDATE) values (SEQ_BO_NO.NEXTVAL ,5,'신라스테이 제주','신라스테이 제주 - <4성급> - 2015년 3월에 오픈한 신라스테이 제주에서 제주국제공항에서 단 3km 거리에 있습니다. 호텔 주변 관광지로는 도보 1분 거리에 바오젠 거리, 차로 15분 거리에 이호테우 해변, 차로 20분 거리에 용두암 등이 있습니다. 뿐만 아니라 차로 50분이면 한라산 국립공원까지 가실 수 있습니다. 호텔 내에 다양한 규모의 미팅, 비즈니스 코너, 유/무산소 기구가 완비된 피트니스 센터 등도 있으며 투숙객에게는 비즈니스 코너, 피트니스 센터, 주차장을 무료로 제공하고 있습니다. 전체 301개의 객실을 보유하고 있으며 일부 객실에서는 바다 또는 한라산 전망을 감상하실 수 있습니다. 모든 객실에는 LED TV와 유니버설 어댑터가 있으며 거위 털 이불과 오리털 베개 등을 비롯한 고급 침구가 기분 좋은 숙면을 돕습니다. 욕실에는 아베다 욕실용품, 비데 등이 준비되어 있습니다. 호텔 최고층인 12층에 위치한 카페에서는 제주 바다를 조망하며 조식 뷔페로 즐기실 수 있으며 별도의 요금이 발생합니다. 저녁에는 라운지로 운영되어 맥주와 와인을 판매합니다. 또한, 1층에는 모던한 느낌의 바가 있습니다.','admin',0,'신라호텔, 신라스테이','N',to_date('20/12/11','RR/MM/DD'));
Insert into TRIP2REAP.HOTEL (BO_NO,HOTEL_ADDRESS,HOTEL_LOCAL_CODE,HOTEL_SITE,HOTEL_TEL,HOTEL_REVIEW_SCORE,HOTEL_RANK,HOTEL_OPEN_TIME,HOTEL_CLOSE_TIME,HOTEL_OPTION,CHECK_IN,CHECK_OUT) values ( SEQ_BO_NO.CURRVAL ,'제주특별자치도 제주시 노연로 100',15,'https://www.shillastay.com/jeju/index.do?lang=ko','064-717-9000',0,4,0,23,'와이파이, 조식, 레스토랑, 세탁, 24시간 리셉션, 수하물 보관, 카페, 비즈니스 시설, 주차, 바/라운지, 주방, 룸서비스',15,12);

Insert into TRIP2REAP.IMG_FILE (FILE_NO,BO_NO,ORIGIN_NAME,CHANGE_NAME,FILE_LEVEL,FILE_PATH,FILE_DELETE_YN) values (SEQ_FILE_NO.NEXTVAL , SEQ_BO_NO.CURRVAL ,'썸네일.jpeg','hotel_thumbnail_202012111134090399.jpeg',1,'/Users/ek/Documents/GitHub/Spring-Project-Trip2Reap/Spring-Final-Trip2Reap/src/main/webapp/resources/buploadFiles/hotel_thumbnail_202012111134090399.jpeg','N');
Insert into TRIP2REAP.IMG_FILE (FILE_NO,BO_NO,ORIGIN_NAME,CHANGE_NAME,FILE_LEVEL,FILE_PATH,FILE_DELETE_YN) values (SEQ_FILE_NO.NEXTVAL , SEQ_BO_NO.CURRVAL ,'디테일1.jpeg','hotel_detail_202012111134090410.jpeg',2,'/Users/ek/Documents/GitHub/Spring-Project-Trip2Reap/Spring-Final-Trip2Reap/src/main/webapp/resources/buploadFiles/hotel_detail_202012111134090410.jpeg','N');
Insert into TRIP2REAP.IMG_FILE (FILE_NO,BO_NO,ORIGIN_NAME,CHANGE_NAME,FILE_LEVEL,FILE_PATH,FILE_DELETE_YN) values (SEQ_FILE_NO.NEXTVAL , SEQ_BO_NO.CURRVAL ,'디테일2.jpeg','hotel_detail_202012111134090421.jpeg',2,'/Users/ek/Documents/GitHub/Spring-Project-Trip2Reap/Spring-Final-Trip2Reap/src/main/webapp/resources/buploadFiles/hotel_detail_202012111134090421.jpeg','N');
Insert into TRIP2REAP.IMG_FILE (FILE_NO,BO_NO,ORIGIN_NAME,CHANGE_NAME,FILE_LEVEL,FILE_PATH,FILE_DELETE_YN) values (SEQ_FILE_NO.NEXTVAL , SEQ_BO_NO.CURRVAL ,'디테일3.jpeg','hotel_detail_202012111134090430.jpeg',2,'/Users/ek/Documents/GitHub/Spring-Project-Trip2Reap/Spring-Final-Trip2Reap/src/main/webapp/resources/buploadFiles/hotel_detail_202012111134090430.jpeg','N');
Insert into TRIP2REAP.IMG_FILE (FILE_NO,BO_NO,ORIGIN_NAME,CHANGE_NAME,FILE_LEVEL,FILE_PATH,FILE_DELETE_YN) values (SEQ_FILE_NO.NEXTVAL , SEQ_BO_NO.CURRVAL ,'디테일4.jpeg','hotel_detail_202012111134090439.jpeg',2,'/Users/ek/Documents/GitHub/Spring-Project-Trip2Reap/Spring-Final-Trip2Reap/src/main/webapp/resources/buploadFiles/hotel_detail_202012111134090439.jpeg','N');
Insert into TRIP2REAP.IMG_FILE (FILE_NO,BO_NO,ORIGIN_NAME,CHANGE_NAME,FILE_LEVEL,FILE_PATH,FILE_DELETE_YN) values (SEQ_FILE_NO.NEXTVAL , SEQ_BO_NO.CURRVAL ,'디테일5.jpeg','hotel_detail_202012111134090450.jpeg',2,'/Users/ek/Documents/GitHub/Spring-Project-Trip2Reap/Spring-Final-Trip2Reap/src/main/webapp/resources/buploadFiles/hotel_detail_202012111134090450.jpeg','N');
Insert into TRIP2REAP.IMG_FILE (FILE_NO,BO_NO,ORIGIN_NAME,CHANGE_NAME,FILE_LEVEL,FILE_PATH,FILE_DELETE_YN) values (SEQ_FILE_NO.NEXTVAL , SEQ_BO_NO.CURRVAL ,'디테일6.jpeg','hotel_detail_202012111134090460.jpeg',2,'/Users/ek/Documents/GitHub/Spring-Project-Trip2Reap/Spring-Final-Trip2Reap/src/main/webapp/resources/buploadFiles/hotel_detail_202012111134090460.jpeg','N');
Insert into TRIP2REAP.IMG_FILE (FILE_NO,BO_NO,ORIGIN_NAME,CHANGE_NAME,FILE_LEVEL,FILE_PATH,FILE_DELETE_YN) values (SEQ_FILE_NO.NEXTVAL , SEQ_BO_NO.CURRVAL ,'디테일7.jpeg','hotel_detail_202012111134090471.jpeg',2,'/Users/ek/Documents/GitHub/Spring-Project-Trip2Reap/Spring-Final-Trip2Reap/src/main/webapp/resources/buploadFiles/hotel_detail_202012111134090471.jpeg','N');
Insert into TRIP2REAP.IMG_FILE (FILE_NO,BO_NO,ORIGIN_NAME,CHANGE_NAME,FILE_LEVEL,FILE_PATH,FILE_DELETE_YN) values (SEQ_FILE_NO.NEXTVAL , SEQ_BO_NO.CURRVAL ,'썸네일.jpeg','hotel_detail_202012111134090481.jpeg',2,'/Users/ek/Documents/GitHub/Spring-Project-Trip2Reap/Spring-Final-Trip2Reap/src/main/webapp/resources/buploadFiles/hotel_detail_202012111134090481.jpeg','N');

Insert into TRIP2REAP.ROOM (ROOM_NO,BO_NO,ROOM_TYPE,ROOM_NAME,PRICE_PER_DAY) values ( SEQ_ROOM_NO.NEXTVAL , SEQ_BO_NO.CURRVAL ,'더블룸','스탠다드 더블룸',86500);
Insert into TRIP2REAP.ROOM (ROOM_NO,BO_NO,ROOM_TYPE,ROOM_NAME,PRICE_PER_DAY) values ( SEQ_ROOM_NO.NEXTVAL , SEQ_BO_NO.CURRVAL ,'스탠다드룸','스탠다드 더블룸',86500);
Insert into TRIP2REAP.ROOM (ROOM_NO,BO_NO,ROOM_TYPE,ROOM_NAME,PRICE_PER_DAY) values ( SEQ_ROOM_NO.NEXTVAL , SEQ_BO_NO.CURRVAL ,'더블룸','디럭스 더블룸',103600);
Insert into TRIP2REAP.ROOM (ROOM_NO,BO_NO,ROOM_TYPE,ROOM_NAME,PRICE_PER_DAY) values ( SEQ_ROOM_NO.NEXTVAL , SEQ_BO_NO.CURRVAL ,'디럭스룸','디럭스더블룸',103600);
Insert into TRIP2REAP.ROOM (ROOM_NO,BO_NO,ROOM_TYPE,ROOM_NAME,PRICE_PER_DAY) values ( SEQ_ROOM_NO.NEXTVAL , SEQ_BO_NO.CURRVAL ,'트윈룸','스탠다드 트윈룸',115600);
Insert into TRIP2REAP.ROOM (ROOM_NO,BO_NO,ROOM_TYPE,ROOM_NAME,PRICE_PER_DAY) values ( SEQ_ROOM_NO.NEXTVAL , SEQ_BO_NO.CURRVAL ,'스탠다드룸','스탠다드 트윈룸',115600);


--60
Insert into TRIP2REAP.BOARD (BO_NO,CA_CODE,BO_TITLE,BO_CONTENT,MEMBER_ID,BO_COUNT,BO_TAG,BO_DELETE_YN,REGDATE) values (SEQ_BO_NO.NEXTVAL ,5,'휘슬락 호텔','휘슬락 호텔에서 차로 15분이면 제주국제공항까지 가실 수 있습니다. 차로 약 10분 거리에 제주의 역사를 한눈에 볼 수 있는 제주 삼성혈과 민속 자연사 박물관이 있습니다. 또한 차로 25분이면 도심에서 가장 가까운 해변인 이호테우 해변까지 가실 수 있습니다. 제주에 자리한 이 호텔에는 공용 지역 무료 무선 인터넷 등이 완비되어 있습니다. 또한, 무료 구내 전용 주차장도 제공하고 있으며, 차로 10분만 가시면 제주종합경기장까지 가실 수 있습니다. 이 호텔에서는 리셉션을 24시간 운영하고 있고 회의실, 24시간 비지니스 센터, 테라스도 갖춰져 있습니다. 모든 객실에는 에어컨이 완비되어 있고 고급 린넨, 샤워 시설 및 평면 TV도 갖추고 있습니다. 각 객실에 전용 욕실, 알람시계, 생수 등이 갖춰져 있습니다. 호텔의 고객님들은 내부에 있는 레스토랑에서 식사를 드실 수 있습니다.','admin',0,'휘슬락호텔, 제주바다앞','N',to_date('20/12/11','RR/MM/DD'));
Insert into TRIP2REAP.HOTEL (BO_NO,HOTEL_ADDRESS,HOTEL_LOCAL_CODE,HOTEL_SITE,HOTEL_TEL,HOTEL_REVIEW_SCORE,HOTEL_RANK,HOTEL_OPEN_TIME,HOTEL_CLOSE_TIME,HOTEL_OPTION,CHECK_IN,CHECK_OUT) values ( SEQ_BO_NO.CURRVAL ,'제주특별자치도 제주시 서부두2길 26',15,'http://www.whistlelark.co.kr/','064-795-7000',0,4,0,23,'와이파이, 조식, 레스토랑, 세탁, 24시간 리셉션, 수하물 보관, 수영장, 피트니스, 스파/사우나, 카페, 비즈니스 시설, 주차, 주방',15,11);

Insert into TRIP2REAP.IMG_FILE (FILE_NO,BO_NO,ORIGIN_NAME,CHANGE_NAME,FILE_LEVEL,FILE_PATH,FILE_DELETE_YN) values (SEQ_FILE_NO.NEXTVAL , SEQ_BO_NO.CURRVAL ,'썸네일.jpeg','hotel_thumbnail_202012111144050067.jpeg',1,'/Users/ek/Documents/GitHub/Spring-Project-Trip2Reap/Spring-Final-Trip2Reap/src/main/webapp/resources/buploadFiles/hotel_thumbnail_202012111144050067.jpeg','N');
Insert into TRIP2REAP.IMG_FILE (FILE_NO,BO_NO,ORIGIN_NAME,CHANGE_NAME,FILE_LEVEL,FILE_PATH,FILE_DELETE_YN) values (SEQ_FILE_NO.NEXTVAL , SEQ_BO_NO.CURRVAL ,'썸네일.jpeg','hotel_detail_202012111144050077.jpeg',2,'/Users/ek/Documents/GitHub/Spring-Project-Trip2Reap/Spring-Final-Trip2Reap/src/main/webapp/resources/buploadFiles/hotel_detail_202012111144050077.jpeg','N');
Insert into TRIP2REAP.IMG_FILE (FILE_NO,BO_NO,ORIGIN_NAME,CHANGE_NAME,FILE_LEVEL,FILE_PATH,FILE_DELETE_YN) values (SEQ_FILE_NO.NEXTVAL , SEQ_BO_NO.CURRVAL ,'디테일1.jpeg','hotel_detail_202012111144050085.jpeg',2,'/Users/ek/Documents/GitHub/Spring-Project-Trip2Reap/Spring-Final-Trip2Reap/src/main/webapp/resources/buploadFiles/hotel_detail_202012111144050085.jpeg','N');
Insert into TRIP2REAP.IMG_FILE (FILE_NO,BO_NO,ORIGIN_NAME,CHANGE_NAME,FILE_LEVEL,FILE_PATH,FILE_DELETE_YN) values (SEQ_FILE_NO.NEXTVAL , SEQ_BO_NO.CURRVAL ,'디테일2.jpeg','hotel_detail_202012111144050096.jpeg',2,'/Users/ek/Documents/GitHub/Spring-Project-Trip2Reap/Spring-Final-Trip2Reap/src/main/webapp/resources/buploadFiles/hotel_detail_202012111144050096.jpeg','N');
Insert into TRIP2REAP.IMG_FILE (FILE_NO,BO_NO,ORIGIN_NAME,CHANGE_NAME,FILE_LEVEL,FILE_PATH,FILE_DELETE_YN) values (SEQ_FILE_NO.NEXTVAL , SEQ_BO_NO.CURRVAL ,'디테일3.jpeg','hotel_detail_202012111144050106.jpeg',2,'/Users/ek/Documents/GitHub/Spring-Project-Trip2Reap/Spring-Final-Trip2Reap/src/main/webapp/resources/buploadFiles/hotel_detail_202012111144050106.jpeg','N');
Insert into TRIP2REAP.IMG_FILE (FILE_NO,BO_NO,ORIGIN_NAME,CHANGE_NAME,FILE_LEVEL,FILE_PATH,FILE_DELETE_YN) values (SEQ_FILE_NO.NEXTVAL , SEQ_BO_NO.CURRVAL ,'디테일4.jpeg','hotel_detail_202012111144050114.jpeg',2,'/Users/ek/Documents/GitHub/Spring-Project-Trip2Reap/Spring-Final-Trip2Reap/src/main/webapp/resources/buploadFiles/hotel_detail_202012111144050114.jpeg','N');
Insert into TRIP2REAP.IMG_FILE (FILE_NO,BO_NO,ORIGIN_NAME,CHANGE_NAME,FILE_LEVEL,FILE_PATH,FILE_DELETE_YN) values (SEQ_FILE_NO.NEXTVAL , SEQ_BO_NO.CURRVAL ,'디테일5.jpeg','hotel_detail_202012111144050122.jpeg',2,'/Users/ek/Documents/GitHub/Spring-Project-Trip2Reap/Spring-Final-Trip2Reap/src/main/webapp/resources/buploadFiles/hotel_detail_202012111144050122.jpeg','N');
Insert into TRIP2REAP.IMG_FILE (FILE_NO,BO_NO,ORIGIN_NAME,CHANGE_NAME,FILE_LEVEL,FILE_PATH,FILE_DELETE_YN) values (SEQ_FILE_NO.NEXTVAL , SEQ_BO_NO.CURRVAL ,'디테일6.jpeg','hotel_detail_202012111144050131.jpeg',2,'/Users/ek/Documents/GitHub/Spring-Project-Trip2Reap/Spring-Final-Trip2Reap/src/main/webapp/resources/buploadFiles/hotel_detail_202012111144050131.jpeg','N');
Insert into TRIP2REAP.IMG_FILE (FILE_NO,BO_NO,ORIGIN_NAME,CHANGE_NAME,FILE_LEVEL,FILE_PATH,FILE_DELETE_YN) values (SEQ_FILE_NO.NEXTVAL , SEQ_BO_NO.CURRVAL ,'디테일7.jpeg','hotel_detail_202012111144050140.jpeg',2,'/Users/ek/Documents/GitHub/Spring-Project-Trip2Reap/Spring-Final-Trip2Reap/src/main/webapp/resources/buploadFiles/hotel_detail_202012111144050140.jpeg','N');
Insert into TRIP2REAP.IMG_FILE (FILE_NO,BO_NO,ORIGIN_NAME,CHANGE_NAME,FILE_LEVEL,FILE_PATH,FILE_DELETE_YN) values (SEQ_FILE_NO.NEXTVAL , SEQ_BO_NO.CURRVAL ,'디테일8.jpeg','hotel_detail_202012111144050148.jpeg',2,'/Users/ek/Documents/GitHub/Spring-Project-Trip2Reap/Spring-Final-Trip2Reap/src/main/webapp/resources/buploadFiles/hotel_detail_202012111144050148.jpeg','N');
Insert into TRIP2REAP.IMG_FILE (FILE_NO,BO_NO,ORIGIN_NAME,CHANGE_NAME,FILE_LEVEL,FILE_PATH,FILE_DELETE_YN) values (SEQ_FILE_NO.NEXTVAL , SEQ_BO_NO.CURRVAL ,'디테일9.jpeg','hotel_detail_202012111144050156.jpeg',2,'/Users/ek/Documents/GitHub/Spring-Project-Trip2Reap/Spring-Final-Trip2Reap/src/main/webapp/resources/buploadFiles/hotel_detail_202012111144050156.jpeg','N');
Insert into TRIP2REAP.IMG_FILE (FILE_NO,BO_NO,ORIGIN_NAME,CHANGE_NAME,FILE_LEVEL,FILE_PATH,FILE_DELETE_YN) values (SEQ_FILE_NO.NEXTVAL , SEQ_BO_NO.CURRVAL ,'디테일10.jpeg','hotel_detail_202012111144050165.jpeg',2,'/Users/ek/Documents/GitHub/Spring-Project-Trip2Reap/Spring-Final-Trip2Reap/src/main/webapp/resources/buploadFiles/hotel_detail_202012111144050165.jpeg','N');
Insert into TRIP2REAP.IMG_FILE (FILE_NO,BO_NO,ORIGIN_NAME,CHANGE_NAME,FILE_LEVEL,FILE_PATH,FILE_DELETE_YN) values (SEQ_FILE_NO.NEXTVAL , SEQ_BO_NO.CURRVAL ,'디테일11.jpeg','hotel_detail_202012111144050173.jpeg',2,'/Users/ek/Documents/GitHub/Spring-Project-Trip2Reap/Spring-Final-Trip2Reap/src/main/webapp/resources/buploadFiles/hotel_detail_202012111144050173.jpeg','N');


Insert into TRIP2REAP.ROOM (ROOM_NO,BO_NO,ROOM_TYPE,ROOM_NAME,PRICE_PER_DAY) values ( SEQ_ROOM_NO.NEXTVAL , SEQ_BO_NO.CURRVAL ,'더블룸','헐리우드 더블(금연)',56000);
Insert into TRIP2REAP.ROOM (ROOM_NO,BO_NO,ROOM_TYPE,ROOM_NAME,PRICE_PER_DAY) values ( SEQ_ROOM_NO.NEXTVAL , SEQ_BO_NO.CURRVAL ,'트윈룸','디럭스 트윈룸',65300);
Insert into TRIP2REAP.ROOM (ROOM_NO,BO_NO,ROOM_TYPE,ROOM_NAME,PRICE_PER_DAY) values ( SEQ_ROOM_NO.NEXTVAL , SEQ_BO_NO.CURRVAL ,'디럭스룸','디럭스 트윈룸',65300);
Insert into TRIP2REAP.ROOM (ROOM_NO,BO_NO,ROOM_TYPE,ROOM_NAME,PRICE_PER_DAY) values ( SEQ_ROOM_NO.NEXTVAL , SEQ_BO_NO.CURRVAL ,'디럭스룸','디럭스 패밀리 트윈 오션뷰',86800);
Insert into TRIP2REAP.ROOM (ROOM_NO,BO_NO,ROOM_TYPE,ROOM_NAME,PRICE_PER_DAY) values ( SEQ_ROOM_NO.NEXTVAL , SEQ_BO_NO.CURRVAL ,'패밀리룸','디럭스 패밀리 트윈 오션뷰',86800);
Insert into TRIP2REAP.ROOM (ROOM_NO,BO_NO,ROOM_TYPE,ROOM_NAME,PRICE_PER_DAY) values ( SEQ_ROOM_NO.NEXTVAL , SEQ_BO_NO.CURRVAL ,'디럭스룸','디럭스 패밀리 트윈 마운틴뷰',81300);
Insert into TRIP2REAP.ROOM (ROOM_NO,BO_NO,ROOM_TYPE,ROOM_NAME,PRICE_PER_DAY) values ( SEQ_ROOM_NO.NEXTVAL , SEQ_BO_NO.CURRVAL ,'패밀리룸','디럭스 패밀리 트윈 마운틴뷰',81300);
Insert into TRIP2REAP.ROOM (ROOM_NO,BO_NO,ROOM_TYPE,ROOM_NAME,PRICE_PER_DAY) values ( SEQ_ROOM_NO.NEXTVAL , SEQ_BO_NO.CURRVAL ,'트윈룸','디럭스 패밀리 트윈 마운틴뷰',81300);
Insert into TRIP2REAP.ROOM (ROOM_NO,BO_NO,ROOM_TYPE,ROOM_NAME,PRICE_PER_DAY) values ( SEQ_ROOM_NO.NEXTVAL , SEQ_BO_NO.CURRVAL ,'트윈룸','디럭스 패밀리 트윈 오션뷰',86800);
Insert into TRIP2REAP.ROOM (ROOM_NO,BO_NO,ROOM_TYPE,ROOM_NAME,PRICE_PER_DAY) values ( SEQ_ROOM_NO.NEXTVAL , SEQ_BO_NO.CURRVAL ,'패밀리룸','패밀리 온돌룸',316500);
Insert into TRIP2REAP.ROOM (ROOM_NO,BO_NO,ROOM_TYPE,ROOM_NAME,PRICE_PER_DAY) values ( SEQ_ROOM_NO.NEXTVAL , SEQ_BO_NO.CURRVAL ,'온돌룸','패밀리 온돌룸',316500);

COMMIT;
