-- UNION - Eleminina registros duplicidades (todas as colunas devem ser igualis, únicos), mantendo registros únicos (similar ao distinct)
SELECT cod_aluno, total, desconto
FROM contrato 
WHERE cod_aluno = 1
UNION
SELECT cod_aluno, total, desconto
FROM contrato 
WHERE total >= 1000;

-- UNION ALL - Junta ambos os resultados dos select, lembrando que deve ter mesmas colunas
SELECT cod_aluno, total, desconto
FROM contrato 
WHERE cod_aluno = 1
UNION ALL
SELECT cod_aluno, total, desconto
FROM contrato 
WHERE total >= 1000;

-- UNION e UNION ALL
SELECT cod_contrato, data, total, 'UNION 1' AS query
FROM contrato
WHERE total >= 1000 AND total < 2000
UNION ALL
SELECT cod_contrato, data, total, 'UNION 2' AS query
FROM contrato
WHERE desconto IS NOT NULL
UNION 
SELECT cod_contrato, data, total, 'UNION 3' AS query
FROM contrato
WHERE desconto >= 2000
ORDER BY 4;

-- INTERSECT - retorna a intersecção entre os resultados (linhas em comum)
SELECT cod_contrato, data, desconto, total
FROM contrato
WHERE desconto IS NOT NULL
INTERSECT 
SELECT cod_contrato, data, desconto, total
FROM contrato 
WHERE total > 1000
ORDER BY 1;

-- MINUS - retorna as linhas que são diferentes entre as queries;
SELECT cod_contrato, data, desconto, total
FROM contrato
WHERE desconto IS NOT NULL
MINUS 
SELECT cod_contrato, data, desconto, total
FROM contrato 
WHERE total > 1000
ORDER BY 1;

