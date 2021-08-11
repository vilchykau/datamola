-----------------  RANK  ---------------------
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
SELECT *
FROM (
         SELECT fact_name,
                year,
                week,
                selling,
                RANK() OVER (
                    PARTITION BY fact_name, year
                    ORDER BY selling DESC
                    ) week_rank
         FROM data_den)
WHERE week_rank <= 3;


-------------------  ROWNUM  ----------------------------
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
SELECT *
FROM (
         SELECT fact_name,
                year,
                week,
                selling,
                ROW_NUMBER() OVER (
                    PARTITION BY fact_name, year
                    ORDER BY selling DESC
                    ) week_rank
         FROM data_den)

