-- 14번
-- 춘대학교에 다니는 동명이인 학생들의 이름을 찾고자한다
SELECT STUDENT_NAME 동일이름, COUNT(*) "동명인 수"
FROM TB_STUDENT
GROUP BY STUDENT_NAME
HAVING COUNT(*)>1 --동명인수가 2명이상인가?
ORDER BY 1; --이름 오름차순
