-- Exemplo 1
CREATE OR REPLACE PROCEDURE aumentaPrecoCurso(pCodCurso NUMBER)
IS 
BEGIN 
	UPDATE curso SET valor = valor * 1.1
	WHERE cod_curso = pCodCurso;
END;
-- OU
CREATE OR REPLACE PROCEDURE aumentaPrecoCurso(pCodCurso CURSO.cod_curso%TYPE)
IS 
BEGIN 
	UPDATE curso SET valor = valor * 1.1
	WHERE cod_curso = pCodCurso;
END;


SELECT * FROM curso;

EXEC aumentaPrecoCurso(52); 
-- OU
DECLARE
	vCodCurso INTEGER := &codigo
BEGIN
	aumentaPrecoCurso(vCodCurso);
END

-- Exemplo 2
CREATE OR REPLACE PROCEDURE consultaAluno (
	pCodigo IN ALUNO.cod_aluno%TYPE,
	pNome OUT ALUNO.nome%TYPE,
	pCep OUT ALUNO.cep%TYPE,
	pCidade OUT ALUNO.cidade%TYPE
) IS 
BEGIN
	SELECT nome, cep, cidade
	INTO pNome, pCep, pCidade
	FROM aluno
	WHERE cod_aluno = pCodigo;
END;

DECLARE
	vCodigo ALUNO.cod_aluno%TYPE := &codigo;
	vNome ALUNO.nome%TYPE;
	vCep ALUNO.cep%TYPE;
	vCidade ALUNO.cidade%TYPE;
BEGIN
	consultaAluno(vCodigo, vNome, vCep, vCidade);
	DBMS_OUTPUT.PUT_LINE(vNome);
	DBMS_OUTPUT.PUT_LINE(vCidade);
	DBMS_OUTPUT.PUT_LINE(vCep);

	consultaAluno(
		pNome => vNome, 
		pCodigo => vCodigo, 
		pCep => vCep, 
		pCidade => vCidade
	);
	DBMS_OUTPUT.PUT_LINE(vNome);
	DBMS_OUTPUT.PUT_LINE(vCidade);
	DBMS_OUTPUT.PUT_LINE(vCep);
END;

-- Exemplo 3
CREATE OR REPLACE PROCEDURE consultarAlunos(
	pAluno IN OUT ALUNO%ROWTYPE
) IS
	CURSOR cAlunos IS
		SELECT * FROM aluno WHERE cod_aluno = pAluno.cod_aluno;
BEGIN
	OPEN cAlunos;
	FETCH cAlunos INTO pAluno;
	CLOSE cAlunos;
END;

DECLARE
	vAluno ALUNO%ROWTYPE;
BEGIN
	vAluno.cod_aluno := 1;
	consultarAlunos(vAluno);

	DBMS_OUTPUT.PUT_LINE(vAluno.nome);
	DBMS_OUTPUT.PUT_LINE(vAluno.cidade || ' Cep: ' || vAluno.cep);
END;

-- Exemplo 4
CREATE OR REPLACE PROCEDURE formatarNumero(pTelefone IN OUT VARCHAR2)
IS 
BEGIN 
	pTelefone := SUBSTR(pTelefone, 1, 4) || '-' || SUBSTR(pTelefone, 5, 4); 
END;

DECLARE
	vTelefone VARCHAR2(20);
BEGIN
	vTelefone := '12345678';
	formatarNumero(vTelefone);

	DBMS_OUTPUT.PUT_LINE(vTelefone);
END;
/







