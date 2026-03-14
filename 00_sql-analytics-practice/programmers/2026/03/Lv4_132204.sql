-- Site   : Programmers
-- Title  : 취소되지 않은 진료 예약 조회하기 (LEVEL 4)
-- Link   : https://school.programmers.co.kr/learn/courses/30/lessons/131124
-- Date   : 2026-03-04

-- 모바일로 풀이시 소문자로 작성.

SELECT
    A.APNT_NO,
    P.PT_NAME,
    A.PT_NO,
    A.MCDP_CD,
    D.DR_NAME,
    A.APNT_YMD
FROM APPOINTMENT A
JOIN PATIENT P ON A.PT_NO = P.PT_NO
JOIN DOCTOR D ON A.MDDR_ID = D.DR_ID
WHERE DATE(A.APNT_YMD) = '2022-04-13'
    AND A.MCDP_CD = 'CS'
    AND A.APNT_CNCL_YN = 'N'
ORDER BY A.APNT_YMD;

-- 테이블이 3개 이상일시 기준테이블 FROM
-- 출력에 필요한 컬럼,테이블 관계 정립하여 JOIN
-- 조건 넣기 WHERE

-- 복습 필요
