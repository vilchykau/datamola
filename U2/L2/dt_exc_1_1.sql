select fa.name, count(0)
    from SA_PRODUCED_PRODUCT pp
    inner join SA_DEPT de on pp.dept_name = de.name
    inner join SA_WORKER wk on pp.wk_id = wk.wk_id
    inner join SA_FACTORY fa on de.fact_id = fa.fact_id
    inner join SA_TYPE_PRODUCT tp on tp.pr_t_id = pp.pr_t_id
    WHERE to_date(pp.event_dt_str, 'MM/DD/YYYY') >= TO_DATE('01/01/2020','DD/MM/YYYY')
    and to_date(pp.event_dt_str, 'MM/DD/YYYY') < TO_DATE('01/02/2020','DD/MM/YYYY')
    group by(fa.name);