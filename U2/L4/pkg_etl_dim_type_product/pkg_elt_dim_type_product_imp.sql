CREATE OR REPLACE PACKAGE BODY PKG_ELT_DIM_TYPE_PRODUCT AS
    PROCEDURE CLEANSING_TYPE_PRODUCT IS
    BEGIN
        EXECUTE IMMEDIATE 'TRUNCATE TABLE U_F_DW_CLS.DW_TYPE_PRODUCT';

        INSERT INTO U_F_DW_CLS.DW_TYPE_PRODUCT ( PR_T_ID
                                               , NAME
                                               , META
                                               , SALE_PRICE)
        SELECT PR_T_ID
             , NAME
             , META
             , SALE_PRICE
        FROM U_F_DW_EXT_REFERENCES.SA_TYPE_PRODUCT;
    END;

    PROCEDURE LOAD IS
    BEGIN
        MERGE INTO U_F_DW_REFERENCES.DIM_TYPE_PRODUCT_SCD VTYPE
        USING U_F_DW_CLS.DW_TYPE_PRODUCT DTYPE
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
