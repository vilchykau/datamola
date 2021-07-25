drop table list_table;

CREATE TABLE list_table
      (deptno number, 
       state varchar2(2))
   PARTITION BY LIST (state)
      (PARTITION p1 VALUES ('OR', 'WA'),
       PARTITION p2 VALUES ('AZ', 'UT', 'NM'))
    tablespace TS_F_STAGING;