select (count(*) * 8 * 55) as Worked_hours
from  (
    select dd, extract(DOW from dd) as dw
    from generate_series('2022-03-01'::date, '2022-03-31'::date, '1 day'::interval) dd
) as month
where  dw not in (6,0);


