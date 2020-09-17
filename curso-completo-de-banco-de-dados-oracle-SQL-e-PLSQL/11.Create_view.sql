-- visualizar views do usuário
SELECT view_name, text
FROM USER_VIEWS;

-- Exemplo 1
CREATE OR REPLACE VIEW v_aluno
AS
	SELECT cod_aluno AS codigo, salario, nome AS aluno, cidade, estado
	FROM aluno
	WHERE estado = 'SP';
	

SELECT * FROM v_aluno ORDER BY aluno;

-- Exemplo 2
CREATE OR REPLACE VIEW v_contrato_top
AS 
	SELECT cod_contrato, desconto
	FROM contrato
	WHERE desconto >= 10;

SELECT * FROM v_contrato_top;
	
-- View com parâmetro de saida
CREATE OR REPLACE VIEW v_aluno2(cod, aluno, sal)
AS 
	SELECT cod_aluno, nome, salario
	FROM aluno;

SELECT * FROM v_aluno2 ORDER BY aluno;

-- View complexa
CREATE OR REPLACE VIEW v_contrato
AS 
	SELECT TRUNC(data) AS data,
		   MAX(desconto) maximo,
		   AVG(desconto) media,
		   COUNT(cod_contrato) QTDE
	FROM contrato
	GROUP BY TRUNC(data);

SELECT * FROM v_contrato;

-- View Simples
CREATE OR REPLACE VIEW v_pessoa_f
AS
	SELECT cod_pessoa, tipo, nome, cod_rua AS RUA
	FROM pessoa
	WHERE tipo = 'F';

SELECT * FROM v_pessoa_f;

-- Exemplo de consulta com view e tabelas
SELECT  pessoa.cod_pessoa AS codigo,
		pessoa.nome AS nome,
		cidade.nome AS cidade,
		rua.nome  AS rua
FROM v_pessoa_f pessoa, rua, cidade
WHERE pessoa.rua = rua.COD_RUA (+)
AND cidade.cod_cidade = rua.cod_cidade
ORDER BY pessoa.nome;

-- Operação DML com view
CREATE OR REPLACE VIEW v_cursos_valor_1000_ck
AS 
	SELECT cod_curso, nome, valor
	FROM curso
	WHERE valor = 1000
	WITH CHECK OPTION CONSTRAINT ck_cursos_valor_1000;

-- Inserir através da view (somente e view simples)-- erro constraint
INSERT INTO v_cursos_valor_1000_ck(cod_curso, nome, valor)
VALUES(52, 'TESTE Y', 999);

-- Inserir através da view (somente e view simples)
INSERT INTO v_cursos_valor_1000_ck(cod_curso, nome, valor)
VALUES(52, 'TESTE Y', 1000);

SELECT * FROM curso;

-- Delete através da view (somente e view simples)
SELECT * FROM v_aluno;
DELETE FROM v_aluno WHERE codigo = 3;

-- Insert aluno pela view
INSERT INTO v_aluno
VALUES (50, 500,'SP', 'Maria', 'NH');

-- Delete em views complexas (não pe permido operações DML)
DELETE FROM v_contrato;

-- View somente para leitura (não permite DML)
CREATE OR REPLACE VIEW v_aluno3
AS
	SELECT cod_aluno codigo,
		   nome aluno,
		   cidade
	FROM aluno
	WHERE estado = 'SP'
	WITH READ ONLY;

DELETE FROM v_aluno3;

-- Excluir view
DROP VIEW v_aluno3;
	
