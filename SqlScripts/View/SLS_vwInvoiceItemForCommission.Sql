IF OBJECT_ID('SLS.vwInvoiceItemForCommission') IS NOT NULL
  DROP View SLS.vwInvoiceItemForCommission
GO
Create View SLS.vwInvoiceItemForCommission
AS
    
    SELECT 
           Invoices.InvoiceRef
          ,Invoices.ReturnedInvoiceRef
          ,Invoices.FiscalYearRef
          ,Invoices.[Date]
          ,Invoices.Number
          ,Invoices.SaleTypeRef
          ,Invoices.InvoiceItemID
          ,Invoices.ReturnedInvoiceItemID
          ,Invoices.BaseInvoiceItemRef
          ,Invoices.ItemRef
          ,ItemTitle = Item.Title
          ,ItemCode = item.Code
          ,Invoices.Quantity
          ,Invoices.Price
          ,IsSettlementedExcludeCheques = CAST(IsSettlementedExcludeCheques AS bit)
            ,IsSettlementedIncludeCheques = CAST(IsSettlementedIncludeCheques AS bit)
          ,IsExtraReturnedInvoice
          ,BrokerPartyRef
          ,SalePortionPercent
          ,ManualCommissionAmount
          ,Invoices.[Version]
          ,AreaRef = AP.ParentAreaAndPathRef
          ,AreaTitle = AP.AreaTitle 
    FROM (
            SELECT 
                   II.InvoiceItemID
                  ,II.InvoiceRef
                  ,ReturnedInvoiceItemID = CAST(NULL AS INT) 
                  ,ReturnedInvoiceRef    = CAST(NULL AS INT) 
                  ,II.ItemRef
                  ,II.Quantity
                  ,Price = II.NetPriceInBaseCurrency - II.TaxInBaseCurrency - II.DutyInBaseCurrency
                  ,I.FiscalYearRef
                  ,I.Number
                  ,I.[Date]
                  ,I.PartyAddressRef
                  ,I.SaleTypeRef
                  ,CAST(NULL AS INT) BaseInvoiceItemRef
                  ,BrokerPartyRef = ICB.PartyRef 
                  ,ICB.SalePortionPercent 
                  ,ICB.ManualCommissionAmount
                  ,d.IsSettlementedExcludeCheques
                  ,d.IsSettlementedIncludeCheques
                  ,IsExtraReturnedInvoice = 0 
                  ,I.[Version]
            FROM    SLS.InvoiceItem II
              INNER JOIN SLS.Invoice I 
                ON II.InvoiceRef = I.InvoiceId
              INNER JOIN SLS.InvoiceCommissionBroker ICB 
                ON II.InvoiceRef = ICB.InvoiceRef  -- InvoiceCommissionBroker
              LEFT  JOIN SLS.vwInvoiceSettlementedStatus d 
                ON II.InvoiceRef = d.InvoiceRef
            WHERE I.[State] = 1 /* Registered = 1, Revoked = 2, */
              AND II.DiscountInvoiceItemRef IS NULL
              AND II.IsAggregateDiscountInvoiceItem = 0
            
            UNION ALL
            
            SELECT 
                   InvoiceItemID = CAST(NULL AS INT)
                  ,InvoiceRef    = CAST(NULL AS INT)
                  ,RII.ReturnedInvoiceItemID
                  ,RII.ReturnedInvoiceRef 
                  ,RII.ItemRef
                  ,RII.Quantity
                  ,Price = RII.NetPriceInBaseCurrency - RII.TaxInBaseCurrency - RII.DutyInBaseCurrency
                  ,RI.FiscalYearRef
                  ,RI.Number
                  ,RI.[Date]
                  ,RI.PartyAddressRef
                  ,RI.SaleTypeRef                  
                  ,RII.InvoiceItemRef BaseInvoiceItemRef
                  ,BrokerPartyRef = RICB.PartyRef 
                  ,RICB.SalePortionPercent
                  ,RICB.ManualCommissionAmount 
                  ,IsSettlementedExcludeCheques = 1
                  ,IsSettlementedIncludeCheques = 1
                  ,IsExtraReturnedInvoice = 0
                  ,RI.[Version]
            FROM       SLS.ReturnedInvoiceItem RII
              INNER JOIN SLS.ReturnedInvoice RI 
                ON RII.ReturnedInvoiceRef = RI.ReturnedInvoiceId
              LEFT  JOIN SLS.ReturnedInvoiceCommissionBroker RICB 
                ON RII.ReturnedInvoiceRef = RICB.ReturnedInvoiceRef
            WHERE   RII.DiscountReturnedInvoiceItemRef IS NULL
              AND    RII.IsAggregateDiscountInvoiceItem = 0
              AND   RII.InvoiceItemRef IS NULL
            
            UNION ALL
            
            SELECT 
                   InvoiceItemID = CAST(NULL AS INT)
                  ,InvoiceRef    = CAST(NULL AS INT)
                  ,RII.ReturnedInvoiceItemID
                  ,RII.ReturnedInvoiceRef 
                  ,RII.ItemRef
                  ,RII.Quantity
                  ,Price = RII.NetPriceInBaseCurrency - RII.TaxInBaseCurrency - RII.DutyInBaseCurrency
                  ,RI.FiscalYearRef
                  ,RI.Number
                  ,RI.[Date]
                  ,I.PartyAddressRef
                  ,RI.SaleTypeRef
                  ,RII.InvoiceItemRef BaseInvoiceItemRef
                  ,BrokerPartyRef = ICB.PartyRef 
                  ,SalePortionPercent = ICB.SalePortionPercent
                  ,RICB.ManualCommissionAmount 
                  ,InvSett.IsSettlementedExcludeCheques
                  ,InvSett.IsSettlementedIncludeCheques 
                  ,IsExtraReturnedInvoice = 0
                  ,RI.[Version]
            FROM       SLS.ReturnedInvoiceItem RII
              INNER JOIN SLS.ReturnedInvoice RI 
                ON RII.ReturnedInvoiceRef = RI.ReturnedInvoiceId
              INNER JOIN SLS.InvoiceItem II 
                ON RII.InvoiceItemRef = II.InvoiceItemid
              INNER JOIN SLS.Invoice I
                ON I.InvoiceId = II.InvoiceRef
              LEFT JOIN SLS.InvoiceCommissionBroker ICB 
                ON II.InvoiceRef = ICB.InvoiceRef
              LEFT  JOIN SLS.vwInvoiceSettlementedStatus InvSett 
                ON II.InvoiceRef = InvSett.InvoiceRef
              LEFT  JOIN SLS.ReturnedInvoiceCommissionBroker RICB 
                ON RII.ReturnedInvoiceRef = RICB.ReturnedInvoiceRef
            WHERE RII.DiscountReturnedInvoiceItemRef IS NULL
            AND   RII.IsAggregateDiscountInvoiceItem = 0
            AND   RII.InvoiceItemRef IS NOT NULL

            UNION ALL

             SELECT 
                   InvoiceItemID = CAST(NULL AS INT)
                  ,InvoiceRef    = CAST(NULL AS INT)
                  ,RII.ReturnedInvoiceItemID
                  ,RII.ReturnedInvoiceRef 
                  ,RII.ItemRef
                  ,RII.Quantity
                  ,Price = RII.NetPriceInBaseCurrency - RII.TaxInBaseCurrency - RII.DutyInBaseCurrency
                  ,RI.FiscalYearRef
                  ,RI.Number
                  ,RI.[Date]
                  ,RI.PartyAddressRef
                  ,RI.SaleTypeRef                  
                  ,RII.InvoiceItemRef BaseInvoiceItemRef
                  ,BrokerPartyRef = RICB.PartyRef 
                  ,RICB.SalePortionPercent
                  ,RICB.ManualCommissionAmount 
                  ,IsSettlementedExcludeCheques = 1
                  ,IsSettlementedIncludeCheques = 1
                  ,IsExtraReturnedInvoice = 1
                  ,RI.[Version]
            FROM       SLS.ReturnedInvoiceItem RII
              INNER JOIN SLS.ReturnedInvoice RI 
                ON RII.ReturnedInvoiceRef = RI.ReturnedInvoiceId
              INNER  JOIN SLS.ReturnedInvoiceCommissionBroker RICB 
                ON RII.ReturnedInvoiceRef = RICB.ReturnedInvoiceRef
            WHERE   RII.DiscountReturnedInvoiceItemRef IS NULL
               AND   RII.IsAggregateDiscountInvoiceItem = 0
               AND   RII.InvoiceItemRef Is NOT Null
    )Invoices
    LEFT JOIN INV.Item Item 
      ON Invoices.ItemRef = Item.ItemId
    LEFT JOIN DST.PathPartyAddress PPA
      ON PPA.PartyAddressRef = Invoices.PartyAddressRef
    LEFT JOIN DST.vwAreaAndPath AP
      ON AP.AreaAndPathId = PPA.AreaAndPathRef
    WHERE (AP.AreaAndPathId IS NOT NULL AND Ap.IsActive = 1)
          OR AP.AreaAndPathId IS NULL
GO

