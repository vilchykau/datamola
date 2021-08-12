DROP TABLE U_FACT_CLS.DW_TYPE_PRODUCT CASCADE CONSTRAINTS;
DROP TABLE U_FACT_CLS.DW_FACTORY_LOC CASCADE CONSTRAINTS;
DROP TABLE U_FACT_CLS.DW_DEPT CASCADE CONSTRAINTS;
DROP TABLE U_FACT_CLS.DW_WORKER CASCADE CONSTRAINTS;
DROP TABLE U_FACT_CLS.DW_PRODUCED_PRODUCT CASCADE CONSTRAINTS;

/*==============================================================*/
/* Table: DW_PRODUCED_PRODUCT                                   */
/*==============================================================*/
CREATE TABLE U_FACT_CLS.DW_PRODUCED_PRODUCT
(
    det_no       NUMBER(22, 0) NOT NULL,
    event_dt_str VARCHAR(50),
    pr_t_id      NUMBER(22, 0),
    wk_id        NUMBER(22, 0),
    dept_name    VARCHAR(50)
);

/*==============================================================*/
/* Table: DW_WORKER                                             */
/*==============================================================*/
CREATE TABLE U_FACT_CLS.DW_WORKER
(
    wk_id       NUMBER(22, 0) NOT NULL,
    dept_raw_id VARCHAR(50),
    name        VARCHAR(50),
    jb_title    VARCHAR(20),
    hours_week  INT,
    salary      INT,
    CONSTRAINT PK_DW_WORKER PRIMARY KEY (wk_id)
);

/*==============================================================*/
/* Table: DW_DEPT                                               */
/*==============================================================*/
CREATE TABLE U_FACT_CLS.DW_DEPT
(
    name        VARCHAR(50),
    fact_id     NUMBER(22, 0),
    parent_dept VARCHAR(50)
);


/*==============================================================*/
/* Table: DW_FACTORY_LOC                                        */
/*==============================================================*/
CREATE TABLE U_FACT_CLS.DW_FACTORY_LOC
(
    fact_id NUMBER(22, 0) NOT NULL,
    name    VARCHAR(50),
    county  VARCHAR(50),
    state   VARCHAR(50),
    city    VARCHAR(50)
);


/*==============================================================*/
/* Table: DW_TYPE_PRODUCT                                       */
/*==============================================================*/
CREATE TABLE U_FACT_CLS.DW_TYPE_PRODUCT
(
    pr_t_id    NUMBER(22, 0) NOT NULL,
    name       VARCHAR(50),
    meta       VARCHAR(200),
    sale_price NUMBER(20),
    CONSTRAINT PK_DW_TYPE_PRODUCT PRIMARY KEY (pr_t_id)
);


COMMIT;