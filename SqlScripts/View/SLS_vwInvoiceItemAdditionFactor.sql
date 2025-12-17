If Object_ID('SLS.vwInvoiceItemAdditionFactor') Is Not Null
	Drop View SLS.vwInvoiceItemAdditionFactor
GO
CREATE VIEW SLS.vwInvoiceItemAdditionFactor
AS
SELECT 
	IIAF.[InvoiceItemAdditionFactorID], 
	IIAF.[InvoiceItemRef], 
	IIAF.[AdditionFactorRef],
	IIAF.[Value],
	IIAF.[ValueInBaseCurrency],
	AF.[Title] AS AdditionFactorTitle,
	AF.[IsEffectiveOnVat],
	AF.[SLRef]

FROM SLS.InvoiceItemAdditionFactor IIAF
--JOIN SLS.InvoiceItem II  ON II.InvoiceItemID = IIAF.InvoiceItemRef
JOIN SLS.AdditionFactor AF  ON AF.AdditionFactorID = IIAF.AdditionFactorRef

