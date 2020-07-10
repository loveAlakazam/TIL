--문제10. 학과별 학생수를 구하여 "학과번호", "학생수(명)"의
-- 형태로 헤더를 만들어 결과값을 출력하시오.
SELECT DEPARTMENT_NO 학과번호, COUNT(*) "학생수(명)"
FROM TB_STUDENT
GROUP BY DEPARTMENT_NO
ORDER BY DEPARTMENT_NO;
