-- Especificação ou declaração
CREATE OR REPLACE PACKAGE pkgAluno
IS
	-- Variaveis global
	vCidade VARCHAR2(30);
	vMedia NUMBER(8, 2);
	vNome VARCHAR2(30);

	PROCEDURE deletarAluno(pCodigoAluno NUMBER);
	PROCEDURE calcularMediaContratos;
	PROCEDURE consultarAluno(pCodigoAluno NUMBER);
END;
/

-- Corpo
CREATE OR REPLACE PACKAGE BODY pkgAluno
IS 
    -- Variaveis locais
	vTeste VARCHAR2(20);
	
	PROCEDURE calcularMediaContratos
	IS
	BEGIN
		vTeste := 'teste';
		SELECT AVG(total) 
		INTO vMedia 
		FROM contrato;
	END;

	PROCEDURE consultarAluno(pCodigoAluno NUMBER)
	IS
	BEGIN
		vNome := '';
		SELECT nome 
		INTO vNome 
		FROM aluno 
		WHERE cod_aluno = pCodigoAluno;
	EXCEPTION
		WHEN NO_DATA_FOUND THEN
			DBMS_OUTPUT.PUT_LINE('Aluno não existe');
	END;

	PROCEDURE deletarAluno(pCodigoAluno NUMBER)
	IS
	BEGIN
		consultarAluno(pCodigoAluno);
		IF LENGTH(vNome) > 0 THEN
			DELETE FROM aluno WHERE cod_aluno = pCodigoAluno;
			DBMS_OUTPUT.PUT_LINE(vNome || ' -> Excluido');
		END IF;
	END;

END;

SELECT * FROM aluno;

EXEC pkgAluno.deletarAluno(60);

--
DECLARE
	vMedia NUMBER;
BEGIN
	pkgAluno.calcularMediaContratos;
	vMedia := pkgAluno.vMedia;
	DBMS_OUTPUT.PUT_LINE('Média: ' || vMedia);
END;

--
DECLARE
	vNome VARCHAR2(30);
BEGIN
	pkgAluno.consultarAluno(1);
	vNome := pkgAluno.vNome;
	DBMS_OUTPUT.PUT_LINE('Nome: ' || vNome);
END;
/





