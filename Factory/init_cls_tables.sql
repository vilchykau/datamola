drop table U_FACT_CLS.DW_TYPE_PRODUCT cascade constraints;
drop table U_FACT_CLS.DW_FACTORY_LOC cascade constraints;
drop table U_FACT_CLS.DW_DEPT cascade constraints;
drop table U_FACT_CLS.DW_WORKER cascade constraints;

/*==============================================================*/
/* Table: DW_WORKER                                             */
/*==============================================================*/
create table U_FACT_CLS.DW_WORKER (
   wk_id                NUMBER(22,0)          not null,
   dept_raw_id          VARCHAR(50),
   name                 VARCHAR(50),
   jb_title             VARCHAR(20),
   hours_week           INT,
   salary               INT,
   constraint PK_DW_WORKER primary key (wk_id)
);

/*==============================================================*/
/* Table: DW_DEPT                                               */
/*==============================================================*/
create table U_FACT_CLS.DW_DEPT (
   name                 VARCHAR(50),
   fact_id              NUMBER(22,0),
   parent_dept          VARCHAR(50)
);


/*==============================================================*/
/* Table: DW_FACTORY_LOC                                        */
/*==============================================================*/
create table U_FACT_CLS.DW_FACTORY_LOC (
   fact_id              NUMBER(22,0)          not null,
   name                 VARCHAR(50),
   county               VARCHAR(50),
   state                VARCHAR(50),
   city                 VARCHAR(50)
);


/*==============================================================*/
/* Table: DW_TYPE_PRODUCT                                       */
/*==============================================================*/
create table U_FACT_CLS.DW_TYPE_PRODUCT (
   pr_t_id              NUMBER(22,0)          not null,
   name                 VARCHAR(50),
   meta                 VARCHAR(200),
   sale_price           NUMBER(20),
   constraint PK_DW_TYPE_PRODUCT primary key (pr_t_id)
);


COMMIT;