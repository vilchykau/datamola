-- SELECT *
-- FROM u_fact_ext.sa_produced_product pp
--          LEFT OUTER JOIN U_FACT_STAR.DIM_DEPT de ON de.NAME = pp.DEPT_NAME
--          LEFT OUTER JOIN U_FACT_STAR.DIM_FACTORY fa ON fa.FACT_ID = de.FACT_ID
--          LEFT OUTER JOIN U_FACT_STAR.DIM_TYPE_PRODUCT_SCD tp ON tp.PR_T_ID = pp.PR_T_ID;


WITH data_den as (
    SELECT fa.NAME                                                          as fact_name
         , to_number(to_char(to_date(pp.EVENT_DT_STR, 'MM/DD/YYYY'), 'YY')) as year
         , to_number(to_char(to_date(pp.EVENT_DT_STR, 'MM/DD/YYYY'), 'WW')) as week
         , SUM(tp.SALE_PRICE)                                               as salling
    FROM u_fact_ext.sa_produced_product pp
             LEFT OUTER JOIN U_FACT_STAR.DIM_DEPT de ON de.NAME = pp.DEPT_NAME
             LEFT OUTER JOIN U_FACT_STAR.DIM_FACTORY fa ON fa.FACT_ID = de.FACT_ID
             LEFT OUTER JOIN U_FACT_STAR.DIM_TYPE_PRODUCT_SCD tp ON tp.PR_T_ID = pp.PR_T_ID
    GROUP BY (fa.NAME, to_number(to_char(to_date(pp.EVENT_DT_STR, 'MM/DD/YYYY'), 'YY')),
              to_number(to_char(to_date(pp.EVENT_DT_STR, 'MM/DD/YYYY'), 'WW')))
    ORDER BY fa.NAME, year, week
)
SELECT fact_name, year, week, salling, acc, delta AS delta_selling
FROM data_den
    MODEL RETURN UPDATED ROWS
        PARTITION BY (fact_name)
        DIMENSION BY (year, week)
        MEASURES (0 acc, 1 delta, salling)
        RULES (
        acc[year, week] = nvl(acc[cv(year), cv(week) - 1], 0)
        + salling[cv(year), cv(week)],

        delta[year, week] = salling[cv(year), cv(week)]
        - nvl(salling[cv(year), cv(week) - 1], salling[cv(year), cv(week)])
        );
