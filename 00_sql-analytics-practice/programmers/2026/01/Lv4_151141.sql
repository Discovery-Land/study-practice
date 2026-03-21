-- Site   : Programmers
-- Title  : 자동차 대여 기록 별 대여 금액 구하기 (LEVEL 4)
-- Link   : https://school.programmers.co.kr/learn/courses/30/lessons/151141
-- Date   : 2026-01-02 / 2026-03-21 (복습)

-- 1) 서브쿼리 활용 -> 트럭 대여 기록만 추출
WITH TRUCK_RENTAL AS (
    SELECT *
    FROM CAR_RENTAL_COMPANY_RENTAL_HISTORY
    WHERE CAR_ID IN (
        SELECT CAR_ID
        FROM CAR_RENTAL_COMPANY_CAR
        WHERE CAR_TYPE = '트럭'
    )
),
-- 2) DATEDIFF와 CASE 활용 -> 대여 기간 계산 및 DURATION_TYPE 매핑
TRUCK_RENTAL_DUR AS (
    SELECT
        HISTORY_ID,
        CAR_ID,
        DATEDIFF(END_DATE, START_DATE) + 1 AS DATE_DIFF,
        CASE
            WHEN DATEDIFF(END_DATE, START_DATE) + 1 >= 90 THEN '90일 이상'
            WHEN DATEDIFF(END_DATE, START_DATE) + 1 >= 30 THEN '30일 이상'
            WHEN DATEDIFF(END_DATE, START_DATE) + 1 >= 7 THEN '7일 이상'
            ELSE NULL
        END AS DURATION_TYPE
    FROM TRUCK_RENTAL
),
-- 3) 트럭 전용 할인 정책
TRUCK_DISCOUNT AS (
    SELECT *
    FROM CAR_RENTAL_COMPANY_DISCOUNT_PLAN
    WHERE CAR_TYPE = '트럭'
)
SELECT
    TRD.HISTORY_ID,
    CASE
        WHEN TD.DISCOUNT_RATE IS NULL THEN FLOOR(C.DAILY_FEE * TRD.DATE_DIFF)   -- 7일 미만(NULL)인 행 할인 없음
        ELSE FLOOR(C.DAILY_FEE * (1 - TD.DISCOUNT_RATE / 100.0) * TRD.DATE_DIFF) # 할인율을 반전해서 할인된 %를 곱하고 FLOOR로 정수 부분만 출력
    END AS FEE
FROM TRUCK_RENTAL_DUR TRD
LEFT JOIN TRUCK_DISCOUNT TD ON TRD.DURATION_TYPE = TD.DURATION_TYPE
LEFT JOIN CAR_RENTAL_COMPANY_CAR C ON TRD.CAR_ID = C.CAR_ID
ORDER BY FEE DESC, HISTORY_ID DESC;

-- [자동차 대여 기록 별 대여 금액 쿼리 방법]
-- 가독성을 위해 윈도우 함수로 트럭, 기간, 할인정책 테이블 만들기
-- DATEDIFF + 1로 DURATION_TYPE 확인(매칭)
-- 기간 일수 정리된 트럭 렌탈 내용을 할인정책에 LEFT JOIN
-- FLOOR와 금액(1일 대여 비용 * 할인율 * 기간) 구하고 NULL 적용