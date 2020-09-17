DECLARE 
	vHora NUMBER;
BEGIN
	vHora := TO_NUMBER(TO_CHAR(SYSDATE, 'HH24'));
	DBMS_OUTPUT.PUT_LINE(vHora || '  ' || TO_CHAR(SYSDATE, 'DAY'));
END;

--
BEGIN
	IF ((TO_CHAR(SYSDATE, 'DAY') IN ('SATURDAY', 'SUNDAY')) OR 
		(TO_NUMBER(TO_CHAR(SYSDATE, 'HH24')) NOT BETWEEN 8 AND 18)) THEN
		RAISE_APPLICATION_ERROR(-20001, 'Fora do horário comercial');
	END IF;
END;
/

-- Exemplo 1
CREATE OR REPLACE TRIGGER validarHorarioCurso
BEFORE INSERT OR DELETE ON 	contrato
BEGIN
	IF (TO_CHAR(SYSDATE, 'D') IN (1,7)) OR (TO_NUMBER(TO_CHAR(SYSDATE, 'HH24')) NOT BETWEEN 8 AND 18) THEN 
		RAISE_APPLICATION_ERROR(-20001, 'Fora do horário comercial');
	END IF;
END;

INSERT INTO contrato VALUES (7665, SYSDATE, 10, 1500, NULL);

-- Exemplo 2
CREATE TABLE log(
	usuario VARCHAR2(30),
	horario DATE,
	valorAntigo VARCHAR2(10),
	valorNome VARCHAR2(10)
);

CREATE OR REPLACE TRIGGER gerarLogContratoTotal
AFTER UPDATE OF total ON contrato
DECLARE
	-- Variáveis
BEGIN 
	INSERT INTO log (usuario, horario) VALUES (USER, SYSDATE);
END;

UPDATE contrato SET total = 5000 WHERE cod_contrato = 1;

SELECT * FROM log;


-- Exemplo 3
CREATE OR REPLACE TRIGGER validarHorarioCurso2
BEFORE INSERT OR UPDATE OR DELETE ON contrato
BEGIN
	IF ((TO_CHAR(SYSDATE, 'D') IN (1, 7)) OR (TO_NUMBER(TO_CHAR(SYSDATE, 'HH24')) NOT BETWEEN 8 AND 23)) THEN
		IF (INSERTING) THEN 
			RAISE_APPLICATION_ERROR(-20001, 'Não pode inserir');
		ELSIF (DELETING) THEN
			RAISE_APPLICATION_ERROR(-20002, 'Não pode deletar');
		ELSIF (UPDATING('total')) THEN 
			RAISE_APPLICATION_ERROR(-20003, 'Não pode alterar total');
		ELSE 
			RAISE_APPLICATION_ERROR(-20004, 'Não pode alterar');
		END IF;
	END IF;
END;
/

ALTER TRIGGER validarHorarioCurso DISABLE;

DELETE FROM contrato;
UPDATE contrato SET total = 5000 WHERE cod_contrato = 1;
INSERT INTO contrato VALUES (90, SYSDATE, 10, 1500, NULL);

-- Exemplo 4
ALTER TABLE log  ADD obs VARCHAR2(80);

CREATE OR REPLACE TRIGGER auditarAluno
AFTER INSERT OR DELETE OR UPDATE ON aluno
FOR EACH ROW --Executa para cada linha afeta, sem ele executa somente uma vez
BEGIN
	IF (DELETING) THEN
		INSERT INTO log (usuario, horario, obs)
		VALUES (USER, SYSDATE, 'Linhas deletadas');
	ELSIF (INSERTING) THEN
		INSERT INTO log (usuario, horario, obs)
		VALUES (USER, SYSDATE, 'Linhas inseridas');
	ELSIF (UPDATING('salario')) THEN
		INSERT INTO log 
		VALUES (:OLD.nome, SYSDATE, :OLD.salario, :NEW.salario, 'Alterado salário');
	ELSE 
		INSERT INTO log (usuario, horario, obs)
		VALUES (USER, SYSDATE, 'Atualização Aluno');
	END IF;
END;

SELECT * FROM log;
UPDATE aluno SET salario = 3500;

-- Exemplo 5
CREATE OR REPLACE TRIGGER gerarLogCurso
BEFORE UPDATE OF valor ON curso 
FOR EACH ROW 
BEGIN 
	INSERT INTO log
	VALUES (USER, SYSDATE, :OLD.valor, :NEW.valor, 'Curso Alterado: ' || :OLD.nome);
END;

UPDATE curso SET valor = 3000
WHERE valor > 1500;

SELECT * FROM log;

-- Exemplo 6
ALTER TABLE contrato ADD valorComissao NUMERIC(8,2);

CREATE OR REPLACE TRIGGER calcularComissao
BEFORE INSERT OR UPDATE OF total ON contrato
REFERENCING OLD AS antigo
			NEW AS novo
FOR EACH ROW 
WHEN (novo.total >= 5000)
DECLARE
	vComissao NUMERIC(6, 2) := 0.15;
BEGIN 
	IF (:novo.total <= 10000) THEN 
		:novo.valorComissao := :novo.total * vComissao;
	ELSE
		:novo.valorComissao := :novo.total * (vComissao + 0.1);
	END IF;
END;

ALTER TRIGGER validarhorariocurso2 DISABLE;

INSERT INTO contrato (cod_contrato, total) VALUES (34, 6000);
INSERT INTO contrato (cod_contrato, total) VALUES (35, 12000);

SELECT * FROM contrato;

-- Exemplo 7
CREATE OR REPLACE VIEW vContratosPares
AS 
	SELECT cod_contrato, data, cod_aluno, desconto, total
	FROM contrato
	WHERE MOD(cod_contrato, 2) = 0;

SELECT * FROM vContratosPares;

-- somente executa a trigger
CREATE OR REPLACE TRIGGER triContratosPares
INSTEAD OF INSERT OR DELETE OR UPDATE ON vContratosPares
DECLARE
BEGIN
	INSERT INTO log (usuario, horario, obs)
	VALUES (USER, SYSDATE, 'DML da view vContratosPares');
END;

INSERT INTO vContratosPares VALUES(90, SYSDATE, 10, NULL, 5000);

SELECT * FROM vContratosPares;
SELECT * FROM log;













