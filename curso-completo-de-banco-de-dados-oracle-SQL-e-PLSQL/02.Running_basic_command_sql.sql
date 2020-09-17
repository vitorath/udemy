/*
 * INTEGER - NUMBER(38)
 * NUMBER(TOTAL_DIGITOS, QUANTOS_DIGITOS_SERAM_RESERVADOR_PARA_DECIMAL)
 * VARCHAR vs VARCHAR2, não tem diferença, são sinonimos. Mesmo que digitar varchar seŕa criado o varchar2
 * CHAR(10) vs VARCHAR2, CHAR terá 10 caracteres mesmo que preenchido somente um único (restante será preenchido com espaços), VARCHAR2 realoca o espaço utilizado até o máximo informado
 * DATE - armazena date e hora
 * */

CREATE TABLE aluno(
	cod_aluno INTEGER NOT NULL,
	nome VARCHAR(30),
	cidade VARCHAR2(50),
	cep VARCHAR(10),
	CONSTRAINT pk_aluno PRIMARY KEY(cod_aluno)
);

CREATE TABLE curso(
	cod_curso INTEGER NOT NULL,
	nome VARCHAR2(30),
	valor NUMBER(8,2),
	carga_horaria INTEGER,
	CONSTRAINT pk_curso PRIMARY KEY(cod_curso)
);

CREATE TABLE contrato(
	cod_contrato INTEGER NOT NULL,
	data DATE,
	cod_aluno INTEGER,
	total NUMBER(8,2),
	desconto NUMBER(5,2),
	CONSTRAINT pk_contrato PRIMARY KEY(cod_contrato)
);

CREATE TABLE item(
	cod_item INTEGER NOT NULL,
	cod_curso INTEGER,
	cod_contrato INTEGER,
	valor NUMBER(8,2),
	CONSTRAINT pk_item PRIMARY KEY(cod_item)
);

CREATE TABLE desconto(
	classe VARCHAR(1),
	inferior NUMBER(4,2),
	superior NUMBER(4,2),
	CONSTRAINT pk_desconto PRIMARY KEY(classe)
);

-- Queries
SELECT * FROM aluno;
SELECT * FROM  curso;
SELECT * FROM contrato;

-- Populate Aluno
INSERT INTO aluno(cod_aluno, nome, cidade, cep)
VALUES (1, 'Vitor', 'Ribeirão Preto', '123456780');

INSERT INTO aluno(cod_aluno, nome, cidade, cep)
VALUES (2, 'Paula', 'Porto Claro', '2345678901');

INSERT INTO aluno(cod_aluno, nome, cidade, cep)
VALUES (3, 'Clara', 'Natal', '3456789012');

INSERT INTO aluno (cod_aluno, nome, cidade, cep) 
VALUES (10, 'Pedro', 'Novo Hamburgo', NULL);

-- Populate Curso
INSERT INTO curso VALUES(1, 'Oracle SQL e PL;SQL', 500, 25);
INSERT INTO curso VALUES(2, 'Oracle DBA', 499, 25);
INSERT INTO curso VALUES(3, 'Java Fundamentals e 00', 1500, 100);
INSERT INTO curso VALUES(4, 'Java Server Faces', 1600, 100);
INSERT INTO curso VALUES(5, 'React', 1000, 200);
INSERT INTO curso VALUES(6, 'PHP', 1000, 200, null);
INSERT INTO curso VALUEs(7, 'Lógica', 100, 20, null);

-- Populate Contrato
INSERT INTO contrato VALUES(1, SYSDATE, 1, 500, 10);
INSERT INTO contrato VALUES(2, SYSDATE, 2, 500, 10);
INSERT INTO contrato VALUES(3, SYSDATE, 3, 1500, 05);
INSERT INTO contrato VALUES(4, SYSDATE-4, 2, 1600, 10);
INSERT INTO contrato VALUES(5, SYSDATE-4, 5, 800, 10);
INSERT INTO contrato VALUES(6, SYSDATE-3, 5, 445, 0);
INSERT INTO contrato VALUES(7, SYSDATE-2, 5, 445, 20);

-- Populate Item
INSERT INTO item VALUES (1, 1, 1, 500);
INSERT INTO item VALUES (2, 1, 2, 500);
INSERT INTO item VALUES (3, 3, 3, 1500);
INSERT INTO item VALUES (4, 4, 4, 1600);
INSERT INTO item VALUES (5, 1, 5, 500);
INSERT INTO item VALUES (6, 1, 6, 500);
INSERT INTO item VALUES (7, 2, 6, 500);
INSERT INTO item VALUES (8, 3, 7, 500);

-- Populate desconto
INSERT INTO desconto VALUES('A', 00, 10);
INSERT INTO desconto VALUES('B', 11, 15);
INSERT INTO desconto VALUES('C', 16, 20);
INSERT INTO desconto VALUES('D', 21, 25);
INSERT INTO desconto VALUES('E', 26, 30);

-- Add new column
ALTER TABLE contrato ADD col_teste VARCHAR(30);

-- DROP COLUMN
ALTER TABLE contrato DROP COLUMN col_teste;

-- Rename column
ALTER TABLE aluno RENAME COLUMN	nome TO	nome2;
ALTER TABLE aluno RENAME COLUMN	nome2 TO nome;

-- Drop Table
DROP TABLE contrato;

-- Sequences
CREATE SEQUENCE seq_aluno START WITH 4;

-- New student dada
INSERT INTO aluno(cod_aluno, nome, cidade, cep)
VALUES (seq_aluno.NEXTVAL, 'Maria', 'Ribeirão Preto', '123456780');

INSERT INTO aluno(cod_aluno, nome, cidade, cep)
VALUES (seq_aluno.NEXTVAL, 'Livia', 'Ribeirão Preto', '123456780');

-- Data/hora do servidor
SELECT SYSDATE FROM DUAL;

-- Valor atual da sequencia
SELECT seq_aluno.CURRVAL FROM DUAL;

-- Desfazer
ROLLBACK;

-- Confirmar
COMMIT;

-- DELETE ALL students
DELETE FROM aluno;

-- Delete conditional student
DELETE FROM aluno WHERE cod_aluno = 4; 

-- Alterar registro na tabela
UPDATE contrato SET desconto = 18
WHERE cod_contrato = 2;

UPDATE contrato SET desconto = 18, data = SYSDATE
WHERE cod_contrato = 2;

UPDATE contrato SET desconto = 20;

SELECT * FROM ALL_TABLES WHERE LOWER(TABLESPACE_NAME) = 'tbs_dados';

-- 
ALTER TABLE aluno ADD estado CHAR(2) DEFAULT 'SP';
ALTER TABLE aluno ADD salario NUMBER(8,2) DEFAULT 620;
ALTER TABLE aluno ADD nascimento DATE DEFAULT SYSDATE - 1000;

ALTER TABLE curso ADD pre_requisito INTEGER;

UPDATE aluno SET estado = 'SC', salario = 250 WHERE cod_aluno = 1;
UPDATE aluno SET estado = 'MT', salario = 2000 WHERE cod_aluno = 2;
UPDATE aluno SET estado = 'SC', salario = 800 WHERE cod_aluno = 5;
UPDATE aluno SET nascimento = TO_DATE('10/10/2001', 'DD/mm/yyyy') WHERE cod_aluno = 2;
UPDATE aluno SET nascimento = TO_DATE('10/08/2000', 'DD/mm/yyyy') WHERE cod_aluno = 5;
UPDATE aluno SET salario = 633.47 WHERE cod_aluno = 1;

UPDATE curso SET pre_requisito = 7 WHERE cod_curso = 1;
UPDATE curso SET pre_requisito = 7 WHERE cod_curso = 3;
UPDATE curso SET pre_requisito = 1 WHERE cod_curso = 2;
UPDATE curso SET pre_requisito = 3 WHERE cod_curso = 4;









