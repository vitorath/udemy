/*
	SELECT [DISTINCT] {*, column [AS] [alias], ...} 
	FROM tablename
	[WHERE condition(s)]
	[ORDER by colunas(s)]
	
	SELECT - Listar
	DISTINCT - Remover duplicidades
    * - Todas as colunas
    column - Especificar coluna
    AS - Opcional
    alias - Apelidos para as colunas para preservar o nome da coluna e não ser convertido é necessário colocar "nomeColuna"
    FROM tablename - Especificar tabela ou tabelas para consulta
    WHERE - Restringe a consulta para as linhas 
    condition(s) - Composta de nomes de coluna expressões, constantes, e operadores de comparação
    
    Operadoes de comparação
    BETWEEN ... AND ...
    IN (list)
    LIKE '%...%' ou '...%' ou '%...'
    IS NULL
    IS NOT NULL
    
    
*/

SELECT cod_aluno, nome, cidade FROM aluno;

SELECT cod_aluno AS "Código", nome AS "Nome do Aluno" FROM aluno;

SELECT cidade FROM aluno;
SELECT DISTINCT cidade FROM aluno;
SELECT DISTINCT cidade, nome FROM aluno;

SELECT nome "Curso", valor, valor/carga_horaria, ROUND(valor/carga_horaria, 1) "Valor Hora" FROM curso;

UPDATE curso set valor = NULL WHERE COD_CURSO  = 2;
SELECT cod_curso, ROUND(valor/carga_horaria, 1) "Valor Hora sem NVL", NVL(ROUND(valor/carga_horaria, 1), 0) "Valor Hora com NVL" FROM curso;

SELECT cod_aluno || ' - ' || nome || ' | ' || cidade FROM aluno;

--
SELECT * FROM aluno WHERE estado <> 'RS' AND salario <= 800; 

SELECT estado, salario, nome FROM aluno ORDER BY estado, salario DESC;

SELECT cod_aluno, nascimento,  nome FROM aluno WHERE TRUNC(nascimento) = TO_DATE('05/11/2017', 'DD/mm/yyyy');

SELECT cod_aluno, nascimento,  nome FROM aluno WHERE nascimento BETWEEN TO_DATE('05/11/2017 00:00', 'DD/mm/yyyy HH24:MI') AND TO_DATE('05/11/2017 23:59', 'DD/mm/yyyy HH24:MI');

SELECT cod_contrato, data, total, desconto, desconto + 1000 AS calculo FROM contrato WHERE total <= (desconto + 1000);

UPDATE CONTRATO SET DESCONTO = NULL WHERE COD_CONTRATO = 3;

SELECT * FROM contrato WHERE desconto IS NULL;

SELECT * FROM contrato WHERE desconto BETWEEN 0 AND 10;
SELECT * FROM contrato WHERE desconto >= 0 AND desconto <= 10;

SELECT * FROM contrato WHERE NVL(desconto, 0) BETWEEN 0 AND 10;
SELECT * FROM contrato WHERE desconto >= 0 AND desconto <= 10 OR desconto IS NULL;


SELECT * FROM curso WHERE cod_curso IN (1,2,3);
SELECT * FROM curso WHERE cod_curso NOT IN (1,2,3);
SELECT * FROM curso WHERE cod_curso IN (SELECT COD_CURSO FROM ITEM);
SELECT * FROM curso WHERE cod_curso NOT IN (SELECT COD_CURSO FROM ITEM);

SELECT * FROM aluno WHERE nome LIKE '_i%'; -- _ - indica qualquer caracter antes
SELECT * FROM aluno WHERE nome LIKE '%i_';
SELECT * FROM aluno WHERE nome LIKE 'V%';
SELECT * FROM aluno WHERE nome LIKE '%a';
SELECT * FROM aluno WHERE nome LIKE '%i%';

SELECT * FROM curso WHERE pre_requisito IS NULL;
SELECT * FROM curso WHERE pre_requisito IS NOT NULL;

-- Precedencia de operadores
-- ()
-- AND
-- OR
SELECT * FROM curso WHERE valor > 750 OR valor < 1000 AND carga_horaria = 25;
SELECT * FROM curso WHERE (valor > 750 OR valor < 1000) AND carga_horaria = 25;













