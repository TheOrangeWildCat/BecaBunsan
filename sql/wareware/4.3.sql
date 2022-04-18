select users.name, users.handle, users.email, count as count_skills FROM (
select user_id, count(user_id)
from user_skills
group by user_id
having count(*)>0
) as mytable 
inner join users
on users.id = mytable.user_id And users.enabled = 't'
order by count, id
limit 10;


