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

drop index u_f_dw_cls.UI_DW_GEO;

drop table u_f_dw_cls.DW_GEO_LOCATIONS cascade constraints;

/*==============================================================*/
/* Table: DW_GEO_LOCATIONS                                      */
/*==============================================================*/
create table u_f_dw_cls.DW_GEO_LOCATIONS (
   raw_loc_id           NUMBER(22,0)          not null,
   state                VARCHAR(100),
   city                 VARCHAR(100),
   contr                VARCHAR(100),
   constraint PK_DW_GEO_LOCATIONS primary key (raw_loc_id)
);

/*==============================================================*/
/* Index: UI_DW_GEO                                             */
/*==============================================================*/
create unique index u_f_dw_cls.UI_DW_GEO on u_f_dw_cls.DW_GEO_LOCATIONS (
   contr ASC,
   city ASC,
   state ASC
);

drop table u_f_dw_cls.DW_STR_LOC_TRUEID cascade constraints;

/*==============================================================*/
/* Table: DW_STR_LOC_TRUEID                                     */
/*==============================================================*/
create table u_f_dw_cls.DW_STR_LOC_TRUEID (
   raw_id               NUMBER(22,0)          not null,
   star_id              NUMBER(22,0),
   constraint PK_DW_STR_LOC_TRUEID primary key (raw_id)
);

drop table u_f_dw_cls.DW_PRODUCED_PRODUCT cascade constraints;

/*==============================================================*/
/* Table: DW_PRODUCED_PRODUCT                                   */
/*==============================================================*/
create table u_f_dw_cls.DW_PRODUCED_PRODUCT (
   det_no               NUMBER(22,0)          not null,
   event_dt             DATE,
   pr_t_id              NUMBER(22,0),
   time_id              NUMBER(22,0),
   wk_id                NUMBER(22,0),
   fact_id              NUMBER(22,0),
   loc_id               NUMBER(22,0),
   dept_raw_id          NUMBER(22,0)
);

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

drop table u_f_dw_cls.DW_STR_DEPT_ID cascade constraints;

/*==============================================================*/
/* Table: DW_STR_DEPT_ID                                        */
/*==============================================================*/
create table u_f_dw_cls.DW_STR_DEPT_ID (
   dept_raw_id          NUMBER(22,0),
   dept_id              NUMBER(22,0),
   fact_id              NUMBER(22,0)
);

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
