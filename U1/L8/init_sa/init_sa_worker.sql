drop table u_f_dw_ext_references.SA_WORKER cascade constraints;

/*==============================================================*/
/* Table: SA_WORKER                                             */
/*==============================================================*/
create table u_f_dw_ext_references.SA_WORKER (
   wk_id                NUMBER(22,0)          not null,
   dept_name            VARCHAR(50),
   name                 VARCHAR(50),
   hours_week           NUMBER(15,0),
   salary               NUMBER(15,0)
);

GRANT SELECT ON u_f_dw_ext_references.SA_WORKER TO u_f_dw_cls;