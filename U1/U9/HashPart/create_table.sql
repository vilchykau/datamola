drop table hashp_table;

CREATE TABLE hashp_table
     (id NUMBER,
      name VARCHAR2 (60))
   PARTITION BY HASH (id)
   PARTITIONS 2
   tablespace TS_F_STAGING;