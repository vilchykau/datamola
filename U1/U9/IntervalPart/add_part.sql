ALTER TABLE range_example
      ADD PARTITION p0n VALUES LESS THAN (to_date('01/01/2015','dd/mm/yyyy'))
      TABLESPACE TS_F_STAGING;