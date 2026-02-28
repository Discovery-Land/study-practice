[GROUP_CONCAT]
용도: 그룹별 여러 값을 한 줄로 보고 싶을 때만 사용
GROUP_CONCAT(컬럼 [ORDER BY 컬럼] [SEPARATOR '구분자'])

-- 5가지 기본 패턴

-- 1. 기본 (콤마 구분) (기본값 / 대부분)
GROUP_CONCAT(name) AS members

-- run 결과
dept_id | info
1       | 김철수(1),이영희(1),박민수(1)
2       | 홍길동(2),최영자(2)
3       | 정철호(3)


-- 2. 구분자 변경
GROUP_CONCAT(name SEPARATOR ' | ') AS members

-- 3. 중복제거+정렬
GROUP_CONCAT(DISTINCT name ORDER BY name) AS members

-- 4. 여러 컬럼 합치기
GROUP_CONCAT(CONCAT(id,':',name)) AS info

-- 5. 조건부
GROUP_CONCAT(CASE WHEN active=1 THEN name END) AS active_members
실무 TOP3

-- 부서별 직원목록
GROUP_CONCAT(name ORDER BY name) AS dept_members

-- 고객별 구매상품
GROUP_CONCAT(product_name) AS purchases

-- 태그목록
GROUP_CONCAT(DISTINCT tag) AS tags
