-- Exemplo 1
CREATE OR REPLACE FUNCTION consultarPreco(pCodigoCurso NUMBER)
RETURN NUMBER 
AS
	vValor NUMBER;
BEGIN
	SELECT valor 
	INTO vValor
	FROM curso
	WHERE cod_curso = pCodigoCurso;
	
	RETURN vValor;
END;

DECLARE
	vCodigoCurso NUMBER := &codigo;
	vValor NUMBER;
BEGIN
	vValor := consultarPreco(vCodigoCurso);
	DBMS_OUTPUT.PUT_LINE('Preco do curso: ' || vValor);
END;

-- Excemplo 2
CREATE OR REPLACE FUNCTION existeAluno(pCodigoAluno IN ALUNO.cod_aluno%TYPE)
RETURN BOOLEAN
IS
	vCodAluno NUMBER(10);
BEGIN 
	SELECT cod_aluno
	INTO vCodAluno 
	FROM aluno 
	WHERE cod_aluno = pCodigoAluno;
	RETURN TRUE;
EXCEPTION
	WHEN OTHERS THEN
		RETURN FALSE;
END;

DECLARE
	vCodigo INTEGER := 100;
BEGIN
	IF existeAluno(vCodigo) THEN
		DBMS_OUTPUT.PUT_LINE('Codigo encontrado');
	ELSE
		DBMS_OUTPUT.PUT_LINE('Codigo NÃO encontrado');
	END IF;
END;

-- Excemplo 3
CREATE OR REPLACE PROCEDURE cadastrarAluno(
	pCodAluno IN ALUNO.cod_aluno%TYPE,
	pNome IN ALUNO.nome%TYPE,
	pCidade IN ALUNO.cidade%TYPE,
	pEstado IN ALUNO.estado%TYPE
) IS 
BEGIN 
	IF (NOT existeAluno(pCodAluno)) THEN
		INSERT INTO aluno(cod_aluno, nome, cidade, estado)
		VALUES (pCodAluno, pNome, pCidade, pEstado);
		DBMS_OUTPUT.PUT_LINE('Aluno cadastrado com sucesso');
	ELSE 
		DBMS_OUTPUT.PUT_LINE('Código já existe');
	END IF;
END;

DECLARE
BEGIN
	cadastrarAluno(seq_aluno.NEXTVAL, 'Roberto', 'Cuiaba', 'MT');
	
END;


SELECT * FROM aluno;














