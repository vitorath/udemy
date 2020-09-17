-- ROLLUP - subtotal e total
SELECT cod_aluno, TRUNC(data),
	   SUM(desconto) total_desconto,
	   SUM(total) soma_total
FROM contrato
WHERE cod_aluno IS NOT NULL
GROUP BY ROLLUP(cod_aluno, TRUNC(data)); -- grupo principal cod_aluno

SELECT cod_aluno,
	   CASE
	   	WHEN TRUNC(data) IS NULL AND cod_aluno IS NOT NULL THEN 'Sub-Total'
	   	WHEN cod_aluno IS NULL THEN 'Total Geral'
	   	ELSE TO_CHAR(TRUNC(data))
	   END descricao,
	   AVG(desconto) media_desconto,
	   SUM(total) soma_total
FROM contrato
WHERE cod_aluno IS NOT NULL
GROUP BY ROLLUP(cod_aluno, TRUNC(data)); -- grupo principal cod_aluno

-- CUBE - subtotal, total e informações adicionais
SELECT cod_aluno, TRUNC(data),
	   SUM(desconto) total_desconto,
	   SUM(total) soma_total
FROM contrato
WHERE cod_aluno IS NOT NULL
GROUP BY CUBE(cod_aluno, TRUNC(data));

-- Groupping -- total geral
SELECT GROUPING(cod_aluno),
	   SUM(desconto) total_desconto,
	   SUM(total) soma_total
FROM contrato
WHERE cod_aluno IS NOT NULL
GROUP BY ROLLUP(cod_aluno);

SELECT GROUPING(cod_aluno),
	   CASE
	   	WHEN GROUPING(cod_aluno) = 0 THEN TO_CHAR(cod_aluno) -- groupping igual a 1 representa o total
	   	ELSE 'Total Geral'
	   END aluno,
	   SUM(desconto) total_desconto,
	   SUM(total) soma_total
FROM contrato
WHERE cod_aluno IS NOT NULL
GROUP BY ROLLUP(cod_aluno);

-- Groupping_id -- subtotais e total geral
SELECT TRUNC(data),
	   GROUPING_ID(TRUNC(data)) GDT,
	   cod_aluno,
	   GROUPING_ID(cod_aluno) GCL,
	   SUM(total) total
FROM contrato
WHERE cod_aluno IS NOT NULL
GROUP BY ROLLUP(TRUNC(data), cod_aluno); -- grupo principal data

SELECT TRUNC(data), cod_aluno,
	   CASE
	   	WHEN GROUPING_ID(TRUNC(data)) = 0 AND GROUPING_ID(cod_aluno) = 1 THEN 'Total do Dia'
	    WHEN GROUPING_ID(TRUNC(data)) = 1 AND GROUPING_ID(cod_aluno) = 1 THEN 'Total Geral'
	   END descricao,
	   SUM(total)
FROM contrato
WHERE cod_aluno IS NOT NULL
GROUP BY ROLLUP(TRUNC(data), cod_aluno); -- grupo principal data

-- Grouping Sets - mostar somente subtotais
SELECT cod_aluno,
	   TRUNC(data),
	   SUM(total) total
FROM contrato
WHERE cod_aluno IS NOT NULL
GROUP BY GROUPING SETS (cod_aluno, TRUNC(data));

-- Rank - segue a contagem dos registros (linhas), empatados ficam com o mesma posição
SELECT cod_aluno,
	   TRUNC(data),
	   SUM(total) total,
	   RANK() OVER (ORDER BY SUM(total) DESC) posicao
FROM contrato
WHERE cod_aluno IS NOT NULL
GROUP BY (cod_aluno, TRUNC(data));

SELECT cod_aluno,
	   SUM(total) total,
	   RANK() OVER (ORDER BY SUM(total) DESC) posicao
FROM contrato
WHERE cod_aluno IS NOT NULL
GROUP BY (cod_aluno);

-- Rank + Partition By - Separa por grupo
SELECT cod_aluno,
	   TRUNC(data),
	   SUM(total) total,
	   RANK() OVER (PARTITION BY TRUNC(DATA) ORDER BY SUM(total) DESC) posicao
FROM contrato
WHERE cod_aluno IS NOT NULL
GROUP BY (cod_aluno, TRUNC(data));

-- Dense Rank - Não deixa "buracos" na contagem
SELECT cod_contrato, total,
	   RANK() OVER(ORDER BY total DESC) posicao,
	   DENSE_RANK() OVER(ORDER BY total DESC) posicao_dense
FROM contrato
WHERE cod_aluno IS NOT NULL
GROUP BY (cod_contrato, total);

-- Ratio To Report - Mostra o percentual de cada subtotal referente ao total
SELECT cod_aluno, SUM(total) "Total do Aluno",
	   ROUND(RATIO_TO_REPORT(SUM(total)) OVER() * 100, 2) "% do Total"
FROM contrato 
GROUP BY cod_aluno;

-- Ratio To Report + Partition By
SELECT cod_aluno,
	   TRUNC(data),
	   SUM(total) "Total do Dia",
	   ROUND(RATIO_TO_REPORT(SUM(total)) OVER(PARTITION BY (TRUNC(data))) * 100, 2) "% do Dia"
FROM contrato 
GROUP BY cod_aluno, TRUNC(data);

-- LAG e LEAD

SELECT TRUNC(data),
	   SUM(total) "Total do Dia",
	   LAG(SUM(total), 1) OVER(ORDER BY TRUNC(data)) "Total do Dia Anterior",
	   LEAD(SUM(total), 1) OVER(ORDER BY TRUNC(data)) "Total do Dia Posterior"
FROM contrato 
GROUP BY TRUNC(data);


