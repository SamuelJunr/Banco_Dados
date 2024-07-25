-- Desabilitar o autocommit
SET autocommit = 0;

-- Iniciar a transação
START TRANSACTION;

-- Definir savepoint para rollback parcial (opcional)
SAVEPOINT savepoint1;

-- Executar instruções SQL (exemplo)
INSERT INTO tabela (coluna1, coluna2) VALUES (valor1, valor2);
UPDATE tabela SET coluna1 = novo_valor WHERE condição;
DELETE FROM tabela WHERE condição;
-- E assim por diante...

-- Verificar se ocorreu algum erro durante a execução das instruções
IF exit_handler THEN
    -- Desfazer até o savepoint (rollback parcial) ou desfazer a transação inteira (rollback total)
    IF rollback_handler THEN
        ROLLBACK TO savepoint1;
    ELSE
        ROLLBACK;
    END IF;
ELSE
    -- Confirmar a transação
    COMMIT;
END IF;

-- Reabilitar o autocommit
SET autocommit = 1;
