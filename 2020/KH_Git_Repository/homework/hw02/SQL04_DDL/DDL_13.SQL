--문제13. 위에서 생성한 학생일반정보 View를 통해서
-- 학번이 A213046인 학생의 이름을 본인의 이름으로 변경하는 SQL문으로 작성하시오.

--1) 학번이 A213046인 학생의 이름 조회=> 서가람
SELECT 학생이름
FROM VW_학생일반정보
WHERE 학번='A213046';

--2) 이름을 '서가람'=> '최은강' 으로 변경 (데이터로우 변경)
UPDATE VW_학생일반정보
SET 학생이름='최은강'
WHERE 학번='A213046';

--3) VW_학생일반정보, TB_STUDENT에서 학번이 A213046 인 학생을 보자.
SELECT 학생이름
FROM VW_학생일반정보
WHERE 학번='A213046'; --최은강

SELECT STUDENT_NAME
FROM TB_STUDENT
WHERE STUDENT_NO='A213046'; --최은강

ROLLBACK; --ROLLBACK을 하여 복원한다.(최은강->서가람)으로 롤백.
