drop view u_f_dw_cls.W_DW_FACTORY;

/*==============================================================*/
/* View: W_DW_FACTORY                                           */
/*==============================================================*/
create or replace view u_f_dw_cls.W_DW_FACTORY as
select fact_id, name, raw_loc_id from u_f_dw_cls.DW_FACTORY;

/*
TODO: triggers
*/