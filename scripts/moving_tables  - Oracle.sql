--Not related to SQL Server but I didn't want to lose this useful script
DECLARE
    v_command      VARCHAR2 (100);
    v_schema       VARCHAR2 (100) := 'SH_TEST';
    v_tablespace   VARCHAR2 (100) := 'TS_1';

    CURSOR C_TABLES
    IS
        SELECT TABLE_NAME
          FROM ALL_TABLES
         WHERE OWNER = UPPER (v_schema);

    CURSOR C_INDEXES
    IS
        SELECT INDEX_NAME
          FROM ALL_INDEXES
         WHERE OWNER = UPPER (v_schema);
BEGIN
    BEGIN
        FOR x IN C_TABLES LOOP
            BEGIN
                v_command := 'ALTER TABLE ' || UPPER (v_schema) || '.'|| x.TABLE_NAME || ' MOVE TABLESPACE ' || UPPER (v_tablespace);
                EXECUTE IMMEDIATE v_command;
            EXCEPTION
                WHEN OTHERS
                THEN
                    NULL;
            END;
        END LOOP;
    END;

    BEGIN
        FOR x IN C_INDEXES
        LOOP
            BEGIN
                v_command := 'ALTER INDEX ' || UPPER (v_schema) || '.' || x.INDEX_NAME || ' REBUILD TABLESPACE ' || UPPER (v_tablespace);
                EXECUTE IMMEDIATE v_command;
            EXCEPTION
                WHEN OTHERS
                THEN
                    NULL;
            END;
        END LOOP;
    END;
END;