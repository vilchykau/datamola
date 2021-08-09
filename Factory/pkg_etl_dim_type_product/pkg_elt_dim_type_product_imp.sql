CREATE OR REPLACE PACKAGE BODY PKG_ELT_DIM_TYPE_PRODUCT AS
    PROCEDURE CLEANSING_TYPE_PRODUCT IS
    BEGIN
        PKG_ELT_ASSIST.MOVE_DBMS_CUR('U_FACT_EXT.SA_TYPE_PRODUCT',
            'U_FACT_CLS.DW_TYPE_PRODUCT');
    END;

    PROCEDURE LOAD IS
    BEGIN
        MERGE INTO U_FACT_STAR.DIM_TYPE_PRODUCT_SCD VTYPE
        USING U_FACT_CLS.DW_TYPE_PRODUCT DTYPE
        ON (VTYPE.PR_T_ID = DTYPE.PR_T_ID)
        WHEN MATCHED THEN
            UPDATE
            SET VTYPE.NAME       = DTYPE.NAME
              , VTYPE.META       = DTYPE.META
              , VTYPE.SALE_PRICE = DTYPE.SALE_PRICE
              , VTYPE.VALID_FROM = SYSDATE
              , VTYPE.VALID_TO   = NULL
              , VTYPE.IS_ACTIVE  = 1
              , VTYPE.INSERT_DT  = SYSDATE
        WHEN NOT MATCHED THEN
            INSERT ( VTYPE.PR_T_ID
                   , VTYPE.NAME
                   , VTYPE.META
                   , VTYPE.SALE_PRICE
                   , VTYPE.VALID_FROM
                   , VTYPE.VALID_TO
                   , VTYPE.IS_ACTIVE
                   , VTYPE.INSERT_DT)
            VALUES ( DTYPE.PR_T_ID
                   , DTYPE.NAME
                   , DTYPE.META
                   , DTYPE.SALE_PRICE
                   , SYSDATE
                   , NULL
                   , 1
                   , SYSDATE);
    END;
END PKG_ELT_DIM_TYPE_PRODUCT;
/
