-- Funções agrupadoras e Group By

SELECT COUNT(1) AS QTDE_REGISTROS,
	AVG(total) AS MEDIA,
	ROUND(AVG(total), 2) AS MEDIA,
	MAX(total) AS MAXIMO,
	MIN(total) AS MINIMO,
	SUM(total) AS SOMA,
	MAX(data) AS DATA_MAIOR,
	MIN(data) AS DATA_MENOR
FROM contrato;

SELECT cod_aluno, COUNT(1) AS QTDE_CONTRATO, SUM(total) AS VALOR_TOTAL FROM contrato; -- ERRO
SELECT cod_aluno, COUNT(1) AS QTDE_CONTRATO, SUM(total) AS VALOR_TOTAL FROM contrato GROUP BY cod_aluno;

SELECT TO_CHAR(TRUNC(data), 'DD/MM/YYYY') AS DATA,
	SUM(total) AS SOMA,
	AVG(total) AS MEDIA,
	COUNT(1) AS QTDE
FROM contrato
GROUP BY data
ORDER BY data DESC; -- ERRADO

SELECT TO_CHAR(TRUNC(data), 'DD/MM/YYYY') AS DATA,
	SUM(total) AS SOMA,
	AVG(total) AS MEDIA,
	COUNT(1) AS QTDE
FROM contrato
GROUP BY TRUNC(data)
ORDER BY data DESC; -- Certo, já que espatamos usando TRUNC(data) como parametro

UPDATE contrato SET	desconto = NULL	WHERE cod_contrato = 4 OR cod_contrato = 3;
SELECT * FROM contrato;

SELECT COUNT(*) FROM contrato; -- Conta com base em todos os registros
SELECT COUNT(desconto) FROM contrato; -- Conta com base no desconto, caso seja NULL, não entra na contagem

SELECT COUNT(estado) FROM aluno; 
SELECT COUNT(DISTINCT(estado)) FROM aluno; -- Contagem de estados unicos/distintos 

SELECT estado, COUNT(*) FROM aluno GROUP BY estado --Como estado não está sendo aplicado funções agrupadoras, adiciana-lo no group by

SELECT COUNT(desconto), AVG(desconto), COUNT(desconto), ROUND(AVG(NVL(desconto, 0)), 2) FROM contrato; --Diferença AVG em registros NULL

SELECT * 
FROM aluno, contrato
WHERE aluno.cod_aluno = contrato.cod_aluno
GROUP BY aluno.estado, TRUNC(contrato.data)
ORDER BY aluno.estado, data DESC; --ERRO

SELECT aluno.estado, TRUNC(contrato.data) AS DATA, SUM(contrato.total) TOTAL, count(*) QTDE 
FROM aluno, contrato
WHERE aluno.cod_aluno = contrato.cod_aluno
GROUP BY aluno.estado, TRUNC(contrato.data)
ORDER BY aluno.estado, data DESC;

SELECT cod_aluno, AVG(total) MEDIA
FROM contrato
WHERE cod_aluno > 0
HAVING AVG(total) > 500 -- Aplicação de filtros junto a funções agrupadoras
GROUP BY cod_aluno
ORDER BY cod_aluno;
-- OU, é a mesma coisa
SELECT cod_aluno, AVG(total) MEDIA
FROM contrato
WHERE cod_aluno > 0
GROUP BY cod_aluno
HAVING AVG(total) > 500 -- Aplicação de filtros junto a funções agrupadoras
ORDER BY cod_aluno;


SELECT MAX(AVG(total))
FROM contrato; -- Erro por conta do max (caso bem específico), pq no max avg está sendo "usado" cod_aluno descobrir um único registro 

SELECT MAX(AVG(total))
FROM contrato
GROUP BY cod_aluno; -- Correto


SELECT estado, SUM(salario) AS TOTAL
FROM aluno
GROUP BY estado
ORDER BY 2 DESC; -- Segunda coluna do select
-- OU
SELECT estado, SUM(salario) AS TOTAL
FROM aluno
GROUP BY estado
ORDER BY TOTAL DESC; -- Segunda coluna do select



