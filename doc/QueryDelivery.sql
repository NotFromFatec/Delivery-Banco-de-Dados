USE master

-- Drop the database if it exists
IF DB_ID('Delivery') IS NOT NULL
    DROP DATABASE Delivery;
GO

-- Create the database
CREATE DATABASE Delivery;
GO

-- Use the new database
USE Delivery;
GO

-- Drop the function if it exists
IF OBJECT_ID('dbo.fn_listarPratosIngredientes', 'IF') IS NOT NULL
    DROP FUNCTION dbo.fn_listarPratosIngredientes;
GO

-- Create the function
CREATE FUNCTION fn_listarPratosIngredientes()
RETURNS @tabela TABLE (
    nomePrato VARCHAR(50),
    nomeIngrediente VARCHAR(50),
    nomePorcao VARCHAR(30),
    valorPorcao DECIMAL(10,2)
)
AS
BEGIN
    DECLARE @PratoId VARCHAR(50);
    DECLARE @PratoNome VARCHAR(50);
    DECLARE @IngredienteNome VARCHAR(50);
    DECLARE @PorcaoNome VARCHAR(30);
    DECLARE @PorcaoValor DECIMAL(10,2);

    DECLARE prato_cursor CURSOR FOR
        SELECT p.id, p.nome, i.nome, tp.nome, tp.valor
        FROM Prato p
        INNER JOIN PratoIngrediente pi ON pi.prato_id = p.id
        INNER JOIN Ingrediente i ON i.id = pi.ingrediente_id
        INNER JOIN TamanhoPorcao tp ON pi.porcao_id = tp.id;

    OPEN prato_cursor;

    FETCH NEXT FROM prato_cursor INTO @PratoId, @PratoNome, @IngredienteNome, @PorcaoNome, @PorcaoValor;

    WHILE @@FETCH_STATUS = 0
    BEGIN
        INSERT INTO @tabela (nomePrato, nomeIngrediente, nomePorcao, valorPorcao) 
        VALUES (@PratoNome, @IngredienteNome, @PorcaoNome, @PorcaoValor);

        FETCH NEXT FROM prato_cursor INTO @PratoId, @PratoNome, @IngredienteNome, @PorcaoNome, @PorcaoValor;
    END

    CLOSE prato_cursor;
    DEALLOCATE prato_cursor;

    RETURN;
END;
GO
