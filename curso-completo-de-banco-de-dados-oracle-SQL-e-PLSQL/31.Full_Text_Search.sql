GRANT CREATE ANY DIRECTORY TO curso;

CREATE OR REPLACE DIRECTORY arquivos AS 'C:\Temp';

CREATE TABLE teste (
  codigo NUMBER,
  nome VARCHAR2(40),
  documento BLOB
);

CREATE SEQUENCE seq_doc;

-- Criação de uma procedure para carregar o arquivo para o banco de dados
CREATE OR REPLACE PROCEDURE grava_arquivo(p_file IN VARCHAR2(40))
AS
	v_bfile BFILE;
	v_blob BLOB;
BEGIN
	INSERT INTO teste (codigo,nome,documento)
	values (seq_doc.nextval,p_file_name,empty_blob())
	RETURN documento INTO v_blob;

	-- Informação de directory tem que ser maiusculo 
	v_bfile := BFILENAME('ARQUIVOS',p_file);

	DBMS_LOB.FILEOPEN(v_bfile, dbms_lob.file_readonly);     
	DBMS_LOB.LOADFROMFILE(v_blob,v_bfile,dbms_lob.getlength(v_bfile));
	DBMS_LOB.FILECLOSE(v_bfile);
	COMMIT;
END;

-- Grava o arquivo para a tabela 
EXEC grava_arquivo('teste.doc');

-- Para testar se gravou o registro faça select na tabela
SELECT * FROM teste;

-- Verificar o tamanho do arquivo armazenado (bytes)
Select dbms_lob.getlength(documento) bytes from teste;

-- Vamos criar índice que vai permitir pesquisar dentro deste arquivo grava na tabela
CREATE INDEX ind_teste_doc ON teste(documento) INDEXTYPE IS CTXSYS.CONTEXT PARAMETERS('sync (on commit)');

-- Para verificar se houve erro na criação do índice
SELECT * FROM CTX_USER_INDEX_ERRORS;

-- Podemos verificar que foram criados alguns índices adicionais usando o selects abaixo
SELECT TABLE_NAME FROM USER_TABLES;
SELECT INDEX_NAME,TABLE_NAME FROM USER_INDEXES;

-- Fazendo pesquisar no documento gravando na tabela
SELECT codigo, nome FROM teste WHERE CONTAINS(documento, 'Marcio', 1) > 0;
SELECT codigo,nome FROM teste WHERE CONTAINS(documento, 'curso', 1) > 0;






