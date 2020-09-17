-- Consultas multiplas tableas

-- Produto cartesiano (Errado fazer isto)
SELECT aluno.cod_aluno, aluno.nome, contrato.total
FROM aluno, contrato;

-- Inner join
SELECT aluno.cod_aluno, aluno.nome, contrato.total
FROM aluno, contrato
WHERE aluno.cod_aluno = contrato.cod_aluno;

SELECT alu.cod_aluno, alu.nome, con.total
FROM aluno alu, contrato con
WHERE alu.cod_aluno = con.cod_aluno
ORDER BY alu.nome;

-- Excpetion: Coluna ambigua. Colunas com mesmo nome colocar prefixo
SELECT cod_aluno, aluno.nome, contrato.total
FROM aluno, contrato
WHERE aluno.cod_aluno = contrato.cod_aluno;

-- Equivalente a um left join ou right join, onde (+) indica a tabela que terá valores nulos
SELECT alu.cod_aluno, alu.nome AS aluno, 
	   con.cod_contrato, con.DATA, con.total,
	   ite.cod_curso, cur.nome AS curso,
	   ite.valor
FROM aluno alu, contrato con, 
	 item ite, curso cur
WHERE alu.cod_aluno = con.cod_aluno(+)
AND con.cod_contrato = ite.cod_contrato(+)
AND ite.cod_curso  = cur.cod_curso(+)
ORDER BY con.total DESC;

-- Relacionamento onde não possui chaves para vincular
SELECT con.cod_contrato AS contrato, des.classe AS desconto
FROM contrato con, desconto des
WHERE NVL(con.desconto, 0) BETWEEN des.inferior AND des.superior
ORDER BY con.cod_contrato;

-- Curos vendidos
SELECT cur.cod_curso, cur.nome, ite.valor
FROM curso cur, item ite
WHERE cur.cod_curso = ite.cod_curso;

-- Cursos não vendidos
SELECT cur.cod_curso, cur.nome, ite.valor
FROM curso cur, item ite
WHERE cur.cod_curso = ite.cod_curso(+)
AND ite.cod_item IS NULL;

-- Join mesma tabela
SELECT curso.nome AS Curso, pre_requisito.nome AS Pre_Requisito
FROM curso curso, curso pre_requisito
WHERE curso.pre_requisito = pre_requisito.cod_curso(+);
