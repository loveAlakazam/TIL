---문제3. 주소지가 강원도와 경기도인 학생들 중
-- 1900년대 학번을 가진 학생들의 이름과 학번, 주소, 이름을
-- 오름차순으로 나타내시오.
-- 단, 출력헤더는 "학생이름", "학번", "거주지 주소"으로 나타낸다.
SELECT STUDENT_NAME, STUDENT_ADDRESS
FROM TB_STUDENT;

SELECT STUDENT_NAME "학생이름", STUDENT_NO "학번", STUDENT_ADDRESS "거주지 주소"
FROM TB_STUDENT
WHERE (STUDENT_ADDRESS LIKE '강원%' OR  STUDENT_ADDRESS LIKE '경기도%')--주소지가 강원도와 경기도
        AND STUDENT_NO LIKE '9%'; -- 1900년대 학번을 가진학생
