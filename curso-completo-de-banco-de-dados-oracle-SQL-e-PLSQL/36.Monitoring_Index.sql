CREATE TABLE teste (
	codigo NUMBER,
	nome VARCHAR2(40)
);

-- Criando um index
CREATE INDEX ind_codigo	 ON teste(codigo);

-- Populando tabela
INSERT INTO teste VALUES (1, 'Vitor');

-- Verificando se o INDEX já foi usado
SELECT index_name, table_name, used FROM v$object_usage;

-- Habilitar monitoramento
ALTER INDEX ind_codigo MONITORING USAGE;

-- Desabilitar monitoramento
ALTER INDEX ind_codigo NOMONITORING USAGE;

SELECT * FROM teste;
SELECT * FROM teste WHERE codigo = 1;