-- 15번
-- 학번이 A112113인 김고운 학생의 년도, 학기별 평점과,
-- 년도별 누적 평점, 총 평점을 구하는 SQL문을 작성하시오
-- (단, 평점은 소수점 1자리까지만 반올림하여 표시한다)

-- ROLLUP 이용한다.
-- NULL이면 빈칸으로 변환시킨다.
SELECT NVL(SUBSTR(TERM_NO,1,4),' ') 년도, NVL(SUBSTR(TERM_NO,5,6),' ') 학기, ROUND(AVG(POINT),1) 평점
FROM TB_GRADE
WHERE STUDENT_NO='A112113'
GROUP BY ROLLUP(SUBSTR(TERM_NO,1,4), SUBSTR(TERM_NO,5,6));
