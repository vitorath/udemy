-- Exemplo 1
DECLARE
	codAluno ALUNO.cod_aluno%TYPE;
	nome ALUNO.nome%TYPE;

	CURSOR cAlunos IS
		SELECT cod_aluno, nome
		FROM aluno;
BEGIN
	OPEN cAlunos;
	LOOP 
		FETCH cAlunos INTO codAluno, nome;
		EXIT WHEN cAlunos%ROWCOUNT > 10 OR cAlunos%NOTFOUND;
		
		DBMS_OUTPUT.PUT_LINE('Codigo: ' || LPAD(codAluno, 4, '0') || ' - Nome: ' || nome);
	END LOOP;
	CLOSE cAlunos;
END;

-- Exemplo 2
DECLARE
	CURSOR cAlunos IS
		SELECT * FROM aluno;
	
	registro cAlunos%ROWTYPE;
BEGIN
	OPEN cAlunos;
	LOOP
		FETCH cAlunos INTO registro;
		EXIT WHEN cAlunos%ROWCOUNT > 10 OR cAlunos%NOTFOUND;
	
		DBMS_OUTPUT.PUT_LINE('Codigo: ' || LPAD(registro.cod_aluno, 4, '0') || ' - Nome: ' || registro.nome);
	END LOOP;
	CLOSE cAlunos;
END;

-- Exemplo 3
DECLARE
	CURSOR cAlunos IS
		SELECT * FROM aluno;
	
	registro cAlunos%ROWTYPE;
BEGIN
	FOR registro IN cAlunos
	LOOP 
		DBMS_OUTPUT.PUT_LINE('Codigo: ' || LPAD(registro.cod_aluno, 4, '0') || ' - Nome: ' || registro.nome);
	END LOOP;
END;

-- Exemplo 4
DECLARE
	registro ALUNO%ROWTYPE;
BEGIN
	FOR registro IN (SELECT * FROM aluno)
	LOOP 
		DBMS_OUTPUT.PUT_LINE('Codigo: ' || LPAD(registro.cod_aluno, 4, '0') || ' - Nome: ' || registro.nome);
	END LOOP;
END;

-- Exemplo 5
DECLARE
	CURSOR cAlunos (pCodAluno NUMBER) IS
		SELECT 	* FROM aluno
		WHERE cod_aluno = pCodAluno
		FOR UPDATE OF nome NOWAIT; -- Bloqueia a coluna nome para alteração
	
	registro cAlunos%ROWTYPE;
BEGIN
	OPEN cAlunos(&codigo);
	FETCH cAlunos INTO registro;
	DBMS_OUTPUT.PUT_LINE('Codigo: ' || LPAD(registro.cod_aluno, 4, '0') || ' - Nome: ' || registro.nome);

	CLOSE cAlunos;
END;

-- Exemplo 6
DECLARE
	CURSOR cAlunos IS
		SELECT nome FROM ALUNO
		FOR UPDATE;
	
	registro cAlunos%ROWTYPE;
BEGIN
	FOR registro IN cAlunos
	LOOP
		UPDATE aluno
		SET nome = INITCAP(registro.nome)
		WHERE CURRENT OF cAlunos;
	
		DBMS_OUTPUT.PUT_LINE('Nome: ' || INITCAP(registro.nome));
	END LOOP;
	COMMIT;
END;

SELECT * FROM aluno;













