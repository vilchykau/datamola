alter table DATETIME
   drop constraint "FK_DATETIME_REFERENCE_DW.T_QUA";

alter table DATETIME
   drop constraint "FK_DATETIME_REFERENCE_DW.T_MON";

alter table DATETIME
   drop constraint "FK_DATETIME_REFERENCE_DW.T_YEA";

alter table DATETIME
   drop constraint "FK_DATETIME_REFERENCE_DW.T_WEE";

alter table DATETIME
   drop constraint "FK_DATETIME_REFERENCE_DW.T_DAY";

drop table DATETIME cascade constraints;

drop table "DW.T_DAYS" cascade constraints;

drop table "DW.T_MONTHS" cascade constraints;

drop table "DW.T_QUARTERS" cascade constraints;

drop table "DW.T_WEEKS" cascade constraints;

drop table "DW.T_YEARS" cascade constraints;

/*==============================================================*/
/* Table: DATETIME                                              */
/*==============================================================*/
create table DATETIME (
   "time_id"            NUMBER(22, 0)         not null,
   "qtr_id"             NUMBER(22,0),
   "mth_id"             NUMBER(22,0),
   "year_id"            NUMBER(22,0),
   "wk_id"              NUMBER(22,0),
   "day_id"             NUMBER(22,0),
   constraint PK_DATETIME primary key ("time_id")
);

/*==============================================================*/
/* Table: "DW.T_DAYS"                                           */
/*==============================================================*/
create table "DW.T_DAYS" (
   "day_id"             NUMBER(22,0)          not null,
   "day_name"           VARCHAR(15),
   "day_num_week"       NUMBER(1, 0),
   "day_number_month"   NUMBER(2, 0),
   "day_number_year"    NUMBER(3, 0),
   constraint "PK_DW.T_DAYS" primary key ("day_id")
);

/*==============================================================*/
/* Table: "DW.T_MONTHS"                                         */
/*==============================================================*/
create table "DW.T_MONTHS" (
   "mth_id"             NUMBER(22,0)          not null,
   "mth_cnt_days"       NUMBER(2,0),
   "mth_name"           VARCHAR(15),
   constraint "PK_DW.T_MONTHS" primary key ("mth_id")
);

/*==============================================================*/
/* Table: "DW.T_QUARTERS"                                       */
/*==============================================================*/
create table "DW.T_QUARTERS" (
   "qtr_id"             NUMBER(22,0)          not null,
   "qtr_cnt_days"       NUMBER(3,0),
   "qtr_stat_dt"        DATE,
   "qtr_end_dt"         DATE,
   "qtr_cal_num"        NUMBER(4,0),
   constraint "PK_DW.T_QUARTERS" primary key ("qtr_id")
);

/*==============================================================*/
/* Table: "DW.T_WEEKS"                                          */
/*==============================================================*/
create table "DW.T_WEEKS" (
   "wk_id"              NUMBER(22,0)          not null,
   "wk_cal_num"         NUMBER(2,0),
   "wk_end_dt"          DATE,
   constraint "PK_DW.T_WEEKS" primary key ("wk_id")
);

/*==============================================================*/
/* Table: "DW.T_YEARS"                                          */
/*==============================================================*/
create table "DW.T_YEARS" (
   "year_id"            NUMBER(22,0)          not null,
   "year"               NUMBER(4,0),
   "year_cnt_days"      NUMBER(3,0),
   "year_start_dt"      DATE,
   "year_end_dt"        DATE,
   constraint "PK_DW.T_YEARS" primary key ("year_id")
);

alter table DATETIME
   add constraint "FK_DATETIME_REFERENCE_DW.T_QUA" foreign key ("qtr_id")
      references "DW.T_QUARTERS" ("qtr_id");

alter table DATETIME
   add constraint "FK_DATETIME_REFERENCE_DW.T_MON" foreign key ("mth_id")
      references "DW.T_MONTHS" ("mth_id");

alter table DATETIME
   add constraint "FK_DATETIME_REFERENCE_DW.T_YEA" foreign key ("year_id")
      references "DW.T_YEARS" ("year_id");

alter table DATETIME
   add constraint "FK_DATETIME_REFERENCE_DW.T_WEE" foreign key ("wk_id")
      references "DW.T_WEEKS" ("wk_id");

alter table DATETIME
   add constraint "FK_DATETIME_REFERENCE_DW.T_DAY" foreign key ("day_id")
      references "DW.T_DAYS" ("day_id");
