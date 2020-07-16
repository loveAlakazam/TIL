-- 문제9
-- 8번의 결과 중 '인문사회' 계열에 속한 과목의 교수 이름을
-- 찾으려고 한다. 이에 해당하는 과목 이름과 교수 이름을
-- 출력하는 SQL문을 작성해라.

--1) 개설된 과목 이름과 계열을 구한다.
SELECT CLASS_NAME, CATEGORY
FROM TB_CLASS
    JOIN TB_DEPARTMENT USING(DEPARTMENT_NO)
    JOIN TB_CLASS_PROFESSOR USING(CLASS_NO)
    JOIN TB_PROFESSOR USING(PROFESSOR_NO);

--2) 인문사회 계열에 속한 교수이름을 찾는다.
SELECT CLASS_NAME, PROFESSOR_NAME
FROM TB_CLASS
        JOIN TB_CLASS_PROFESSOR USING(CLASS_NO)
        JOIN TB_PROFESSOR USING(PROFESSOR_NO)
WHERE (CLASS_NAME, PROFESSOR_NAME) IN (SELECT CLASS_NAME, PROFESSOR_NAME
                                        FROM TB_CLASS
                                                JOIN TB_DEPARTMENT USING(DEPARTMENT_NO)
                                                JOIN TB_CLASS_PROFESSOR USING(CLASS_NO)
                                                JOIN TB_PROFESSOR USING(PROFESSOR_NO)
                                        WHERE CATEGORY ='인문사회')
;
