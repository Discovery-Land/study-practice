-- Site   : Programmers
-- Title  : 연간 평가점수에 해당하는 평가 등급 및 성과금 조회하기 (LEVEL 4)
-- Link   : https://school.programmers.co.kr/learn/courses/30/lessons/284528
-- Date   : 2026-02-23

-- HR_DEPARTMENT DEPT_ID, DEPT_NAME_KR, DEPT_NAME_EN, LOCATION
-- HR_EMPLOYEES EMP_NO, EMP_NAME, DEPT_ID, POSITION, EMAIL, COMP_TEL, HIRE_DATE, SAL
-- HR_GRADE EMP_NO, YEAR, HALF_YEAR, SCORE
-- 사원별 성과금 정보 조회

SELECT 
    EMP_NO,
    EMP_NAME,
    GRADE,
    BONUS
FROM HR_EMPLOYEES

-- 기상 실패로 인한 시간 초과