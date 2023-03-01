# 가격대 별 상품 개수 구하기
# PRODUCT 테이블에서 만원 단위의 가격대 별로 상품 개수를 출력하는 SQL 문을 작성해주세요.
# 이때 컬럼명은 각각 컬럼명은 PRICE_GROUP, PRODUCTS로 지정해주시고
# 가격대 정보는 각 구간의 최소금액(10,000원 이상 ~ 20,000 미만인 구간인 경우 10,000)으로 표시해주세요. 결과는 가격대를 기준으로 오름차순 정렬해주세요.

select (case when price between 0 and 9999 then '0'
       when price between 10000 and 19999 then '10000'
       when price between 20000 and 29999 then '20000'
       when price between 30000 and 39999 then '30000'
       when price between 40000 and 49999 then '40000'
       when price between 50000 and 59999 then '50000'
       when price between 60000 and 69999 then '60000'
       when price between 70000 and 79999 then '70000'
       when price between 80000 and 89999 then '80000' end) as price_group,
       count(*) as products
from product
group by price_group
order by price_group;

-----------------------------------------------------------------------------------------------------------
#너무 비효율적인거 같아서 다시 짜봄
select (case when price < 10000 then '0'
       else truncate(price, -4) end) as price_group, count(product_id) as products
from product
group by price_group
order by price_group;

#여기서 배운점은 truncate를 사용해서 반올림하는 수를 구하는 법

# 성분으로 구분한 아이스크림 총 주문량
# 상반기 동안 각 아이스크림 성분 타입과, 성분 타입에 대한 아이스크림의 총주문량을 총주문량이 작은 순서대로 조회하는 SQL 문을 작성해주세요.
# 이때 총주문량을 나타내는 컬럼명은 TOTAL_ORDER로 지정해주세요


SELECT ICECREAM_INFO.INGREDIENT_TYPE AS INGREDIENT_TYPE, SUM(TOTAL_ORDER) AS TOTAL_ORDER
FROM FIRST_HALF
INNER JOIN ICECREAM_INFO ON ICECREAM_INFO.FLAVOR = FIRST_HALF.FLAVOR
GROUP BY INGREDIENT_TYPE
ORDER BY TOTAL_ORDER ASC;


# 즐겨찾기가 가장 많은 식당 정보 출력하기
# REST_INFO 테이블에서 음식종류별로 즐겨찾기수가 가장 많은 식당의 음식 종류, ID, 식당 이름, 즐겨찾기수를 조회하는 SQL문을 작성해주세요.
# 이때 결과는 음식 종류를 기준으로 내림차순 정렬해주세요.

SELECT FOOD_TYPE, REST_ID, REST_NAME, FAVORITES
FROM REST_INFO
WHERE FAVORITES IN (SELECT MAX(FAVORITES)
                   FROM REST_INFO
                   GROUP BY FOOD_TYPE)
GROUP BY FOOD_TYPE
ORDER BY FOOD_TYPE DESC;


# 5월 식품들의 총매출 조회하기ㄴㄴ
# FOOD_PRODUCT와 FOOD_ORDER 테이블에서 생산일자가 2022년 5월인 식품들의 식품 ID, 식품 이름, 총매출을 조회하는 SQL문을 작성해주세요.
# 이때 결과는 총매출을 기준으로 내림차순 정렬해주시고 총매출이 같다면 식품 ID를 기준으로 오름차순 정렬해주세요.

select food_product.product_id, food_product.product_name,
sum(food_product.price * food_order.amount) as TOTAL_SALES
from food_product
join food_order on food_product.product_id = food_order.product_id
where date_format(food_order.produce_date, '%Y-%m') = '2022-05'
group by food_product.product_id
order by TOTAL_SALES desc, food_product.product_id;