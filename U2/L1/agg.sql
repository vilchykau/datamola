select det_no, pp.dept_name, fa.name as fa_name, county as country, city, wk.name
    from SA_PRODUCED_PRODUCT pp, SA_DEPT de, SA_WORKER wk, SA_FACTORY fa, SA_TYPE_PRODUCT tp
    where pp.dept_name = de.name and pp.wk_id = wk.wk_id and de.fact_id = fa.fact_id and tp.pr_t_id = pp.pr_t_id;
