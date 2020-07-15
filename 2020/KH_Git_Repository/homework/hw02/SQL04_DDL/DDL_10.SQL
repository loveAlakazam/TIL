--문제10. 춘 기술대학교 학생들의 정보만이 포함되어있는
-- 학생 일반정보 VIEW를 만들고자 한다.
-- 아래 내용을 참고하여 적절한 SQL문을 작성해라.

-- 뷰이름: VW_학생일반정보
-- 컬럼: 학번/학생이름/주소

-- (초기 뷰 생성권한 부여)
-- SYSTEM 계정으로부터 CREATE VIEW 권한을 받는다. =>
GRANT CREATE VIEW TO CHOON;

--1) 뷰생성
CREATE OR REPLACE VIEW VW_학생일반정보
AS
SELECT STUDENT_NO "학번", STUDENT_NAME "학생이름", STUDENT_ADDRESS "주소"
FROM TB_STUDENT;

--2) 생성한 VIEW 확인
SELECT * FROM VW_학생일반정보;
