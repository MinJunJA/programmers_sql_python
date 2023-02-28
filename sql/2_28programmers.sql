# 자동차 종류 별 특정 옵션이 포함된 자동차 수 구하기
# CAR_RENTAL_COMPANY_CAR 테이블에서 '통풍시트', '열선시트', '가죽시트' 중 하나 이상의 옵션이 포함된 자동차가 자동차 종류 별로 몇 대인지 출력하는 SQL문을 작성해주세요.
# 이때 자동차 수에 대한 컬럼명은 CARS로 지정하고, 결과는 자동차 종류를 기준으로 오름차순 정렬해주세요.

select car_type, count(car_id) as cars
from car_rental_company_car
where options like '%통풍시트%' or
options like '%열선시트%' or
options like '%가죽시트%'
group by car_type
order by car_type;

# 카테고리 별 도서 판매량 집계하기
# 2022년 1월의 카테고리 별 도서 판매량을 합산하고, 카테고리(CATEGORY), 총 판매량(TOTAL_SALES) 리스트를 출력하는 SQL문을 작성해주세요.
# 결과는 카테고리명을 기준으로 오름차순 정렬해주세요.

select book.category, sum(book_sales.sales) as total_sales
from book
join book_sales
on book.book_id = book_sales.book_id
where date_format(book_sales.sales_date, '%Y-%m') = '2022-01'
group by book.category
order by book.category asc;

# 없어진 기록 찾기
# 천재지변으로 인해 일부 데이터가 유실되었습니다. 입양을 간 기록은 있는데, 보호소에 들어온 기록이 없는 동물의 ID와 이름을 ID 순으로 조회하는 SQL문을 작성해주세요.

# 두가지버전

select animal_outs.animal_id, animal_outs.name
from animal_outs
left join animal_ins
on animal_outs.animal_id = animal_ins.animal_id
where animal_ins is null

=========================================================================================================================

select animal_id, name
from animal_outs
where animal_id not in (select animal_id from animal_ins);