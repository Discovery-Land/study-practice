-- Site   : Programmers
-- Title  : 아픈 동물 찾기 (LEVEL 1)
-- Link   : https://school.programmers.co.kr/learn/courses/30/lessons/59036
-- Date   : 2026-02-27

-- INTAKE_CONDITION Sick
SELECT
    ANIMAL_ID,
    NAME
FROM ANIMAL_INS
WHERE INTAKE_CONDITION = 'Sick';
