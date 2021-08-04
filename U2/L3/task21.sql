DROP TABLE SB_MBackUp_USER.SB_MBackUp_TABLE PURGE;

CREATE TABLE SB_MBackUp_USER.SB_MBackUp_TABLE AS
SELECT MGEO_ID
     , NODE_TYPE
     , PATH
     , LCG.GEO_SYSTEM_CODE
     , LGP.PART_DESC
     , LGR.REGION_DESC
     , LC.COUNTRY_DESC
FROM (
         SELECT GEO_ID                                        AS MGEO_ID,
                DECODE(LEVEL, 1, 'ROOT', 4, 'LEAF', 'BRANCH') AS NODE_TYPE,
                SYS_CONNECT_BY_PATH(GEO_ID, ':')                 PATH,
                REGEXP_SUBSTR(SYS_CONNECT_BY_PATH(GEO_ID, ':'), ':(\d+)', 1, 1, NULL, 1)
                                                              AS GEO_SYS_ID,
                REGEXP_SUBSTR(SYS_CONNECT_BY_PATH(GEO_ID, ':'), ':(\d+)', 1, 2, NULL, 1)
                                                              AS GEO_PART_ID,
                REGEXP_SUBSTR(SYS_CONNECT_BY_PATH(GEO_ID, ':'), ':(\d+)', 1, 3, NULL, 1)
                                                              AS GEO_REG_ID,
                REGEXP_SUBSTR(SYS_CONNECT_BY_PATH(GEO_ID, ':'), ':(\d+)', 1, 4, NULL, 1)
                                                              AS GEO_CONT_ID,
                CONNECT_BY_ISLEAF                             AS IS_LEAF
         FROM (
                  SELECT *
                  FROM U_DW_REFERENCES.T_GEO_OBJECTS
                           LEFT OUTER JOIN U_DW_REFERENCES.T_GEO_OBJECT_LINKS ON CHILD_GEO_ID = GEO_ID
              )
         START WITH PARENT_GEO_ID IS NULL
         CONNECT BY PRIOR GEO_ID = PARENT_GEO_ID
         ORDER SIBLINGS BY MGEO_ID
     )
         LEFT OUTER JOIN U_DW_REFERENCES.LC_GEO_SYSTEMS LCG ON LCG.GEO_ID = GEO_SYS_ID
         LEFT OUTER JOIN U_DW_REFERENCES.LC_GEO_PARTS LGP on GEO_PART_ID = LGP.GEO_ID
         LEFT OUTER JOIN U_DW_REFERENCES.LC_GEO_REGIONS LGR on GEO_REG_ID = LGR.GEO_ID
         LEFT OUTER JOIN U_DW_REFERENCES.LC_COUNTRIES LC on LC.GEO_ID = GEO_CONT_ID;


SELECT *
FROM SB_MBackUp_USER.SB_MBackUp_TABLE;
