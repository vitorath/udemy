--  Códigos de erros vão de 20001 até 20999 (RAISE)

-- Exemplo 1 - Exceptions
DECLARE
	codAluno ALUNO.cod_aluno%TYPE := 566;
	cidade ALUNO.cidade%TYPE;
	x NUMBER;
BEGIN
	SELECT cidade INTO cidade
	FROM aluno
	WHERE cod_aluno = codAluno;

	x := 0 / 0;

	DBMS_OUTPUT.PUT_LINE('Cidade: ' || cidade);
EXCEPTION
	WHEN NO_DATA_FOUND THEN
		RAISE_APPLICATION_ERROR(-20001, 'Aluno onexistente! ' || SQLCODE || ' ' || SQLERRM);
	WHEN TOO_MANY_ROWS THEN
		RAISE_APPLICATION_ERROR(-20002, 'Registro Duplicado! ' || SQLCODE || ' ' || SQLERRM);
	WHEN OTHERS THEN
		RAISE_APPLICATION_ERROR(-20003, 'Exceção Desconhecida! ' || SQLCODE || ' ' || SQLERRM);
END;

-- Exemplo 2 - Forçar erro de regra de negócio
CREATE TABLE contas (
	codigo INTEGER NOT NULL PRIMARY KEY,
	valor NUMBER(10, 2),
	juros NUMBER(10, 2),
	vencimento DATE
);

INSERT INTO contas VALUES (100, 550, 50, SYSDATE - 10);
SELECT * FROM contas;
COMMIT;

DECLARE
	vDataVencimento DATE;
	vCodigoConta NUMBER := 100;
	eContaVencida EXCEPTION;
BEGIN
	SELECT vencimento 
	INTO vDataVencimento
	FROM contas WHERE codigo = vCodigoConta;

	IF vDataVencimento < TRUNC(SYSDATE) THEN
		RAISE eContaVencida;
	END IF;
EXCEPTION
	WHEN eContaVencida THEN
		DBMS_OUTPUT.PUT_LINE('Conta vencida');
	
		UPDATE contas SET valor = valor + juros
		WHERE codigo = vCodigoConta;
END;

SELECT * FROM contas;

-- Exemplo 3 - Pragma Exception
DECLARE
	eFkInexistente EXCEPTION;
	PRAGMA EXCEPTION_INIT(eFkInexistente, -02291);
BEGIN
	INSERT INTO bairro VALUES (100, 100, 'Erro');
EXCEPTION 
	WHEN eFkInexistente THEN
		RAISE_APPLICATION_ERROR(-20200, 'cidade não existe!');
END;






