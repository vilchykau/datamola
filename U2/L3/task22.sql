SELECT BE_NAME, WK_COUNT FROM (
    SELECT lpad(' ', level * 2 - 1, ' ') || CNAME as BE_NAME, CNAME
FROM (
         SELECT CURR.NAME AS CNAME, PARENT.NAME AS PNAME
         FROM SA_DEPT CURR
                  LEFT JOIN SA_DEPT PARENT ON PARENT.NAME = CURR.PARENT_NAME
     )
CONNECT BY PRIOR CNAME = PNAME
START WITH PNAME IS NULL
ORDER SIBLINGS BY CNAME
    ) LEFT JOIN (
    SELECT DEPT_NAME, COUNT(1) AS WK_COUNT FROM SA_WORKER GROUP BY DEPT_NAME
    )
ON CNAME = DEPT_NAME;
