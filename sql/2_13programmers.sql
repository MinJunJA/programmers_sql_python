#인기있는 아이스크림

#문제
#상반기에 판매된 아이스크림의 맛을 총주문량을 기준으로 내림차순 정렬하고 총주문량이 같다면 출하 번호를 기준으로 오름차순 정렬하여 조회하는 SQL 문을 작성해주세요.
#다음예시처럼 나와야합니다.
# FLAVOR
# chocolate
# melon
# white_chocolate
# strawberry
# mango
# orange
# pineapple
# vanilla
# caramel
# peach
# watermelon
# mint_chocolate

SELECT flavor
from first_half
order by total_order desc, shipment_id asc;


# 모든 레코드 조회하기
# 문제 설명
# 동물 보호소에 들어온 모든 동물의 정보를 ANIMAL_ID순으로 조회하는 SQL문을 작성해주세요. SQL을 실행하면 다음과 같이 출력되어야 합니다.
SELECT *
from animal_ins
order by animal_id;

# 흉부외과 또는 일반외과 의사 목록 출력하기
# 문제 설명
# 다음은 종합병원에 속한 의사 정보를 담은DOCTOR 테이블입니다.
# DOCTOR 테이블에서 진료과가 흉부외과(CS)이거나 일반외과(GS)인 의사의 이름, 의사ID, 진료과, 고용일자를 조회하는 SQL문을 작성해주세요.
# 이때 결과는 고용일자를 기준으로 내림차순 정렬하고,
# 고용일자가 같다면 이름을 기준으로 오름차순 정렬해주세요.
# DOCTOR 테이블은 다음과 같으며 DR_NAME, DR_ID, LCNS_NO, HIRE_YMD, MCDP_CD, TLNO는 각각 의사이름, 의사ID, 면허번호, 고용일자, 진료과코드, 전화번호를 나타냅니다.

SELECT dr_name, dr_id, mcdp_cd, date_format(hire_ymd, '%Y-%m-%d')
from doctor
where MCDP_CD in ('CS', 'GS')
order by hire_ymd desc, dr_name;

#12세 이하인 여자 환자 목록 출력하기
#문제 설명
#다음은 종합병원에 등록된 환자정보를 담은 PATIENT 테이블입니다.
#PATIENT 테이블은 다음과 같으며 PT_NO, PT_NAME, GEND_CD, AGE, TLNO는 각각 환자번호, 환자이름, 성별코드, 나이, 전화번호를 의미합니다.

#PATIENT 테이블에서 12세 이하인 여자환자의 환자이름, 환자번호, 성별코드, 나이, 전화번호를 조회하는 SQL문을 작성해주세요.
# 이때 전화번호가 없는 경우, 'NONE'으로 출력시켜 주시고 결과는 나이를 기준으로 내림차순 정렬하고, 나이 같다면 환자이름을 기준으로 오름차순 정렬해주세요.

SELECT pt_name, pt_no, gend_cd, age, ifnull(tlno, 'NONE') as TLNO
from patient
where age <= 12
and gend_cd = 'W'
order by age desc, pt_name asc;


#과일로 만든 아이스크림 고르기
#문제 설명
# ICECREAM_INFO 테이블 구조는 다음과 같으며, FLAVOR, INGREDITENT_TYPE 은 각각 아이스크림 맛, 아이스크림의 성분 타입을 나타냅니다.
# INGREDIENT_TYPE에는 아이스크림의 주 성분이 설탕이면 sugar_based라고 입력되고, 아이스크림의 주 성분이 과일이면 fruit_based라고 입력됩니다.
# ICECREAM_INFO의 기본 키는 FLAVOR입니다. ICECREAM_INFO테이블의 FLAVOR는 FIRST_HALF 테이블의 FLAVOR의 외래 키입니다.

# 상반기 아이스크림 총주문량이 3,000보다 높으면서 아이스크림의 주 성분이 과일인 아이스크림의 맛을 총주문량이 큰 순서대로 조회하는 SQL 문을 작성해주세요.

SELECT first_half.flavor
from first_half
inner join icecream_info
on first_half.flavor = icecream_info.flavor
where first_half.total_order >= 3000
and icecream_info.ingredient_type = 'fruit_based';




