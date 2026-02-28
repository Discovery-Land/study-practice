-- Site   : Programmers
-- Title  : 식품분류별 가장 비싼 식품의 정보 조회하기 (LEVEL 4)
-- Link   : https://school.programmers.co.kr/learn/courses/30/lessons/131116
-- Date   : 2026-02-07 / 2026-03-01 (수정)

-- 식품분류별로 가격이 제일 비싼 식품
-- 식품의 분류, 가격, 이름 조회
-- 과자, 국, 김치, 식용유
-- 식품 가격을 기준 DESC

SELECT
    CATEGORY,
    MAX(PRICE) MAX_PRICE,
    PRODUCT_NAME
FROM FOOD_PRODUCT
GROUP BY CATEGORY
HAVING CATEGORY IN ('과자', '국', '김치', '식용유')
ORDER BY PRICE DESC;

-- HAVING으로 안됨 -> 서브쿼리 GROUP BY 규칙

SELECT CATEGORY, PRICE AS MAX_PRICE, PRODUCT_NAME
FROM FOOD_PRODUCT
WHERE (CATEGORY, PRICE) IN (
    SELECT CATEGORY, MAX(PRICE)
    FROM FOOD_PRODUCT
    WHERE CATEGORY IN ('과자', '국', '김치', '식용유')
    GROUP BY CATEGORY
)
ORDER BY PRICE DESC;

-- GROUP_CONCAT 사용법

SELECT 
    CATEGORY,
    MAX(PRICE) MAX_PRICE,
    SUBSTRING_INDEX(GROUP_CONCAT(PRODUCT_NAME ORDER BY PRICE DESC), ',', 1) AS PRODUCT_NAME
FROM FOOD_PRODUCT
WHERE CATEGORY IN ('과자','국','김치','식용유')
GROUP BY CATEGORY
ORDER BY MAX_PRICE DESC;

-- 숙지 필요