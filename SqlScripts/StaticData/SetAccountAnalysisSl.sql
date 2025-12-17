DECLARE @value AS NVARCHAR(MAX),
@SalesReceivableSLvalue AS NVARCHAR(MAX)
SELECT @value=[Value] FROM FMK.Configuration WHERE [Key] LIKE '%AccountAnalysisSl%'

IF @value IS NULL 
	BEGIN
	SELECT @SalesReceivableSLvalue =[Value] 
			FROM FMK.Configuration WHERE [Key] LIKE '%SalesReceivableSL%'

			IF @SalesReceivableSLvalue IS NOT NULL AND  @SalesReceivableSLvalue!=''
				EXEC FMK.spSetConfiguration 'AccountAnalysisSl',@SalesReceivableSLvalue
	END