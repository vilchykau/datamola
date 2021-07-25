ALTER TABLE list_table 
   ADD PARTITION p3 VALUES ('FL', 'GA')
        TABLESPACE TS_F_STAGING;

/*
INSERT INTO LIST_TABLE(
    DEPTNO,
    STATE
  )
VALUES
  (
    6,
    'FL'
  );
*/