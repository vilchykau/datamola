CREATE OR REPLACE PACKAGE BODY U_FACT_CLS.PKG_ELT_DIM_DEPT AS
    PROCEDURE CLEAN IS
    BEGIN
        PKG_ELT_ASSIST.MOVE('U_FACT_EXT.SA_DEPT', 'U_FACT_CLS.DW_DEPT');
    END;


    PROCEDURE LOAD IS
    BEGIN
        MERGE INTO U_FACT_STAR.DIM_DEPT DD
        USING U_FACT_CLS.DW_DEPT CD
        ON (DD.NAME = CD.NAME)
        WHEN MATCHED THEN
            UPDATE
            SET DD.MNG_ID    = 0
              , DD.UPDATE_DT = SYSDATE
              , DD.FACT_ID   = CD.FACT_ID
        WHEN NOT MATCHED THEN
            INSERT ( DD.NAME
                   , DD.MNG_ID
                   , DD.INSERT_DT
                   , DD.UPDATE_DT
                   , DD.FACT_ID)
            VALUES ( CD.NAME
                   , 0
                   , SYSDATE
                   , SYSDATE
                   , CD.FACT_ID);
    END;
END PKG_ELT_DIM_DEPT;
