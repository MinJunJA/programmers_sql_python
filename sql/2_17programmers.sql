# 동물 수 구하기
# 문제 설명
# 동물 보호소에 동물이 몇 마리 들어왔는지 조회하는 SQL 문을 작성해주세요.

SELECT count(animal_id) as count
from animal_ins;

# 최솟값 구하기
# 문제 설명
# 동물 보호소에 가장 먼저 들어온 동물은 언제 들어왔는지 조회하는 SQL 문을 작성해주세요.

SELECT datetime as 시간
from animal_ins
order by datetime
limit 1;

# 중복 제거하기
# 문제 설명
# 동물 보호소에 들어온 동물의 이름은 몇 개인지 조회하는 SQL 문을 작성해주세요. 이때 이름이 NULL인 경우는 집계하지 않으며 중복되는 이름은 하나로 칩니다.

SELECT count(distinct(name))
from animal_ins;

# 이름에 el이 들어가는 동물 찾기
# 문제 설명
# 보호소에 돌아가신 할머니가 기르던 개를 찾는 사람이 찾아왔습니다.
# 이 사람이 말하길 할머니가 기르던 개는 이름에 'el'이 들어간다고 합니다. 동물 보호소에 들어온 동물 이름 중,
# 이름에 "EL"이 들어가는 개의 아이디와 이름을 조회하는 SQL문을 작성해주세요.
# 이때 결과는 이름 순으로 조회해주세요. 단, 이름의 대소문자는 구분하지 않습니다.

select animal_id, name
from animal_ins
where name like ('%el%')
and animal_type = 'dog'
order by name;

# 동명 동물 수 찾기
# 문제 설명
# 동물 보호소에 들어온 동물 이름 중 두 번 이상 쓰인 이름과 해당 이름이 쓰인 횟수를 조회하는 SQL문을 작성해주세요.
# 이때 결과는 이름이 없는 동물은 집계에서 제외하며, 결과는 이름 순으로 조회해주세요.

SELECT name, count(name)
from animal_ins
where name is not null
group by name
having count(name) >=2
order by name;