-- 정규화
-- > 데이터베이스의 테이블을 올바른 형태로 개선해나가는 것
-- > 일반적으로 데이터베이스의 설계 단계에서 진행하고, 경우에 따라서는 기존 시스템을 재검토할 때 정규화하는 경우도 있음
-- > 정규화 과정을 통해 데이터베이스가 효율적으로 동작하도록 설계할 수 있음

-- 정규화는 단계적으로 실시하기 때문에 첫 번째로 제 1 정규화를 시행하고 제 1 정규형 테이블을 만듦

-- 제 1 정규형
-- > 관계형 데이터베이스의 테이블에는 하나의 셀에 하나의 값만 저장할 수 있다는 제약이 있음
-- > 따라서 주문상품 데이터를 그대로 테이블로 만들 수 없음
-- -- 상품 코드, 상품명, 개수 의 3개의 열로 나누어야 함

-- > 제 1 정규화를 수행하면 하나의 셀에 하나의 값만 저장하게되므로 테이블화 할 수 있음
-- > 제 2 정규화 과정에서 열이 두 개 더 추가되고 행도 늘어나게 됨
-- -- 하나의 셀에 하나의 값만 저장될 수 있도록 하고, 반복되는 부분을 행으로 늘려나가는 것이 제 1 정규화

-- > 제 1 정규화에서는 중복을 제거하는 테이블의 분할도 이루어짐
-- -- 예제 상황에서는 한 번의 주문으로 여러 개의 상품을 주문할 수 있으므르
-- -- 주문번호, 날짜,성명, 연락처가 통일한 값을 가지는행이 여러 개 만들어짐
-- -- 이때 동일한 값을 가지는 중복 행이 여러 개 존재하지 않도록 정리

-- 테이블 분할을 하면 반복되는 부분이 하나로 정리되고, 주문 데이터가 변경되면 주문 테이블 하나만 수정하면 됨
-- > 분할 전 상태의 데이터를 원하더라도 주문번호로 JOIN하면 되므로 문제 없음

-- 분할 이후의 주문 테이블은 주문번호에 중복된 값이 없기 때문에 기본키로 지정할 수 있음
-- > 주문 상품 테이블에서는 주문 번호와 상품코드를 하나로 묶어 기본키로 지정할 수 있음

-- 제 2 정규형
-- > 제 1 정규화에서 테이블에 기본키를 작성한 것과 같은 방법으로, 데이터가 중복되는 부분을 찾아내어 테이블로 분할
-- > 이때 기본키에 의해 특정되는 열과 그렇지 않은 열로 나누는 것을 정규화
-- -- 주문 상품의 기본키는 주문번호와 상품코드의 2개의 열로 구성됨
-- -- 상품명은 주문번호와 관계없이 상품코드만으로 특정 할 수 있는 데이터임
-- -- 따라서 테이블을 두 개로 분할할 수 있음

-- > 제 2 정규화는 함수종속성을 찾아내서 테이블을 분할하는 것
-- -- 함수종속성 : 키 값을 이용해 데이터를 특정 지을 수 있는 것

-- 제 3 정규형
-- > 제 2 정규화의 경우에는 기본키에 중복이 없는지 조사했지만 제 3 정규화에서는 기본키 이외의 부분에서 중복이 없는지 조사
-- > 분할하기 전의 주문 테이블에는 같은 사람이 여러 번 주문하는 경우가 있음
-- > 이때 주문 테이블에서 이름을 기준으로 연락처를 특정지을 수 있음
-- -- 주문 테이블의 기본키는 주문번호로, 이름은 기본키와는 관계가 없음


-- 이론적으로는 제 5 정규형까지 있지만 프로젝트 구조나 상황에 따라서 정규화 단계를 선택할 수 있음
-- > 일반적으로는 제 3 정규형까지를 채택
-- 테이블 그림 그려볼 수 있는 사이트 참고(erd, drawio

-- 정규화의 목적
-- > 정규화에서는 중복되거나 반복되는 부분을 찾아내서 테이블을 분할하고 기본키를 작성해 사용하는 것을 기본 개념으로 삼음
-- > 정규화의 모든 과정은 '하나의 데이터는 한 곳에 있어야 한다'는 규칙에 근거함
-- -- 하나의 데이터가 한 곳에만 저장되어 있다면 데이터를 변경하더라도 한 곳만 변경하는 것으로 끝낼 수 있기 때문
-- -- 정규화 되지 않은 경우에는 여기저기서 중복된 데이터를 검색하고 일일이 변경해야 함
-- -- 만약 인덱스가 지정된 열의 데이터가 변경된다면 인덱스도 재구축되어야 함