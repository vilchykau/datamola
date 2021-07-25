select SUBOBJECT_NAME as PART_NAME, RANGE_KEY_COLUMN, "DATA" 
    from (select SUBOBJECT_NAME, data_object_id from user_objects
        where data_object_id in (
        SELECT dbms_rowid.rowid_object(ROWID) data_object_id
        FROM RANGE_EXAMPLE)) s
    inner join (
        SELECT dbms_rowid.rowid_object(ROWID) data_object_id, RANGE_KEY_COLUMN, "DATA"
        FROM RANGE_EXAMPLE) d
    on s.data_object_id = d.data_object_id;
