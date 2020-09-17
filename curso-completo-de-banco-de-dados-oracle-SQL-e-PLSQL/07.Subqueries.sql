-- Sub-consultas

SELECT cod_contrato, data, total
FROM contrato
WHERE total > 
	(SELECT valor FROM curso WHERE COD_CURSO  = 1);
	

-- Erro subconsulta com igual. maior, menor, maior igual, menor igual deve retornar somente um uni valor
SELECT cod_contrato, data, total
FROM contrato
WHERE total >= 
	(SELECT valor FROM curso WHERE valor  > 500);
	

-- Todos os alunos da mesma cidade doa aluno 1
SELECT cod_aluno, nome, cidade
FROM aluno
WHERE cidade = (SELECT cidade FROM aluno WHERE cod_aluno = 1)
AND cod_aluno  <> 1;


-- Todos os alunos da mesma cidade e estado doa aluno 1
SELECT cod_aluno, nome, cidade
FROM aluno
WHERE (cidade, estado) = (SELECT cidade, estado FROM aluno WHERE cod_aluno = 1)
AND cod_aluno  <> 1;

-- Soma totos os itens e mostra somente os itens com valor minimo maior que a media dos cursos
 SELECT cod_curso, MIN(valor), SUM(valor), count(COD_ITEM) QTDE
 FROM item
 WHERE cod_curso > 0 -- Sóm para demonstrar onde fica ow where
 GROUP BY cod_curso
 HAVING MIN(valor) >= 
 	(SELECT AVG(valor) FROM curso)
 ORDER BY cod_curso;
 
-- Soma total de contrato por aluno e mostrar somente alunos cujo o menor contrato seja maior que o valor médio de curso
SELECT cod_aluno, MIN(total), SUM(total)
FROM contrato
GROUP BY cod_aluno
HAVING MIN(total) > 
	(SELECT AVG(valor) FROM curso);

-- Total dos cursos vendidos (Operador IN -  mais de um item no subselect - Array)
SELECT cod_curso, nome, valor
FROM curso
WHERE cod_curso IN (SELECT cod_curso FROM item)
ORDER BY nome;

-- Total dos cursos não vendidos (Operador NOT IN - mais de um item no subselect - Array)
SELECT cod_curso, nome, valor
FROM curso
WHERE cod_curso NOT IN (SELECT cod_curso FROM item)
ORDER BY nome;

-- Todos os cursos que foram vendidos pelo valor padrão (Array com valores compostos)
SELECT * FROM item 
WHERE (cod_curso, valor) IN 
	(SELECT cod_curso, valor FROM curso);

-- subconsulta na clausula from 
SELECT item.COD_CONTRATO, item.valor, item.COD_CURSO, 
	curso.cod_curso, curso.valor
FROM item, 
	( SELECT cod_curso, valor 
	  FROM curso WHERE valor > 500 ) curso
WHERE curso.COD_CURSO = item.cod_curso;
 
 