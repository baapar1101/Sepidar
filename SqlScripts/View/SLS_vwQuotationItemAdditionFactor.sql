If Object_ID('SLS.vwQuotationItemAdditionFactor') Is Not Null
	Drop View SLS.vwQuotationItemAdditionFactor
GO
CREATE VIEW SLS.vwQuotationItemAdditionFactor
AS
SELECT 
	QIAF.[QuotationItemAdditionFactorID], 
	QIAF.[QuotationItemRef], 
	QIAF.[AdditionFactorRef],
	QIAF.[Value],
	QIAF.[ValueInBaseCurrency],
	AF.[Title] AS AdditionFactorTitle,
	AF.[IsEffectiveOnVat],
	AF.[SLRef]

FROM SLS.QuotationItemAdditionFactor QIAF
--JOIN SLS.QuotationItem II  ON II.QuotationItemID = QIAF.QuotationItemRef
JOIN SLS.AdditionFactor AF  ON AF.AdditionFactorID = QIAF.AdditionFactorRef

