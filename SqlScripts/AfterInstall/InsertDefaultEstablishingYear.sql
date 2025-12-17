
Go
DECLARE @FiscalYear INT

SET @FiscalYear = (SELECT TOP 1 FiscalYearId FROM fmk.FiscalYear ORDER BY FiscalYearId DESC)
IF @FiscalYear IS NOT NULL AND NOT EXISTS(SELECT 1 FROM fmk.Configuration WHERE [key] = 'DefaultEstablishingYear')
BEGIN 
	EXEC FMK.[spSetConfiguration] 'DefaultEstablishingYear', @FiscalYear 
END 
Go


 