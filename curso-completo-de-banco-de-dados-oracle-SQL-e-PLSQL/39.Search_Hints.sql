-- Conectado como system --Visão dos hints 
SELECT * FROM v$sql_hint;

-- Conectado como system grant select_catalog_role to marcio; grant select any dictionary to marcio;

-- first_rows: Para forçar o uso de índice de modo geral.  
-- Faz com que o otimizador escolha um caminho que recupera N linhas primeiramente e ja mostra enquanto processa o resto
SELECT * FROM taluno;

CREATE INDEX ind_aluno_nome ON taluno(nome);

SELECT /*+ first_rows(2) */ cod_aluno, nome FROM taluno

-- all_rows: Para forçar varredura completa na tabela.
SELECT /*+ all_rows (10) */ cod_aluno, nome
FROM taluno;

-- full: Para forçar um scan completo na tabela. 
-- A hint full também pode causar resultados inesperados como varredura 
-- na tabela em ordem diferente da ordem padrão.
 
SELECT /*+ full_rows (taluno) */ cod_aluno, nome
FROM taluno
WHERE nome = 'MARCIO';

-- index: Força o uso de um índice. -- Nenhum índice é especificado.  
-- O Oracle pesa todos os índices possíveis e escolhe um ou mais a serem usados.  
-- Otimizador não fará um scan completo na tabela.
SELECT /*+ index */ cod_aluno, nome
FROM taluno
WHERE nome = 'MARCIO';

---Exemplo do uso da hint index informando os índices que devem ser utilizados:
SELECT /*+ index (taluno ind_aluno_nome) */ cod_aluno, nome, cidade
FROM taluno
WHERE nome = 'MARCIO';

-- no_index: Evitar que um índice especificado seja usado pelo Oracle.
SELECT /*+ no_index (taluno ind_aluno_nome) */ cod_aluno, nome, cidade
FROM taluno
WHERE nome = 'MARCIO' ;

-- index_join : Permite mesclar índice em uma única tabela.  
-- Permite acessar somente os índices da tabela, e não apenas um scan  
-- com menos bloco no total, é mais rápido do que usar um índice que faz scan na tabela por rowid.
CREATE INDEX ind_aluno_cidade ON taluno(cidade);

SELECT /*+ index_join (taluno ind_aluno_nome, ind_aluno_cidade) */ cod_aluno, nome, cidade
FROM taluno
WHERE nome = 'MARCIO' AND cidade = 'NOVO HAMBURGO';

-- and_equal : Para acessar todos os índices que você especificar.  
-- A hint and_equal faz com que o otimizador misture vários índices para uma única tabela em vez de escolher qual é ao melhor.
SELECT /*+ and_equal (taluno ind_aluno_nome, ind_aluno_cidade) */ cod_aluno, nome, cidade
FROM taluno
WHERE nome = 'MARCIO' AND cidade = 'NOVO HAMBURGO';

-- index_ffs: Força um scan completo do índice.  
-- Este hint pode oferecer grandes ganhos de desempenho quando a tabela também possuir muitas colunas.
SELECT /*+ index_ffs (taluno ind_aluno_nome) */ cod_aluno, nome
FROM taluno
WHERE nome = 'MARCIO';

