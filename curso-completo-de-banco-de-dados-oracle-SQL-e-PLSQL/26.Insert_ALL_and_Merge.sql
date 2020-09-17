-- Exemplo 1 - INSERT ALL
INSERT ALL 
	INTO curso (cod_curso, nome, valor)
	INTO aluno  (cod_aluno, nome, salario)
		SELECT cod_contrato + 50, 'INSERT ALL', 1013
		FROM contrato
		WHERE cod_contrato = 1;
		
SELECT * FROM curso;
SELECT * FROM aluno;

-- Exemplo 2 - INSERT ALL
CREATE SEQUENCE seqCurso START WITH 100;

INSERT ALL
	WHEN total > 1000 THEN
		INTO curso (cod_curso, nome, valor)
		VALUES (seqCurso.NEXTVAL, 'curso > 1000', total)
	WHEN desconto IS NULL THEN
		INTO curso (cod_curso, nome, valor)
		VALUES (seqCurso.NEXTVAL, 'Desconto is null', total)
	SELECT cod_contrato, total, desconto
	FROM contrato WHERE cod_contrato = 1;
	
-- Exemplo 3 - MERGE
MERGE INTO contrato
	USING (SELECT cod_aluno AS aluno
		   FROM aluno 
		   WHERE estado = 'SP')
	ON (contrato.cod_aluno = aluno)
		WHEN MATCHED THEN
			UPDATE SET desconto = 22
		WHEN NOT MATCHED THEN 
			INSERT(contrato.cod_contrato, 
				   contrato.data, 
				   contrato.cod_aluno, 
				   contrato.desconto, 
				   contrato.total)
			VALUES (seq_contrato.NEXTVAL, SYSDATE, aluno, 0, 69);

SELECT * FROM contrato;
SELECT * FROM aluno;
		   
		   
		   
		   
		   