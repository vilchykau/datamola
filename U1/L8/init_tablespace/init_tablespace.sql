drop tablespace TS_CLS including contents cascade constraints;
drop tablespace TS_REFERENCES_EXT_DATA_01 including contents cascade constraints;
drop tablespace TS_REFERENCES_DATA_01 including contents cascade constraints;


create tablespace TS_CLS
datafile 'ts_cls_st'
size 50m
 autoextend on next 50m
 segment space management auto;


create tablespace TS_REFERENCES_EXT_DATA_01
datafile 'db_qpt_ext_references_data_01.dat'
size 20M
 autoextend on
    next 20M
    maxsize 60M
 segment space management auto;


create tablespace TS_REFERENCES_DATA_01
datafile 'db_qpt_references_data_01.dat'
size 150M
 autoextend on next 50m
 segment space management auto;

