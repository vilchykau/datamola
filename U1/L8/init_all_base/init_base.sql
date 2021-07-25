-- Type package declaration
create or replace package PDTypes  
as
    TYPE ref_cursor IS REF CURSOR;
end;

-- Integrity package declaration
create or replace package IntegrityPackage AS
 procedure InitNestLevel;
 function GetNestLevel return number;
 procedure NextNestLevel;
 procedure PreviousNestLevel;
 end IntegrityPackage;
/

-- Integrity package definition
create or replace package body IntegrityPackage AS
 NestLevel number;

-- Procedure to initialize the trigger nest level
 procedure InitNestLevel is
 begin
 NestLevel := 0;
 end;


-- Function to return the trigger nest level
 function GetNestLevel return number is
 begin
 if NestLevel is null then
     NestLevel := 0;
 end if;
 return(NestLevel);
 end;

-- Procedure to increase the trigger nest level
 procedure NextNestLevel is
 begin
 if NestLevel is null then
     NestLevel := 0;
 end if;
 NestLevel := NestLevel + 1;
 end;

-- Procedure to decrease the trigger nest level
 procedure PreviousNestLevel is
 begin
 NestLevel := NestLevel - 1;
 end;

 end IntegrityPackage;
/


drop trigger u_f_dw_references.TW_DIM_DEPT_INSET
/

drop trigger u_f_dw_references.TW_DIM_DEPT_UPDATE
/

drop trigger u_f_dw_references.T_W_TYPE_DELETE
/

drop trigger u_f_dw_references.W_TYPE_INSERT
/

drop trigger u_f_dw_references.W_TYPE_UPDATE
/

drop trigger u_f_dw_references.TW_DIM_WORKER_DELETE
/

drop trigger u_f_dw_references.TW_DIM_WORKER_INSERT
/

drop trigger u_f_dw_references.TW_DIM_WORKER_UPDATE
/

drop trigger u_f_dw_cls.T_W_DW_FACTORY_INSERT
/

alter table u_f_dw_references.DIM_WORKER_SCD
   drop constraint FK_DIM_WORK_REFERENCE_DIM_DEPT
/

alter table u_f_dw_references.FACT_AGG_WORKER_PRODTIME_DATE
   drop constraint FK_FACT_AGG_REFERENCE_DIM_WORK
/

alter table u_f_dw_references.FACT_AGG_WORKER_PRODTIME_DATE
   drop constraint FK_FACT_AGG_REFERENCE_DM_TIME
/

alter table u_f_dw_references.FACT_PRODUCED_PRODUCT
   drop constraint FK_FACT_PRO_REFERENCE_DIM_TYPE
/

alter table u_f_dw_references.FACT_PRODUCED_PRODUCT
   drop constraint FK_FACT_PRO_REFERENCE_DIM_WORK
/

alter table u_f_dw_references.FACT_PRODUCED_PRODUCT
   drop constraint FK_FACT_PRO_REFERENCE_DIM_FACT
/

alter table u_f_dw_references.FACT_PRODUCED_PRODUCT
   drop constraint FK_FACT_PRO_REFERENCE_DIM_DEPT
/

alter table u_f_dw_references.FACT_PRODUCED_PRODUCT
   drop constraint FK_FACT_PRO_REFERENCE_DIM_GEO_
/

alter table u_f_dw_references.FACT_PRODUCED_PRODUCT
   drop constraint FK_FACT_PRO_REFERENCE_DM_TIME
/

drop view u_f_dw_cls.W_DW_FACTORY
/

drop view u_f_dw_references.W_DIM_WORKER_SCD
/

drop view u_f_dw_references.W_DIM_TYPE_PRODUCT_SCD
/

drop view u_f_dw_references.W_DIM_GEO_LOCATIONS
/

drop view u_f_dw_references.W_DIM_DEPT
/

drop table u_f_dw_references.DIM_DEPT cascade constraints
/

drop table u_f_dw_references.DIM_FACTORY cascade constraints
/

drop table u_f_dw_references.DIM_GEO_LOCATIONS cascade constraints
/

drop index u_f_dw_references.IDX_PROD
/

drop table u_f_dw_references.DIM_TYPE_PRODUCT_SCD cascade constraints
/

drop index u_f_dw_references.IDX_WORKER
/

drop table u_f_dw_references.DIM_WORKER_SCD cascade constraints
/

drop table u_f_dw_references.DM_TIME cascade constraints
/

drop table u_f_dw_cls.DW_DEPT_NAME_ID cascade constraints
/

drop table u_f_dw_cls.DW_FACTORY cascade constraints
/

drop index u_f_dw_cls.UI_DW_GEO
/

drop table u_f_dw_cls.DW_GEO_LOCATIONS cascade constraints
/

drop table u_f_dw_cls.DW_PRODUCED_PRODUCT cascade constraints
/

drop table u_f_dw_cls.DW_STR_DEPT_ID cascade constraints
/

drop table u_f_dw_cls.DW_STR_LOC_TRUEID cascade constraints
/

drop table u_f_dw_cls.DW_TYPE_PRODUCT cascade constraints
/

drop table u_f_dw_cls.DW_WORKER cascade constraints
/

drop table u_f_dw_references.FACT_AGG_WORKER_PRODTIME_DATE cascade constraints
/

drop table u_f_dw_references.FACT_PRODUCED_PRODUCT cascade constraints
/

drop table u_f_dw_ext_references.SA_DEPT cascade constraints
/

drop table u_f_dw_ext_references.SA_FACTORY cascade constraints
/

drop table u_f_dw_ext_references.SA_PRODUCED_PRODUCT cascade constraints
/

drop table u_f_dw_ext_references.SA_TYPE_PRODUCT cascade constraints
/

drop table u_f_dw_ext_references.SA_WORKER cascade constraints
/

drop sequence u_f_dw_cls.sq_dw_geo
/

drop user u_f_dw_cls
/

drop user u_f_dw_ext_references
/

drop user u_f_dw_references
/

drop tablespace TS_CLS including contents cascade constraints
/

drop tablespace Tablespace_2 including contents cascade constraints
/

create tablespace TS_CLS
datafile 'ts_cls_st'
size 50m
 autoextend on next 50m
 segment space management auto
/

create tablespace Tablespace_2
/

/*==============================================================*/
/* User: u_f_dw_cls                                             */
/*==============================================================*/
create user u_f_dw_cls 
  identified by ""
/

/*==============================================================*/
/* User: u_f_dw_ext_references                                  */
/*==============================================================*/
create user u_f_dw_ext_references 
  identified by ""
    default tablespace TS_REFERENCES_EXT_DATA_01
/

/*==============================================================*/
/* User: u_f_dw_references                                      */
/*==============================================================*/
create user u_f_dw_references 
  identified by ""
    default tablespace TS_REFERENCES_DATA_01
/

create sequence u_f_dw_cls.sq_dw_geo
increment by 1
start with 1
/

/*==============================================================*/
/* Table: DIM_DEPT                                              */
/*==============================================================*/
create table u_f_dw_references.DIM_DEPT (
   dept_id              NUMBER(22,0)          not null,
   name                 VARCHAR(50),
   mng_id               NUMBER(22,0),
   insert_dt            DATE,
   update_dt            DATE,
   fact_id              NUMBER(22,0),
   constraint PK_DIM_DEPT primary key (dept_id)
)
/

/*==============================================================*/
/* Table: DIM_FACTORY                                           */
/*==============================================================*/
create table u_f_dw_references.DIM_FACTORY (
   fact_id              NUMBER(22,0)          not null,
   name                 VARCHAR(50),
   insert_dt            DATE,
   update_dt            DATE,
   loc_id               NUMBER(22,0),
   constraint PK_DIM_FACTORY primary key (fact_id)
)
/

/*==============================================================*/
/* Table: DIM_GEO_LOCATIONS                                     */
/*==============================================================*/
create table u_f_dw_references.DIM_GEO_LOCATIONS (
   loc_id               NUMBER(22,0)          not null,
   state                VARCHAR(100),
   city                 VARCHAR(100),
   contr                VARCHAR(100),
   constraint PK_DIM_GEO_LOCATIONS primary key (loc_id)
)
/

/*==============================================================*/
/* Table: DIM_TYPE_PRODUCT_SCD                                  */
/*==============================================================*/
create table u_f_dw_references.DIM_TYPE_PRODUCT_SCD (
   pr_t_id              NUMBER(22,0),
   name                 VARCHAR(50),
   meta                 VARCHAR(200),
   sale_price           NUMBER(20),
   valid_from           DATE,
   valid_to             DATE,
   is_active            VARCHAR2(4),
   insert_dt            DATE
)
/

/*==============================================================*/
/* Index: IDX_PROD                                              */
/*==============================================================*/
create index u_f_dw_references.IDX_PROD on u_f_dw_references.DIM_TYPE_PRODUCT_SCD (
   insert_dt ASC,
   valid_from ASC,
   is_active ASC
)
/

/*==============================================================*/
/* Table: DIM_WORKER_SCD                                        */
/*==============================================================*/
create table u_f_dw_references.DIM_WORKER_SCD (
   wk_id                NUMBER(22,0)          not null,
   dept_id              NUMBER(22,0),
   name                 VARCHAR(50),
   salary               INT,
   valid_from           DATE                  not null,
   valid_to             DATE                  not null,
   is_active            VARCHAR2(4),
   insert_dt            DATE,
   constraint PK_DIM_WORKER_SCD primary key (wk_id, valid_from)
)
/

/*==============================================================*/
/* Index: IDX_WORKER                                            */
/*==============================================================*/
create index u_f_dw_references.IDX_WORKER on u_f_dw_references.DIM_WORKER_SCD (
   wk_id ASC,
   is_active ASC,
   valid_from ASC
)
/

/*==============================================================*/
/* Table: DM_TIME                                               */
/*==============================================================*/
create table u_f_dw_references.DM_TIME (
   time_id              NUMBER(22, 0)         not null,
   day_name             VARCHAR(15),
   day_num_week         NUMBER(1, 0),
   day_number_month     NUMBER(2, 0),
   day_number_year      NUMBER(3, 0),
   wk_cal_num           NUMBER(2,0),
   wk_end_dt            DATE,
   mth_cnt_days         NUMBER(2,0),
   mth_name             VARCHAR(15),
   qtr_cnt_days         NUMBER(3,0),
   qtr_stat_dt          DATE,
   qtr_end_dt           DATE,
   qtr_cal_num          NUMBER(4,0),
   year                 NUMBER(4,0),
   year_cnt_days        NUMBER(3,0),
   year_start_dt        DATE,
   year_end_dt          DATE,
   constraint PK_DM_TIME primary key (time_id)
)
/

/*==============================================================*/
/* Table: DW_DEPT_NAME_ID                                       */
/*==============================================================*/
create table u_f_dw_cls.DW_DEPT_NAME_ID (
   dept_name            VARCHAR(50)           not null,
   dept_raw_id          NUMBER(22,0),
   fact_id              NUMBER(22,0),
   constraint PK_DW_DEPT_NAME_ID primary key (dept_name)
)
/

/*==============================================================*/
/* Table: DW_FACTORY                                            */
/*==============================================================*/
create table u_f_dw_cls.DW_FACTORY (
   fact_id              NUMBER(22,0)          not null,
   name                 VARCHAR(50),
   raw_loc_id           NUMBER(22,0),
   constraint PK_DW_FACTORY primary key (fact_id)
)
/

/*==============================================================*/
/* Table: DW_GEO_LOCATIONS                                      */
/*==============================================================*/
create table u_f_dw_cls.DW_GEO_LOCATIONS (
   raw_loc_id           NUMBER(22,0)          not null,
   state                VARCHAR(100),
   city                 VARCHAR(100),
   contr                VARCHAR(100),
   constraint PK_DW_GEO_LOCATIONS primary key (raw_loc_id)
)
/

/*==============================================================*/
/* Index: UI_DW_GEO                                             */
/*==============================================================*/
create unique index u_f_dw_cls.UI_DW_GEO on u_f_dw_cls.DW_GEO_LOCATIONS (
   contr ASC,
   city ASC,
   state ASC
)
/

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
   dept_raw_id          NUMBER(22,0),
   constraint PK_DW_PRODUCED_PRODUCT primary key ()
)
/

/*==============================================================*/
/* Table: DW_STR_DEPT_ID                                        */
/*==============================================================*/
create table u_f_dw_cls.DW_STR_DEPT_ID (
   dept_raw_id          NUMBER(22,0),
   dept_id              NUMBER(22,0),
   fact_id              NUMBER(22,0)
)
/

/*==============================================================*/
/* Table: DW_STR_LOC_TRUEID                                     */
/*==============================================================*/
create table u_f_dw_cls.DW_STR_LOC_TRUEID (
   raw_id               NUMBER(22,0)          not null,
   star_id              NUMBER(22,0),
   constraint PK_DW_STR_LOC_TRUEID primary key (raw_id)
)
/

/*==============================================================*/
/* Table: DW_TYPE_PRODUCT                                       */
/*==============================================================*/
create table u_f_dw_cls.DW_TYPE_PRODUCT (
   pr_t_id              NUMBER(22,0)          not null,
   name                 VARCHAR(50),
   meta                 VARCHAR(200),
   sale_price           NUMBER(20),
   constraint PK_DW_TYPE_PRODUCT primary key (pr_t_id)
)
/

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
)
/

/*==============================================================*/
/* Table: FACT_AGG_WORKER_PRODTIME_DATE                         */
/*==============================================================*/
create table u_f_dw_references.FACT_AGG_WORKER_PRODTIME_DATE (
   wk_id                NUMBER(22,0)          not null,
   valid_from           DATE                  not null,
   valid_to             DATE                  not null,
   time_id              NUMBER(22,0)          not null,
   product_cnt          NUMBER(5,0),
   sale_price           NUMBER(10,),
   constraint PK_FACT_AGG_WORKER_PRODTIME_DA primary key (wk_id, valid_from, valid_to, time_id)
)
/

/*==============================================================*/
/* Table: FACT_PRODUCED_PRODUCT                                 */
/*==============================================================*/
create table u_f_dw_references.FACT_PRODUCED_PRODUCT (
   det_no               NUMBER(22,0)          not null,
   event_dt             DATE,
   insert_dt            DATE,
   time_id              NUMBER(22,0),
   wk_id                NUMBER(22,0),
   fact_id              NUMBER(22,0),
   dept_id              NUMBER(22,0),
   loc_id               NUMBER(22,0),
   pr_t_id              NUMBER(22,0),
   constraint PK_FACT_PRODUCED_PRODUCT primary key (det_no)
)
/

/*==============================================================*/
/* Table: SA_DEPT                                               */
/*==============================================================*/
create table u_f_dw_ext_references.SA_DEPT (
   name                 VARCHAR(50),
   fact_id              NUMBER(22,0)
)
/

/*==============================================================*/
/* Table: SA_FACTORY                                            */
/*==============================================================*/
create table u_f_dw_ext_references.SA_FACTORY (
   fact_id              NUMBER(22,0)          not null,
   name                 VARCHAR(50),
   county               VARCHAR(50),
   state                VARCHAR(50),
   city                 VARCHAR(50)
)
/

/*==============================================================*/
/* Table: SA_PRODUCED_PRODUCT                                   */
/*==============================================================*/
create table u_f_dw_ext_references.SA_PRODUCED_PRODUCT (
   det_no               NUMBER(22,0)          not null,
   event_dt_str         VARCHAR(50),
   pr_t_id              NUMBER(22,0),
   wk_id                NUMBER(22,0),
   dept_name            VARCHAR(50),
   constraint PK_SA_PRODUCED_PRODUCT primary key ()
)
/

/*==============================================================*/
/* Table: SA_TYPE_PRODUCT                                       */
/*==============================================================*/
create table u_f_dw_ext_references.SA_TYPE_PRODUCT (
   pr_t_id              NUMBER(22,0)          not null,
   name                 VARCHAR(50),
   meta                 VARCHAR(200),
   sale_price           NUMBER(20)
)
/

/*==============================================================*/
/* Table: SA_WORKER                                             */
/*==============================================================*/
create table u_f_dw_ext_references.SA_WORKER (
   wk_id                NUMBER(22,0)          not null,
   dept_name            VARCHAR(50),
   name                 VARCHAR(50),
   hours_week           NUMBER(15,0),
   salary               NUMBER(15,0)
)
/

/*==============================================================*/
/* View: W_DIM_DEPT                                             */
/*==============================================================*/
create or replace view u_f_dw_references.W_DIM_DEPT as
select dept_id, name, mng_id, fact_id from u_f_dw_references.DIM_DEPT
/

/*==============================================================*/
/* View: W_DIM_GEO_LOCATIONS                                    */
/*==============================================================*/
create or replace view u_f_dw_references.W_DIM_GEO_LOCATIONS as
select loc_id, contr, state, city from u_f_dw_references.DIM_GEO_LOCATIONS;
/

/*==============================================================*/
/* View: W_DIM_TYPE_PRODUCT_SCD                                 */
/*==============================================================*/
create or replace view u_f_dw_references.W_DIM_TYPE_PRODUCT_SCD as
select pr_t_id, name, meta, sale_price from u_f_dw_references.DIM_TYPE_PRODUCT_SCD;
/

/*==============================================================*/
/* View: W_DIM_WORKER_SCD                                       */
/*==============================================================*/
create or replace view u_f_dw_references.W_DIM_WORKER_SCD as
select wk_id, dept_id, name, jb_title, hours_week, salary from u_f_dw_references.DIM_WORKER_SCD;
with read only
/

/*==============================================================*/
/* View: W_DW_FACTORY                                           */
/*==============================================================*/
create or replace view u_f_dw_cls.W_DW_FACTORY as
select fact_id, name, raw_loc_id from u_f_dw_cls.DW_FACTORY;
/

alter table u_f_dw_references.DIM_WORKER_SCD
   add constraint FK_DIM_WORK_REFERENCE_DIM_DEPT foreign key (dept_id)
      references u_f_dw_references.DIM_DEPT (dept_id)
/

alter table u_f_dw_references.FACT_AGG_WORKER_PRODTIME_DATE
   add constraint FK_FACT_AGG_REFERENCE_DIM_WORK foreign key (wk_id, valid_from)
      references u_f_dw_references.DIM_WORKER_SCD (wk_id, valid_from)
/

alter table u_f_dw_references.FACT_AGG_WORKER_PRODTIME_DATE
   add constraint FK_FACT_AGG_REFERENCE_DM_TIME foreign key (time_id)
      references u_f_dw_references.DM_TIME (time_id)
/

alter table u_f_dw_references.FACT_PRODUCED_PRODUCT
   add constraint FK_FACT_PRO_REFERENCE_DIM_TYPE foreign key ()
      references u_f_dw_references.DIM_TYPE_PRODUCT_SCD
/

alter table u_f_dw_references.FACT_PRODUCED_PRODUCT
   add constraint FK_FACT_PRO_REFERENCE_DIM_WORK foreign key (wk_id, )
      references u_f_dw_references.DIM_WORKER_SCD (wk_id, valid_from)
/

alter table u_f_dw_references.FACT_PRODUCED_PRODUCT
   add constraint FK_FACT_PRO_REFERENCE_DIM_FACT foreign key (fact_id)
      references u_f_dw_references.DIM_FACTORY (fact_id)
/

alter table u_f_dw_references.FACT_PRODUCED_PRODUCT
   add constraint FK_FACT_PRO_REFERENCE_DIM_DEPT foreign key (dept_id)
      references u_f_dw_references.DIM_DEPT (dept_id)
/

alter table u_f_dw_references.FACT_PRODUCED_PRODUCT
   add constraint FK_FACT_PRO_REFERENCE_DIM_GEO_ foreign key (loc_id)
      references u_f_dw_references.DIM_GEO_LOCATIONS (loc_id)
/

alter table u_f_dw_references.FACT_PRODUCED_PRODUCT
   add constraint FK_FACT_PRO_REFERENCE_DM_TIME foreign key (time_id)
      references u_f_dw_references.DM_TIME (time_id)
/


create trigger u_f_dw_references.TW_DIM_DEPT_INSET instead of insert
   on u_f_dw_references.W_DIM_DEPT for each row
declare
   integrity_error  exception;
   errno            integer;
   errmsg           char(200);

begin
    insert into u_f_dw_references.DIM_DEPT (dept_id, name, mng_id, fact_id, insert_dt, update_dt)
        values (:new.dept_id, :new.name, :new.mng_id, :new.fact_id, sysdate, sysdate);
--  Errors handling
exception
    when integrity_error then
       raise_application_error(errno, errmsg);
end;
/


create trigger u_f_dw_references.TW_DIM_DEPT_UPDATE instead of update
   on u_f_dw_references.W_DIM_DEPT for each row
declare
   integrity_error  exception;
   errno            integer;
   errmsg           char(200);

begin
    update u_f_dw_references.DIM_DEPT
        set name = :new.name, mng_id = :new.mng_id, fact_id = :new.fact_id, update_dt = sysdate
        where :new.dept_id = dept_id;
--  Errors handling
exception
    when integrity_error then
       raise_application_error(errno, errmsg);
end;
/


create trigger u_f_dw_references.T_W_TYPE_DELETE instead of delete
   on u_f_dw_references.W_DIM_TYPE_PRODUCT_SCD for each row
declare
   integrity_error  exception;
   errno            integer;
   errmsg           char(200);

begin
    update u_f_dw_references.DIM_TYPE_PRODUCT_SCD
        set valid_to = sysdate, is_active = 'NO'
        where :new.pr_t_id = pr_t_id and valid_to is null;
--  Errors handling
exception
    when integrity_error then
       raise_application_error(errno, errmsg);
end;
/


create trigger u_f_dw_references.W_TYPE_INSERT instead of insert
   on u_f_dw_references.W_DIM_TYPE_PRODUCT_SCD for each row
declare
   integrity_error  exception;
   errno            integer;
   errmsg           char(200);

begin
    insert into u_f_dw_references.DIM_TYPE_PRODUCT_SCD
                (pr_t_id, name, meta, sale_price, valid_from, valid_to, is_active, insert_dt)
        values (:new.pr_t_id, :new.name, :new.meta, :new.sale_price, sysdate, NULL, 'YES', sysdate);
exception
    when integrity_error then
       raise_application_error(errno, errmsg);
end;
/


create trigger u_f_dw_references.W_TYPE_UPDATE instead of update
   on u_f_dw_references.W_DIM_TYPE_PRODUCT_SCD for each row
declare
   integrity_error  exception;
   errno            integer;
   errmsg           char(200);
   

begin
    update u_f_dw_references.DIM_TYPE_PRODUCT_SCD
        set valid_to = sysdate, is_active = 'NO'
        where :new.pr_t_id = pr_t_id and valid_to is null;
    
    insert into u_f_dw_references.DIM_TYPE_PRODUCT_SCD
        (pr_t_id, name, meta, sale_price, valid_from, valid_to, is_active, insert_dt)
        values (:new.pr_t_id, :new.name, :new.meta, :new.sale_price, sysdate, null, 'YES', null);
        
--  Errors handling
exception
    when integrity_error then
       raise_application_error(errno, errmsg);
end;
/


create trigger u_f_dw_references.TW_DIM_WORKER_DELETE instead of delete
   on u_f_dw_references.W_DIM_WORKER_SCD for each row
declare
   integrity_error  exception;
   errno            integer;
   errmsg           char(200);

begin
    update u_f_dw_references.DIM_WORKER_SCD
        set valid_to = sysdate, is_active = 'NO'
        where :new.wk_id = wk_id and valid_to is null;
--  Errors handling
exception
    when integrity_error then
       raise_application_error(errno, errmsg);
end;
/


create trigger u_f_dw_references.TW_DIM_WORKER_INSERT instead of insert
   on u_f_dw_references.W_DIM_WORKER_SCD for each row
declare
   integrity_error  exception;
   errno            integer;
   errmsg           char(200);

begin
    insert into u_f_dw_references.DIM_WORKER_SCD
        (wk_id, dept_id, name, jb_title, hours_week, salary, valid_from, valid_to, is_active, insert_dt)
        values (:new.wk_id, :new.dept_id, :new.name, :new.jb_title, :new.hours_week, :new.salary, sysdate, NULL, 'YES', NULL);
--  Errors handling
exception
    when integrity_error then
       raise_application_error(errno, errmsg);
end;
/


create trigger u_f_dw_references.TW_DIM_WORKER_UPDATE instead of update
   on u_f_dw_references.W_DIM_WORKER_SCD for each row
declare
   integrity_error  exception;
   errno            integer;
   errmsg           char(200);

begin
    u_f_dw_references.DIM_WORKER_SCD
    
    update u_f_dw_references.DIM_WORKER_SCD
        set valid_to = sysdate, is_active = 'NO'
        where :new.wk_id = wk_id and valid_to is null;
        
    insert into u_f_dw_references.DIM_WORKER_SCD
        (wk_id, dept_id, name, jb_title, hours_week, salary, valid_from, valid_to, is_active, insert_dt)
        values (:new.wk_id, :new.dept_id, :new.name, :new.jb_title, :new.hours_week, :new.salary, sysdate, NULL, 'YES', NULL);
--  Errors handling
exception
    when integrity_error then
       raise_application_error(errno, errmsg);
end;
/
