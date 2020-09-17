-- Bloco anônimo

-- Exemplo 1
DECLARE 
	x INTEGER;
	y INTEGER;
	c INTEGER;
BEGIN 
	x := 10;
	y := 20;
	c := x + y;
	DBMS_OUTPUT.PUT_LINE('Resultado ' || c);
END;

-- Exemplo 2
DECLARE
	vDesconto NUMBER(6,2) := 0.5;
	vCidade VARCHAR(30) := 'NOVO HAMBURGO';
	vCodAluno ALUNO.COD_ALUNO%TYPE :=  5;
	vTotal NUMBER(8,2) := 1345.89;
BEGIN
	vTotal := ROUND(vTotal * vDesconto, 2);
	DBMS_OUTPUT.PUT_LINE('Total: ' || vTotal);

	vDesconto := 1.20;
	vCidade := INITCAP(vCidade);
	DBMS_OUTPUT.PUT_LINE('Cidade: ' || vCidade);
	DBMS_OUTPUT.PUT_LINE('Desconto: ' || vDesconto);
	DBMS_OUTPUT.PUT_LINE('Aluno: ' || vCodAluno);
END;

-- Exemplo 3
DECLARE
	vPreco1 NUMBER(8,2) := 10;
	vPreco2 NUMBER(8,2) := 20;
	vFlag BOOLEAN;
BEGIN
	vFlag := (vPreco1 > vPreco2);

	IF (vFlag = True) THEN
		DBMS_OUTPUT.PUT_LINE('Verdadeiro');
	ELSE
		DBMS_OUTPUT.PUT_LINE('Falso');
	END IF;

	IF (vPreco1 > vPreco2) THEN
		DBMS_OUTPUT.PUT_LINE('Preço 1 é maior');
	ELSE
		DBMS_OUTPUT.PUT_LINE('Preço 2 é maior');
	END IF;
END;

-- Bind Variable
VARIABLE vDesconto2 NUMBER

DECLARE
	vCodAluno NUMBER := 1;
BEGIN
	:vDesconto2 := 0.90;
	DBMS_OUTPUT.PUT_LINE('Desconto 2: ' || :vDesconto2);

	UPDATE contrato SET total = total * :vDesconto2
	WHERE cod_aluno = vCodAluno;
END;

-- Alinhamento de blocos
DECLARE
	vTeste VARCHAR(10) := 'José';
BEGIN
	
	DECLARE
		vTeste VARCHAR(10) := 'Pedro';
	BEGIN
		DBMS_OUTPUT.PUT_LINE('Bloco interno 1: ' || vTeste);
	END;

	BEGIN
		DBMS_OUTPUT.PUT_LINE('Bloco interno 2: ' || vTeste);
	END;

	DBMS_OUTPUT.PUT_LINE('Bloco externo: ' || vTeste);
END;



