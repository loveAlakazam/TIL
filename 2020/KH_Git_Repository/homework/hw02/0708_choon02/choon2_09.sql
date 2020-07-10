--문제9. 학번이 A517178 인 한아름 학생의 학점 총 평점을
-- 구하는 SQL문을 작성하시오.
SELECT ROUND(AVG(POINT),1) 평점
FROM TB_GRADE
WHERE STUDENT_NO='A517178';
