-- 문제1. 학생이름과 주소지를 표시하시오.
-- 단, 출력헤더는 "학생이름", "주소지"라고 하고
-- 정렬은 이름으로 오름차순 표시하도록 한다.
SELECT STUDENT_NAME "학생 이름", STUDENT_ADDRESS 주소지
FROM TB_STUDENT
ORDER BY "학생 이름";
