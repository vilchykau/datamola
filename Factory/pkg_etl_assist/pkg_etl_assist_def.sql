CREATE OR REPLACE PACKAGE U_FACT_CLS.PKG_ELT_ASSIST AS
    PROCEDURE MOVE(table_from VARCHAR2, table_to VARCHAR2);
    PROCEDURE MOVE_DBMS_CUR(table_from VARCHAR2, table_to VARCHAR2);

  /*  TYPE den_row_t IS RECORD
                      (
                          ev_date          DATE,
                          det_no           NUMBER(22),
                          fa_name          VARCHAR2(50),
                          fa_country       VARCHAR2(50),
                          fa_state         VARCHAR2(50),
                          fa_city          VARCHAR2(50),
                          dept_name        VARCHAR2(50),
                          dept_parent_name VARCHAR2(50),
                          tp_name          VARCHAR2(50),
                          tp_price         NUMBER(20),
                          tp_meta          VARCHAR2(200),
                          wk_name          VARCHAR2(50),
                          wk_salary        VARCHAR2(15)
                      );

    TYPE den_table_t IS TABLE OF den_row_t;

    FUNCTION GET_DEN(foo NUMBER)
        RETURN den_table_t
        PIPELINED ;*/
END;
