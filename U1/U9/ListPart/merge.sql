ALTER TABLE list_table 
   MERGE PARTITIONS p1, p2 
   INTO PARTITION p1;