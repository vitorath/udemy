-- Exemplo 1
DECLARE
	TYPE RecAluno IS RECORD (
		cod_aluno NUMBER NOT NULL := 0,
		nome ALUNO.nome%TYPE,
		cidade ALUNO.cidade%TYPE
	);

	registro RecAluno;
BEGIN
	registro.cod_aluno := 50;
	registro.nome := 'Master';
	registro.cidade := 'Novo Hamburgo';

	DBMS_OUTPUT.PUT_LINE('Codigo: ' || registro.cod_aluno);
	DBMS_OUTPUT.PUT_LINE('Nome: ' || registro.nome);
	DBMS_OUTPUT.PUT_LINE('Cidade: ' || registro.cidade);
END;

-- Exemplo 2
DECLARE
	registroAluno ALUNO%ROWTYPE;
BEGIN
	SELECT cod_aluno, nome, cidade
	INTO registroAluno.cod_aluno, registroAluno.nome, registroAluno.cidade
	FROM aluno
	WHERE cod_aluno = 1;
	
	registroAluno.cep := '93500000';
	registroAluno.salario := 1500;

	DBMS_OUTPUT.PUT_LINE('Codigo: ' || registroAluno.cod_aluno);
	DBMS_OUTPUT.PUT_LINE('Nome: ' || registroAluno.nome);
	DBMS_OUTPUT.PUT_LINE('Cidade: ' || registroAluno.cidade);
	DBMS_OUTPUT.PUT_LINE('Cep: ' || registroAluno.cep);
	DBMS_OUTPUT.PUT_LINE('Salario: ' || registroAluno.salario);
END;

-- Exemplo 3
DECLARE
	TYPE RecAluno IS TABLE OF ALUNO.nome%TYPE
	INDEX BY BINARY_INTEGER;

	registro RecAluno;
BEGIN
	registro(1) := 'Marcio';
	registro(2) := 	'José';
	registro(3) := 'Pedro';
	
	DBMS_OUTPUT.PUT_LINE('Nome 1: ' || registro(1));
	DBMS_OUTPUT.PUT_LINE('Nome 2: ' || registro(2));
	DBMS_OUTPUT.PUT_LINE('Nome 3: ' || registro(3));
END;
/

-- Exemplo 4
DECLARE
	TYPE RecNome IS TABLE OF ALUNO.nome%TYPE;

	nomes RecNome := RecNome(); -- Criar instancia
BEGIN
	nomes.EXTEND; -- Alocar memória
	nomes(1) := 'Pedro';

	nomes.EXTEND; -- Alocar memória
	nomes(2) := 'Marcio';

	DBMS_OUTPUT.PUT_LINE('Nome 1: ' || nomes(1));
	DBMS_OUTPUT.PUT_LINE('Nome 2: ' || nomes(2));
END;
/

-- Exmeplo 5
DECLARE
	TYPE RecCapital IS TABLE OF VARCHAR(30) INDEX BY VARCHAR(2);
	capitais RecCapital;
BEGIN
	capitais('RS') := 'Porto Alegre';
	capitais('RJ') := 'Rio de Janeiro';
	capitais('PR') := 'Curitiba';
	capitais('MT') := 'Cuiaba';

	DBMS_OUTPUT.PUT_LINE(capitais('RS'));
	DBMS_OUTPUT.PUT_LINE(capitais('RJ'));
	DBMS_OUTPUT.PUT_LINE(capitais('PR'));
	DBMS_OUTPUT.PUT_LINE(capitais('MT'));
END;
/

-- Exemplo 6
DECLARE
	TYPE RecNome IS VARRAY(5) OF ALUNO.nome%TYPE;
	
	nomes RecNome := RecNome();
BEGIN
	nomes.EXTEND;
	nomes(1) := 'Marcio';

	DBMS_OUTPUT.PUT_LINE(nomes(1));
END;
/









