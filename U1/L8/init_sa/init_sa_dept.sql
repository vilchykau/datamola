drop table u_f_dw_ext_references.SA_DEPT cascade constraints;

/*==============================================================*/
/* Table: SA_DEPT                                               */
/*==============================================================*/
create table u_f_dw_ext_references.SA_DEPT (
   name                 VARCHAR(50),
   fact_id              NUMBER(22,0),
);

GRANT SELECT ON u_f_dw_ext_references.SA_DEPT TO u_f_dw_cls;