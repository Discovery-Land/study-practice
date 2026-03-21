-- =========================================
-- CTE + 윈도우 함수 완전 정리
-- =========================================


-- =========================================
-- 1. 순위 함수 (Ranking Functions)
-- =========================================

-- ROW_NUMBER: 무조건 순번 (동점도 다르게)
ROW_NUMBER() OVER(PARTITION BY dept_id ORDER BY salary DESC) AS rn

-- RANK: 동점 동일 순위 + 다음 순위 건너뜀
RANK() OVER(PARTITION BY dept_id ORDER BY salary DESC) AS rank_num

-- DENSE_RANK: 동점 동일 순위 + 순위 연속
DENSE_RANK() OVER(PARTITION BY dept_id ORDER BY salary DESC) AS dense_rank

-- NTILE: 구간 나누기 (예: 4분위)
NTILE(4) OVER(PARTITION BY region ORDER BY sales DESC) AS sales_quartile



-- =========================================
-- 2. 집계 윈도우 함수
-- =========================================

-- 월별 총합
SUM(sales) OVER(PARTITION BY month) AS monthly_total

-- 누적 평균 (이전 행 포함)
AVG(sales) OVER(
    PARTITION BY product 
    ORDER BY date 
    ROWS UNBOUNDED PRECEDING
) AS moving_avg

-- 고객별 주문 수
COUNT(*) OVER(PARTITION BY customer) AS order_count



-- =========================================
-- 3. 이동 윈도우 함수 (시계열 분석 핵심)
-- =========================================

-- 이전 값
LAG(sales, 1) OVER(PARTITION BY product ORDER BY date) AS prev_sales

-- 다음 값
LEAD(sales, 1) OVER(PARTITION BY product ORDER BY date) AS next_sales

-- 그룹 내 최고값
FIRST_VALUE(sales) OVER(
    PARTITION BY month 
    ORDER BY sales DESC
) AS top_sales



-- =========================================
-- 4. CTE + 윈도우 함수 실전 조합
-- =========================================

WITH analysis AS (
    SELECT 
        product,
        date,
        sales,

        -- 순위
        ROW_NUMBER() OVER(
            PARTITION BY product 
            ORDER BY sales DESC
        ) AS rn,

        RANK() OVER(
            PARTITION BY product 
            ORDER BY sales DESC
        ) AS rk,

        -- 집계
        SUM(sales) OVER(PARTITION BY product) AS total_sales,

        -- 이전 값
        LAG(sales) OVER(
            PARTITION BY product 
            ORDER BY date
        ) AS prev_day

    FROM sales_data
)

-- 상위 3개만
SELECT *
FROM analysis
WHERE rn <= 3;



-- =========================================
-- 5. 재귀 CTE (Recursive CTE)
-- =========================================

WITH RECURSIVE tree AS (
    -- ① 시작 (Anchor)
    SELECT id, parent_id
    FROM category
    WHERE parent_id IS NULL

    UNION ALL

    -- ② 반복 (Recursive)
    SELECT c.id, c.parent_id
    FROM category c
    JOIN tree t ON c.parent_id = t.id
)
SELECT * FROM tree;



-- =========================================
-- 6. 순위 함수 비교
-- =========================================

| 함수           | 동점 처리 | 순위 건너뜀 | 결과 예시 (100,95,95,90) |
|---------------|----------|------------|--------------------------|
| ROW_NUMBER()  | X        | X          | 1,2,3,4                  |
| RANK()        | O        | O          | 1,2,2,4                  |
| DENSE_RANK()  | O        | X          | 1,2,2,3                  |



-- =========================================
-- 7. CTE 핵심 개념
-- =========================================

-- ✔ CTE는 "임시 테이블처럼 보이는 서브쿼리"
-- ✔ 실제로는 대부분 inline 처리됨
-- ✔ 옵티마이저가 재작성 (pushdown 발생 가능)
-- ✔ 실행 순서가 바뀔 수 있음



-- =========================================
-- 8. 실무 패턴 TOP 10
-- =========================================

-- 1. 부서별 급여 1위
ROW_NUMBER() OVER(PARTITION BY dept_id ORDER BY salary DESC) AS rank

-- 2. 월별 매출 TOP 3
ROW_NUMBER() OVER(PARTITION BY sale_month ORDER BY total_sales DESC) AS monthly_rank

-- 3. 고객별 최근 주문
ROW_NUMBER() OVER(PARTITION BY customer_id ORDER BY order_date DESC) AS recent_order

-- 4. 카테고리별 평점 순위
ROW_NUMBER() OVER(PARTITION BY category ORDER BY avg_rating DESC) AS category_rank

-- 5. 팀 순위 (공동 1위 허용)
RANK() OVER(PARTITION BY team_id ORDER BY performance DESC) AS team_rank

-- 6. 연도별 가입자 순위
ROW_NUMBER() OVER(PARTITION BY signup_year ORDER BY new_users DESC) AS yearly_rank

-- 7. 매장 방문자 순위 (동점 유지)
DENSE_RANK() OVER(PARTITION BY store_id ORDER BY visitors DESC) AS store_rank

-- 8. 매출 성장률 순위
ROW_NUMBER() OVER(PARTITION BY product_type ORDER BY sales_growth DESC) AS growth_rank

-- 9. 지역 우선순위 랭킹
ROW_NUMBER() OVER(
    PARTITION BY region 
    ORDER BY is_priority DESC, revenue DESC
) AS region_rank

-- 10. 일별 DAU 순위
ROW_NUMBER() OVER(PARTITION BY activity_date ORDER BY dau DESC) AS daily_rank