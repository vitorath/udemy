-- visualizar todas as sequências do usuário
SELECT * FROM USER_SEQUENCES;

-- Criar sequância
CREATE SEQUENCE seq_aluno1
START WITH 60 -- Valor inicial
INCREMENT BY 5 -- Quantidade de incremento
MINVALUE 60 -- Valor mínimo
MAXVALUE 250 -- Valor máximo
NOCACHE -- não guarda em cache faixa de valores -- 20 padrão
NOCYCLE;

-- Utilizar sequência
INSERT INTO aluno (cod_aluno, nome)
VALUES (seq_aluno1.NEXTVAL, 'Master Training');

INSERT INTO aluno (cod_aluno, nome)
VALUES (seq_aluno1.NEXTVAL, 'Master Training 2');

SELECT * FROM aluno;

-- valor atual da sequância
SELECT seq_aluno1.CURRVAL FROM dual;

-- Alter parametro da sequência (altera tudo menos o valor atual)
ALTER SEQUENCE seq_aluno1 MAXVALUE 500;

-- Alterar valor atual da sequância
DROP SEQUENCE seq_aluno1;
CREATE SEQUENCE seq_aluno1
START WITH 80 -- Colocar aqui o valor que desejar
INCREMENT BY 5 
MINVALUE 60 
MAXVALUE 250 
NOCACHE 
NOCYCLE;

-- Indices secundários
-- Obs. Chave primária ṕe considerada indice primário
SELECT * FROM USER_INDEXES;

SELECT nome FROM aluno
WHERE nome LIKE '%A%'; 

SELECT nome FROM aluno
WHERE UPPER(nome) LIKE '%A%'; -- Aplicar uma função não funciona o index

CREATE INDEX ind_aluno_nome ON aluno(nome);

SELECT nome FROM aluno
WHERE UPPER(nome) LIKE '%A%' AND UPPER(cidade) LIKE '%A%';

CREATE INDEX ind_aluno_nome_cidade ON aluno(nome, cidade);

-- Excluir indice
DROP INDEX ind_aluno_nome_cidade;

--- Sinomimos (apelidos para objetos)
CREATE SYNONYM alu FOR aluno;

SELECT * FROM alu;


