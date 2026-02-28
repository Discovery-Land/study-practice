-- Site   : Programmers
-- Title  : 루시와 엘라 찾기 (LEVEL 2)
-- Link   : https://school.programmers.co.kr/learn/courses/30/lessons/59046
-- Date   : 2026-03-01

SELECT
    ANIMAL_ID,
    NAME,
    SEX_UPON_INTAKE
FROM ANIMAL_INS
WHERE NAME IN ('Lucy', 'Ella', 'Pickle', 'Rogan', 'Sabrina', 'Mitty')
ORDER BY ANIMAL_ID