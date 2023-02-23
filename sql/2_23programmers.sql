# 3월에 태어난 여성 회원 목록 출력하기
# MEMBER_PROFILE 테이블에서 생일이 3월인 여성 회원의 ID, 이름, 성별, 생년월일을 조회하는 SQL문을 작성해주세요.
# 이때 전화번호가 NULL인 경우는 출력대상에서 제외시켜 주시고, 결과는 회원ID를 기준으로 오름차순 정렬해주세요.

select member_id, member_name, gender, date_format(date_of_birth, "%Y-%m-%d") as date_of_birth
from member_profile
where date_format(date_of_birth, '%m') = '03'
and gender = 'W'
and tlno is not null
order by member_id;

# 진료과별 총 예약 횟수 출력하기
# APPOINTMENT 테이블에서 2022년 5월에 예약한 환자 수를 진료과코드 별로 조회하는 SQL문을 작성해주세요.
# 이때, 컬럼명은 '진료과 코드', '5월예약건수'로 지정해주시고 결과는 진료과별 예약한 환자 수를 기준으로 오름차순 정렬하고,
# 예약한 환자 수가 같다면 진료과 코드를 기준으로 오름차순 정렬해주세요.

select mcdp_cd as '진료과코드', count(apnt_ymd) as '5월예약건수'
from appointment
where date_format(apnt_ymd, '%Y-%m') = '2022-05'
group by mcdp_cd
order by count(apnt_ymd), mcdp_cd;

# 상품 별 오프라인 매출 구하기
# PRODUCT 테이블과 OFFLINE_SALE 테이블에서 상품코드 별 매출액(판매가 * 판매량) 합계를 출력하는 SQL문을 작성해주세요.
# 결과는 매출액을 기준으로 내림차순 정렬해주시고 매출액이 같다면 상품코드를 기준으로 오름차순 정렬해주세요

select product.product_code, sum(product.price * offline_sale.sales_amount) as sales
from product
inner join offline_sale
on product.product_id = offline_sale.product_id
group by product.product_code
order by sum(product.price * offline_sale.sales_amount) desc, product_code asc;

# 조건별로 분류하여 주문상태 출력하기
# FOOD_ORDER 테이블에서 5월 1일을 기준으로 주문 ID, 제품 ID, 출고일자, 출고여부를 조회하는 SQL문을 작성해주세요.
# 출고여부는 5월 1일까지 출고완료로 이 후 날짜는 출고 대기로 미정이면 출고미정으로 출력해주시고, 결과는 주문 ID를 기준으로 오름차순 정렬해주세요.

select order_id, product_id, date_format(out_date, '%Y-%m-%d') as out_date,
case when
out_date > date('2022-05-01') then '출고대기'
when date('2022-05-01') >= out_date then '출고완료'
when out_date is null then '출고미정' end as '출고여부'
from food_order
order by order_id;