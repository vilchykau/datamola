drop table u_f_dw_ext_references.SA_PRODUCED_PRODUCT cascade constraints;

/*==============================================================*/
/* Table: SA_PRODUCED_PRODUCT                                   */
/*==============================================================*/
create table u_f_dw_ext_references.SA_PRODUCED_PRODUCT (
   det_no               NUMBER(22,0)          not null,
   event_dt_str         VARCHAR(50),
   pr_t_id              NUMBER(22,0),
   wk_id                NUMBER(22,0),
   fact_name            VARCHAR(50),
   dept_name            VARCHAR(50)
);

GRANT SELECT ON u_f_dw_ext_references.SA_PRODUCED_PRODUCT TO u_f_dw_cls;