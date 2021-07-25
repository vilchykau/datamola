drop table u_f_dw_ext_references.SA_FACTORY cascade constraints;

/*==============================================================*/
/* Table: SA_FACTORY                                            */
/*==============================================================*/
create table u_f_dw_ext_references.SA_FACTORY (
   fact_id              NUMBER(22,0)          not null,
   name                 VARCHAR(50),
   county               VARCHAR(50),
   state                VARCHAR(50),
   city                 VARCHAR(50)
);

GRANT SELECT ON u_f_dw_ext_references.SA_FACTORY TO u_f_dw_cls;