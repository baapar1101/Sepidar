IF OBJECT_ID('SLS.vwInvoiceReceiptPosInfo') IS NOT NULL
	DROP VIEW SLS.vwInvoiceReceiptPosInfo
GO

CREATE VIEW SLS.vwInvoiceReceiptPosInfo
AS
SELECT
	[IRP].[InvoiceReceiptPosInfoId]
   ,[IRP].[InvoiceRef]
   ,[IRP].[Amount]
   ,[IRP].[PartyAccountSettlementItemRef]
   ,[IRP].[TrackingCode]
FROM [SLS].[InvoiceReceiptPosInfo] AS [IRP]