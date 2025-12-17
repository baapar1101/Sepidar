if object_id('gnr.fnGetSystemCurrencyPrecisionCount') is not null
drop function gnr.fnGetSystemCurrencyPrecisionCount
go
Create FUNCTION [GNR].[fnGetSystemCurrencyPrecisionCount]()  
RETURNS int
AS  
BEGIN  
	DECLARE @PrecisionCount int
	SELECT @PrecisionCount = PrecisionCount 
		FROM GNR.Currency
		WHERE CurrencyID = 
		   (SELECT [Value] 
			FROM FMK.Configuration   
			WHERE [key] =  'SystemCurrency' )

	RETURN isnull(@PrecisionCount, 0)
END
