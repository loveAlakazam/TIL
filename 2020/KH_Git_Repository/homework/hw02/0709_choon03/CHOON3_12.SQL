--문제12. 2007년도에 '인간관계론' 과목을 수강한 학생을 찾아
-- 학생이름과 수강학기를 표시하는 SQL문장을 작성하라
--1) 인간관계론 과목의 수강코드와 수강학기를 알아본다.
SELECT DISTINCT CLASS_NO 수강코드, TERM_NO 수강학기
FROM TB_CLASS
        JOIN TB_GRADE USING(CLASS_NO)
WHERE CLASS_NAME='인간관계론' --인간관계론
        AND TO_NUMBER(SUBSTR(TERM_NO,1,4))=2007; --2007년도

--2) ANSWER
SELECT STUDENT_NAME, TERM_NO "TERM_NAME"
FROM TB_STUDENT
        JOIN TB_GRADE USING(STUDENT_NO)
WHERE (CLASS_NO, TERM_NO) IN (SELECT DISTINCT CLASS_NO, TERM_NO
                    FROM TB_CLASS
                            JOIN TB_GRADE USING(CLASS_NO)
                    WHERE CLASS_NAME='인간관계론'
                            AND TO_NUMBER(SUBSTR(TERM_NO,1,4))=2007)
ORDER BY STUDENT_NAME;
