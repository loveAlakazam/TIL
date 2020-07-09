-- 문제1
-- 영어영문학과(학과코드 002) 학생들의 학번과 이름, 입학년도를 구하여라
-- 입학년도가 빠른 순으로 표시한다.
SELECT STUDENT_NO 학번, STUDENT_NAME 이름, ENTRANCE_DATE 입학년도
FROM TB_STUDENT
WHERE DEPARTMENT_NO='002'
ORDER BY ENTRANCE_DATE;
