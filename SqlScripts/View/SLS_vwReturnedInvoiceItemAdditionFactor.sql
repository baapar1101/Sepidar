If Object_ID('SLS.vwReturnedInvoiceItemAdditionFactor') Is Not Null
	Drop View SLS.vwReturnedInvoiceItemAdditionFactor
GO
CREATE VIEW SLS.vwReturnedInvoiceItemAdditionFactor
AS
SELECT 
	RIIAF.[ReturnedInvoiceItemAdditionFactorID], 
	RIIAF.[ReturnedInvoiceItemRef], 
	RIIAF.[AdditionFactorRef],
	RIIAF.[Value],
	RIIAF.[ValueInBaseCurrency],
	AF.[Title] AS AdditionFactorTitle,
	AF.[IsEffectiveOnVat],
	AF.[SLRef]

FROM SLS.ReturnedInvoiceItemAdditionFactor RIIAF
--JOIN SLS.ReturnedInvoiceItem II  ON II.ReturnedInvoiceItemID = RIIAF.ReturnedInvoiceItemRef
JOIN SLS.AdditionFactor AF  ON AF.AdditionFactorID = RIIAF.AdditionFactorRef

