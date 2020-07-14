-- 11번: 지도교수를 배정받지 못한 학생수는 몇명 정도 되는지를
-- 알아내는 SQL문을 작성하시오

-- 지도교수번호가 NULL인 학생을 구한다.
SELECT COUNT(*)
FROM TB_STUDENT
WHERE COACH_PROFESSOR_NO IS NULL;
