if object_id('gnr.fnGetLatestExchangeRate') is not null
drop function gnr.fnGetLatestExchangeRate
go
CREATE FUNCTION GNR.fnGetLatestExchangeRate 
(
	@currencyRef int,
	@date smalldatetime
)
RETURNS decimal(26, 16)
AS
BEGIN
	DECLARE @rate decimal(26, 16)
	SET @rate = 1 --default rate

	SELECT TOP 1 @rate = ExchangeRate
	FROM GNR.CurrencyExchangeRate
	WHERE EffectiveDate <= @date
		AND CurrencyRef = @currencyRef
	ORDER BY EffectiveDate DESC, CurrencyExchangeRateId DESC

	RETURN @rate
END
GO

