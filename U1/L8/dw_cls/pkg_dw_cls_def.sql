CREATE OR REPLACE PACKAGE pkg_dw_cls
AS
    PROCEDURE load_dw_type_product;
    PROCEDURE load_dw_fact_loc;

    PROCEDURE load_dw_dept_nameid;
    PROCEDURE load_dw_proc_prod;
    PROCEDURE load_dw_worker;

    PROCEDURE load_str_dept_id;
END;