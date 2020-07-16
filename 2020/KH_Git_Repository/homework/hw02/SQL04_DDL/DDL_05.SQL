--문제5 두 테이블에서 컬럼 명이 NO인 것은 기존 타입을 유지하면서 크기는 10으로
-- 컬럼명이 NAME인 것은 마찬가지로 기존타입을 유지하면서 크기는 20으로 변경하시오.

-- 만든테이블: TB_CATEGORY, TB_CLASS_TYPE

--1) TB_CATEGORY 테이블의 NAME컬럼 타입을 유지하고 길이를 20으로한다.
ALTER TABLE TB_CATEGORY MODIFY NAME VARCHAR2(20); --크기 10-> 20으로 변경

--2) TB_CLASS_TYPE 테이블의 NAME컬럼 타입을 유지하고 길이를 20으로한다.
ALTER TABLE TB_CLASS_TYPE MODIFY NAME VARCHAR2(20); -- 10=> 20바이트로 변경

--3) TB_CLASS_TYPE 테이블의 NO컬럼의 타입을 유지하고 길이를 10으로 한다.
ALTER TABLE TB_CLASS_TYPE MODIFY NO VARCHAR2(10); -- 5=> 10바이트로 변경
