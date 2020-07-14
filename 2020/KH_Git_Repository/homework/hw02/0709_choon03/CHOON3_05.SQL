--문제5. 2004년 2학기에 'C3118100' 과목을 수강한 학생들의 학점을 조회하려고 한다.
-- 학점이 높은 학생부터 표시하고, 학점이 같으면 학번이 낮은 학생부터 표시하는 구문을 작성해라.

SELECT STUDENT_NO, TO_CHAR(POINT,'0.00') --소수점 나타나게끔하기.
FROM TB_GRADE
WHERE CLASS_NO='C3118100' -- C3118100 과목코드인 과목을 수강했다.
        AND TO_NUMBER(SUBSTR(TERM_NO,1,4))=2004  --2004년에 수강
        AND TO_NUMBER(SUBSTR(TERM_NO,5,6))=2 --2학기
ORDER BY POINT DESC; --성적이 높은 순으로
