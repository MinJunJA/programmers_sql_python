# 오랜 기간 보호한 동물(2)
# 문제 설명
# 입양을 간 동물 중, 보호 기간이 가장 길었던 동물 두 마리의 아이디와 이름을 조회하는 SQL문을 작성해주세요. 이때 결과는 보호 기간이 긴 순으로 조회해야 합니다.

SELECT animal_ins.animal_id, animal_ins.name
from animal_ins
inner join animal_outs
on animal_ins.animal_id = animal_outs.animal_id
where datediff(animal_ins.datetime, animal_outs.datetime)
order by datediff(animal_ins.datetime, animal_outs.datetime)
limit 2;

#datetime을 비교하려면 datediff를 써야한다.

# 있었는데요 없었습니다
# 문제 설명
# 관리자의 실수로 일부 동물의 입양일이 잘못 입력되었습니다. 보호 시작일보다 입양일이 더 빠른 동물의 아이디와 이름을 조회하는 SQL문을 작성해주세요.
# 이때 결과는 보호 시작일이 빠른 순으로 조회해야합니다.


SELECT animal_ins.animal_id, animal_ins.name
from animal_ins
inner join animal_outs
on animal_ins.animal_id = animal_outs.animal_id
where timediff (animal_outs.datetime, animal_ins.datetime) < 0
order by animal_ins.datetime;

#이때 배운 코드
#timediff, datediff의 차이를 배웠음
#datediff는 날짜만 고려한다는것을 배웠음 즉, datetime의 시간, 분은 고려하지 않음
#이럴경우에는 timediff를 사용하여 문제를 푸는것이 좋다


# 루시와 엘라 찾기
# 동물 보호소에 들어온 동물 중 이름이 Lucy, Ella, Pickle, Rogan, Sabrina, Mitty인 동물의 아이디와 이름, 성별 및 중성화 여부를 조회하는 SQL 문을 작성해주세요.

select animal_id, name, sex_upon_intake
from animal_ins
where name in ('lucy', 'ella', 'pickle', 'rogan', 'sabrina', 'mitty');


# 보호소에서 중성화한 동물
# 보호소에서 중성화 수술을 거친 동물 정보를 알아보려 합니다. 보호소에 들어올 당시에는 중성화1되지 않았지만,
# 보호소를 나갈 당시에는 중성화된 동물의 아이디와 생물 종, 이름을 조회하는 아이디 순으로 조회하는 SQL 문을 작성해주세요.

select animal_ins.animal_id, animal_ins.animal_type, animal_ins.name
from animal_ins
join animal_outs
on animal_ins.animal_id = animal_outs.animal_id
where (animal_outs.sex_upon_outcome like 'Neutered%'
    or animal_outs.sex_upon_outcome like'Spayed%')
    and animal_ins.sex_upon_intake like 'Intact%';