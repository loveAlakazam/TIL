-- 1. 계열 정보를 저장할 카테고리 테이블을 만들려고한다.
-- 테이블 이름 : TB_CATEGORY
-- 컬럼
--  NAME, VARCHAR2(10)
--  USE_YN, CHAR(1), 기본값은 Y가 들어가도록
CREATE TABLE TB_CATEGORY(
    NAME VARCHAR2(10),
    USE_YN CHAR(1) DEFAULT 'Y'
);
