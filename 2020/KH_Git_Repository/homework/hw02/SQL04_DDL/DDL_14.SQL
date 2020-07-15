-- 문제14. 13번에서와 같이 VIEW를 통해서 데이터가 변경될 수
-- 있는 상황을 막으려면 VIEW를 어떻게 생성해야하는지 작성하시오.
-- READ ONLY로 한다.
CREATE OR REPLACE VIEW VW_학생일반정보 --OR REPLACE: 뷰를 덮어쓸 수 있다.
AS
SELECT STUDENT_NO "학번", STUDENT_NAME "학생이름", STUDENT_ADDRESS "주소"
FROM TB_STUDENT
WITH READ ONLY;

--다시 데이터로우 1개를 수정해보자 (13번문제와 동일)
UPDATE VW_학생일반정보
SET 학생이름='최은강'
WHERE 학번='A213046';
--SQL 오류: ORA-42399: cannot perform a DML operation on a read-only view
--42399.0000 - "cannot perform a DML operation on a read-only view"
