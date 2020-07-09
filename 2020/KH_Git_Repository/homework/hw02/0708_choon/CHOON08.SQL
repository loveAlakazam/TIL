-- 문제8
-- 수강신청을 하려고한다. 선수 과목 여부를 확인해야하는데
-- 선수과목이 존재하는 과목들은 어떤과목인지 과목번호를 조회해보시오.

-- 선수과목번호 컬럼: PREATTENDING_CLASS_NO (NULLABLE)
-- 선수과목이 존재한다면, 그 선수과목이 어떤과목인지 과목번호를 조회
SELECT CLASS_NO
FROM TB_CLASS
WHERE PREATTENDING_CLASS_NO IS NOT NULL;
