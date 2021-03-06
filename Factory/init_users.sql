DROP USER U_FACT_CLS;
DROP USER U_FACT_EXT;
DROP USER U_FACT_STAR;

CREATE USER U_FACT_CLS
    IDENTIFIED BY "123456"
    DEFAULT TABLESPACE TS_FACT_CLS;


CREATE USER U_FACT_EXT
    IDENTIFIED BY "123456"
    DEFAULT TABLESPACE TS_FACT_EXT;


CREATE USER U_FACT_STAR
    IDENTIFIED BY "123456"
    DEFAULT TABLESPACE TS_FACT_STAR;


GRANT CONNECT, RESOURCE, CREATE PROCEDURE TO U_FACT_CLS;
GRANT CONNECT, RESOURCE TO U_FACT_EXT;
GRANT CONNECT, RESOURCE,
    CREATE MATERIALIZED VIEW, CREATE TABLE, ON COMMIT REFRESH TO U_FACT_STAR;

GRANT UNLIMITED TABLESPACE TO U_FACT_CLS;
GRANT UNLIMITED TABLESPACE TO U_FACT_EXT;
GRANT UNLIMITED TABLESPACE TO U_FACT_STAR;

COMMIT;