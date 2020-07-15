-- 문제11. 춘 기술대학교는 1년에 두번씩 학과별로 학생과 지도교수가
--지도면담을 진행했다. 이를 위해 사용할 학생이름, 학과이름, 담당교수이름으로
--구성되어있는 VIEW를 만드시오.
--이때 지도교수가 없는 학생이 있을 수 있음을 고려하시오.
--(단, 이 VIEW는 단순 SELECT만을 할 경우 학과별로 정렬되어 화면에 보여지게 만드시오.)

--1) STD_PROF_TALK 테이블을 만든다.
CREATE TABLE STD_PROF_TALK
AS
SELECT STUDENT_NAME 학생이름, DEPARTMENT_NAME 학과이름,
        PROFESSOR_NAME 담당교수이름
FROM TB_STUDENT
        JOIN TB_DEPARTMENT USING (DEPARTMENT_NO)
        JOIN TB_PROFESSOR ON (COACH_PROFESSOR_NO=PROFESSOR_NO)
ORDER BY DEPARTMENT_NAME; --학과이름별로 정렬

SELECT * FROM STD_PROF_TALK;

--2) 뷰를 만든다.
CREATE OR REPLACE VIEW VW_지도면담
AS
SELECT *
FROM  STD_PROF_TALK;
