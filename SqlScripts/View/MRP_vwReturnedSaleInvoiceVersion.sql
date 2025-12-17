IF OBJECT_ID('MRP.vwReturnedSaleInvoiceVersion', 'V') IS NOT NULL
    DROP VIEW MRP.vwReturnedSaleInvoiceVersion
GO

CREATE VIEW MRP.vwReturnedSaleInvoiceVersion
AS
SELECT ReturnedInvoiceId AS [ID], [Version], [Date]
FROM SLS.ReturnedInvoice
GO