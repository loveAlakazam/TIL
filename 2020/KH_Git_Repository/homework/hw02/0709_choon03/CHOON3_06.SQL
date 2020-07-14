--문제6. 학생번호, 학생이름, 학과이름을 학생이름으로 오름차순 정렬하여
-- 출력하는 SQL문을 작성하시오
SELECT STUDENT_NO "학생번호", STUDENT_NAME 학생이름, DEPARTMENT_NAME 학과이름
FROM TB_STUDENT
    JOIN TB_DEPARTMENT USING(DEPARTMENT_NO) --학과테이블 DEPARTMENT와 내부 JOIN
ORDER BY STUDENT_NAME; --학생이름으로 오름차순정렬
