WITH data_den as (
    SELECT fa.NAME                                                          as fact_name
         , to_number(to_char(to_date(pp.EVENT_DT_STR, 'MM/DD/YYYY'), 'YY')) as year
         , to_number(to_char(to_date(pp.EVENT_DT_STR, 'MM/DD/YYYY'), 'WW')) as week
         , SUM(tp.SALE_PRICE)                                               as selling
    FROM u_fact_ext.sa_produced_product pp
             LEFT OUTER JOIN U_FACT_STAR.DIM_DEPT de ON de.NAME = pp.DEPT_NAME
             LEFT OUTER JOIN U_FACT_STAR.DIM_FACTORY fa ON fa.FACT_ID = de.FACT_ID
             LEFT OUTER JOIN U_FACT_STAR.DIM_TYPE_PRODUCT_SCD tp ON tp.PR_T_ID = pp.PR_T_ID
    GROUP BY (fa.NAME, to_number(to_char(to_date(pp.EVENT_DT_STR, 'MM/DD/YYYY'), 'YY')),
              to_number(to_char(to_date(pp.EVENT_DT_STR, 'MM/DD/YYYY'), 'WW')))
    ORDER BY fa.NAME, year, week
)
SELECT fact_name, year, week, selling,
       FIRST_VALUE(selling) IGNORE NULLS
           over (
               partition by fact_name, year
               order by week
               rows between 1 preceding and current row
               ) as prev_week,
        LAST_VALUE(selling) IGNORE NULLS
           over (
               partition by fact_name, year
               order by week
               rows between current row and 1 following
               ) as next_week
FROM data_den;











-- WITH data_den as (
--     SELECT fa.NAME                                                          as fact_name
--          , to_number(to_char(to_date(pp.EVENT_DT_STR, 'MM/DD/YYYY'), 'YY')) as year
--          , to_number(to_char(to_date(pp.EVENT_DT_STR, 'MM/DD/YYYY'), 'WW')) as week
--          , SUM(tp.SALE_PRICE)                                               as salling
--     FROM u_fact_ext.sa_produced_product pp
--              LEFT OUTER JOIN U_FACT_STAR.DIM_DEPT de ON de.NAME = pp.DEPT_NAME
--              LEFT OUTER JOIN U_FACT_STAR.DIM_FACTORY fa ON fa.FACT_ID = de.FACT_ID
--              LEFT OUTER JOIN U_FACT_STAR.DIM_TYPE_PRODUCT_SCD tp ON tp.PR_T_ID = pp.PR_T_ID
--     GROUP BY (fa.NAME, to_number(to_char(to_date(pp.EVENT_DT_STR, 'MM/DD/YYYY'), 'YY')),
--               to_number(to_char(to_date(pp.EVENT_DT_STR, 'MM/DD/YYYY'), 'WW')))
--     ORDER BY fa.NAME, year, week
-- )
-- SELECT fact_name, year, week, FIRST_VALUE(salling)
--            over (
--                partition by fact_name, year
--                order by week
--                rows between unbounded preceding and current row
--                ) as sum_since_year
-- FROM data_den;
