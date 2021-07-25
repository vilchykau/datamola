drop table u_f_dw_cls.DW_WORKER cascade constraints;

/*==============================================================*/
/* Table: DW_WORKER                                             */
/*==============================================================*/
create table u_f_dw_cls.DW_WORKER (
   wk_id                NUMBER(22,0)          not null,
   dept_raw_id          NUMBER(22,0),
   name                 VARCHAR(50),
   jb_title             VARCHAR(20),
   hours_week           INT,
   salary               INT,
   constraint PK_DW_WORKER primary key (wk_id)
);
