-- Site   : Programmers
-- Title  : 조건에 맞는 사원 정보 조회하기 (LEVEL 2)
-- Link   : https://school.programmers.co.kr/learn/courses/30/lessons/284527
-- Date   : 2026-03-5

-- 2022년도 한해 평가 점수가 가장 높은 사원 정보를 조회
-- 점수, 사번, 성명, 직책, 이메일을 조회
# SELECT 
#     MAX(M.SCORE) AS SCORE, 
#     E.EMP_NO, E.EMP_NAME, 
#     E.POSITION, E.EMAIL
# FROM HR_EMPLOYEES E
# JOIN (
#     SELECT MAX(S.SCORE) SCORE, S.EMP_NO EMP_NO
#     FROM (
#         SELECT SUM(SCORE) SCORE, EMP_NO
#         FROM HR_GRADE
#         WHERE YEAR = '2022'
#         GROUP BY EMP_NO) AS S
# ) M ON E.EMP_NO = M.EMP_NO


# SELECT S.SCORE, E.EMP_NO, E.EMP_NAME, E.POSITION, E.EMAIL
# FROM HR_EMPLOYEES E
# JOIN (
#     SELECT SUM(SCORE) AS SCORE, EMP_NO
#     FROM HR_GRADE
#     WHERE YEAR = '2022'
#     GROUP BY EMP_NO
# ) S ON E.EMP_NO = S.EMP_NO
# ORDER BY SCORE DESC
# LIMIT 1

-- 점수가 가장 높은 사원 조회
-- HG.SCORE(SCORE), HG.EMP_NO, HE.EMP_NAME, HE.POSITION HE.EMP_NAME, HE.EMAIL
SELECT 
    HG.SCORE,
    HG.EMP_NO,
    HE.EMP_NAME,
    HE.POSITION,
    HE.EMAIL
FROM HR_EMPLOYEES HE
JOIN (
    SELECT EMP_NO, SUM(SCORE) SCORE
    FROM HR_GRADE
    GROUP BY EMP_NO
    ORDER BY SCORE DESC
    LIMIT 1
) HG ON HE.EMP_NO = HG.EMP_NO;

-- 기본 패턴 철저히 지키기