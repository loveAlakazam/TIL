
-- 4. 교수들의 이름 중 성을 제외한 이름만 출력하는 SQL문장을 작성
-- 출력헤더는 "이름"이 찍히도록한다
-- 성이 2자인 경우 교수는 없다고 가정.
SELECT SUBSTR(PROFESSOR_NAME,2) 이름
FROM TB_PROFESSOR;
