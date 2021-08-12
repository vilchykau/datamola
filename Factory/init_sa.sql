DROP TABLE U_FACT_EXT.SA_TYPE_PRODUCT CASCADE CONSTRAINTS;
DROP TABLE U_FACT_EXT.SA_FACTORY CASCADE CONSTRAINTS;
DROP TABLE U_FACT_EXT.SA_PRODUCED_PRODUCT CASCADE CONSTRAINTS;
DROP TABLE U_FACT_EXT.SA_DEPT CASCADE CONSTRAINTS;
DROP TABLE U_FACT_EXT.SA_WORKER CASCADE CONSTRAINTS;

/*==============================================================*/
/* Table: SA_WORKER                                             */
/*==============================================================*/
CREATE TABLE U_FACT_EXT.SA_WORKER
(
    wk_id      NUMBER(22, 0) NOT NULL,
    dept_name  VARCHAR(50),
    name       VARCHAR(50),
    hours_week NUMBER(15, 0),
    salary     NUMBER(15, 0)
);


/*==============================================================*/
/* Table: SA_DEPT                                               */
/*==============================================================*/
CREATE TABLE U_FACT_EXT.SA_DEPT
(
    name        VARCHAR(50),
    fact_id     NUMBER(22, 0),
    parent_dept VARCHAR(50)
);



/*==============================================================*/
/* Table: SA_TYPE_PRODUCT                                       */
/*==============================================================*/
CREATE TABLE U_FACT_EXT.SA_TYPE_PRODUCT
(
    pr_t_id    NUMBER(22, 0) NOT NULL,
    name       VARCHAR(50),
    meta       VARCHAR(200),
    sale_price NUMBER(20)
);

/*==============================================================*/
/* Table: SA_FACTORY                                            */
/*==============================================================*/
CREATE TABLE U_FACT_EXT.SA_FACTORY
(
    fact_id NUMBER(22, 0) NOT NULL,
    name    VARCHAR(50),
    county  VARCHAR(50),
    state   VARCHAR(50),
    city    VARCHAR(50)
);

/*==============================================================*/
/* Table: SA_PRODUCED_PRODUCT                                   */
/*==============================================================*/
CREATE TABLE U_FACT_EXT.SA_PRODUCED_PRODUCT
(
    det_no       NUMBER(22, 0) NOT NULL,
    event_dt_str VARCHAR(50),
    pr_t_id      NUMBER(22, 0),
    wk_id        NUMBER(22, 0),
    dept_name    VARCHAR(50)
);


GRANT SELECT ON U_FACT_EXT.SA_WORKER TO U_FACT_CLS;
GRANT SELECT ON U_FACT_EXT.SA_TYPE_PRODUCT TO U_FACT_CLS;
GRANT SELECT ON U_FACT_EXT.SA_PRODUCED_PRODUCT TO U_FACT_CLS;
GRANT SELECT ON U_FACT_EXT.SA_FACTORY TO U_FACT_CLS;
GRANT SELECT ON U_FACT_EXT.SA_DEPT TO U_FACT_CLS;

GRANT SELECT ON U_FACT_EXT.SA_WORKER TO U_FACT_STAR;
GRANT SELECT ON U_FACT_EXT.SA_TYPE_PRODUCT TO U_FACT_STAR;
GRANT SELECT, INSERT, DELETE ON U_FACT_EXT.SA_PRODUCED_PRODUCT TO U_FACT_STAR;
GRANT SELECT ON U_FACT_EXT.SA_FACTORY TO U_FACT_STAR;
GRANT SELECT ON U_FACT_EXT.SA_DEPT TO U_FACT_STAR;


COMMIT;