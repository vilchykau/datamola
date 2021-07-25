select SUBOBJECT_NAME as PART_NAME, id, name 
    from (select SUBOBJECT_NAME, data_object_id from user_objects
        where data_object_id in (
        SELECT dbms_rowid.rowid_object(ROWID) data_object_id
        FROM hashp_table)) s
    inner join (
        SELECT dbms_rowid.rowid_object(ROWID) data_object_id, id, name
        FROM hashp_table) d
    on s.data_object_id = d.data_object_id;
