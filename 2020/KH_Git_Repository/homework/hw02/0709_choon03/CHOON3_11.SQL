-- 문제11. 학번이 A313047 인 학생이 학교에 나오고 있지 않다
-- 지도교수에게 내용을 전달하기 위한  학과이름/학생이름/ 지도교수 이름이 필요하다.
-- 이때 사용할 SQL문을 작성해라.
SELECT DEPARTMENT_NAME 학과이름, STUDENT_NAME 학생이름, PROFESSOR_NAME 지도교수이름
FROM TB_STUDENT
        JOIN TB_DEPARTMENT USING(DEPARTMENT_NO)
        JOIN TB_PROFESSOR ON (COACH_PROFESSOR_NO=PROFESSOR_NO)
WHERE STUDENT_NO='A313047';
