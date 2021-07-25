drop table u_f_dw_cls.DW_FACTORY cascade constraints;

/*==============================================================*/
/* Table: DW_FACTORY                                            */
/*==============================================================*/
create table u_f_dw_cls.DW_FACTORY (
   fact_id              NUMBER(22,0)          not null,
   name                 VARCHAR(50),
   raw_loc_id           NUMBER(22,0),
   constraint PK_DW_FACTORY primary key (fact_id)
);
