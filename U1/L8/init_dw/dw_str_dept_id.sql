drop table u_f_dw_cls.DW_STR_DEPT_ID cascade constraints;

/*==============================================================*/
/* Table: DW_STR_DEPT_ID                                        */
/*==============================================================*/
create table u_f_dw_cls.DW_STR_DEPT_ID (
   dept_raw_id          NUMBER(22,0)          not null,
   dept_id              NUMBER(22,0),
   fact_id              NUMBER(22,0),
   constraint PK_DW_STR_DEPT_ID primary key (dept_raw_id)
);
