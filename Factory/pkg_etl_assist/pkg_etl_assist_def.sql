CREATE OR REPLACE PACKAGE U_FACT_CLS.PKG_ELT_ASSIST AS
    PROCEDURE MOVE(table_from VARCHAR2, table_to VARCHAR2);
    PROCEDURE MOVE_DBMS_CUR(table_from VARCHAR2, table_to VARCHAR2);
END;