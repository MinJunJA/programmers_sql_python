# DATETIME에서 DATE로 형 변환
# 문제 설명
# ANIMAL_INS 테이블에 등록된 모든 레코드에 대해, 각 동물의 아이디와 이름, 들어온 날짜1를 조회하는 SQL문을 작성해주세요.
# 이때 결과는 아이디 순으로 조회해야 합니다.

SELECT animal_id, name, date_format(datetime, '%Y-%m-%d') as 날짜
from animal_ins
order by animal_id;

# 중성화 여부 파악하기
# 문제 설명
# 보호소의 동물이 중성화되었는지 아닌지 파악하려 합니다. 중성화된 동물은 SEX_UPON_INTAKE 컬럼에 'Neutered' 또는 'Spayed'라는 단어가 들어있습니다.
# 동물의 아이디와 이름, 중성화 여부를 아이디 순으로 조회하는 SQL문을 작성해주세요. 이때 중성화가 되어있다면 'O', 아니라면 'X'라고 표시해주세요.

#case when 사용법
# CASE
# 	WHEN 조건
# 	THEN '반환 값'
# 	WHEN 조건
# 	THEN '반환 값'
# 	ELSE 'WHEN 조건에 해당 안되는 경우 반환 값'
# END

select animal_id, name,
case
    when sex_upon_intake like '%Neutered%' then 'O'
    when sex_upon_intake like '%Spayed%' then 'O'
    else 'X' end as '중성화'
from animal_ins;


#if문 활용

select animal_id, name,
if(sex_upon_intake like '%Neutered%' or sex_upon_intake like '%Spayed%', 'O','X' )
as '중성화'
from animal_ins
order by animal_id;

# 고양이와 개는 몇 마리 있을까
# 동물 보호소에 들어온 동물 중 고양이와 개가 각각 몇 마리인지 조회하는 SQL문을 작성해주세요. 이때 고양이를 개보다 먼저 조회해주세요.

select animal_type, count(animal_type) as 'count'
from animal_ins
group by animal_type
order by animal_type;


# 입양 시각 구하기(1)
# 문제 설명
# 보호소에서는 몇 시에 입양이 가장 활발하게 일어나는지 알아보려 합니다.
# 09:00부터 19:59까지, 각 시간대별로 입양이 몇 건이나 발생했는지 조회하는 SQL문을 작성해주세요. 이때 결과는 시간대 순으로 정렬해야 합니다.

SELECT hour(datetime) as hour, count(hour(datetime)) as count
from animal_outs
where hour(datetime) between 9 and 20
group by hour(datetime)
order by hour(datetime);

# 이때 배운 코드
# hour(x) 시간을 조회할 수 있는 코드

# 오랜 기간 보호한 동물(1)

# 문제 설명

# 아직 입양을 못 간 동물 중, 가장 오래 보호소에 있었던 동물 3마리의 이름과 보호 시작일을 조회하는 SQL문을 작성해주세요.
# 이때 결과는 보호 시작일 순으로 조회해야 합니다.

select animal_ins.name as 'NAME', animal_ins.datetime as 'DATETIME'
from animal_ins
left join animal_outs
on animal_ins.animal_id = animal_outs.animal_id
where animal_outs.animal_id is null
order by animal_ins.datetime asc
limit 3;

# 카테고리 별 상품 개수 구하기
# 문제 설명

# PRODUCT 테이블에서 상품 카테고리 코드(PRODUCT_CODE 앞 2자리) 별 상품 개수를 출력하는 SQL문을 작성해주세요.
# 결과는 상품 카테고리 코드를 기준으로 오름차순 정렬해주세요.

#문제푸는 과정에서 배운 절 select left 왼쪽에서 문자열 자르기
# select substring 중간에서 문자열 자르기 substring(컬럼 또는 문자열, 시작위치, 길이);

select left(product_code, 2) as category, count(product_id) as products
from product
group by category
order by category;