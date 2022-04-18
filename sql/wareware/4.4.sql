select  percentile_disc(0.5) within group (order by end_date) as fecha 
from (select end_date from assignments
WHERE (DATE '2022-03-01', DATE '2022-03-31') OVERLAPS (start_date, end_date)
order by end_date) as mytab;




