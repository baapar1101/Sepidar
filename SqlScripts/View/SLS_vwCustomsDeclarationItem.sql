If Object_ID('SLS.vwCustomsDeclarationItem') Is Not Null
    Drop View SLS.vwCustomsDeclarationItem
GO
CREATE VIEW SLS.vwCustomsDeclarationItem
AS
SELECT CDI.[CustomsDeclarationItemId],
       CDI.[CustomsDeclarationRef],
       CDI.[InvoiceItemRef],
       CDI.RowNumber,
       CDI.[Quantity],
       CDI.[Price],
       CDI.[PriceInBaseCurrency],
       CDI.[NetWeight],
       CDI.[OtherTaxes],
       CDI.[OtherAmounts],
       I.Number AS InvoiceNumber,
       II.ItemRef,
       II.ItemCode,
       II.ItemTitle,
       II.ItemTitle_En,
       II.ItemUnitRef,
       II.ItemType
FROM SLS.CustomsDeclarationItem CDI
         LEFT JOIN SLS.vwInvoiceItem II ON CDI.InvoiceItemRef = II.InvoiceItemID
         LEFT JOIN SLS.Invoice I ON II.InvoiceRef = I.InvoiceID