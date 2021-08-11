WITH data_den as (
    SELECT fa.NAME                                                          as fact_name
         , to_number(to_char(to_date(pp.EVENT_DT_STR, 'MM/DD/YYYY'), 'WW')) as week
         , SALE_PRICE                                                       as selling
         , to_date(pp.EVENT_DT_STR, 'MM/DD/YYYY')                           as datet
         , trunc(sysdate - to_date(pp.EVENT_DT_STR, 'MM/DD/YYYY'))          as delta_days
    FROM u_fact_ext.sa_produced_product pp
             LEFT OUTER JOIN U_FACT_STAR.DIM_DEPT de
                             ON de.NAME = pp.DEPT_NAME
             LEFT OUTER JOIN U_FACT_STAR.DIM_FACTORY fa ON fa.FACT_ID = de.FACT_ID
             LEFT OUTER JOIN U_FACT_STAR.DIM_TYPE_PRODUCT_SCD tp ON tp.PR_T_ID = pp.PR_T_ID
    ORDER BY fact_name, datet
)
SELECT fact_name,
       datet, MAX(week_max__) as week_max,
       MAX(week_agv__) as week_avg,
       MAX(week_min__) as weel_min
FROM (
         SELECT fact_name,
                datet
                 ,
                MAX(selling) OVER (
                    PARTITION BY fact_name
                    ORDER BY delta_days
                    RANGE BETWEEN 7 PRECEDING AND CURRENT ROW
                    ) week_max__
                 ,
                AVG(selling) OVER (
                    PARTITION BY fact_name
                    ORDER BY delta_days
                    RANGE BETWEEN 7 PRECEDING AND CURRENT ROW
                    ) week_agv__
                 ,
                MIN(selling) OVER (
                    PARTITION BY fact_name
                    ORDER BY delta_days
                    RANGE BETWEEN 7 PRECEDING AND CURRENT ROW
                    ) week_min__
         FROM data_den
         ORDER BY fact_name, datet)
GROUP BY fact_name, datet
ORDER BY fact_name, datet;