drop tablespace TS_FACT_CLS including contents cascade constraints;
drop tablespace TS_FACT_EXT including contents cascade constraints;
drop tablespace TS_FACT_STAR including contents cascade constraints;


create tablespace TS_FACT_CLS
datafile 'sv_ts_fact_cls.dat'
size 100m
 autoextend on next 50m
 segment space management auto;

create tablespace TS_FACT_EXT
datafile 'sv_ts_fact_ext.dat'
size 100m
 autoextend on next 50m
 segment space management auto;

create tablespace TS_FACT_STAR
datafile 'sv_ts_fact_star.dat'
size 100m
 autoextend on next 50m
 segment space management auto;

COMMIT;