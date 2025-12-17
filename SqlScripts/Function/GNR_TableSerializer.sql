IF Object_ID('GNR.fnGetTableColumns') IS NOT NULL
	DROP FUNCTION [GNR].[fnGetTableColumns]
GO

CREATE FUNCTION [GNR].[fnGetTableColumns] (
    @schemaname VARCHAR(50),
    @tablename nvarchar(256))
RETURNS nvarchar(max)

AS
BEGIN
    RETURN (
        SELECT STUFF(e,1,1,'')
        FROM (
            SELECT
                ',' + COLUMN_NAME
            FROM INFORMATION_SCHEMA.COLUMNS
            WHERE TABLE_NAME = @tablename AND TABLE_SCHEMA = @schemaname
            ORDER BY ORDINAL_POSITION
            FOR XML PATH('')
        ) x(e)
    )

END
GO

IF Object_ID('GNR.fnGetSerializedRowValuesQuery') IS NOT NULL
	DROP FUNCTION [GNR].[fnGetSerializedRowValuesQuery]
GO

CREATE FUNCTION [GNR].[fnGetSerializedRowValuesQuery] (
    @schemaname VARCHAR(50),
    @tablename nvarchar(256),
    @id int)
RETURNS nvarchar(max)

AS
BEGIN
    RETURN 'SELECT @res = ' + (
        SELECT
            CASE WHEN POS <> MAXPOS THEN COL + '+'',''+'
            ELSE COL END
        FROM
        (
            SELECT
                CASE
                    WHEN DATA_TYPE = 'nvarchar' OR DATA_TYPE = 'varchar'
                        THEN 'ISNULL(''''''''+['+COLUMN_NAME+']+'''''''', ''NULL'')'
                    WHEN DATA_TYPE = 'decimal' OR DATA_TYPE = 'float' OR DATA_TYPE = 'int' OR DATA_TYPE = 'bigint' OR DATA_TYPE = 'bit'
                        THEN 'ISNULL(''''''''+CAST(['+COLUMN_NAME+']AS NVARCHAR(50))+'''''''', ''NULL'')'
                    WHEN DATA_TYPE = 'datetime' THEN 'ISNULL(''''''''+CONVERT(NVARCHAR(50), ['+COLUMN_NAME+'], 25)+'''''''', ''NULL'')'
                        ELSE 'ERR in ' + COLUMN_NAME
                END AS COL, ORDINAL_POSITION AS POS, A.MAXPOS
            FROM INFORMATION_SCHEMA.COLUMNS
            CROSS APPLY (
                SELECT MAX(ORDINAL_POSITION) AS MAXPOS
                FROM INFORMATION_SCHEMA.COLUMNS
                WHERE TABLE_NAME = @tablename AND TABLE_SCHEMA = @schemaname
            ) A
            WHERE TABLE_NAME = @tablename AND TABLE_SCHEMA = @schemaname
        ) COLUMNS
        ORDER BY POS
        for xml path('')
    ) + ' FROM ' + @schemaname + '.' + @tablename + ' WHERE ' + @tablename + 'Id = ' + CAST(@id AS NVARCHAR(20))

END
GO

IF Object_ID('GNR.spGetInsertQueryForRow') IS NOT NULL
	DROP PROCEDURE [GNR].[spGetInsertQueryForRow]
GO

CREATE PROCEDURE [GNR].[spGetInsertQueryForRow] (
    @schemaname VARCHAR(50),
    @tablename nvarchar(256),
    @id int,
    @query NVARCHAR(MAX) OUTPUT)

AS
BEGIN
    DECLARE @values NVARCHAR(MAX);
    
    SET @query = 'INSERT INTO '+@schemaname+'.'+@tablename+'(' + GNR.fnGetTableColumns(@schemaname, @tablename) + ')VALUES(';

    DECLARE @q NVARCHAR(max) = GNR.fnGetSerializedRowValuesQuery(@schemaname, @tablename, @id);
    EXEC sp_executesql @q, N'@res NVARCHAR(MAX) OUTPUT', @res = @values OUTPUT;

    SET @query = @query + @values + ');'
END
GO
