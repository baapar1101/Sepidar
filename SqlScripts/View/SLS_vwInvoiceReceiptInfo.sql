IF OBJECT_ID('SLS.vwInvoiceReceiptInfo') IS NOT NULL
	DROP VIEW SLS.vwInvoiceReceiptInfo
GO

CREATE VIEW SLS.vwInvoiceReceiptInfo
AS
SELECT
	[IRI].[InvoiceReceiptInfoID]
   ,[IRI].[InvoiceRef]
   ,[IRI].[Discount]
   ,[IRI].[Amount]
   ,[IRI].[DraftAmount]
   ,[IRI].[PartyAccountSettlementItemRef]
FROM [SLS].[InvoiceReceiptInfo] AS [IRI]