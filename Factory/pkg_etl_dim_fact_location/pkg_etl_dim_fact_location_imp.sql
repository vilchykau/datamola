CREATE OR REPLACE PACKAGE BODY PKG_ELT_DIM_FACT_LOCATION AS
    PROCEDURE CLEAN IS
        TYPE Fact_Loc_T IS TABLE OF U_FACT_EXT.SA_FACTORY%ROWTYPE;
        CURSOR cur IS SELECT *
                      FROM U_FACT_EXT.SA_FACTORY;
        cur_get Fact_Loc_T;
    BEGIN
        OPEN cur;
        FETCH cur BULK COLLECT INTO cur_get;
        CLOSE cur;

        FORALL idx IN 1..cur_get.COUNT
            INSERT INTO U_FACT_CLS.DW_FACTORY_LOC( FACT_ID
                                                 , NAME
                                                 , COUNTY
                                                 , STATE
                                                 , CITY)
            VALUES (cur_get(idx).FACT_ID,
                    cur_get(idx).NAME,
                    cur_get(idx).COUNTY,
                    cur_get(idx).STATE,
                    cur_get(idx).CITY);
    END;


    PROCEDURE LOAD IS
        CURSOR cur IS SELECT *
                      FROM U_FACT_CLS.DW_FACTORY_LOC;
        fact_loc    cur%ROWTYPE;
        is_in_table NUMBER        := 0;
        loc_id      NUMBER(22, 0) := 0;
    BEGIN
        OPEN cur;

        LOOP
            EXIT WHEN cur%NOTFOUND;
            FETCH cur INTO fact_loc;

            SELECT count(1)
            INTO is_in_table
            FROM U_FACT_STAR.DIM_GEO_LOCATIONS LOC
            WHERE COUNTRY = fact_loc.COUNTY
              AND STATE = fact_loc.STATE
              AND CITY = fact_loc.CITY;

            IF is_in_table = 0 THEN
                INSERT INTO U_FACT_STAR.DIM_GEO_LOCATIONS( COUNTRY
                                                         , STATE
                                                         , CITY)
                VALUES ( fact_loc.COUNTY
                       , fact_loc.STATE
                       , fact_loc.CITY)
                RETURNING LOC_ID INTO loc_id;
            END IF;

            SELECT COUNT(1)
            INTO is_in_table
            FROM U_FACT_STAR.DIM_FACTORY
            WHERE FACT_ID = fact_loc.FACT_ID;

            IF is_in_table = 0 THEN
                INSERT INTO U_FACT_STAR.DIM_FACTORY( FACT_ID
                                                   , NAME
                                                   , INSERT_DT
                                                   , UPDATE_DT
                                                   , LOC_ID)
                VALUES ( fact_loc.FACT_ID
                       , fact_loc.NAME
                       , SYSDATE
                       , SYSDATE
                       , loc_id);
            ELSE
                NULL; --TODO
            end if;

        END LOOP;
        CLOSE cur;
    END;
END PKG_ELT_DIM_FACT_LOCATION;
