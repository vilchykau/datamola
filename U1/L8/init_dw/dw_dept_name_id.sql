drop table u_f_dw_cls.DW_DEPT_NAME_ID cascade constraints;

/*==============================================================*/
/* Table: DW_DEPT_NAME_ID                                       */
/*==============================================================*/
create table u_f_dw_cls.DW_DEPT_NAME_ID (
   dept_name            VARCHAR(50)           not null,
   dept_raw_id          NUMBER(22,0),
   fact_id              NUMBER(22,0),
   constraint PK_DW_DEPT_NAME_ID primary key (dept_name)
);
