-- Site   : Programmers
-- Title  : 연간 평가점수에 해당하는 평가 등급 및 성과금 조회하기 (LEVEL 4)
-- Link   : https://school.programmers.co.kr/learn/courses/30/lessons/284528
-- Date   : 2026-02-23 / 2026-02-28 (수정)

-- HR_DEPARTMENT DEPT_ID, DEPT_NAME_KR, DEPT_NAME_EN, LOCATION
-- HR_EMPLOYEES EMP_NO, EMP_NAME, DEPT_ID, POSITION, EMAIL, COMP_TEL, HIRE_DATE, SAL
-- HR_GRADE EMP_NO, YEAR, HALF_YEAR, SCORE

-- 기상 실패로 인한 시간 초과


SELECT 
    HE.EMP_NO,
    HE.EMP_NAME,
    CASE
        WHEN HG.AVG_SCORE >= 96 THEN 'S'
        WHEN HG.AVG_SCORE >= 90 THEN 'A'
        WHEN HG.AVG_SCORE >= 80 THEN 'B'
        ELSE 'C'
    END AS GRADE, -- 2. HG의 평균 점수로 평가등급(GRADE) 계산
    CASE
        WHEN HG.AVG_SCORE >= 96 THEN HE.SAL * 0.20
        WHEN HG.AVG_SCORE >= 90 THEN HE.SAL * 0.15
        WHEN HG.AVG_SCORE >= 80 THEN HE.SAL * 0.10
        ELSE 0
    END AS BONUS -- 3. 등급에 따라 연봉(SAL) * 성과금(BONUS) 비율 계산
FROM HR_EMPLOYEES HE
JOIN (
    SELECT EMP_NO,
        AVG(SCORE) AS AVG_SCORE
    FROM HR_GRADE
    WHERE YEAR = 2022
    GROUP BY EMP_NO
) HG -- 1. 2022년 사원별 평균점수 계산
    ON HE.EMP_NO = HG.EMP_NO -- 4. 사원번호(EMP_NO) 기준으로 JOIN
ORDER BY HE.EMP_NO;


-- CTE를 쓰지 않는 이유는 메모리 차이라고 생각했지만 실제로 복잡하다.
-- SQL Server에서는 CTE가 더 효율적일 수 있지만, PostgreSQL/MySQL에서는 일반적인 JOIN이 더 빠를 수 있음
-- 결론적으로, 코딩테스트에서는 서브쿼리를 우선적으로 사용.