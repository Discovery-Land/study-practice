-- Site   : Programmers
-- Title  : 어린 동물 찾기 (LEVEL 1)
-- Link   : https://school.programmers.co.kr/learn/courses/30/lessons/59037
-- Date   : 2026-02-27 / 2026-03-01 (수정)

-- SEX_UPON_INTAKE
SELECT 
    ANIMAL_ID,
    NAME
FROM ANIMAL_INS
WHERE SEX_UPON_INTAKE LIKE '%Neutered%'
ORDER BY ANIMAL_ID;

-- 오답

SELECT 
    ANIMAL_ID,
    NAME
FROM ANIMAL_INS
WHERE INTAKE_CONDITION NOT IN ('Aged')
ORDER BY ANIMAL_ID;

-- Neutered은 중성화를 의미 / Aged는 늙은을 의미