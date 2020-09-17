CREATE OR REPLACE DIRECTORY diretorio AS 'F:\Temp';

-- Exemplo 1 -- Gerar arquivo de texto
DECLARE
	arquivo_saida UTL_FILE.FILE_TYPE;
	CURSOR cur_linha IS
		SELECT cod_aluno, nome, cidade FROM taluno; 
BEGIN
	arquivo_saida := UTL_FILE.FOPEN('DIRETORIO','Lista.txt','w');

	FOR reg_linha IN cur_linha 
	LOOP
		UTL_FILE.PUT_LINE(arquivo_saida, reg_linha.COD_ALUNO||'-'||reg_linha.NOME);
	END LOOP;

	UTL_FILE.FCLOSE(arquivo_saida);

	DBMS_OUTPUT.PUT_LINE('Arquivo gerado com sucesso.');
EXCEPTION
	WHEN UTL_FILE.INVALID_OPERATION THEN
		DBMS_OUTPUT.PUT_LINE('Operação inválida no arquivo.');
		UTL_FILE.FCLOSE(arquivo_saida);
	
	WHEN UTL_FILE.WRITE_ERROR THEN
		DBMS_OUTPUT.PUT_LINE('Erro de gravação no arquivo.');
		UTL_FILE.FCLOSE(arquivo_saida);
	
	WHEN UTL_FILE.INVALID_PATH THEN
		DBMS_OUTPUT.PUT_LINE('Diretório inválido.');
		UTL_FILE.FCLOSE(arquivo_saida);
	
	WHEN UTL_FILE.INVALID_MODE THEN
		DBMS_OUTPUT.PUT_LINE('Modo de acesso inválido.');
		UTL_FILE.FCLOSE(arquivo_saida);
	
	WHEN OTHERS THEN
		DBMS_OUTPUT.PUT_LINE('Problemas na geração do arquivo.');
		UTL_FILE.FCLOSE(arquivo_saida);
END;

-- Exemplo 2 -- Leitura de arquivo
DECLARE
	arquivo UTL_FILE.FILE_TYPE;
	linha VARCHAR2(100);
BEGIN
	arquivo := UTL_FILE.FOPEN('DIRETORIO','Lista.txt', 'r');
	LOOP
		UTL_FILE.GET_LINE(arquivo, Linha);
		DBMS_OUTPUT.PUT_LINE('Registro: ' || linha);
	End Loop;
	UTL_FILE.FCLOSE(arquivo);
	DBMS_OUTPUT.PUT_LINE('Arquivo processado com sucesso.');
EXCEPTION
	WHEN NO_DATA_FOUND THEN
		UTL_FILE.FCLOSE(arquivo);
	
	WHEN UTL_FILE.INVALID_PATH THEN
		DBMS_OUTPUT.PUT_LINE('Diretório inválido.');
		UTL_FILE.FCLOSE(arquivo);
	
	WHEN OTHERS THEN
		DBMS_OUTPUT.PUT_LINE('Problemas na leitura do arquivo.');
		UTL_FILE.FCLOSE(arquivo);
END;

-- Exemplo 3
DECLARE
	vLinha VARCHAR2(2000) := '';
	vArquivo UTL_FILE.FILE_TYPE;
BEGIN
	vArquivo := UTL_FILE.FOPEN('DIRETORIO', 'Lista.TXT', 'w');
	FOR x in 1..8 LOOP
		vLinha := 'LINHA ' || x;
		UTL_FILE.PUT_LINE(vArquivo, vLinha);
		DBMS_OUTPUT.PUT_LINE('Registro: ' || vLinha);
	END LOOP;
	UTL_FILE.FCLOSE(vArquivo);
END;
   
   
   
   
   
   
   
   
   
   