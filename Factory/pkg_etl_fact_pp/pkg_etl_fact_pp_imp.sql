CREATE OR REPLACE PACKAGE BODY U_FACT_CLS.PKG_ETL_FACT_PP IS
    PROCEDURE CLEAN IS
    BEGIN
        PKG_ELT_ASSIST.MOVE('U_FACT_EXT.SA_PRODUCED_PRODUCT',
                            'U_FACT_CLS.DW_PRODUCED_PRODUCT');
    END;

    PROCEDURE LOAD IS
    BEGIN
        MERGE INTO U_FACT_STAR.FACT_PRODUCED_PRODUCT s
        USING (
            SELECT det_no,
                   TO_DATE(pp.EVENT_DT_STR, 'MM/DD/YYYY') ev_date,
                   pp.PR_T_ID,
                   pp.wk_id,
                   de.fact_id,
                   de.dept_id,
                   fa.loc_id
            FROM DW_PRODUCED_PRODUCT pp
                     LEFT OUTER JOIN U_FACT_STAR.DIM_DEPT de ON pp.DEPT_NAME = de.NAME
                     LEFT OUTER JOIN U_FACT_STAR.DIM_FACTORY fa ON fa.FACT_ID = de.FACT_ID) c
        ON (s.DET_NO = c.DET_NO)
        WHEN NOT MATCHED THEN
            INSERT (s.DET_NO,
                    s.EVENT_DT,
                    s.INSERT_DT,
                    s.TIME_ID,
                    s.WK_ID,
                    s.FACT_ID,
                    s.DEPT_ID,
                    s.LOC_ID,
                    s.PR_T_ID)
            VALUES (c.DET_NO,
                    c.ev_date,
                    SYSDATE,
                    0,
                    c.WK_ID,
                    c.FACT_ID,
                    c.DEPT_ID,
                    c.LOC_ID,
                    c.PR_T_ID)
        WHEN MATCHED THEN
            UPDATE
            SET s.EVENT_DT  = c.ev_date,
                s.WK_ID     = c.WK_ID,
                s.FACT_ID   = c.FACT_ID,
                s.DEPT_ID   = c.DEPT_ID,
                s.LOC_ID    = c.LOC_ID,
                s.PR_T_ID   = c.PR_T_ID,
                s.INSERT_DT = SYSDATE;
    END;
END PKG_ETL_FACT_PP;