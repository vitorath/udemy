SELECT * FROM USER_CONSTRAINTS;
SELECT * FROM ALL_CONSTRAINTS;

CREATE TABLE cidade(
	cod_cidade INTEGER NOT NULL,
	nome VARCHAR2(40),
	CONSTRAINT pk_cidade PRIMARY KEY(cod_cidade)
);

CREATE TABLE bairro(
	cod_cidade INTEGER NOT NULL,
	cod_bairro INTEGER NOT NULL,
	nome VARCHAR2(40),
	CONSTRAINT pk_bairro PRIMARY KEY(cod_cidade, cod_bairro)
);

CREATE TABLE rua(
	cod_rua INTEGER NOT NULL,
	cod_cidade INTEGER NOT NULL,
	cod_bairro INTEGER NOT NULL,
	nome VARCHAR2(40),
	CONSTRAINT pk_rua PRIMARY KEY(cod_rua, cod_cidade, cod_bairro)
);

CREATE TABLE pessoa(
	cod_pessoa INTEGER NOT NULL,
	tipo CHAR(1) NOT NULL,
	nome VARCHAR2(30) NOT NULL,
	pessoa CHAR(1) NOT NULL,
	cod_rua INTEGER NOT NULL,
	cod_cidade INTEGER NOT NULL,
	cod_bairro INTEGER NOT NULL,
	cpf VARCHAR2(15),
	CONSTRAINT pk_pessoa PRIMARY KEY(cod_pessoa)
);

-- Add Foreign Key
ALTER TABLE bairro ADD CONSTRAINT fk_cod_cidade
FOREIGN KEY (cod_cidade)
REFERENCES cidade(cod_cidade);

ALTER TABLE rua ADD CONSTRAINT fk_cidade_bairro
FOREIGN KEY(cod_cidade, cod_bairro)
REFERENCES bairro(cod_cidade, cod_bairro);

ALTER TABLE pessoa ADD CONSTRAINT fk_pessoa_rua
FOREIGN KEY(cod_rua, cod_cidade, cod_bairro)
REFERENCES rua;

-- Unique key
ALTER TABLE pessoa ADD CONSTRAINT uk_cpf UNIQUE(cpf);

-- Check
ALTER TABLE pessoa ADD CONSTRAINT ck_pessoa_tipo
CHECK(tipo IN ('C', 'F'));

ALTER TABLE pessoa ADD CONSTRAINT ck_pessoa_jf
CHECK(pessoa IN ('J', 'F'));

ALTER TABLE contrato ADD CONSTRAINT ck_contrato_desconto
CHECK(desconto BETWEEN 0 AND 30); -- se existir algum valor divergente irá dar erro ao executar

-- Desabilitar/Habilitar constraint
ALTER TABLE pessoa DISABLE CONSTRAINT uk_cpf;
ALTER TABLE pessoa ENABLE CONSTRAINT uk_cpf;

-- drop constaint 
ALTER TABLE pessoa DROP CONSTRAINT uk_cpf
CASCADE CONSTRAINT -- se necessario adicionar

-- Cidade
INSERT INTO cidade VALUES(1, 'Novo Hamburgo');
INSERT INTO cidade VALUES(2, 'Ivoti');
INSERT INTO cidade VALUES(3, 'Sapiranga');
INSERT INTO cidade VALUES(4, 'taquara');

-- Bairro
INSERT INTO bairro VALUES(1, 1, 'Centro');
INSERT INTO bairro VALUES(2, 1, 'Rio Branco');
INSERT INTO bairro VALUES(3, 1, 'Centro');
INSERT INTO bairro VALUES(4, 1, 'Fritz');

-- Bairro com erro de constraint foreign key, já que não existe
INSERT INTO bairro VALUES(5, 1, 'Amaral');
INSERT INTO bairro VALUES(6, 1, 'Empresa');

-- Rua
INSERT INTO rua VALUES(1, 1, 1, 'Marcilio Dias');
INSERT INTO rua VALUES(2, 2, 1, 'Fritz');
INSERT INTO rua VALUES(3, 3, 1, 'Jacobina');
INSERT INTO rua VALUES(4, 3, 1, 'João da Silva');

-- Pessoa
INSERT INTO pessoa VALUES(1, 'C', 'Marcio', 'F', 1, 1, 1, '1234');
INSERT INTO pessoa VALUES(2, 'C', 'Beatriz', 'F', 2, 2, 1, '123');
INSERT INTO pessoa VALUES(3, 'F', 'Pedro', 'F', 3, 3, 1, '12345');
INSERT INTO pessoa VALUES(4, 'F', 'Maria', 'J', 4, 3, 1, '12356');

-- Consultas específicas
SELECT * FROM USER_CONSTRAINTS WHERE table_name = 'PESSOA';
SELECT constraint_name, column_name FROM USER_CONS_COLUMNS WHERE table_name = 'PESSOA';
SELECT object_name, object_type FROM USER_OBJECTS WHERE object_name IN ('PESSOA', 'UK_CPF'); 

SELECT * FROM pessoa;


