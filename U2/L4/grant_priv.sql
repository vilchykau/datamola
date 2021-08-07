-- grant SA layer
grant select, insert, update, delete on U_F_DW_EXT_REFERENCES.SA_DEPT to u_f_dw_cls;
grant select, insert, update, delete on U_F_DW_EXT_REFERENCES.SA_FACTORY to U_F_DW_CLS;
grant select, insert, update, delete on U_F_DW_EXT_REFERENCES.SA_PRODUCED_PRODUCT to U_F_DW_CLS;
grant select, insert, update, delete on U_F_DW_EXT_REFERENCES.SA_TYPE_PRODUCT to U_F_DW_CLS;
grant select, insert, update, delete on U_F_DW_EXT_REFERENCES.SA_WORKER to U_F_DW_CLS;

-- grant DW layer
grant select, insert, update, delete on U_F_DW_CLS.DW_TYPE_PRODUCT to u_f_dw_cls;

GRANT UNLIMITED TABLESPACE TO u_f_dw_cls;
-- grant star layer
GRANT SELECT, INSERT, UPDATE, DELETE ON U_F_DW_REFERENCES.DIM_TYPE_PRODUCT_SCD TO u_f_dw_cls;
-- TODO