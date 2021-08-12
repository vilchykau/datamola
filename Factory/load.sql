BEGIN
    -- ...............................
    PKG_ELT_DIM_TYPE_PRODUCT.CLEANSING_TYPE_PRODUCT;
    PKG_ELT_DIM_TYPE_PRODUCT.LOAD;

    -- ...............................
    PKG_ELT_DIM_FACT_LOCATION.CLEAN;
    PKG_ELT_DIM_FACT_LOCATION.LOAD;

    -- .................................
    PKG_ELT_DIM_DEPT.CLEAN;
    PKG_ELT_DIM_DEPT.LOAD;

    -- ..................................
    PKG_ETL_DIM_WORKER.CLEAN;
    PKG_ETL_DIM_WORKER.LOAD;

    PKG_ETL_FACT_PP.CLEAN;
    PKG_ETL_FACT_PP.LOAD;
    COMMIT;
END;
