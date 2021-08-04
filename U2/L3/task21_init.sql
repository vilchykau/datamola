CREATE TABLESPACE SB_MBackUp
    DATAFILE 'vilchykau_db_SB_MBackUp.dat'
    SIZE 5 M
    AUTOEXTEND ON NEXT 5 M
    SEGMENT SPACE MANAGEMENT AUTO;

CREATE USER SB_MBackUp_USER
    IDENTIFIED BY "123456"
    DEFAULT TABLESPACE SB_MBackUp;

GRANT CONNECT, RESOURCE TO SB_MBackUp_USER;

grant select, insert, update, delete on U_DW_REFERENCES.T_GEO_OBJECTS to SB_MBackUp_USER;
grant select, insert, update, delete on U_DW_REFERENCES.T_GEO_OBJECT_LINKS to SB_MBackUp_USER;

grant select, insert, update, delete on U_DW_REFERENCES.LC_GEO_SYSTEMS to SB_MBackUp_USER;
grant select, insert, update, delete on U_DW_REFERENCES.LC_GEO_PARTS to SB_MBackUp_USER;
grant select, insert, update, delete on U_DW_REFERENCES.LC_GEO_REGIONS to SB_MBackUp_USER;
grant select, insert, update, delete on U_DW_REFERENCES.LC_COUNTRIES to SB_MBackUp_USER;

GRANT UNLIMITED TABLESPACE TO SB_MBackUp_USER;