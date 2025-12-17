IF OBJECT_ID('GNR.sp_recreate_computed_column') is not null
	DROP PROCEDURE GNR.sp_recreate_computed_column
GO
CREATE PROCEDURE GNR.sp_recreate_computed_column @TableName nvarchar(255), @ColumnName nvarchar(255), @DataType nvarchar(255), @Expression nvarchar(max)
AS
	-----------------------------------------------------------------------------------------------------------------------------------------------------------
	Declare @TempTableName nvarchar(255) , @dropTempTableCommand nvarchar(255)
	SELECT  @TempTableName = '_Temp_' + REPLACE(CAST(NEWID() as nvarchar(255)),'-','_')

	SET @dropTempTableCommand = 'IF OBJECT_ID(''' + @TempTableName + ''') IS NOT NULL DROP TABLE ' + @TempTableName
	execute(@dropTempTableCommand)

	SET NOCOUNT ON
    execute('SELECT TOP 0 * INTO ' + @TempTableName + ' FROM ' + @TableName)
	SET NOCOUNT OFF
	-----------------------------------------------------------------------------------------------------------------------------------------------------------
    execute('
	IF EXISTS (SELECT 1	FROM syscolumns WHERE name = ''' + @ColumnName + ''' and id = object_id(''' + @TempTableName + '''))
		Alter Table ' + @TempTableName + ' DROP COLUMN ' + @ColumnName
	)

	IF RTRIM(LTRIM(ISNULL(@DataType, ''))) <> ''
		SET @Expression = 'CAST(' + @Expression + ' AS ' + @DataType + ')'

	execute('Alter Table ' + @TempTableName + ' Add ' + @ColumnName + ' AS ' + @Expression)
	-----------------------------------------------------------------------------------------------------------------------------------------------------------
	Declare @NewExpression nvarchar(max)
	SELECT  @NewExpression = definition FROM sys.computed_columns WHERE object_id = object_id(@TempTableName) AND [Name] = @ColumnName

	execute('ALTER TABLE ' + @TempTableName + ' DROP COLUMN ' + @ColumnName)
	execute('ALTER TABLE ' + @TempTableName + ' ADD ' + @ColumnName + ' AS ' + @NewExpression + ' PERSISTED')

	SELECT  @NewExpression = definition FROM sys.computed_columns WHERE object_id = object_id(@TempTableName) AND [Name] = @ColumnName
	execute(@dropTempTableCommand)
	-----------------------------------------------------------------------------------------------------------------------------------------------------------
	IF NOT EXISTS (
		SELECT 1
		FROM  sys.computed_columns
		WHERE object_id    = object_id(@TableName) 
		AND   [Name]       = @ColumnName
		AND   is_computed  = 1 
		AND   is_persisted = 1
		AND   definition   = @NewExpression)
	BEGIN
		Declare @columnExists int
		SET @columnExists = 0
		IF EXISTS (SELECT 1	FROM syscolumns WHERE name = @ColumnName and id = object_id(@TableName))
		BEGIN
			execute('ALTER TABLE ' + @TableName + ' DROP COLUMN ' + @ColumnName)
			SET @columnExists = 1
		END

		execute('ALTER TABLE ' + @TableName + ' ADD ' + @ColumnName + ' AS ' + @NewExpression + ' PERSISTED')

		if (@columnExists = 1)
			print 'Column ' + @TableName + '.' + @ColumnName + ' Modified'
		else
			print 'Column ' + @TableName + '.' + @ColumnName + ' Added'
	END
	-----------------------------------------------------------------------------------------------------------------------------------------------------------
GO
