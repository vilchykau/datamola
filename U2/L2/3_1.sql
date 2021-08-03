with prods as (
    select fa.name as fact_name, de.name as dept_name, tp.name as product_name, tp.sale_price
        from SA_PRODUCED_PRODUCT pp
        inner join SA_DEPT de on pp.dept_name = de.name
        inner join SA_WORKER wk on pp.wk_id = wk.wk_id
        inner join SA_FACTORY fa on de.fact_id = fa.fact_id
        inner join SA_TYPE_PRODUCT tp on tp.pr_t_id = pp.pr_t_id
        WHERE to_date(pp.event_dt_str, 'MM/DD/YYYY') = TO_DATE('01/01/2020','DD/MM/YYYY')
) SELECT 
    GROUPING_ID(dept_name, product_name),
    fact_name, 
    decode(grouping(dept_name),1,'ALL DEPTS',dept_name) dept_name, 
    decode(grouping(product_name),1,'ALL PRODUCTS',product_name) product_name, 
    SUM(sale_price) 
    from prods
    group by fact_name, cube(dept_name, product_name);