DECLARE @key AS NVARCHAR(50), @value AS NVARCHAR(MAX)
SET @key = 'PettyCashInstallFiscalYear'

SELECT @value=[Value] FROM FMK.Configuration WHERE [Key]=@key
IF @value IS NULL OR @value=''
BEGIN
	SELECT TOP 1 @value= FiscalYearId FROM FMK.FiscalYear ORDER BY StartDate DESC
	exec FMK.spSetConfiguration @key,@value
END

GO

DECLARE @key AS NVARCHAR(50), @value AS NVARCHAR(MAX)
SET @key = 'ControlPettyCashBalance'

SELECT @value=[Value] FROM FMK.Configuration WHERE [Key]=@key

IF @value IS NULL OR @value=''
BEGIN
	exec FMK.spSetConfiguration @key,'True'
END