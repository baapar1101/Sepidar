If Object_ID('DST.spColdDistributionSummary') Is Not Null
    Drop Procedure [DST].[spColdDistributionSummary]
GO

CREATE PROCEDURE [DST].[spColdDistributionSummary] @ColdDistributionRef int
AS
BEGIN
    SELECT ItemRef                      = ISNULL(Invoice.ItemRef, ReturnedInvoice.ItemRef)
         , TracingRef                   = ISNULL(Invoice.TracingRef, ReturnedInvoice.TracingRef)
         , ItemCode                     = ISNULL(Invoice.ItemCode, ReturnedInvoice.ItemCode)
         , ItemTitle                    = ISNULL(Invoice.ItemTitle, ReturnedInvoice.ItemTitle)
         , TracingTitle                 = ISNULL(Invoice.TracingTitle, ReturnedInvoice.TracingTitle)
         , UnitTitle                    = ISNULL(Invoice.UnitTitle, ReturnedInvoice.UnitTitle)
         , SecondaryUnitTitle           = ISNULL(Invoice.SecondaryUnitTitle, ReturnedInvoice.SecondaryUnitTitle)
         , InvoiceQuantity              = ISNULL(Invoice.InvoiceQuantity, 0)
         , InventoryDeliveryQuantity    = ISNULL(Invoice.InventoryDeliveryQuantity, 0)
         , ReturnedInvoiceQuantity      = ISNULL(ReturnedInvoice.ReturnedInvoiceQuantity, 0)
         , FinalQuantity                = ISNULL(ReturnedInvoice.SuccessReturnedInvoiceQuantity, 0) + ISNULL(Invoice.UnSuccessReturnedInvoiceQuantity, 0)
    FROM (SELECT II.ItemRef
               , II.ItemCode
               , II.ItemTitle
               , II.TracingRef
               , II.TracingTitle
               , II.UnitTitle
               , II.SecondaryUnitTitle
               , InvoiceQuantity  = SUM(II.Quantity)
               , InventoryDeliveryQuantity = SUM(ISNULL(DQ.TotalQuantity, 0))
               , UnSuccessReturnedInvoiceQuantity = SUM(CASE WHEN CDI.UnexecutedActReasonRef is not null THEN II.Quantity END)
          FROM (SELECT * FROM DST.vwColdDistributionInvoice WHERE ColdDistributionRef = @ColdDistributionRef) CDI
               JOIN SLS.Invoice I ON CDI.InvoiceRef = I.InvoiceId
               JOIN SLS.vwInvoiceItem II ON II.ItemType <> 2 AND I.InvoiceId = II.InvoiceRef
               LEFT JOIN INV.fnGetInventoryDeliveryQuntityBasedOnInvoiceItem() DQ ON II.InvoiceItemID = DQ.InvoiceItemID
          GROUP BY II.ItemRef
                 , II.ItemCode
                 , II.ItemTitle
                 , II.TracingRef
                 , II.TracingTitle
                 , II.UnitTitle
                 , II.SecondaryUnitTitle
         ) Invoice
         FULL JOIN
         (SELECT RII.ItemRef
               , RII.ItemCode
               , RII.ItemTitle
               , RII.TracingRef
               , RII.TracingTitle
               , RII.UnitTitle
               , RII.SecondaryUnitTitle
               , ReturnedInvoiceQuantity = SUM(RII.Quantity)
               , SuccessReturnedInvoiceQuantity = SUM(CASE WHEN CDRI.UnexecutedActReasonRef is null THEN RII.Quantity END)
         FROM (SELECT * FROM DST.vwColdDistributionReturnedInvoice WHERE ColdDistributionRef = @ColdDistributionRef) CDRI
              JOIN SLS.ReturnedInvoice RI ON CDRI.ReturnedInvoiceRef = RI.ReturnedInvoiceId
              JOIN SLS.vwReturnedInvoiceItem RII ON RII.ItemType <> 2 AND RI.ReturnedInvoiceId = RII.ReturnedInvoiceRef
              LEFT JOIN INV.fnGetInventoryDeliveryReturnedQuntityBasedOnReturnedInvoiceItem() DRQ ON RII.ReturnedInvoiceItemID = DRQ.ReturnedInvoiceItemID
         GROUP BY RII.ItemRef
                , RII.ItemCode
                , RII.ItemTitle
                , RII.TracingRef
                , RII.TracingTitle
                , RII.UnitTitle
                , RII.SecondaryUnitTitle
         ) ReturnedInvoice
         ON Invoice.ItemRef = ReturnedInvoice.ItemRef AND ISNULL(Invoice.TracingRef, 0) = ISNULL(ReturnedInvoice.TracingRef, 0)
END
