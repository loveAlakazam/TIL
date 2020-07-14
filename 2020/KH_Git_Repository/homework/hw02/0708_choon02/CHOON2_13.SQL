-- 13번. 학과별 휴학생 수를 파악하고자한다.
-- 학과번호와 휴학생 수를 표시하는 SQL문장을 작성하시오

-- 풀이1 => 그러나 휴학생이 없는 학과 표시안됨
--(반례) 학과코드가 002번인 학과는 휴학생이 0명
SELECT DEPARTMENT_NO "학과번호" , COUNT(*)
FROM TB_STUDENT
WHERE ABSENCE_YN='Y'
GROUP BY DEPARTMENT_NO
ORDER BY 1;

--풀이2(실제 답)
SELECT DEPARTMENT_NO "학과번호",
    COUNT(DECODE(ABSENCE_YN,'Y',1)) "휴학생 수"
FROM TB_STUDENT
GROUP BY DEPARTMENT_NO
ORDER BY 1;


SELECT DEPARTMENT_NO "학과번호",
    COUNT(DECODE(ABSENCE_YN,'Y',1)) "휴학생 수" -- 휴학여부가 Y일때 1로 한다.
    --주의: COUNT(DECODE(ABSENCE_YN,'Y',1,0)) => COUNT(*) 결과와 동일하게된다.
FROM TB_STUDENT
GROUP BY DEPARTMENT_NO
ORDER BY 1;
