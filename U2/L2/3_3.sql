with prods as (
    select fa.name as fact_name, de.name as dept_name, tp.name as product_name, tp.sale_price,
        extract(day from to_date(pp.event_dt_str, 'MM/DD/YYYY')) as day,
        extract(month from to_date(pp.event_dt_str, 'MM/DD/YYYY')) as month,
        extract(year from to_date(pp.event_dt_str, 'MM/DD/YYYY')) as year
        from SA_PRODUCED_PRODUCT pp
        inner join SA_DEPT de on pp.dept_name = de.name
        inner join SA_WORKER wk on pp.wk_id = wk.wk_id
        inner join SA_FACTORY fa on de.fact_id = fa.fact_id
        inner join SA_TYPE_PRODUCT tp on tp.pr_t_id = pp.pr_t_id
       -- WHERE to_date(pp.event_dt_str, 'MM/DD/YYYY') = TO_DATE('01/01/2020','DD/MM/YYYY')
) SELECT 
    day,
    month,
    year,
    fact_name, 
    dept_name, 
    product_name 
    from prods
    rollup(year, month, day);