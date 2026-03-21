-- =========================================
-- PostgreSQL 실무 쿼리 치트시트
-- =========================================
-- 작성 목적:
-- ✔ 실무에서 자주 쓰는 핵심 기능 정리
-- ✔ 가독성 + 바로 사용 가능
-- ✔ 최신 SQL 패턴 포함
-- =========================================



-- =========================================
-- 1. FILTER (조건부 집계)
-- =========================================

SELECT
    COUNT(*) AS total,
    COUNT(*) FILTER (WHERE gender = 'M') AS male_cnt,
    COUNT(*) FILTER (WHERE gender = 'F') AS female_cnt
FROM users;



-- =========================================
-- 2. WINDOW FRAME (롤링 계산)
-- =========================================

SELECT
    product,
    date,
    sales,

    -- 최근 3일 합계
    SUM(sales) OVER (
        PARTITION BY product
        ORDER BY date
        ROWS BETWEEN 2 PRECEDING AND CURRENT ROW
    ) AS rolling_3day_sum

FROM sales;



-- =========================================
-- 3. JSON 처리 (핵심 ⭐)
-- =========================================

-- JSON 값 추출
SELECT
    data->>'name' AS name,
    data->>'age' AS age
FROM users;

-- JSON 배열 펼치기
SELECT
    json_array_elements('[1,2,3]'::json) AS value;



-- =========================================
-- 4. UPSERT (중복 처리)
-- =========================================

INSERT INTO users (id, name)
VALUES (1, 'kim')
ON CONFLICT (id)
DO UPDATE SET
    name = EXCLUDED.name;



-- =========================================
-- 5. LATERAL JOIN (행별 서브쿼리)
-- =========================================

SELECT
    u.id,
    o.latest_order_date
FROM users u
LEFT JOIN LATERAL (
    SELECT
        order_date AS latest_order_date
    FROM orders o
    WHERE o.user_id = u.id
    ORDER BY order_date DESC
    LIMIT 1
) o ON TRUE;



-- =========================================
-- 6. DISTINCT ON (Top 1 추출)
-- =========================================

SELECT DISTINCT ON (product)
    product,
    sales
FROM sales
ORDER BY product, sales DESC;



-- =========================================
-- 7. ARRAY_AGG (배열 집계)
-- =========================================

SELECT
    customer_id,
    ARRAY_AGG(product_name) AS product_list
FROM orders
GROUP BY customer_id;



-- =========================================
-- 8. JSON_AGG (JSON 집계)
-- =========================================

SELECT
    customer_id,
    json_agg(product_name) AS product_json
FROM orders
GROUP BY customer_id;



-- =========================================
-- 9. GENERATE_SERIES (데이터 생성)
-- =========================================

-- 숫자 생성
SELECT generate_series(1, 10);

-- 날짜 생성
SELECT generate_series(
    '2025-01-01'::date,
    '2025-01-10'::date,
    interval '1 day'
);



-- =========================================
-- 10. MATERIALIZED VIEW (성능 최적화)
-- =========================================

CREATE MATERIALIZED VIEW mv_sales AS
SELECT
    product,
    SUM(sales) AS total_sales
FROM sales
GROUP BY product;

-- 갱신
REFRESH MATERIALIZED VIEW mv_sales;



-- =========================================
-- 11. PERCENTILE (중앙값, 분위수)
-- =========================================

SELECT
    PERCENTILE_CONT(0.5) 
    WITHIN GROUP (ORDER BY salary) AS median_salary
FROM employees;



-- =========================================
-- 12. STRING_AGG (문자열 집계)
-- =========================================

SELECT
    dept_id,
    STRING_AGG(name, ',' ORDER BY name) AS members
FROM employees
GROUP BY dept_id;



-- =========================================
-- 13. WITH + CTE 실전 패턴
-- =========================================

WITH ranked AS (
    SELECT
        product,
        sales,
        ROW_NUMBER() OVER(
            PARTITION BY product
            ORDER BY sales DESC
        ) AS rn
    FROM sales
)
SELECT *
FROM ranked
WHERE rn = 1;



-- =========================================
-- 14. 윈도우 + 누적합
-- =========================================

SELECT
    date,
    SUM(sales) OVER (
        ORDER BY date
        ROWS UNBOUNDED PRECEDING
    ) AS cumulative_sales
FROM sales;



-- =========================================
-- 15. CASE + 실무 패턴
-- =========================================

SELECT
    user_id,
    CASE
        WHEN age < 20 THEN '10대'
        WHEN age < 30 THEN '20대'
        ELSE '30대 이상'
    END AS age_group
FROM users;



-- =========================================
-- 핵심 요약
-- =========================================

-- ✔ FILTER → 조건 집계
-- ✔ JSON → 로그 / API 필수
-- ✔ UPSERT → 중복 처리
-- ✔ LATERAL → 최신 1건
-- ✔ DISTINCT ON → Top N
-- ✔ ARRAY_AGG / JSON_AGG → 데이터 묶기
-- ✔ GENERATE_SERIES → 테스트/날짜
-- ✔ MATERIALIZED VIEW → 성능
-- ✔ WINDOW → 분석 핵심