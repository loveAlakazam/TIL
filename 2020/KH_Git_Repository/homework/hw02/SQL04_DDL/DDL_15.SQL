--문제15. 춘기술대학교는 매년 수강신청 기간만 되면 특정 인기과목들에 수강신청이
-- 몰려 문제가 되고있다. 최근 3년을 기준으로 수강인원이 가장 많았던 3과목을 찾는 구문을 작성해보시오.

--1) 년도별 수업을 구한다. 년도를 기준으로 내림차순 정렬
SELECT SUBSTR(TERM_NO,1,4) 년도, CLASS_NAME
FROM TB_CLASS
        JOIN TB_GRADE USING(CLASS_NO)
ORDER BY 년도 DESC, CLASS_NAME;

-- 최근 3년을 구한다.
SELECT *
FROM (SELECT DISTINCT SUBSTR(TERM_NO,1,4) 년도
        FROM TB_CLASS
            JOIN TB_GRADE USING(CLASS_NO)
        ORDER BY 년도 DESC)
WHERE ROWNUM<=3;

--2) 최근 5년이내의 수업들을 구한다.(실행 결과 사진과 똑같음)
SELECT CLASS_NO 과목번호, CLASS_NAME 과목이름, COUNT(*) "누적수강생수(명)"
FROM TB_CLASS
        JOIN TB_GRADE USING(CLASS_NO)
WHERE SUBSTR(TERM_NO,1,4) IN (SELECT *
                                FROM (SELECT DISTINCT SUBSTR(TERM_NO,1,4) 년도
                                        FROM TB_CLASS
                                                JOIN TB_GRADE USING(CLASS_NO)
                                        ORDER BY 년도 DESC)
                                WHERE ROWNUM<=5)
GROUP BY CLASS_NO, CLASS_NAME
ORDER BY "누적수강생수(명)" DESC;


--3) 최근3년을 기준의 수업에서 학생수를 구한다.
SELECT CLASS_NO 과목번호, CLASS_NAME 과목이름, COUNT(*) "누적수강생수(명)"
FROM TB_CLASS
        JOIN TB_GRADE USING(CLASS_NO)
WHERE SUBSTR(TERM_NO,1,4) IN (SELECT *
                                FROM (SELECT DISTINCT SUBSTR(TERM_NO,1,4) 년도
                                        FROM TB_CLASS
                                                JOIN TB_GRADE USING(CLASS_NO)
                                        ORDER BY 년도 DESC)
                                WHERE ROWNUM<=3)
GROUP BY CLASS_NO, CLASS_NAME
ORDER BY "누적수강생수(명)" DESC;
