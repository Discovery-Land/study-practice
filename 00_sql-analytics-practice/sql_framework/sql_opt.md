=========================================
SQL 문제 풀이 통합 프레임워크 (최종 정리)
=========================================


[1] 핵심 5단 풀이법 (빠른 풀이용)

1. 요구사항 파악
   - 무엇을 기준으로 보고 싶은가 (user / product / date 등)

2. 한 줄 요약
   - 결과를 문장으로 정리
   - 예: 유저별 최근 주문 1건

3. 논리 구조 설계
   - 테이블 관계 파악 (1:1, 1:N)
   - JOIN / EXISTS / CTE 중 선택

4. 쿼리 작성 및 수정
   - JOIN 조건
   - GROUP BY / 윈도우 함수

5. 검증
   - NULL / 중복 / 정렬 / 경계값 확인



=========================================


[2] 실무형 9단 풀이법 (완성형)

1. 환경 가정
   - 데이터 크기 / 인덱스 고려
   - 풀스캔 발생 가능성 판단

2. 실행 계획 감각 체크
   - FULL SCAN / HASH JOIN / SORT 여부
   - IN vs EXISTS / JOIN vs 서브쿼리 판단

3. 요구사항 파악
   - 최종 결과 단위 정의 (user / order / date 등)

4. 한 줄 요약
   - 문제를 수식처럼 정리
   - 예: 유저별 첫 주문 → 최근 30일 → 날짜별 집계

5. 최종 결과 구조 설계
   - SELECT / GROUP BY 기준 먼저 결정
   - 결과 한 줄이 의미하는 것 정의

6. 중간 결과 필요 여부 판단 (CTE 기준)
   - Top N / 첫값 / 마지막값
   - 집계 후 필터링
   - 로직 재사용
   - 한 번에 GROUP BY 불가능한 경우

7. 중간 결과 생성
   - CTE 또는 Subquery 사용
   - 의미 있는 이름 부여 (ex: active_users, first_orders)

8. 최종 조립
   - JOIN / WHERE / GROUP BY 구성
   - 필요한 컬럼만 선택

9. 검증 및 성능 체크
   - NULL / 중복 / 날짜 경계
   - 비정상 데이터 상황까지 고려



=========================================


[3] CTE / JOIN / WHERE 선택 기준

[CTE (WITH)]
- 단계가 여러 개인 쿼리
- 중간 결과 재사용
- 복잡한 서브쿼리 분리
- 결과에 의미 있는 이름을 붙이고 싶을 때

핵심:
"한 번에 못 풀겠으면 CTE"


[WHERE - EXISTS]
WHERE EXISTS (
    SELECT 1
    FROM orders o
    WHERE o.user_id = u.id
)

- 존재 여부만 확인
- 대용량에서 성능 유리


[WHERE - IN]
WHERE user_id IN (SELECT user_id FROM orders)

- 단순 포함 여부
- 작은 집합일 때 적합


[JOIN]
- 컬럼을 추가로 가져올 때
- 결과 row 수를 확장/제어할 때
- 집계 결과를 옆에 붙일 때

핵심:
값 필요 → JOIN
존재 여부 → EXISTS



=========================================


[4] 실무 사고 패턴

1. Top N / 최신 1건
ROW_NUMBER() OVER(PARTITION BY user_id ORDER BY created_at DESC)

2. 집계 후 필터
WITH t AS (
    SELECT user_id, SUM(amount) AS total
    FROM orders
    GROUP BY user_id
)
SELECT *
FROM t
WHERE total > 100000;

3. 시계열 분석
LAG()
LEAD()
SUM() OVER()

4. 존재 여부 확인
WHERE EXISTS (...)

5. JSON / 배열 처리
json_agg()
array_agg()



=========================================


[5] 실수 방지 체크리스트

- JOIN → 중복 행 증가 여부 확인
- GROUP BY → 누락된 컬럼 없는지
- NULL → 비교 연산 문제
- 날짜 → BETWEEN 경계값 확인
- DISTINCT → 성능 영향
- ORDER BY → 존재하지 않는 컬럼 사용 여부
- LEFT JOIN → WHERE 조건으로 INNER JOIN 되는 실수



=========================================


[6] 핵심 요약

1. 결과 한 줄의 의미를 먼저 정의한다
2. 복잡하면 CTE로 나눈다
3. 값이 필요하면 JOIN, 존재만 확인하면 EXISTS
4. 데이터가 비정상적이어도 안전한지 검증한다

=========================================