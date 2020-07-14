-- 문제 17. 춘 기술대학교에 다니고 있는 최경희 학생과 같은과 학생들의 이름과
-- 주소를 출력하는 SQL문을 작성하시오.
--1) 최경희 학생의 학과를 구해보자
SELECT *
FROM TB_STUDENT
WHERE STUDENT_NAME='최경희';

-- ANSWER
--2) 최경희 학생과 같은 학과 친구를 구해보자
SELECT STUDENT_NAME, STUDENT_ADDRESS
FROM TB_STUDENT
WHERE DEPARTMENT_NO =(SELECT DEPARTMENT_NO
                      FROM TB_STUDENT
                      WHERE STUDENT_NAME='최경희');
