-- =========================================
-- 정규식 (Regular Expression) 핵심 정리
-- =========================================

-- 1. 기본 패턴 매칭
SELECT *
FROM users
WHERE name REGEXP 'kim';              -- 'kim' 포함

SELECT *
FROM users
WHERE name REGEXP '^kim';             -- 'kim'으로 시작

SELECT *
FROM users
WHERE name REGEXP 'kim$';             -- 'kim'으로 끝

SELECT *
FROM users
WHERE name REGEXP '^kim$';            -- 정확히 'kim'


-- =========================================
-- 2. 문자 클래스
-- =========================================

SELECT *
FROM users
WHERE name REGEXP '[abc]';            -- a 또는 b 또는 c 포함

SELECT *
FROM users
WHERE name REGEXP '[a-z]';            -- 소문자 포함

SELECT *
FROM users
WHERE name REGEXP '[0-9]';            -- 숫자 포함

SELECT *
FROM users
WHERE name REGEXP '[^0-9]';           -- 숫자가 아닌 문자


-- =========================================
-- 3. 반복 패턴
-- =========================================

SELECT *
FROM logs
WHERE message REGEXP 'a*';            -- a가 0개 이상

SELECT *
FROM logs
WHERE message REGEXP 'a+';            -- a가 1개 이상

SELECT *
FROM logs
WHERE message REGEXP 'a?';            -- a가 0개 또는 1개

SELECT *
FROM logs
WHERE message REGEXP 'a{3}';          -- a가 정확히 3개

SELECT *
FROM logs
WHERE message REGEXP 'a{2,5}';        -- a가 2~5개


-- =========================================
-- 4. 자주 쓰는 패턴
-- =========================================

-- 이메일
SELECT *
FROM users
WHERE email REGEXP '^[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,}$';

-- 전화번호 (간단)
SELECT *
FROM users
WHERE phone REGEXP '^010-[0-9]{4}-[0-9]{4}$';

-- 숫자만
SELECT *
FROM data
WHERE value REGEXP '^[0-9]+$';

-- 영문 + 숫자
SELECT *
FROM data
WHERE value REGEXP '^[A-Za-z0-9]+$';


-- =========================================
-- 5. 그룹 & OR 조건
-- =========================================

SELECT *
FROM products
WHERE name REGEXP 'apple|banana';     -- apple 또는 banana

SELECT *
FROM logs
WHERE message REGEXP '(error|fail)';  -- error 또는 fail


-- =========================================
-- 6. 서브스트링 추출 (DB별 상이)
-- =========================================

-- MySQL
SELECT REGEXP_SUBSTR(email, '[^@]+') AS id_part
FROM users;

-- PostgreSQL
SELECT substring(email FROM '[^@]+') AS id_part
FROM users;


-- =========================================
-- 7. 치환 (REPLACE)
-- =========================================

-- MySQL
SELECT REGEXP_REPLACE(phone, '[^0-9]', '') AS only_number
FROM users;

-- PostgreSQL
SELECT regexp_replace(phone, '[^0-9]', '', 'g') AS only_number
FROM users;


-- =========================================
-- 8. CTE + 정규식 실전 예시
-- =========================================

WITH filtered AS (
    SELECT 
        user_id,
        email,
        phone,
        -- 이메일 유효성
        CASE 
            WHEN email REGEXP '^[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,}$'
            THEN 1 ELSE 0 
        END AS valid_email,
        
        -- 숫자만 추출
        REGEXP_REPLACE(phone, '[^0-9]', '') AS clean_phone
    FROM users
)
SELECT *
FROM filtered
WHERE valid_email = 1;


-- =========================================
-- 9. 정규식 요약 테이블
-- =========================================

| 패턴        | 의미                  | 예시 매칭         | 사용처           |
|------------|-----------------------|------------------|------------------|
| ^          | 시작                  | ^abc             | prefix 검색      |
| $          | 끝                    | abc$             | suffix 검색      |
| .          | 아무 문자 1개         | a.c              | 패턴 매칭        |
| *          | 0회 이상              | a*               | 반복 허용        |
| +          | 1회 이상              | a+               | 최소 1회 반복    |
| ?          | 0 또는 1회            | a?               | 선택적 문자      |
| []         | 문자 집합             | [abc]            | OR 조건          |
| [^]        | 제외                  | [^0-9]           | 필터링           |
| {}         | 반복 횟수 지정        | a{2,3}           | 정확한 개수      |
| \|         | OR                    | a\|b             | 다중 조건        |


-- =========================================
-- 핵심 정리
-- =========================================
-- 1. REGEXP / RLIKE 로 패턴 검색
-- 2. REGEXP_REPLACE 로 데이터 정제
-- 3. CTE와 결합하면 데이터 품질 체크 가능
-- 4. DB마다 함수명이 조금씩 다름 (MySQL vs PostgreSQL)