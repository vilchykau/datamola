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
    decode(grouping(day),1,'ALL MONTH',day) day,
    decode(grouping(month),1,'ALL YEAR',month) month,
    year,
    fact_name,
    SUM(sale_price)
    from prods
    group by fact_name, rollup(year, month, day);