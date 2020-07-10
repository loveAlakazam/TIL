-- 문제8. 춘 기술대학교의 2000년도 이후 입학자들은
-- 학번이 A로 시작하게 되어있다.
-- 2000년도 이전 학번을 받은 학생들의 학번과 이름을 보여주는
-- SQL문장을 작성

SELECT STUDENT_NO, STUDENT_NAME
FROM TB_STUDENT
WHERE STUDENT_NO NOT LIKE 'A%';
