-- IF ... ELSIF ... ELSE

DECLARE 
	vNome VARCHAR2(30) := 'Carioca';
	vCidade VARCHAR2(30);
	vEstado VARCHAR2(2);
BEGIN
	IF (vNome = 'Gaucho') THEN
		vCidade := 'Porto Alegre';
		vEstado := 'RS';
	ELSIF (vNome = 'Carioco') THEN
		vCidade := 'Rio de Janeiro';
		vEstado := 'RJ';
	ELSE
		IF (vEstado = 'SP') THEN
			vCidade := 'Paulista';
			vEstado := 'SP';
		ELSE
			vCidade := 'Outros';
			vEstado := 'XX';
		END IF;
	END IF;

	DBMS_OUTPUT.PUT_LINE(vCidade || ' - ' || vEstado);
END;

-- CASE ... WHEN
DECLARE 	
	vEstado VARCHAR2(2) := 'RR';
	vNome VARCHAR2(20);
BEGIN
	CASE
		WHEN vEstado = 'RS' THEN vNome := 'Gaucho';
		WHEN vEstado = 'RJ' OR vEstado = 'ES' THEN vNome := 'Carioca';
	ELSE
		vNome := 'Outros';
	END CASE;

	DBMS_OUTPUT.PUT_LINE('Apelido: ' || vNome);
END;

-- Loop
DECLARE 
	vContador INTEGER := 0;
BEGIN 
	LOOP
		vContador := vContador + 1;
		DBMS_OUTPUT.PUT_LINE(vContador);
	
		EXIT WHEN vContador = 10;
	END LOOP;

	DBMS_OUTPUT.PUT_LINE('Fim do loop');
END;

-- For ... Loop
DECLARE 
	vContador INTEGER := 0;
BEGIN 
	FOR vContador IN 1..10
	LOOP
		DBMS_OUTPUT.PUT_LINE(vContador);
	END LOOP;

	DBMS_OUTPUT.PUT_LINE('Fim do loop');
END;

-- While ... Loop
DECLARE 
	vContador INTEGER := 0;
	vTexto VARCHAR2(10);
BEGIN
	WHILE vContador < 6
	LOOP
		vContador := vContador + 1;
		IF (vContador MOD 2) = 0 THEN
			vTexto := 'Par';
		ELSE 
			vTexto := 'Impar';
		END IF;
	
		DBMS_OUTPUT.PUT_LINE(vContador || ' -> ' || vTexto);
	END LOOP;
END;









