
--문제2. 과목구분을 저장할 테이블을 만들려고한다.
-- 다음과 같은 테이블을 작성하시오
-- 테이블이름: TB_CLASS_TYPE
-- 컬럼
-- NO , VARCHAR2(5), PRIMARY KEY
-- NAME, VARCHAR2(10)

CREATE TABLE TB_CLASS_TYPE(
    NO VARCHAR2(5) PRIMARY KEY,
    NAME VARCHAR2(10)
);
