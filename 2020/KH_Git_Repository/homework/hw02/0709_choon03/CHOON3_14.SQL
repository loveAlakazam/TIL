--문제14. 춘기술대학교 서반아어학과 학생들의 지도교수를 게시하고자한다.
-- 학생이름과 지도교수 이름을 찾고
-- 만일 지도교수가 없는 학생일 경우, "지도교수 미지정"으로 표시하도록 하는 SQL문을 작성하시오.

SELECT STUDENT_NAME 학생이름, NVL(PROFESSOR_NAME, '지도교수 미지정') 지도교수
FROM TB_STUDENT
        JOIN TB_DEPARTMENT USING (DEPARTMENT_NO)
        JOIN TB_PROFESSOR ON (COACH_PROFESSOR_NO= PROFESSOR_NO)
WHERE DEPARTMENT_NAME='서반아어학과';
