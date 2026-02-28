-- Site   : Programmers
-- Title  : 언어별 개발자 분류하기 (LEVEL 4)
-- Link   : https://school.programmers.co.kr/learn/courses/30/lessons/276036
-- Date   : 2026-02-26

-- A : Front End 스킬과 Python 스킬을 함께 가지고 있는 개발자
--  # CATEGORY가 Front End인 2진코드
-- B : C# 스킬을 가진 개발자
--  # CODE 1024
-- # C : 그 외의 Front End 개발자
--  # AND THEN CATEGORY Front End

SELECT # GROUP_CONCAT은 여러 행을 하나의 문자열로 합칠 때 사용
    CASE
        WHEN GROUP_CONCAT(S.NAME) LIKE '%Python%' 
        AND GROUP_CONCAT(S.CATEGORY) LIKE '%Front End%'
            THEN 'A'
        WHEN GROUP_CONCAT(S.NAME) LIKE '%C#%' 
            THEN 'B'
        WHEN GROUP_CONCAT(S.CATEGORY) LIKE '%Front End%'
            THEN 'C'
        ELSE NULL
    END AS GRADE,
    D.ID,
    MIN(D.EMAIL) AS EMAIL   # case는 alias도 나눌 수 있음
FROM DEVELOPERS D
JOIN SKILLCODES S ON (D.SKILL_CODE & S.CODE) = S.CODE
GROUP BY D.ID, D.EMAIL
HAVING GRADE IS NOT NULL
ORDER BY GRADE ASC, ID ASC;
    

-- 필요한 코드의 합산 SUM, 비트 비교 연산 &, 스위치 ON은 > 0