drop table U_FACT_EXT.SA_TYPE_PRODUCT cascade constraints;
drop table U_FACT_EXT.SA_FACTORY cascade constraints;
drop table U_FACT_EXT.SA_PRODUCED_PRODUCT cascade constraints;
drop table U_FACT_EXT.SA_DEPT cascade constraints;
drop table U_FACT_EXT.SA_WORKER cascade constraints;

/*==============================================================*/
/* Table: SA_WORKER                                             */
/*==============================================================*/
create table U_FACT_EXT.SA_WORKER (
   wk_id                NUMBER(22,0)          not null,
   dept_name            VARCHAR(50),
   name                 VARCHAR(50),
   hours_week           NUMBER(15,0),
   salary               NUMBER(15,0)
);


/*==============================================================*/
/* Table: SA_DEPT                                               */
/*==============================================================*/
create table U_FACT_EXT.SA_DEPT (
   name                 VARCHAR(50),
   fact_id              NUMBER(22,0),
   parent_dept          VARCHAR(50)
);



/*==============================================================*/
/* Table: SA_TYPE_PRODUCT                                       */
/*==============================================================*/
create table U_FACT_EXT.SA_TYPE_PRODUCT (
   pr_t_id              NUMBER(22,0)          not null,
   name                 VARCHAR(50),
   meta                 VARCHAR(200),
   sale_price           NUMBER(20)
);

/*==============================================================*/
/* Table: SA_FACTORY                                            */
/*==============================================================*/
create table U_FACT_EXT.SA_FACTORY (
   fact_id              NUMBER(22,0)          not null,
   name                 VARCHAR(50),
   county               VARCHAR(50),
   state                VARCHAR(50),
   city                 VARCHAR(50)
);

/*==============================================================*/
/* Table: SA_PRODUCED_PRODUCT                                   */
/*==============================================================*/
create table U_FACT_EXT.SA_PRODUCED_PRODUCT (
   det_no               NUMBER(22,0)          not null,
   event_dt_str         VARCHAR(50),
   pr_t_id              NUMBER(22,0),
   wk_id                NUMBER(22,0),
   dept_name            VARCHAR(50)
);


grant select on U_FACT_EXT.SA_WORKER to U_FACT_CLS;
grant select on U_FACT_EXT.SA_TYPE_PRODUCT to U_FACT_CLS;
grant select on U_FACT_EXT.SA_PRODUCED_PRODUCT to U_FACT_CLS;
grant select on U_FACT_EXT.SA_FACTORY to U_FACT_CLS;
grant select on U_FACT_EXT.SA_DEPT to U_FACT_CLS;

COMMIT;