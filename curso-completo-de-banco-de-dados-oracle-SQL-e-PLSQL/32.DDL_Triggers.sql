-- Conectado com o usuário SYS como SYSDBA
CREATE TABLE log_ddl(
	data DATE,
	usuario VARCHAR2(40),
	schema VARCHAR2(30),
	operacao VARCHAR2(100),
	objecto VARCHAR2(1000)
);

CREATE OR REPLACE TRIGGER tri_log_ddl
BEFORE DDL ON DATABASE 
DECLARE 
	v_operacao VARCHAR2(30);
	v_schema VARCHAR2(30);
	v_obj VARCHAR2(30);
BEGIN 
	SELECT ORA_SYSEVENT, ORA_DICT_OBJ_OWNER, ORA_DICT_OBJ_NAME
	INTO v_operacao, v_schema, v_obj FROM dual;

	INSERT INTO log_ddl VALUES (SYSDATE, USER, v_schema, v_operacao, v_obj);
END;

SELECT * FROM log_ddl;

-- Conectado com usuário normal
DROP TABLE teste;