-- 문제 18. 국어 국문학과에서 총 평점이 가장 높은 학생의 이름과 학번을 표시하는 SQL문
-- 1) 국어국문학과에 속한 학생들의 평점을 조회한다.
SELECT STUDENT_NAME, AVG(POINT)
FROM TB_STUDENT
    JOIN TB_GRADE USING (STUDENT_NO)
    JOIN TB_DEPARTMENT USING(DEPARTMENT_NO)
WHERE DEPARTMENT_NAME='국어국문학과'
GROUP BY STUDENT_NAME -- 학생이름으로 묶어서, 평점평균으로 구한다.
ORDER BY AVG(POINT) DESC; --학생성적을 내림차순으로 조회



--2) ANSWER
SELECT STUDENT_NO, STUDENT_NAME
FROM TB_STUDENT
WHERE STUDENT_NAME=(SELECT STUDENT_NAME
                    FROM (SELECT STUDENT_NAME, AVG(POINT)
                            FROM TB_STUDENT
                                JOIN TB_GRADE USING (STUDENT_NO)
                                JOIN TB_DEPARTMENT USING(DEPARTMENT_NO)
                            WHERE DEPARTMENT_NAME='국어국문학과'
                            GROUP BY STUDENT_NAME
                            ORDER BY AVG(POINT) DESC)
                    WHERE ROWNUM<=1  -- ROWNUM이 1인 데이터로우만 가져온다.
);


-- 정답지
SELECT STUDENT_NO, STUDENT_NAME
FROM TB_STUDENT
  JOIN TB_DEPARTMENT USING (DEPARTMENT_NO)
  JOIN TB_GRADE USING(STUDENT_NO)
WHERE DEPARTMENT_NAME='국어국문학과'
GROUP BY STUDENT_NO, STUDENT_NAME
HAVING AVG(POINT)=( SELECT MAX(AVG(POINT))
                    FROM TB_GRADE
                      JOIN TB_STUDENT USING (STUDENT_NO)
                      JOIN TB_DEPARTMENT USING (DEPARTMENT_NO)
                    WHERE DEPARTMENT_NAME='국어국문학과'
                    GROUP BY STUDENT_NO
                  );



-- 정답지 2
SELECT STUDENT_NO, STUDENT_NAME
FROM (SELECT STUDENT_NO, STUDENT_NAME, AVG(POINT)
      FROM TB_GRADE
           JOIN TB_STUDENT USING(STUDENT_NO)
      WHERE DEPARTMENT_NO = (SELECT DEPARTMENT_NO
                             FROM TB_DEPARTMENT
                             WHERE DEPARTMENT_NAME = '국어국문학과')
      GROUP BY STUDENT_NO, STUDENT_NAME
      ORDER BY AVG(POINT) DESC)
WHERE ROWNUM = 1;




--정답지2번 뜯어보기
SELECT STUDENT_NO, STUDENT_NAME

-- INNER VIEW를 사용.
FROM(SELECT STUDENT_NO, STUDENT_NAME, AVG(POINT)
     FROM TB_GRADE
        JOIN TB_STUDENT USING(STUDENT_NO)

     --국어국문학과 의 학과코드와 일치한 학과코드를 구한다.
     --국어국문학과 학생들중 평균점수 높은순으로 정렬.
     WHERE DEPARTMENT_NO =(SELECT DEPARTMENT_NO
                           FROM TB_DEPARTMENT
                           WHERE DEPARTMENAT_NAME='국어국문학과')
     GROUP BY STUDENT_NO, STUDENT_NAME --STUDENT_NO, STUDENT_NAME으로 기준으로 그룹을 묶는다.
     ORDER BY AVG(POINT) DESC --점수평균을 내림차순으로 한다.
     )
WHERE ROWNUM=1; --가장 첫번째 학생만
