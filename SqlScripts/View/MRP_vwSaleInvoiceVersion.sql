IF OBJECT_ID('MRP.vwSaleInvoiceVersion', 'V') IS NOT NULL
    DROP VIEW MRP.vwSaleInvoiceVersion
GO

CREATE VIEW MRP.vwSaleInvoiceVersion
AS
SELECT InvoiceId AS [ID], [Version], [Date]
FROM SLS.Invoice
GO