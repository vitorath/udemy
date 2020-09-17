CREATE TABLE teste (
	codigo INTEGER NOT NULL PRIMARY KEY,
	data DATE DEFAULT SYSDATE
);

INSERT INTO teste (codigo) VALUES (1);
INSERT INTO teste (codigo, data) VALUES (2, TO_DATE('2020/08/03', 'YYYY/MM/DD'));

SELECT * FROM teste;

-- tabelas criadas pelo usuário(views)
SELECT * FROM USER_TABLES;
SELECT * FROM ALL_TABLES;

CREATE TABLE contrato_vip
AS
  SELECT * FROM contrato WHERE total > 500;
  
SELECT * FROM contrato_vip;

-- add coluna na tabela
ALTER TABLE contrato_vip ADD valor NUMBER(5,2);

-- alterar coluna
ALTER TABLE contrato_vip MODIFY valor NUMBER(8,2);

-- alterar coluna 
ALTER TABLE contrato_vip MODIFY valor NUMBER(8,2) DEFAULT 0;

-- renomear coluna
ALTER TABLE contrato_vip RENAME COLUMN valor TO valor2;

-- excluir coluna
ALTER TABLE contrato_vip DROP COLUMN valor2;

-- excluir tabela
DROP TABLE contrato_vip;

-- renomear table
RENAME contrato TO contrato_top;

SELECT * FROM contrato_top;

RENAME contrato_top TO contrato;

SELECT * FROM contrato;

-- comentário na tabela
COMMENT ON TABLE contrato IS 'Informações de contrato';

-- comentário na coluna
COMMENT ON COLUMN contrato.cod_contrato IS 'Código do contrato';
COMMENT ON COLUMN contrato.data IS 'Data de emissão do contrato';

-- visualizar comentários
SELECT * FROM USER_COL_COMMENTS WHERE TABLE_NAME = 'CONTRATO';
SELECT * FROM USER_TAB_COMMENTS WHERE TABLE_NAME = 'CONTRATO';

-- Desabilitar coluna
ALTER TABLE contrato ADD total2 NUMERIC(8,2);
ALTER TABLE contrato SET UNUSED (total2); -- Não tem como habilitar novamente
SELECT * FROM contrato;

-- Excluir colunas desabilitada
ALTER TABLE contrato DROP UNUSED COLUMNS;

-- Deletar todos os registros da tabela sem where e commit/rollback
TRUNCATE TABLE teste;




