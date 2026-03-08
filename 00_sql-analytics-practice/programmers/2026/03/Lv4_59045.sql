-- Site   : Programmers
-- Title  : 보호소에서 중성화한 동물 (LEVEL 4)
-- Link   : https://school.programmers.co.kr/learn/courses/30/lessons/59045
-- Date   : 2026-03-09

SELECT 
    AI.ANIMAL_ID,
    AI.ANIMAL_TYPE,
    AI.NAME
FROM ANIMAL_INS AI
JOIN ANIMAL_OUTS AO ON AI.ANIMAL_ID = AO.ANIMAL_ID 
WHERE AI.SEX_UPON_INTAKE LIKE ('Intact%')
    AND AO.SEX_UPON_OUTCOME NOT LIKE ('Intact%')
ORDER BY ANIMAL_ID ASC;

-- 1시간