--문제7. 춘 기술대학교의 과목이름과 과목의 학과이름을 출력하는
-- SQL문장을 작성하시오.
SELECT CLASS_NAME 과목이름, DEPARTMENT_NAME 학과이름
FROM TB_CLASS
    JOIN TB_DEPARTMENT USING (DEPARTMENT_NO);
