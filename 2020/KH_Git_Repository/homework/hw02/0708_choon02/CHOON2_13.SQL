-- 13번. 학과별 휴학생 수를 파악하고자한다.
-- 학과번호와 휴학생 수를 표시하는 SQL문장을 작성하시오

-- 풀이1 => 그러나 휴학생이 없는 학과 표시안됨
--(반례) 학과코드가 002번인 학과는 휴학생이 0명
SELECT DEPARTMENT_NO "학과번호" , COUNT(*)
FROM TB_STUDENT
WHERE ABSENCE_YN='Y'
GROUP BY DEPARTMENT_NO
ORDER BY 1;
