CREATE OR REPLACE PACKAGE pkg_sal_dw_cls
AS
    PROCEDURE load_type_product;
    PROCEDURE load_factory;
    PROCEDURE load_produced_prod;
    PROCEDURE load_produced_worker;
END;