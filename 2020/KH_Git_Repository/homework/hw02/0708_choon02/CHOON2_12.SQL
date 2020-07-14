-- 12번. 학번이 A112113인 김고운 학생의 년도별 평점을 구하는 SQL문을 작성
-- 단,헤더는 "년도", "년도별 평점" 이라고 출력.
-- 점수는 반올림하여, 소수점 이하 한자리까지만 표시

-- 년도만 구하기
SELECT TERM_NO, TO_CHAR(TO_DATE(TERM_NO,'RRMM'), 'YYYY') 년도
FROM TB_GRADE
WHERE STUDENT_NO='A112113';


-- ANSWER
-- 년도를 그룹으로하여 평점을 구한다.
-- ROUND(TARGET-COLUMN , 1) => 소수점 아래 2번째자리에서 반올림.
SELECT TO_CHAR(TO_DATE(TERM_NO, 'RRMM'), 'YYYY') 년도, ROUND(AVG(POINT),1) "년도별 평점"
FROM TB_GRADE
WHERE STUDENT_NO='A112113'
GROUP BY TO_CHAR(TO_DATE(TERM_NO, 'RRMM'), 'YYYY');
