-- Site   : Programmers
-- Title  : 진료과별 총 예약 횟수 출력하기 (LEVEL 2) 
-- Link   : https://school.programmers.co.kr/learn/courses/30/lessons/132202
-- Date   : 2026-01-26 / 2026-03-02 (수정)

-- 2022년 5월에 예약한 환자 수
-- 진료과코드 별로 조회
# SELECT * FROM APPOINTMENT

# SELECT MCDP_CD AS '진료과 코드', COUNT(*) AS '5월예약건수'
# FROM APPOINTMENT 
# WHERE APNT_YMD >= '2022-05-01' AND APNT_YMD < '2022-06-01'
#   AND (APNT_CNCL_YN = 'N' OR APNT_CNCL_YN IS NULL)
# GROUP BY MCDP_CD
# ORDER BY 2, 1;

-- COUNT(PT_NO)

SELECT
    MCDP_CD AS '진료과 코드',
    COUNT(*) AS '5월예약건수'
FROM APPOINTMENT
WHERE DATE_FORMAT(APNT_YMD, '%Y-%m') = '2022-05'
GROUP BY MCDP_CD
ORDER BY 2, 1;

-- ORDER BY SELECT 기준으로 숫자로 표명
-- 프로그래머스는 년월 기준은 DATE_FORMAT 사용이 문제없음
