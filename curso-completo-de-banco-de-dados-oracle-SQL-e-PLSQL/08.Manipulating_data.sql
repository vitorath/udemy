-- DML

-- Variavel de substituição
INSERT INTO desconto (classe, inferior, superior)
VALUES ('&cla', &inf, &sup);

UPDATE desconto 
SET inferior = &inf, 
	superior  = &sup 
WHERE classe = '&cla';

DELETE FROM desconto WHERE classe = '&cla';

SELECT * FROM desconto WHERE classe = '&cla';

-- Criar tabelas a partir de um SELECT
CREATE TABLE desconto2 
	AS SELECT * FROM desconto;
	
SELECT * FROM desconto2;

-- Transação (COMMIT/ROLLBACK) Insert, Update e Delete

DELETE FROM desconto2;

ROLLBACK;
-- COMMIT;

-- deleta todos os registros da tabela, não tem clauas WHERE e não tem ROLLBACK
TRUNCATE TABLE desconto2;

-- Savepoint
SELECT * FROM DESCONTO;

SAVEPOINT update_b;
UPDATE desconto SET superior = 88
WHERE classe = 'B';

SAVEPOINT update_a;
UPDATE desconto SET superior = 99
WHERE classe = 'A';

SAVEPOINT insert_x;
INSERT INTO desconto (classe, inferior, superior) VALUES ('X', 90, 99);

SELECT * FROM DESCONTO;

ROLLBACK TO SAVEPOINT insert_x;
ROLLBACK TO SAVEPOINT update_a;
ROLLBACK TO SAVEPOINT update_b;



