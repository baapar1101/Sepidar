IF OBJECT_ID('SLS.vwInvoiceReceiptChequeInfo') IS NOT NULL
	DROP VIEW SLS.vwInvoiceReceiptChequeInfo
GO

CREATE VIEW SLS.vwInvoiceReceiptChequeInfo
AS
SELECT
	[IRI].[InvoiceReceiptChequeInfoId]
   ,[IRI].[InvoiceRef]
   ,[IRI].[Number]
   ,[IRI].[Amount]
   ,[IRI].[Date]
   ,[IRI].[AccountNo]
   ,[IRI].[BankRef]
   ,[IRI].[SayadCode]
   ,[B].[Title] AS [BankTitle]
   ,[B].[Title_En] AS [BankTitle_En]
   ,[IRI].[PartyAccountSettlementItemRef]
FROM [SLS].[InvoiceReceiptChequeInfo] AS [IRI]
JOIN [RPA].[Bank] AS [B]
	ON [IRI].[BankRef] = [B].[BankId]