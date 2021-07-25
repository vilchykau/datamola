drop user u_f_dw_cls;
drop user u_f_dw_ext_references;
drop user u_f_dw_references;

/*==============================================================*/
/* User: u_f_dw_cls                                             */
/*==============================================================*/
create user u_f_dw_cls 
  identified by "123456";


/*==============================================================*/
/* User: u_f_dw_ext_references                                  */
/*==============================================================*/
create user u_f_dw_ext_references 
  identified by "123456"
    default tablespace TS_REFERENCES_EXT_DATA_01;


/*==============================================================*/
/* User: u_f_dw_references                                      */
/*==============================================================*/
create user u_f_dw_references 
  identified by "123456"
    default tablespace TS_REFERENCES_DATA_01;



GRANT CONNECT,RESOURCE TO u_f_dw_cls;
GRANT CONNECT,RESOURCE TO u_f_dw_ext_references;
GRANT CONNECT,RESOURCE TO u_f_dw_references;
