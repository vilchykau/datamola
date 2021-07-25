drop table range_example;

CREATE TABLE range_example
   ( range_key_column date         NOT NULL,
                 data varchar2(20))
  PARTITION BY RANGE (range_key_column)
  INTERVAL(NUMTOYMINTERVAL(1, 'MONTH'))
 ( 
    PARTITION p0 VALUES LESS THAN (to_date('01/01/2010','dd/mm/yyyy')),
    PARTITION p1 VALUES LESS THAN (to_date('01/01/2011','dd/mm/yyyy'))
 ) tablespace TS_F_STAGING;