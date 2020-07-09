-- 02학번 전주 거주자들의 모임을 만들려고한다.
-- 휴학한 사람들은 제외한 재학중인 학생들의 학번, 이름, 주민번호를 출력하는 구문을 작성.
SELECT STUDENT_NO 학번, STUDENT_NAME 이름, STUDENT_SSN 주민번호
FROM TB_STUDENT
WHERE ABSENCE_YN='N' --휴학하지 않은 사람들
    AND TO_CHAR(ENTRANCE_DATE,'RR')='02' --02학번- 입학년도가 02년도
    AND STUDENT_ADDRESS LIKE '%전주%'; --전주 거주자
