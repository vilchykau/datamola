ALTER TABLE RANGE_EXAMPLE
    SPLIT PARTITION FOR(TO_DATE('11-01-2010','dd-mm-yyyy'))
    AT (TO_DATE('12-01-2010','dd-mm-yyyy'));