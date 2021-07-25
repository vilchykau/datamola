drop table u_f_dw_cls.DW_TYPE_PRODUCT cascade constraints;

/*==============================================================*/
/* Table: DW_TYPE_PRODUCT                                       */
/*==============================================================*/
create table u_f_dw_cls.DW_TYPE_PRODUCT (
   pr_t_id              NUMBER(22,0)          not null,
   name                 VARCHAR(50),
   meta                 VARCHAR(200),
   sale_price           NUMBER(20),
   constraint PK_DW_TYPE_PRODUCT primary key (pr_t_id)
);
