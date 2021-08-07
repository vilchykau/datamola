CREATE OR REPLACE PACKAGE BODY U_FACT_CLS.PKG_ETL_DIM_WORKER IS

    PROCEDURE LOAD IS
    BEGIN
        MERGE INTO U_FACT_STAR.DIM_WORKER_SCD OL
        USING (SELECT WK.*, DE.DEPT_ID
               FROM U_FACT_CLS.DW_WORKER WK
                        LEFT JOIN U_FACT_STAR.DIM_DEPT DE ON WK.DEPT_RAW_ID = DE.NAME
        ) NW
        ON (OL.WK_ID = NW.WK_ID)
        WHEN MATCHED THEN
            UPDATE
            SET OL.DEPT_ID = NW.DEPT_ID
              , OL.NAME    = NW.NAME
              , OL.SALARY  = NW.SALARY
              , VALID_FROM = SYSDATE
              , VALID_TO   = NULL
              , IS_ACTIVE  = 1
        WHEN NOT MATCHED THEN
            INSERT ( OL.NAME
                   , OL.WK_ID
                   , OL.DEPT_ID
                   , OL.SALARY
                   , OL.VALID_FROM
                   , OL.VALID_TO
                   , OL.IS_ACTIVE
                   , OL.INSERT_DT)
            VALUES ( NW.NAME
                   , NW.WK_ID
                   , NW.DEPT_ID
                   , NW.SALARY
                   , SYSDATE
                   , NULL
                   , 1
                   , SYSDATE);

    END;


    PROCEDURE CLEAN IS
        TYPE Fact_T IS RECORD
                       (
                           WK_ID      U_FACT_EXT.SA_WORKER.WK_ID%TYPE,
                           DEPT_NAME  U_FACT_EXT.SA_WORKER.DEPT_NAME%TYPE,
                           NAME       U_FACT_EXT.SA_WORKER.NAME%TYPE,
                           HOURS_WEEK U_FACT_EXT.SA_WORKER.HOURS_WEEK%TYPE,
                           SALARY     U_FACT_EXT.SA_WORKER.SALARY%TYPE
                       );
        TYPE FactTable_T IS TABLE OF Fact_T;
        lines FactTable_T;
    BEGIN
        EXECUTE IMMEDIATE 'TRUNCATE TABLE U_FACT_CLS.DW_WORKER';

        SELECT WK_ID
             , DEPT_NAME
             , NAME
             , HOURS_WEEK
             , SALARY
        BULK COLLECT INTO lines
        FROM U_FACT_EXT.SA_WORKER;

        FORALL idx in 1..lines.COUNT
            INSERT INTO U_FACT_CLS.DW_WORKER( WK_ID
                                            , DEPT_RAW_ID
                                            , NAME
                                            , JB_TITLE
                                            , SALARY)
            VALUES ( lines(idx).WK_ID
                   , lines(idx).DEPT_NAME
                   , lines(idx).NAME
                   , NULL
                   , lines(idx).SALARY);
    END;

END PKG_ETL_DIM_WORKER;