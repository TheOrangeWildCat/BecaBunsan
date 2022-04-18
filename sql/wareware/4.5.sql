select (count(*) * 8 * (select count(*) 
    from assignments
    WHERE (DATE '2022-03-01', DATE '2022-03-31') 
    OVERLAPS (start_date, end_date))) as Worked_hours
from  (
    select dd, extract(DOW from dd) as dw
    from generate_series('2022-03-01'::date, '2022-03-31'::date, '1 day'::interval) dd) as month
where  dw not in (6,0);








