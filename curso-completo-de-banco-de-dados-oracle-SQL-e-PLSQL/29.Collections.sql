-- Exemplo 1 -- Record
DECLARE
	TYPE Rec_aluno IS RECORD ( 
		cod_aluno NUMBER NOT NULL := 0,
		nome TALUNO.Nome%TYPE,
		cidade TALUNO.Cidade%TYPE 
	);

	Registro rec_aluno;
BEGIN
	registro.cod_aluno := 50;
	registro.nome := 'Marcio Konrath';
	registro.cidade := 'Novo Hamburgo';

	Dbms_Output.Put_Line('Codigo: '||registro.cod_aluno);
	Dbms_Output.Put_Line(' Nome: '||registro.nome);
	Dbms_Output.Put_Line('Cidade: '||registro.cidade);
END;

-- Exemplo 2 -- Rowtype
DECLARE
	reg TAluno%ROWTYPE; --Record
	vcep VARCHAR(10) := '98300000';
BEGIN
	SELECT COD_ALUNO, NOME, CIDADE
	INTO Reg.cod_aluno, Reg.nome, Reg.cidade
	FROM TALUNO
	WHERE COD_ALUNO = 1;

	vCep := '93500000';
	reg.cep := vCep;

	Dbms_Output.Put_Line('Codigo: ' ||reg.cod_aluno);
	Dbms_Output.Put_Line('Nome : ' ||reg.nome);
	Dbms_Output.Put_Line('Cidade: ' ||reg.cidade);
	Dbms_Output.Put_Line('Cep : ' ||reg.cep);
END;

-- Exemplo 3 -- Nested Table
DECLARE
	TYPE T_ALUNO IS TABLE OF TALUNO.NOME%TYPE
	INDEX BY BINARY_INTEGER; --Matriz
	REGISTRO T_ALUNO; --Record
BEGIN
	REGISTRO(1) := 'MARCIO';
	REGISTRO(2) := 'JOSE';
	REGISTRO(3) := 'PEDRO';

	Dbms_Output.Put_Line('Nome 1: '||registro(1));
	Dbms_Output.Put_Line('Nome 2: '||registro(2));
	Dbms_Output.Put_Line('Nome 3: '||registro(3));
END;

--
SELECT cod_aluno, NOME
FROM tALUNO WHERE COD_ALUNO = 1;
--

-- Exemplo 4 --  Nested Table 
DECLARE
	TYPE nome_type IS TABLE OF taluno.nome%TYPE;
	nome_table nome_type := nome_type(); --Criando Instancia
BEGIN
	nome_table.EXTEND; -- alocando uma nova linha
	nome_table(1) := 'Marcelo';
	nome_table.EXTEND; -- alocando uma nova linha
	nome_table(2) := 'Marcio';

	Dbms_Output.Put_Line('Nome 1: '||nome_table(1));
	Dbms_Output.Put_Line('Nome 2: '||nome_table(2));
END;

-- Exemplo 5 -- Associative Table
DECLARE
	TYPE tipo IS TABLE OF VARCHAR2(40) INDEX BY VARCHAR2(2);
	uf_capital tipo;
BEGIN
	uf_capital('RS') := 'PORTO ALEGRE';
	uf_capital('RJ') := 'RIO DE JANEIRO';
	uf_capital('PR') := 'CURITIBA';
	uf_capital('MT') := 'CUIABA';

	dbms_output.put_line(uf_capital('RS'));
	dbms_output.put_line(uf_capital('RJ'));
	dbms_output.put_line(uf_capital('PR'));
	dbms_output.put_line(uf_capital('MT'));
END;

-- Exemplo 6 -- VArray
DECLARE 
	TYPE nome_varray IS VARRAY(5) OF taluno.nome%TYPE;
	nome_vetor nome_varray := nome_varray();
BEGIN
	nome_vetor.EXTEND;
	nome_vetor(1) := 'MasterTraining';

	Dbms_Output.Put_Line(nome_vetor(1));
END;

-- Exemplo 7 - Funciton Pipelined
DROP TYPE table_reg_aluno;

CREATE OR REPLACE TYPE reg_aluno 
AS OBJECT (
	codigo INTEGER,
	nome VARCHAR2(30),
	cidade VARCHAR2(30)
);

CREATE OR REPLACE TYPE table_reg_aluno 
AS TABLE OF reg_aluno;

CREATE OR REPLACE FUNCTION get_aluno(pCodigo NUMBER)
RETURN table_reg_aluno PIPELINED
IS 
	CURSOR cSQL IS
		SELECT alu.cod_aluno, alu.nome, alu.cidade 
		FROM taluno alu
		WHERE alu.cod_aluno = pCodigo;

	outLista REG_ALUNO;
	reg cSQL%ROWTYPE;
BEGIN
	OPEN cSQL;
	FETCH cSQL INTO reg;
	outLista := REG_ALUNO(reg.cod_aluno, reg.nome, reg.cidade);
	PIPE ROW(outLista);
	CLOSE cSQL;

	RETURN;
END;

SELECT * FROM TABLE(get_aluno(1));

SELECT * FROM TABLE(get_aluno(1)) alu, tcontrato con
WHERE con.cod_aluno = alu.codigo;

-- Exemplo 7 - Funciton Pipelined
CREATE OR REPLACE FUNCTION get_alunos
RETURN table_reg_aluno PIPELINED
IS 
	CURSOR cSQL IS
		SELECT alu.cod_aluno, alu.nome, alu.cidade 
		FROM taluno alu;

	outLista REG_ALUNO;
	reg cSQL%ROWTYPE;
BEGIN
	FOR reg IN cSQL
	LOOP
		outLista := REG_ALUNO(reg.cod_aluno, reg.nome, reg.cidade);
		PIPE ROW(outLista);
	END LOOP;

	RETURN;
END;

SELECT * FROM TABLE(get_alunos);

-- Exemplo 8 -- Bulk Collect
CREATE TABLE TPRODUTO (
	COD_PRODUTO NUMBER(5),
	DESCRICAO VARCHAR2(40),
	CONSTRAINT PRODUTO_PK PRIMARY KEY (COD_PRODUTO)
);
--
BEGIN
	INSERT INTO TPRODUTO
	SELECT LEVEL, DBMS_RANDOM.STRING('A', 40) FROM DUAL CONNECT BY LEVEL <= 100;
	COMMIT;
END;

--
DECLARE
	CURSOR CUR_PRODUTO IS
		SELECT COD_PRODUTO, DESCRICAO FROM TPRODUTO;
	
	TYPE TROW_PRODUTO IS TABLE OF CUR_PRODUTO%ROWTYPE INDEX BY PLS_INTEGER;

	ROW_PRODUTO TROW_PRODUTO;
BEGIN
	OPEN CUR_PRODUTO;
	LOOP
		FETCH CUR_PRODUTO BULK COLLECT INTO ROW_PRODUTO LIMIT 50;
		EXIT WHEN ROW_PRODUTO.COUNT = 0;
	
		FOR I IN 1 .. ROW_PRODUTO.Count LOOP
			DBMS_OUTPUT.PUT_LINE('Código: ' || ROW_PRODUTO(I).COD_PRODUTO || ' Descrição: ' || ROW_PRODUTO(I).DESCRICAO);
		END LOOP;
	END LOOP;
	CLOSE CUR_PRODUTO;
END;




