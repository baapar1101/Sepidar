DECLARE @key AS NVARCHAR(50), @value AS NVARCHAR(MAX)
SET @key = 'InventoryInstallFiscalYear'

SELECT @value=[Value] FROM FMK.Configuration WHERE [Key]=@key
IF @value IS NULL OR @value=''
BEGIN
	SELECT TOP 1 @value= FiscalYearId FROM FMK.FiscalYear ORDER BY StartDate
	exec FMK.spSetConfiguration @key,@value
END