#역순 정렬하기

# 동물 보호소에 들어온 모든 동물의 이름과 보호 시작일을 조회하는 SQL문을 작성해주세요.
# 이때 결과는 ANIMAL_ID 역순으로 보여주세요. SQL을 실행하면 다음과 같이 출력되어야 합니다.
SELECT name, datetime
from animal_ins
order by animal_id desc;

# 아픈 동물 찾기
# 동물 보호소에 들어온 동물 중 아픈 동물1의 아이디와 이름을 조회하는 SQL 문을 작성해주세요. 이때 결과는 아이디 순으로 조회해주세요.

SELECT animal_id, name
from animal_ins
where intake_condition = 'sick'
order by animal_id;


# 어린 동물 찾기
# 동물 보호소에 들어온 동물 중 젊은 동물1의 아이디와 이름을 조회하는 SQL 문을 작성해주세요. 이때 결과는 아이디 순으로 조회해주세요.
# INTAKE_CONDITION이 Aged가 아닌 경우를 뜻함
SELECT animal_id, name
from animal_ins
where intake_condition not in ('Aged')
order by animal_id;

#최댓값 구하기
# 가장 최근에 들어온 동물은 언제 들어왔는지 조회하는 SQL 문을 작성해주세요.
SELECT datetime as '시간'
from animal_ins
order by datetime desc
limit 1;


# 강원도에 위치한 생산공장 목록 출력하기
# FOOD_FACTORY 테이블에서 강원도에 위치한 식품공장의 공장 ID, 공장 이름, 주소를 조회하는 SQL문을 작성해주세요.
# 이때 결과는 공장 ID를 기준으로 오름차순 정렬해주세요.

SELECT factory_id, factory_name, address
from food_factory
where address like ('강원도%')
order by factory_id asc;

# 경기도에 위치한 식품창고 목록 출력하기
# FOOD_WAREHOUSE 테이블에서 경기도에 위치한 창고의 ID, 이름, 주소, 냉동시설 여부를 조회하는 SQL문을 작성해주세요.
# 이때 냉동시설 여부가 NULL인 경우, 'N'으로 출력시켜 주시고 결과는 창고 ID를 기준으로 오름차순 정렬해주세요.

SELECT warehouse_id, warehouse_name, address, ifnull(freezer_yn, 'N') as FREEZER_YN
from food_warehouse
where address like ('경기도%')
order by warehouse_id asc;

# 가장 비싼 상품 구하기
# PRODUCT 테이블에서 판매 중인 상품 중 가장 높은 판매가를 출력하는 SQL문을 작성해주세요. 이때 컬럼명은 MAX_PRICE로 지정해주세요.
SELECT price as MAX_PRICE
from product
order by price desc
limit 1;

# 2차버전
SELECT max(price) as MAX_PRICE
from product;

# 조건에 맞는 도서 리스트 출력하기
# BOOK 테이블에서 2021년에 출판된 '인문' 카테고리에 속하는 도서 리스트를 찾아서 도서 ID(BOOK_ID), 출판일 (PUBLISHED_DATE)을 출력하는 SQL문을 작성해주세요.
# 결과는 출판일을 기준으로 오름차순 정렬해주세요.

SELECT book_id, date_format(published_date, '%Y-%m-%d') as PUBLISHED_DATE
from book
where category in ('인문')
and year(published_date) = '2021'
order by book_id desc;

# 평균 일일 대여 요금 구하기
# CAR_RENTAL_COMPANY_CAR 테이블에서 자동차 종류가 'SUV'인 자동차들의 평균 일일 대여 요금을 출력하는 SQL문을 작성해주세요.
# 이때 평균 일일 대여 요금은 소수 첫 번째 자리에서 반올림하고, 컬럼명은 AVERAGE_FEE 로 지정해주세요.

SELECT round(avg(daily_fee)) as AVERAGE_FEE
from car_rental_company_car
where car_type = 'suv';

# 자동차 대여 기록에서 장기/단기 대여 구분하기
# CAR_RENTAL_COMPANY_RENTAL_HISTORY 테이블에서 대여 시작일이 2022년 9월에 속하는 대여 기록에 대해서 대여 기간이 30일 이상이면 '장기 대여'
# 그렇지 않으면 '단기 대여' 로 표시하는 컬럼(컬럼명: RENT_TYPE)을 추가하여 대여기록을 출력하는 SQL문을 작성해주세요.
# 결과는 대여 기록 ID를 기준으로 내림차순 정렬해주세요.


SELECT history_id, car_id,
date_format(start_date, '%Y-%m-%d') as START_DATE,
date_format(end_date, '%Y-%m-%d') as END_DATE,
IF (timestampdiff(day, start_date, end_date) < 29, '단기 대여', '장기 대여') as RENT_TYPE
from car_rental_company_rental_history
where month(start_date) = '09'
order by history_id desc;

#여기서 배운코드

# if조건문
# DATEDIFF, TIMESTAMPDIFF 함수

