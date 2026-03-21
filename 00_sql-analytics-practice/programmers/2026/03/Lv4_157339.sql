-- Site   : Programmers
-- Title  : 특정 기간동안 대여 가능한 자동차들의 대여비용 구하기 (LEVEL 4)
-- Link   : https://school.programmers.co.kr/learn/courses/30/lessons/157339
-- Date   : 2026-03-09 / 2026-03-21 (복습)

-- CAR_RENTAL_COMPANY_CAR 
-- CAR_ID,      CAR_TYPE,       DAILY_FEE,          OPTIONS
-- 자동차 ID,      자동차 종류,     일일 대여 요금(원),    자동차 옵션 리스트

-- 대여 가능한 자동차는 어떻게 뽑나?
-- 30일간의 대여 금액이 50만원 이상 200만원 미만인 자동차

-- 1번을 먼저 쿼리해서 서브쿼리로 만듬, 그러기 위해선 CAR 테이블에서 세단과 SUV를 IN해주고, 그 내용을 HISTORY 테이블과 JOIN하고,
-- 이 내용을 전부 FROM으로 들고와서 자동차를 뽑으면 

-- 1. 테이블 자동차 종류가 세단 또는 SUV인 자동차를 쿼리로 만든다.
-- 2. 30일간 대여 금액이 50만원 ~ 200만원 미만인 자동차를 뽑는다.

-- SELECT *
-- FROM CAR_RENTAL_COMPANY_RENTAL_HISTORY 

-- 늦잠-시간초과

SELECT
    C.CAR_ID,
    C.CAR_TYPE,
    ROUND(C.DAILY_FEE * 30 * (100 - P.DISCOUNT_RATE) / 100) AS FEE  # 30일 이상 * 할인율을 적용한 총 대여금
FROM CAR_RENTAL_COMPANY_CAR C
JOIN CAR_RENTAL_COMPANY_DISCOUNT_PLAN P
  ON C.CAR_TYPE = P.CAR_TYPE
WHERE C.CAR_TYPE IN ('세단', 'SUV')   # 세단, SUV
  AND P.DURATION_TYPE = '30일 이상'    # 30일 이상
  AND NOT EXISTS (  # 11월 대여 기록이 없는 차 정보 (NOT IN)
      SELECT 1
      FROM CAR_RENTAL_COMPANY_RENTAL_HISTORY H
      WHERE H.CAR_ID = C.CAR_ID
      AND H.START_DATE <= '2022-11-30'
      AND H.END_DATE >= '2022-11-01'
  )
 AND ROUND(C.DAILY_FEE * 30 * (100 - P.DISCOUNT_RATE) / 100) BETWEEN 500000 AND 1999999 # 총 대여금이 50만원 이상 200만원 미만인 금액
 ORDER BY FEE DESC, CAR_TYPE, CAR_ID DESC;