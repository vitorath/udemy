-- Conectado como system --Direito para criar view materializada 
GRANT CREATE ANY MATERIALIZED VIEW TO marcio;

-- Criar log para view 
CREATE MATERIALIZED VIEW LOG ON taluno TABLESPACE tbs_dados

-- Excluir View 
DROP MATERIALIZED VIEW V_MAT;

-- Criar View 
CREATE MATERIALIZED VIEW V_MAT
TABLESPACE tbs_dados
BUILD IMMEDIATE
REFRESH FAST ON COMMIT AS
	(SELECT COD_ALUNO, NOME, CIDADE FROM TALUNO 
		WHERE CIDADE = 'NOVO HABURGO');

INSERT INTO TALUNO (COD_ALUNO,NOME,CIDADE)
VALUES(SEQ_ALUNO.NEXTVAL,'TESTE 2','NOVO HAMBURGO');

SELECT * FROM TALUNO;

SELECT * FROM V_MAT;
