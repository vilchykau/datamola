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
