-- Site   : Programmers
-- Title  : 취소되지 않은 진료 예약 조회하기 (LEVEL 4)
-- Link   : https://school.programmers.co.kr/learn/courses/30/lessons/131124
-- Date   : 2026-03-12

SELECT
A.APNT_NO,
P.PT_NAME,
P.PT_NO,
A.MCDP_CD,
DR_NAME,
A.APNT_YMD
FROM
APPOINTMENT A
JOIN DoCTOR D ON A.MDDR_ID = D.DR_ID

-- 시간초과