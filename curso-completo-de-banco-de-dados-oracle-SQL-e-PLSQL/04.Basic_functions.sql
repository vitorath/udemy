/* FUNÇÕES SIMPLE ROWS */
SELECT CONCAT(cod_aluno, nome) FROM aluno;
SELECT cod_aluno || nome FROM aluno;

SELECT INITCAP(nome) FROM aluno;
SELECT INITCAP('JOÃO DA SILVA') FROM dual;

-- Posição que encontrar a primeira letra indicada
SELECT nome, INSTR(nome, 'a') FROM aluno;

SELECT nome, LENGTH(nome) FROM aluno;

SELECT nome, LOWER(nome) FROM aluno;
SELECT nome, UPPER(nome) FROM aluno;

SELECT cod_aluno, LPAD(cod_aluno, 5, '0') FROM aluno;
SELECT cod_aluno, RPAD(cod_aluno, 5, '0') FROM aluno; 

SELECT nome, SUBSTR(nome, 1, 3) FROM aluno;
SELECT nome, SUBSTR(nome, 3, 1) FROM aluno;
SELECT nome, SUBSTR(nome, 1, LENGTH(nome)) FROM aluno;
SELECT nome, SUBSTR(nome, LENGTH(nome), 1) FROM aluno;
SELECT nome, SUBSTR(nome, LENGTH(nome) - 1, 2) FROM aluno;
SELECT nome, SUBSTR(nome, LENGTH(nome) + 1, 10) FROM aluno;

SELECT REPLACE(nome, 'V', 'a') FROM aluno;
SELECT REPLACE(UPPER(nome),'A', 'i') FROM aluno; 

SELECT * FROM aluno WHERE LOWER(nome) = 'vitor';
SELECT * FROM aluno WHERE UPPER(nome) = 'LIVIA';
SELECT * FROM aluno WHERE UPPER(SUBSTR(cidade, 1, 3)) = 'RIB';

SELECT salario, REPLACE(salario, '.', ''), RPAD(salario, 10, '0'), LPAD(salario, 10, '0'), LPAD(REPLACE(salario, '.', ''), 10, '0') FROM aluno;  

-- Números
SELECT ROUND(45.925, 2), TRUNC(45.925, 2), MOD(10, 2) "Resto 10/2", MOD(10, 3) "Resto 10/3", TRUNC(1.99), TRUNC(1.99, 2) FROM dual; 

-- Data
SELECT data, SYSDATE, data + 5 FROM contrato;
SELECT SYSDATE - data diff_dia FROM contrato; 
SELECT TRUNC(SYSDATE - DATA) diff_dia FROM contrato; 

SELECT SYSDATE, SYSDATE + 2 / 24 add_horas FROM contrato;
SELECT SYSDATE, SYSDATE + 15 / 1440 add_minutos FROM contrato;
SELECT SYSDATE, SYSDATE + 30 / (3600 * 24) add_minutos FROM contrato;

SELECT SYSDATE, TRUNC(SYSDATE) FROM dual;
SELECT SYSDATE, MONTHS_BETWEEN(SYSDATE, SYSDATE - 90) diff_mes FROM dual;
SELECT SYSDATE, ADD_MONTHS(SYSDATE, 5) add_mes FROM dual;
SELECT SYSDATE, NEXT_DAY(SYSDATE, 'WEDNESDAY') proxima_quarta_feira FROM dual;
SELECT SYSDATE, LAST_DAY(SYSDATE) FROM dual; 

-- <= 15 Mes Atual, > 15 Próximo mês
SELECT SYSDATE, ROUND(SYSDATE, 'Month') primeiro_dia_proximo_mes FROM dual;
SELECT SYSDATE, TRUNC(SYSDATE, 'Month') primeiro_dia_mes_atual FROM dual;

-- Formatação de data
SELECT SYSDATE, TO_CHAR(SYSDATE, 'DD') dia FROM dual; 
SELECT SYSDATE, TO_CHAR(SYSDATE, 'MM') mes FROM dual; 
SELECT SYSDATE, TO_CHAR(SYSDATE, 'YYYY') ano FROM dual; 
SELECT SYSDATE, TO_CHAR(SYSDATE, 'YY') ano_dois_utlimos_numeros FROM dual; 
SELECT SYSDATE, TO_CHAR(SYSDATE, 'DD/MM/YYYY') dia_mes_ano FROM dual; 
SELECT SYSDATE, TO_CHAR(SYSDATE, 'DD/MM') dia_mes FROM dual; 
SELECT SYSDATE, TO_CHAR(SYSDATE, 'MM/YYYY') mes_ano FROM dual; 
SELECT SYSDATE, TO_CHAR(SYSDATE, 'MONTH') nome_dia FROM dual; 
SELECT SYSDATE, TO_CHAR(SYSDATE, 'D') dia_semana_indice FROM dual; 
SELECT SYSDATE, TO_CHAR(SYSDATE, 'DY') dia_semana_simplificado FROM dual; 
SELECT SYSDATE, TO_CHAR(SYSDATE, 'DAY') dia_semana_completo FROM dual; 
SELECT SYSDATE, TO_CHAR(SYSDATE, 'YEAR') ano_extenso FROM dual;

--fm tira espaços
SELECT TO_CHAR(SYSDATE , '"Ribeirão Preto", fmDAY "," DD "de" fmMONTH "de" YYYY') FROM dual; 

--Hora
SELECT TO_CHAR(SYSDATE, 'HH24:MI') hora_min FROM dual;
SELECT TO_CHAR(SYSDATE, 'HH24:MI:SS') hora_min_seg FROM dual;
SELECT TO_CHAR(SYSDATE, 'DD/MM/YYYY HH24:MI') data_hora FROM dual;
SELECT TO_CHAR(SYSDATE, 'DD/MM/YYYY HH24:MI:SS') data_hora FROM dual;

-- TO_CHAR numérico
-- L -> Moeda configurada pelo sistema
-- G -> pontos
-- D -> casas decimais
SELECT TRIM( TO_CHAR(salario, 'L99999.99')), TO_CHAR(salario, 'L99G99D99') FROM aluno; 
SELECT 'R$ ' || ROUND(salario, 2) FROM aluno; 

SELECT 'R$ ' || LPAD(TRIM(TO_CHAR(salario, '99999.99')), 12, ' ') FROM aluno; 

-- NVL e NVL2 (similar ao if else - NVL(valor, is not null, is null)
SELECT total, desconto, desconto + total, NVL(desconto, 0), NVL(desconto, 0) + total, NVL2(desconto, total, -1), NVL2(desconto, -1, total) FROM contrato; 

SELECT NVL(NULL, 'Também funciona com strings') FROM dual;

-- Case
SELECT nome, estado,
	CASE 
		WHEN estado = 'SP' THEN 'Paulista'
		WHEN estado = 'SC' OR salario > 500 THEN 'Gaucho'
	 	ELSE 
	 		'Outros'
	 	END AS Apelido
FROM aluno;

-- Decode (Não funciona condicionais <, >, <=, >=)
SELECT nome, estado, DECODE(estado, 'SP', 'Paulista', 'SC', 'Gaucho', 'Outros') AS Apelido FROM aluno;


