-- Site   : Programmers
-- Title  : 월별 잡은 물고기 수 구하기 (LEVEL 3)
-- Link   : https://school.programmers.co.kr/learn/courses/30/lessons/293260
-- Date   : 2026-01-18 / 2026-03-01 (수정)


SELECT
    COUNT(*) AS FISH_COUNT,
    MONTH(FISH_TYPE) AS MONTH
FROM FISH_INFO
WHERE MONTH(FISH_TYPE) IS NOT NULL
GROUP BY FISH_TYPE
ORDER BY MONTH;

-- 복기 필요

SELECT 
    COUNT(*) FISH_COUNT,
    MONTH(TIME) MONTH
FROM FISH_INFO
GROUP BY MONTH(TIME)
ORDER BY MONTH(TIME);

-- 여기서 NULL은 물고기가 없는 것이 아니라 10cm 이하인 경우라고 지침되어 있기 때문에 NOT NULL 하면 안됨