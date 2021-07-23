drop table DATETIME cascade constraints;

/*==============================================================*/
/* Table: DATETIME                                              */
/*==============================================================*/
create table DATETIME (
   "time_id"            NUMBER(22, 0),
   "day_name"           VARCHAR(15),
   "day_num_week"       NUMBER(1, 0),
   "day_number_month"   NUMBER(2, 0),
   "day_number_year"    NUMBER(3, 0),
   "wk_cal_num"         NUMBER(2,0),
   "wk_end_dt"          DATE,
   "mth_cnt_days"       NUMBER(2,0),
   "mth_name"           VARCHAR(15),
   "qtr_cnt_days"       NUMBER(3,0),
   "qtr_stat_dt"        DATE,
   "qtr_end_dt"         DATE,
   "qtr_cal_num"        NUMBER(4,0),
   "year"               NUMBER(4,0),
   "year_cnt_days"      NUMBER(3,0),
   "year_start_dt"      DATE,
   "year_end_dt"        DATE
);
