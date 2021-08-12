CREATE OR REPLACE PACKAGE BODY U_FACT_CLS.PKG_ELT_ASSIST AS
    PROCEDURE MOVE(table_from VARCHAR2,
                   table_to VARCHAR2) IS
    BEGIN
        EXECUTE IMMEDIATE 'TRUNCATE TABLE '
            || table_to;

        --         EXECUTE IMMEDIATE '
--         INSERT INTO :a
--         SELECT *
--         FROM :b'
--             USING table_to, table_from;

        EXECUTE IMMEDIATE '
        INSERT INTO ' || table_to || '
        SELECT *
        FROM ' || table_from;
    END ;

    PROCEDURE MOVE_DBMS_CUR(table_from VARCHAR2,
                            table_to VARCHAR2) IS
        TYPE cur_t IS REF CURSOR;
        cur              cur_t;
        cols             DBMS_SQL.DESC_TAB;
        ncols            PLS_INTEGER;
        sql_stat         VARCHAR2(4000);
        inset_header_str VARCHAR2(4000);
        inset_values_str VARCHAR2(4000);
        curid            NUMBER;
        namevar          VARCHAR2(50);
        numvar           NUMBER;
        datevar          DATE;
    BEGIN
        EXECUTE IMMEDIATE 'TRUNCATE TABLE ' || table_to;
        sql_stat := 'SELECT * FROM ' || table_from;
        OPEN cur FOR sql_stat;
        curid := DBMS_SQL.TO_CURSOR_NUMBER(cur);

        DBMS_SQL.DESCRIBE_COLUMNS(curid, ncols, cols);

        -- Вывод каждого из имен столбцов
        FOR i IN 1 .. ncols
            LOOP
                IF cols(i).col_type = 2 THEN
                    DBMS_SQL.DEFINE_COLUMN(curid, i, numvar);
                ELSIF cols(i).col_type = 12 THEN
                    DBMS_SQL.DEFINE_COLUMN(curid, i, datevar);
                ELSE
                    DBMS_SQL.DEFINE_COLUMN(curid, i, namevar, 50);
                END IF;
            END LOOP;

        WHILE DBMS_SQL.fetch_rows(curid) > 0
            LOOP
                inset_values_str := '';
                inset_header_str := '';
                FOR indx IN 1 .. ncols
                    LOOP
                        inset_header_str := inset_header_str || ',' || cols(indx).col_name;
                        IF (cols(indx).col_type = 1) THEN
                            DBMS_SQL.COLUMN_VALUE(curid, indx, namevar);
                            inset_values_str := inset_values_str || ',''' || namevar || '''';
                        ELSIF (cols(indx).col_type = 2) THEN
                            DBMS_SQL.COLUMN_VALUE(curid, indx, numvar);
                            inset_values_str := inset_values_str || ',' || numvar;
                        ELSIF (cols(indx).col_type = 12) THEN
                            DBMS_SQL.COLUMN_VALUE(curid, indx, datevar);
                            inset_values_str := inset_values_str || ',' || datevar;
                        END IF;
                    END LOOP;
                inset_values_str := SUBSTR(inset_values_str, 2);
                inset_header_str := SUBSTR(inset_header_str, 2);

                EXECUTE IMMEDIATE 'INSERT INTO '||table_to||'(' || inset_header_str || ')'
                    || ' VALUES (' || inset_values_str || ')';
            END LOOP;

        DBMS_SQL.CLOSE_CURSOR(curid);
    END ;


--     FUNCTION GET_DEN(foo NUMBER)
--         RETURN den_table_t;
--                 PIPELINED IS
--         rw DEN_ROW_T;
--     BEGIN
--         NULL;
--     END;
END;
