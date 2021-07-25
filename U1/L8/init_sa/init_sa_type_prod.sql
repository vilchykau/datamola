drop table u_f_dw_ext_references.SA_TYPE_PRODUCT cascade constraints;

/*==============================================================*/
/* Table: SA_TYPE_PRODUCT                                       */
/*==============================================================*/
create table u_f_dw_ext_references.SA_TYPE_PRODUCT (
   pr_t_id              NUMBER(22,0)          not null,
   name                 VARCHAR(50),
   meta                 VARCHAR(200),
   sale_price           NUMBER(20)
);

GRANT SELECT ON u_f_dw_ext_references.SA_TYPE_PRODUCT TO u_f_dw_cls;