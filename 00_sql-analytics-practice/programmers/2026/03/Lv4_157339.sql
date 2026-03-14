-- Site   : Programmers
-- Title  : 특정 기간동안 대여 가능한 자동차들의 대여비용 구하기 (LEVEL 4)
-- Link   : https://school.programmers.co.kr/learn/courses/30/lessons/157339
-- Date   : 2026-03-09

-- CAR_RENTAL_COMPANY_CAR 
-- CAR_ID,      CAR_TYPE,       DAILY_FEE,          OPTIONS
-- 자동차 ID,      자동차 종류,     일일 대여 요금(원),    자동차 옵션 리스트

-- 대여 가능한 자동차는 어떻게 뽑나?
-- 30일간의 대여 금액이 50만원 이상 200만원 미만인 자동차

-- 1번을 먼저 쿼리해서 서브쿼리로 만듬, 그러기 위해선 CAR 테이블에서 세단과 SUV를 IN해주고, 그 내용을 HISTORY 테이블과 JOIN하고,
-- 이 내용을 전부 FROM으로 들고와서 자동차를 뽑으면 

-- 1. 테이블 자동차 종류가 세단 또는 SUV인 자동차를 쿼리로 만든다.
-- 2. 30일간 대여 금액이 50만원 ~ 200만원 미만인 자동차를 뽑는다.

SELECT *
FROM CAR_RENTAL_COMPANY_RENTAL_HISTORY 

-- 늦잠-시간초과

select
    c.car_id,
    c.car_type
    daily_fee
from
    car_rental_company_car c
join
    car_rental_company_discount_plan p on c.car_type = p.car_type
where
     .car_type in ('ㅅㅔㄷㅏㄴ', 'suv')