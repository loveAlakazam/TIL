-- 동명 동물 수 찾기
SELECT NAME, COUNT(*) AS COUNT
FROM ANIMAL_INS
WHERE NAME IS NOT NULL --이름이 없는 동물은 집계에서 제외.
GROUP BY NAME -- 이름을 기준으로 그룹화
HAVING COUNT(*)>=2 -- 이름이 2번이상 쓰임.
ORDER BY NAME;
