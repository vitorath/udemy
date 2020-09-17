-- Recuperando dados
-- Exemplo 1
DECLARE
	vValor NUMBER(8,2);
	vNome VARCHAR2(30);
BEGIN
	SELECT valor, nome
	INTO vValor, vNome
	FROM curso
	WHERE cod_curso = &cod_curso;

	DBMS_OUTPUT.PUT_LINE('Valor: ' || TO_CHAR(vValor, 'fm9999.99'));
	DBMS_OUTPUT.PUT_LINE('Curso: ' || INITCAP(vNome));
END;

-- Exemplo 2
DECLARE 
	vDataCompra contrato.data%TYPE;
	vDataCurso contrato.data%TYPE;
BEGIN
	SELECT DATA, DATA + 10
	INTO vDataCompra, vDataCurso
	FROM contrato
	WHERE cod_contrato = &contrato;
	DBMS_OUTPUT.PUT_LINE('Data Compra: ' || vDataCompra);
	DBMS_OUTPUT.PUT_LINE('Data Curso: ' ||vDataCurso);
END;

-- Exemplo 3
SELECT MAX(cod_contrato) FROM contrato;
CREATE SEQUENCE seq_contrato START WITH 8;

DECLARE
	vCodContrato contrato.cod_contrato%TYPE;
BEGIN
	SELECT seq_contrato.NEXTVAL
	INTO vCodContrato FROM DUAL;

	INSERT INTO contrato (cod_contrato, data, cod_aluno, desconto)
	VALUES (vCodContrato, SYSDATE, 2, NULL);

	DBMS_OUTPUT.PUT_LINE('Criando Contrato: ' || vCodContrato);
END;

-- Exemplo 4
DECLARE 
	vValor curso.valor%TYPE	:= &valor;
BEGIN
	UPDATE curso SET valor = valor + vValor
	WHERE carga_horaria >= 30;
END;

-- Exemplo 5
DECLARE 
	vCodContrato contrato.cod_contrato%TYPE := &contrato;
BEGIN
	DELETE FROM contrato
	WHERE cod_contrato = vCodContrato;
END;

-- Exemplo 6 - Erro "No Data Found"
DECLARE 
	vDataCompra contrato.data%TYPE;
	vTotal contrato.total%TYPE;
	vDataAtual DATE := SYSDATE;
BEGIN
	SELECT data, total
	INTO vDataCompra, vTotal
	FROM contrato
	WHERE DATA = vDataAtual;
END;

-- Exemplo 7 - Retornar quantidade de registros afetadas
DECLARE
	vCodContrato NUMBER := &cod_contrato;
	vQtdeRegistrosAfetados VARCHAR2(50);
BEGIN
	UPDATE contrato SET desconto = desconto + 2
	WHERE cod_contrato >= vCodContrato;

	vQtdeRegistrosAfetados := SQL%ROWCOUNT;
	DBMS_OUTPUT.PUT_LINE(vQtdeRegistrosAfetados || ' linhas atualizadas.');
END;

-- SQL%ROWCOUNT - Retornar quantidade de registros afetadas
-- SQL%FOUND - Retorna TRUE se o comando SQL mais recente afetou uma ou mais linhas
-- SQL%NOTFOUND - Retorna TRUE se o comando SQL mais recente NÃO afetou uma ou mais linhas
-- SQL%ISOPEN - Retorna sempre FALSE, pois o PL/SQL fecha cursores implicitos imediatamente após sua execução


