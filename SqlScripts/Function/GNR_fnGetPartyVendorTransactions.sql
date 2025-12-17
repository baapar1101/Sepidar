IF OBJECT_ID('GNR.fnGetPartyVendorTransactions') IS NOT NULL
	DROP FUNCTION [GNR].[fnGetPartyVendorTransactions]
GO

CREATE FUNCTION [GNR].[fnGetPartyVendorTransactions] (@PartyDLRef INT = -1, @ContainsCheque INT = 1, @FiscalYearRef INT, @FromDate DATE = NULL, @ToDate DATE = NULL)
RETURNS TABLE

RETURN

--DECLARE @PartyDLRef INT = -1, @ContainsCheque INT = 1, @FiscalYearRef INT = 2, @FromDate DATE = NULL, @ToDate DATE = NULL

SELECT
    RecordType
    ,PartyRef AS PartyDLRef
    ,Date
    ,Amount = ISNULL(Amount, 0)
    ,AmountInBaseCurrency = ISNULL(AmountInBaseCurrency, 0)
    ,CreditDebit = VendorRemainFactor
    ,EntityID
    ,EntityItemID
    ,Number
    ,CurrencyRef
    ,VoucherRef
FROM (SELECT RecordType           = 10
           , EntityID             = DCN.DebitCreditNoteID
           , EntityItemID         = DCNI.DebitCreditNoteItemID
           , DCN.FiscalYearRef
           , DCN.Number
           , PartyRef             = DCNI.CreditDLRef
           , DCN.VoucherRef
           , Description          = DCNI.Description
           , Amount               = DCNI.Amount
           , CurrencyRef
           , AmountInBaseCurrency = DCNI.AmountInBaseCurrency
           , Date                 = DCN.Date
           , PartyRoleType        = CASE
                                        WHEN DCNI.CreditType = 2 THEN 1
                                        WHEN DCNI.CreditType = 1 THEN 2
                                        WHEN DCNI.CreditType = 3 THEN 4
                                        WHEN DCNI.CreditType = 4 THEN 3
        END
           , CustomerRemainFactor = CASE WHEN DCNI.CreditType = 2 THEN -1 ELSE 0 END
           , VendorRemainFactor   = CASE WHEN DCNI.CreditType = 1 THEN -1 ELSE 0 END
           , BrokerFactor         = CASE WHEN DCNI.CreditType = 4 THEN -1 ELSE 0 END
           , OtherFactor          = CASE WHEN DCNI.CreditType = 3 THEN -1 ELSE 0 END
           , PettyCashFactor      = 0
      FROM GNR.DebitCreditNote DCN
               JOIN GNR.DebitCreditNoteItem DCNI
                    ON DCN.DebitCreditNoteID = DCNI.DebitCreditNoteRef
      WHERE DCNI.CreditType <> 5 AND DCNI.CreditDLRef IS NOT NULL

      UNION ALL

      SELECT RecordType           = 11
           , EntityID             = DCN.DebitCreditNoteID
           , EntityItemID         = DCNI.DebitCreditNoteItemID
           , DCN.FiscalYearRef
           , DCN.Number
           , PartyRef             = DCNI.DebitDLRef
           , DCN.VoucherRef
           , Description          = DCNI.Description
           , Amount               = DCNI.Amount
           , CurrencyRef
           , AmountInBaseCurrency = DCNI.AmountInBaseCurrency
           , Date                 = DCN.Date
           , PartyRoleType        = CASE
                                        WHEN DCNI.DebitType = 2 THEN 1
                                        WHEN DCNI.DebitType = 1 THEN 2
                                        WHEN DCNI.DebitType = 3 THEN 4
                                        WHEN DCNI.DebitType = 4 THEN 3
          END
           , CustomerRemainFactor = CASE WHEN DCNI.DebitType = 2 THEN 1 ELSE 0 END
           , VendorRemainFactor   = CASE WHEN DCNI.DebitType = 1 THEN 1 ELSE 0 END
           , BrokerFactor         = CASE WHEN DCNI.DebitType = 4 THEN 1 ELSE 0 END
           , OtherFactor          = CASE WHEN DCNI.DebitType = 3 THEN 1 ELSE 0 END
           , PettyCashFactor      = 0
      FROM GNR.DebitCreditNote DCN
               JOIN GNR.DebitCreditNoteItem DCNI
                    ON DCN.DebitCreditNoteID = DCNI.DebitCreditNoteRef
		WHERE DCNI.DebitDLRef IS NOT NULL

      UNION ALL

      SELECT RecordType           = 30
           , EntityID             = -1
           , EntityItemID         = 0
           , POB.FiscalYearRef
           , Number               = NULL
           , PartyRef             = P.DLRef
           , VoucherRef           = NULL
           , Description          = NULL
           , Amount               = NULL
           , CurrencyRef          = 0
           , AmountInBaseCurrency = POB.OpeningBalance
           , Date                 = (SELECT TOP 1 StartDate FROM FMK.FiscalYear WHERE FiscalYearId = @FiscalYearRef)
           , PartyRoleType        = 2
           , CustomerRemainFactor = 0
           , VendorRemainFactor   =   CASE
                                          WHEN POB.OpeningBalanceType = 1 THEN 1
                                          WHEN POB.OpeningBalanceType = 2 THEN -1
                                      END
           , BrokerFactor         = 0
           , OtherFactor          = 0
           , PettyCashFactor      = 0
      FROM GNR.PartyOpeningBalance POB
               JOIN GNR.Party P
                    ON POB.PartyRef = P.PartyID
      WHERE POB.Type = 1
        AND POB.OpeningBalance <> 0
        AND POB.FiscalYearRef = @FiscalYearRef

      UNION ALL

      SELECT RecordType           = 18
           , EntityID             = S.ShredID
           , EntityItemID         = 0
           , FiscalYearRef        = (SELECT FY.FiscalYearId
                                     FROM FMK.FiscalYear FY
                                     WHERE S.Date >= FY.StartDate
                                       AND S.Date <= FY.EndDate)
           , Number               = S.Number
           , PartyDLRef           = S.DLRef
           , VoucherRef           = NULL
           , Description          = NULL
           , Amount               = CASE
                                        WHEN [Key] <> 4
                                            THEN (SELECT SUM(ISNULL(SI.InterestAmount, 0) + ISNULL(SI.PenaltyAmount, 0))
                                                  FROM GNR.ShredItem SI
                                                  WHERE SI.ShredRef = S.ShredID)
                                        WHEN [Key] = 4
                                            THEN (SELECT SUM(ISNULL(SI.InterestAmount, 0) + ISNULL(SI.PenaltyAmount, 0))
                                                  FROM GNR.ShredItem SI
                                                  WHERE SI.ShredRef = S.ShredID
                                                    AND SI.ReceiptRef IS NOT NULL)
          END
           , CurrencyRef          = 0
           , AmountInBaseCurrency = CASE
                                        WHEN [Key] <> 4
                                            THEN (SELECT SUM(ISNULL(SI.InterestAmount, 0) + ISNULL(SI.PenaltyAmount, 0))
                                                  FROM GNR.ShredItem SI
                                                  WHERE SI.ShredRef = S.ShredID)
                                        WHEN [Key] = 4
                                            THEN (SELECT SUM(ISNULL(SI.InterestAmount, 0) + ISNULL(SI.PenaltyAmount, 0))
                                                  FROM GNR.ShredItem SI
                                                  WHERE SI.ShredRef = S.ShredID
                                                    AND SI.ReceiptRef IS NOT NULL)
          END
           , Date                 = S.Date
           , PartyRoleType        = CASE
                                        WHEN [Key] = 1 THEN 1
                                        WHEN [Key] = 2 THEN 2
                                        WHEN [Key] = 3 THEN 2
                                        WHEN [Key] = 4 THEN 4
                                        WHEN [Key] = 5 THEN 4
                                        WHEN [Key] = 6 THEN 4
                                        WHEN [Key] = 7 THEN 4
                                        WHEN [Key] = 8 THEN 2
          END
           , CustomerRemainFactor = CASE
                                        WHEN [Key] = 1 THEN 1
                                        ELSE 0
          END
           , VendorRemainFactor   = CASE
                                        WHEN [Key] = 2 THEN -1
                                        WHEN [Key] = 3 THEN -1
                                        WHEN [Key] = 8 THEN -1
                                        ELSE 0
          END
           , BrokerFactor         = 0
           , OtherFactor          = CASE
                                        WHEN [Key] = 4 THEN 1
                                        WHEN [Key] = 6 THEN 1
                                        WHEN [Key] = 7 THEN -1
                                        ELSE 0
          END
           , PettyCashFactor      = 0
      FROM GNR.Shred S
               JOIN GNR.ShredItem SH
                    ON SH.ShredRef = S.ShredId
      WHERE ([Key] IN (1, 2, 3, 6, 7, 8))
         OR ([Key] = 4
          AND SH.ReceiptRef IS NOT NULL)
      GROUP BY S.ShredID, S.Number, S.DLRef, S.[Key], S.Date
      HAVING SUM(SH.InterestAmount)
          > 0
          OR SUM(SH.PenaltyAmount)
          > 0

      UNION ALL

      SELECT RecordType           = 17
           , EntityID             = IPI.InventoryPurchaseInvoiceID
           , EntityItemID         = 0
           , IPI.FiscalYearRef
           , IPI.Number
           , PartyDLRef           = IPI.VendorDLRef
           , VoucherRef           = IPI.AccountingVoucherRef
           , Description          = NULL
           , Amount               = IPI.TotalNetPrice
           , CurrencyRef          = IPI.CurrencyRef
           , AmountInBaseCurrency = IPI.TotalNetPriceInBaseCurrency
           , Date                 = IPI.Date
           , PartyRoleType        = 2
           , CustomerRemainFactor = 0
           , VendorRemainFactor   = -1
           , BrokerFactor         = 0
           , OtherFactor          = 0
           , PettyCashFactor      = 0
      FROM INV.InventoryPurchaseInvoice IPI
      WHERE Type = 2

      UNION ALL

      SELECT RecordType           = 12
           , EntityID             = IR.InventoryReceiptID
           , EntityItemID         = 0
           , IR.FiscalYearRef
           , IR.Number
           , PartyRef             = IR.DelivererDLRef
           , IR.AccountingVoucherRef
           , Description          = ''
           , Amount               = (SELECT SUM(ISNULL(IRI.Price, 0) + ISNULL(IRI.Tax, 0) + ISNULL(IRI.Duty, 0))
                                     FROM INV.InventoryReceiptItem IRI
                                     WHERE IR.InventoryReceiptID = IRI.InventoryReceiptRef)
           , CurrencyRef          = 0
           , AmountInBaseCurrency = (SELECT SUM(ISNULL(IRI.Price, 0) + ISNULL(IRI.Tax, 0) + ISNULL(IRI.Duty, 0))
                                     FROM INV.InventoryReceiptItem IRI
                                     WHERE IR.InventoryReceiptID = IRI.InventoryReceiptRef)
           , Date                 = IR.Date
           , PartyRoleType        = CASE
                                        WHEN IR.Type = 1 THEN 2
                                        WHEN IR.Type = 3 THEN 4
          END
           , CustomerRemainFactor = 0
           , VendorRemainFactor   = CASE WHEN IR.Type = 1 THEN -1 ELSE 0 END
           , BrokerFactor         = 0
           , OtherFactor          = CASE WHEN IR.Type = 3 THEN -1 ELSE 0 END
           , PettyCashFactor      = 0
      FROM INV.InventoryReceipt IR
      WHERE IR.IsReturn = 0
        AND IR.BaseImportPurchaseInvoiceRef IS NULL

      UNION ALL

      SELECT RecordType           = 13
           , EntityID             = IR.InventoryReceiptID
           , EntityItemID         = 0
           , IR.FiscalYearRef
           , IR.Number
           , PartyRef             = IR.DelivererDLRef
           , IR.AccountingVoucherRef
           , Description          =''
           , Amount               = ISNULL(TotalReturnedPrice, 0) + TotalTax + TotalDuty
           , CurrencyRef          = 1
           , AmountInBaseCurrency = ISNULL(TotalReturnedPrice, 0) + TotalTax + TotalDuty
           , Date                 = IR.Date
           , PartyRoleType        = CASE
                                        WHEN IR.Type = 1 THEN 2
                                        WHEN IR.Type = 3 THEN 4
          END
           , CustomerRemainFactor = 0
           , VendorRemainFactor   = CASE WHEN IR.Type = 1 THEN 1 ELSE 0 END
           , BrokerFactor         = 0
           , OtherFactor          = CASE WHEN IR.Type = 3 THEN 1 ELSE 0 END
           , PettyCashFactor      = 0
      FROM INV.InventoryReceipt IR
      WHERE IR.IsReturn = 1

      UNION ALL

      SELECT RecordType           = 14
           , EntityID             = IR.InventoryReceiptID
           , EntityItemId         = 0
           , IR.FiscalYearRef
           , IR.Number
           , PartyRef             = IR.TransporterDLRef
           , IR.AccountingVoucherRef
           , Description          = ''
           , Amount               = (SELECT SUM((ISNULL(IRI.TransportDuty, 0) + ISNULL(IRI.TransportPrice, 0) +
                                                 ISNULL(IRI.TransportTax, 0)))
                                     FROM INV.InventoryReceiptItem IRI
                                     WHERE IR.InventoryReceiptID = IRI.InventoryReceiptRef)
           , CurrencyRef          = 0
           , AmountInBaseCurrency = (SELECT SUM((ISNULL(IRI.TransportDuty, 0) + ISNULL(IRI.TransportPrice, 0) +
                                                 ISNULL(IRI.TransportTax, 0)))
                                     FROM INV.InventoryReceiptItem IRI
                                     WHERE IR.InventoryReceiptID = IRI.InventoryReceiptRef)
           , Date                 = IR.Date
           , PartyRoleType        = CASE
                                        WHEN IR.Type = 1 THEN 2
                                        WHEN IR.Type = 3 THEN 4
          END
           , CustomerRemainFactor = 0
           , VendorRemainFactor   = CASE WHEN IR.Type = 1 THEN -1 ELSE 0 END
           , BrokerFactor         = 0
           , OtherFactor          = CASE WHEN IR.Type = 3 THEN -1 ELSE 0 END
           , PettyCashFactor      = 0
      FROM INV.InventoryReceipt IR
      WHERE EXISTS
          (
              SELECT TOP 1 1
              FROM INV.InventoryReceiptItem IRI
              WHERE IRI.InventoryReceiptRef = IR.InventoryReceiptID
                AND (IRI.TransportPrice <> 0
                  OR IRI.TransportTax <> 0
                  OR IRI.TransportDuty <> 0)
          )
        AND IsReturn = 0
        AND IR.TransporterDLRef IS NOT NULL

      UNION ALL

      SELECT RecordType           = 39
           , EntityID             = PI.PurchaseInvoiceID
           , EntityItemID         = 0
           ,                        PI.FiscalYearRef
           ,                        PI.Number
           , PartyDLRef           = PI.VendorDLRef
           ,                        0 VoucherRef
           , Description          = ''
           , Amount               = SUM(PII.NetPrice)
           ,                        PI.CurrencyRef
           , AmountInBaseCurrency = SUM(PII.NetPriceInBaseCurrency)
           , Date                 = PI.Date
           , PartyRoleType        = 2
           , CustomerRemainFactor = 0
           , VendorRemainFactor   = -1
           , BrokerFactor         = 0
           , OtherFactor          = 0
           , PettyCashFactor      = 0
      FROM POM.PurchaseInvoice PI
               INNER JOIN pom.PurchaseInvoiceItem PII
                          ON PI.PurchaseInvoiceID = PII.PurchaseInvoiceRef
               INNER JOIN pom.PurchaseCost PC
                          ON PC.PurchaseInvoiceRef = PI.PurchaseInvoiceID
      WHERE PI.VendorDLRef IS NOT NULL
        AND PI.IsInitial = 0
        AND PC.State = 1
      GROUP BY PI.PurchaseInvoiceID, PI.FiscalYearRef, PI.Number, PI.VendorDLRef, PI.Date, PI.CurrencyRef

      UNION ALL

      SELECT RecordType           = 40
           , EntityID             = BL.BillOfLoadingID
           , EntityItemID         = 0
           ,                        BL.FiscalYearRef
           ,                        BL.Number
           , PartyDLRef           = BL.TransporterDLRef
           ,                        BL.VoucherRef VoucherRef
           , Description          = ''
           , Amount               = SUM(BL.totalNetPrice)
           ,                        BL.CurrencyRef
           , AmountInBaseCurrency = SUM(BL.TotalNetPriceInBaseCurrency)
           , Date                 = BL.Date
           , PartyRoleType        =2
           , CustomerRemainFactor = 0
           , VendorRemainFactor   = -1
           , BrokerFactor         = 0
           , OtherFactor          = 0
           , PettyCashFactor      = 0
      FROM POM.BillOfLoading BL
           --INNER JOIN pom.BillOfLoadingItem BLI
           -- ON BL.BillOfLoadingID = BLI.BillOfLoadingRef
      WHERE BL.TransporterDLRef IS NOT NULL
      GROUP BY BL.BillOfLoadingID, BL.FiscalYearRef, BL.Number, BL.TransporterDLRef, BL.Date, BL.CurrencyRef,
               BL.VoucherRef

      UNION ALL

      SELECT RecordType           = 41
           , EntityID             = IP.InsurancePolicyID
           , EntityItemID         = 0
           , IP.FiscalYearRef
           , IP.Number
           , PartyDLRef           = IP.AgencyDLRef
           , IP.VoucherRef
           , Description          = ''
           , Amount               = SUM(IP.TotalNetPrice)
           , IP.CurrencyRef
           , AmountInBaseCurrency = SUM(IP.TotalNetPriceInBaseCurrency)
           , Date                 = IP.Date
           , PartyRoleType        =2
           , CustomerRemainFactor = 0
           , VendorRemainFactor   = -1
           , BrokerFactor         = 0
           , OtherFactor          = 0
           , PettyCashFactor      = 0
      FROM POM.InsurancePolicy IP
           --INNER JOIN pom.InsurancePolicyItem IPI
           --ON IP.InsurancePolicyID= IPI.InsurancePolicyRef
      WHERE IP.AgencyDLRef IS NOT NULL
      GROUP BY IP.InsurancePolicyID, IP.FiscalYearRef, IP.Number, IP.AgencyDLRef, IP.Date, IP.CurrencyRef,
               IP.VoucherRef

      UNION ALL

      SELECT RecordType           = 42
           , EntityID             = CO.CommercialOrderID
           , EntityItemID         = 0
           ,                        CO.FiscalYearRef
           ,                        CO.Number
           , PartyDLRef           = CO.DLRef
           ,                        CO.VoucherRef
           , Description          = ''
           , Amount               = SUM(COI.RegisterFee)
           ,                        0 CurrencyRef
           , AmountInBaseCurrency = SUM(COI.RegisterFee)
           , Date                 = CO.Date
           , PartyRoleType        =2
           , CustomerRemainFactor = 0
           , VendorRemainFactor   = -1
           , BrokerFactor         = 0
           , OtherFactor          = 0
           , PettyCashFactor      = 0
      FROM POM.CommercialOrder CO
               INNER JOIN pom.CommercialOrderItem COI
                          ON CO.CommercialOrderID = COI.CommercialOrderRef
      WHERE CO.DLRef IS NOT NULL
      GROUP BY CO.CommercialOrderID, CO.FiscalYearRef, CO.Number, CO.DLRef, CO.Date, CO.VoucherRef

      UNION ALL

      SELECT RecordType           = 43
           , EntityID             = CC.CustomsClearanceID
           , EntityItemID         = 0
           , CC.FiscalYearRef
           , CC.Number
           , PartyDLRef           = CC.DLRef
           , CC.VoucherRef
           , Description          = ''
           , Amount               = SUM(CCI.CustomsCost) + SUM(CCI.Tax) + SUM(CCI.Duty)
           , CurrencyRef          = 0
           , AmountInBaseCurrency = SUM(CCI.CustomsCost) + SUM(CCI.Tax) + SUM(CCI.Duty)
           , Date                 = CC.Date
           , PartyRoleType        =2
           , CustomerRemainFactor = 0
           , VendorRemainFactor   = -1
           , BrokerFactor         = 0
           , OtherFactor          = 0
           , PettyCashFactor      = 0
      FROM POM.CustomsClearance CC
               INNER JOIN pom.CustomsClearanceItem CCI
                          ON CC.CustomsClearanceID = CCI.CustomsClearanceRef
      WHERE CC.DLRef IS NOT NULL
      GROUP BY CC.CustomsClearanceID, CC.FiscalYearRef, CC.Number, CC.DLRef, CC.Date, CC.VoucherRef

      UNION ALL

      SELECT *
      FROM (SELECT RecordType           = 6
                 , EntityID             = PH.PaymentHeaderID
                 , EntityItemID         = 0
                 , PH.FiscalYearRef
                 , PH.Number
                 , PartyRef             = PH.DlRef
                 , PH.VoucherRef
                 , Description          = PH.Description
                 , Amount               = PH.Amount + ISNULL(PH.Discount, 0)
              + ISNULL(
                                                  (SELECT SUM(PC.Amount)
                                                   FROM RPA.PaymentCheque PC
                                                   WHERE PC.PaymentHeaderRef = PH.PaymentHeaderId
                                                     AND PC.State IN (1, 2)), 0)
              + ISNULL(
                                                  (SELECT SUM(RC.Amount)
                                                   FROM RPA.PaymentChequeOther PCO
                                                            JOIN RPA.ReceiptCheque RC ON RC.ReceiptChequeID = PCO.ReceiptChequeRef
                                                   WHERE PCO.PaymentHeaderRef = PH.PaymentHeaderID), 0)
              + ISNULL(
                                                  (SELECT SUM(PD.Amount)
                                                   FROM RPA.PaymentDraft PD
                                                   WHERE PD.PaymentHeaderRef = PH.PaymentHeaderId), 0)
                 , PH.CurrencyRef
                 , AmountInBaseCurrency = PH.AmountInBaseCurrency + ISNULL(PH.DiscountInBaseCurrency, 0)
              + ISNULL(
                                                  (SELECT SUM(PC.AmountInBaseCurrency)
                                                   FROM RPA.PaymentCheque PC
                                                   WHERE PC.PaymentHeaderRef = PH.PaymentHeaderId
                                                     AND PC.State IN (1, 2)), 0)
              + ISNULL(
                                                  (SELECT SUM(RC.AmountInBaseCurrency)
                                                   FROM RPA.PaymentChequeOther PCO
                                                            JOIN RPA.ReceiptCheque RC ON RC.ReceiptChequeID = PCO.ReceiptChequeRef
                                                   WHERE PCO.PaymentHeaderRef = PH.PaymentHeaderID), 0)
              + ISNULL(
                                                  (SELECT SUM(PD.AmountInBaseCurrency)
                                                   FROM RPA.PaymentDraft PD
                                                   WHERE PD.PaymentHeaderRef = PH.PaymentHeaderId), 0)
                 , Date                 = PH.Date
                 , PartyRoleType        = CASE
                                              WHEN PH.Type = 1 THEN 1
                                              WHEN PH.Type = 256 THEN 2
                                              WHEN PH.Type = 2 THEN 4
                                              WHEN PH.Type = 128 THEN 3
                                              WHEN PH.Type = 2048 THEN 5
              END
                 , CustomerRemainFactor = CASE WHEN PH.Type = 1 THEN 1 ELSE 0 END
                 , VendorRemainFactor   = CASE WHEN PH.Type = 256 THEN 1 ELSE 0 END
                 , BrokerFactor         = CASE WHEN PH.Type = 128 THEN 1 ELSE 0 END
                 , OtherFactor          = CASE WHEN PH.Type = 2 THEN 1 ELSE 0 END
                 , PettyCashFactor      = CASE WHEN PH.Type = 2048 THEN 1 ELSE 0 END
            FROM RPA.PaymentHeader PH
            WHERE (PH.State <> 4 AND PH.Type <> 64)
               OR (PH.Amount <> 0)) a
      WHERE AmountInBaseCurrency > 0

      UNION ALL

      SELECT RecordType           = 7
           , EntityId             = RefundChequeId
           , EntityItemID         = RCI.RefundChequeItemID
           ,                        RFC.FiscalYearRef
           ,                        RFC.Number
           , PartyRef             = RFC.DlRef
           ,                        RFC.VoucherRef
           ,                        NULL AS Description
           , Amount               =
                                    (SELECT PC.Amount
                                     FROM RPA.RefundChequeItem RCI1
                                              JOIN RPA.PaymentCheque PC1 ON PC1.PaymentChequeId = RCI1.PaymentChequeRef
                                     WHERE RCI1.RefundChequeItemId = RCI.RefundChequeItemId)
           ,                        PC.CurrencyRef
           , AmountInBaseCurrency =
                                    (SELECT AmountInBaseCurrency
                                     FROM RPA.RefundChequeItem RCI1
                                              JOIN RPA.PaymentCheque PC1 ON PC1.PaymentChequeId = RCI1.PaymentChequeRef
                                     WHERE RCI1.RefundChequeItemId = RCI.RefundChequeItemId)
           ,                        RFC.Date
           , PartyRoleType        = CASE
                                        WHEN PH.Type = 1 THEN 1
                                        WHEN PH.Type = 256 THEN 2
                                        WHEN PH.Type = 2 THEN 4
                                        WHEN PH.Type = 128 THEN 3
                                        WHEN PH.Type = 2048 THEN 5
                                        END
           , CustomerRemainFactor = CASE WHEN PH.Type = 1 THEN -1 ELSE 0 END
           , VendorRemainFactor   = CASE WHEN PH.Type = 256 THEN -1 ELSE 0 END
           , BrokerFactor         = CASE WHEN PH.Type = 128 THEN -1 ELSE 0 END
           , OtherFactor          = CASE WHEN PH.Type = 2 THEN -1 ELSE 0 END
           , PettyCashFactor      = CASE WHEN PH.Type = 2048 THEN -1 ELSE 0 END
      FROM RPA.RefundChequeItem RCI
               JOIN RPA.RefundCheque RFC
                    ON RFC.RefundChequeId = RCI.RefundChequeRef
               JOIN RPA.PaymentCheque PC ON PC.PaymentChequeId = RCI.PaymentChequeRef
               JOIN RPA.PaymentHeader PH ON PC.PaymentHeaderRef = PH.PaymentHeaderId
      WHERE RFC.Type = 2
        AND PH.State = 4

      UNION ALL

      SELECT *
      FROM (SELECT RecordType           = 9
                 , EntityID             = RC.RefundChequeId
                 , EntityItemID         = RCI.RefundChequeItemId
                 ,                        RC.FiscalYearRef
                 ,                        RC.Number
                 , PartyRef             = RC.DlRef
                 ,                        RC.VoucherRef
                 ,                        null Description
                 , Amount               = RCI.Amount
                 ,                        RC.CurrencyRef
                 , AmountInBaseCurrency = RCI.AmountInBaseCurrency
                 , Date                 = RC.Date
                 , PartyRoleType        = CASE
                                              WHEN PH.Type = 1 /*دريافت از مشتري*/ THEN 1
                                              WHEN PH.Type = 256 /*دريافت از تاميين كننده*/ THEN 2
                                              WHEN PH.Type = 2 /*دريافت از ساير*/ THEN 4
                                              WHEN PH.Type = 128 /*واسط*/ THEN 3
                                              WHEN PH.Type = 2048 THEN 5
                                              END
                 , CustomerRemainFactor = CASE WHEN PH.Type = 1 THEN -1 ELSE 0 END
                 , VendorRemainFactor   = CASE WHEN PH.Type = 256 THEN -1 ELSE 0 END
                 , BrokerFactor         = CASE WHEN PH.Type = 128 THEN -1 ELSE 0 END
                 , OtherFactor          = CASE WHEN PH.Type = 2 THEN -1 ELSE 0 END
                 , PettyCashFactor      = CASE WHEN PH.Type = 2048 THEN -1 ELSE 0 END
            FROM RPA.RefundCheque RC
                     JOIN RPA.vwRefundChequeItem RCI ON RC.RefundChequeId = RCI.RefundChequeRef
                     JOIN RPA.PaymentHeader PH ON PH.PaymentHeaderId = RCI.PaymentHeaderRef
            WHERE RC.Type = 2 /*استرداد چك پرداختني*/
              AND PH.State <> 4) a
      WHERE a.AmountInBaseCurrency > 0

      UNION ALL

      SELECT *
      FROM (SELECT RecordType           = 3
                 , EntityID             = RH.ReceiptHeaderID
                 , EntityItemID         = 0
                 , RH.FiscalYearRef
                 , RH.Number
                 , PartyRef             = RH.DlRef
                 , RH.VoucherRef
                 , Description          = RH.Description
                 , Amount               = RH.Amount + RH.Discount
              + ISNULL(
                                                  (SELECT SUM(RC.Amount)
                                                   FROM RPA.ReceiptCheque RC
                                                   WHERE RC.ReceiptHeaderRef = RH.ReceiptHeaderID
                                                     AND (
                                                           (RH.FiscalYearRef <> @FiscalYearRef And
                                                            RC.State IN (1, 2, 4, 8, 16, 32, 64)
                                                               )
                                                           OR
                                                           (RH.FiscalYearRef = @FiscalYearRef AND
                                                            ((RC.State IN (1, 2, 8) AND @containsCheque = 1) OR
                                                             RC.State IN (4, 16, 32, 64))
                                                               )
                                                       )), 0)
              + ISNULL(
                                                  (SELECT SUM(RD.Amount)
                                                   FROM RPA.ReceiptDraft RD
                                                   WHERE RD.ReceiptHeaderRef = RH.ReceiptHeaderID), 0)
              + ISNULL(
                                                  (SELECT SUM(Amount)
                                                   FROM RPA.ReceiptPos RP
                                                   WHERE RP.ReceiptHeaderRef = RH.ReceiptHeaderId), 0)

              + ISNULL(
                                                  (SELECT SUM(Amount)
                                                      FROM RPA.ReceiptPettyCash RPC
                                                      WHERE RPC.ReceiptHeaderRef = RH.ReceiptHeaderId), 0)
                 , RH.CurrencyRef
                 , AmountInBaseCurrency = RH.AmountInBaseCurrency + ISNULL(RH.DiscountInBaseCurrency, 0)
              + ISNULL(
                                                  (SELECT SUM(RC.AmountInBaseCurrency)
                                                   FROM RPA.ReceiptCheque RC
                                                   WHERE RC.ReceiptHeaderRef = RH.ReceiptHeaderID
                                                     AND (
                                                           (RH.FiscalYearRef <> @FiscalYearRef And
                                                            RC.State IN (1, 2, 4, 8, 16, 32, 64)
                                                               )
                                                           OR
                                                           (RH.FiscalYearRef = @FiscalYearRef AND
                                                            ((RC.State IN (1, 2, 8) AND @containsCheque = 1) OR
                                                             RC.State IN (4, 16, 32, 64))
                                                               )
                                                       )), 0)
              + ISNULL(
                                                  (SELECT SUM(RD.AmountInBaseCurrency)
                                                   FROM RPA.ReceiptDraft RD
                                                   WHERE RD.ReceiptHeaderRef = RH.ReceiptHeaderID), 0)
              + ISNULL(
                                                  (SELECT SUM(AmountInBaseCurrency)
                                                   FROM RPA.ReceiptPos RP
                                                   WHERE RP.ReceiptHeaderRef = RH.ReceiptHeaderId), 0)
              + ISNULL(
                                                  (SELECT SUM(AmountInBaseCurrency)
                                                      FROM RPA.ReceiptPettyCash RPC
                                                      WHERE RPC.ReceiptHeaderRef = RH.ReceiptHeaderId), 0)
                 , Date                 = RH.Date
                 , PartyRoleType        = CASE
                                              WHEN RH.Type = 1 THEN 1
                                              WHEN RH.Type = 16 THEN 2
                                              WHEN RH.Type = 2 THEN 4
                                              WHEN RH.Type = 8 THEN 3
                                              WHEN RH.Type = 64 THEN 5
              END
                 , CustomerRemainFactor = CASE WHEN RH.Type = 1 THEN -1 ELSE 0 END
                 , VendorRemainFactor   = CASE WHEN RH.Type = 16 THEN -1 ELSE 0 END
                 , BrokerFactor         = CASE WHEN RH.Type = 8 THEN -1 ELSE 0 END
                 , OtherFactor          = CASE WHEN RH.Type = 2 THEN -1 ELSE 0 END
                 , PettyCashFactor      = CASE WHEN RH.Type = 64 THEN -1 ELSE 0 END
            FROM RPA.ReceiptHeader RH
            WHERE (RH.State <> 4)
              AND RH.Type IN (1, 2, 8, 16, 32, 64)) a
      WHERE a.AmountInBaseCurrency > 0

      UNION ALL

      SELECT *
      FROM (SELECT RecordType           = 3
                 , EntityID             = RH.ReceiptHeaderID
                 , EntityItemID         = 0
                 , RH.FiscalYearRef
                 , RH.Number
                 , PartyRef             = RH.DlRef
                 , RH.VoucherRef
                 , Description          = RH.Description
                 , Amount               = -ISNULL(
                  (SELECT SUM(RC.Amount)
                   FROM RPA.ReceiptCheque RC
                   WHERE RC.ReceiptHeaderRef = RH.ReceiptHeaderID
                     AND RC.State IN (1, 2, 8)), 0)
                 , RH.CurrencyRef
                 , AmountInBaseCurrency = -ISNULL(
                  (SELECT SUM(RC.AmountInBaseCurrency)
                   FROM RPA.ReceiptCheque RC
                   WHERE RC.ReceiptHeaderRef = RH.ReceiptHeaderID
                     AND RC.State IN (1, 2, 8)), 0)
                 , Date                 = RH.Date
                 , PartyRoleType        = CASE
                                              WHEN RH.Type = 1 THEN 1
                                              WHEN RH.Type = 16 THEN 2
                                              WHEN RH.Type = 2 THEN 4
                                              WHEN RH.Type = 8 THEN 3
                                              WHEN RH.Type = 64 THEN 5
              END
                 , CustomerRemainFactor = CASE WHEN RH.Type = 1 THEN -1 ELSE 0 END
                 , VendorRemainFactor   = CASE WHEN RH.Type = 16 THEN -1 ELSE 0 END
                 , BrokerFactor         = CASE WHEN RH.Type = 8 THEN -1 ELSE 0 END
                 , OtherFactor          = CASE WHEN RH.Type = 2 THEN -1 ELSE 0 END
                 , PettyCashFactor      = CASE WHEN RH.Type = 64 THEN -1 ELSE 0 END
            FROM RPA.ReceiptHeader RH
            WHERE @containsCheque <> 1
              AND RH.State = 4
              AND RH.Type IN (1, 2, 8, 16, 32, 64)
              AND RH.FiscalYearRef = @FiscalYearRef) a
      WHERE a.AmountInBaseCurrency <> 0

      UNION ALL

      SELECT RecordType           = 5
           , EntityId             = RefundChequeId
           , EntityItemID         = RCI.RefundChequeItemID
           ,                        RFC.FiscalYearRef
           ,                        RFC.Number
           , PartyRef             = RFC.DlRef
           ,                        RFC.VoucherRef
           ,                        NULL AS Description
           , Amount               =
                                    (SELECT RC.Amount
                                     FROM RPA.RefundChequeItem RCI1
                                              JOIN RPA.ReceiptCheque RC1 ON RC1.ReceiptChequeId = RCI1.ReceiptChequeRef
                                     WHERE RCI1.RefundChequeItemId = RCI.RefundChequeItemId)
           ,                        RC.CurrencyRef
           , AmountInBaseCurrency =
                                    (SELECT AmountInBaseCurrency
                                     FROM RPA.RefundChequeItem RCI1
                                              JOIN RPA.ReceiptCheque RC1 ON RC1.ReceiptChequeId = RCI1.ReceiptChequeRef
                                     WHERE RCI1.RefundChequeItemId = RCI.RefundChequeItemId)
           ,                        RFC.Date
           , PartyRoleType        = CASE
                                        WHEN RH.Type = 1 THEN 1
                                        WHEN RH.Type = 16 THEN 2
                                        WHEN RH.Type = 2 THEN 4
                                        WHEN RH.Type = 8 THEN 3
                                        WHEN RH.Type = 64 THEN 5
                                        END
           , CustomerRemainFactor = CASE WHEN RH.Type = 1 THEN 1 ELSE 0 END
           , VendorRemainFactor   = CASE WHEN RH.Type = 16 THEN 1 ELSE 0 END
           , BrokerFactor         = CASE WHEN RH.Type = 8 THEN 1 ELSE 0 END
           , OtherFactor          = CASE WHEN RH.Type = 2 THEN 1 ELSE 0 END
           , PettyCashFactor      = CASE WHEN RH.Type = 64 THEN 1 ELSE 0 END
      FROM RPA.RefundChequeItem RCI
               JOIN RPA.RefundCheque RFC
                    ON RFC.RefundChequeId = RCI.RefundChequeRef
               JOIN RPA.ReceiptCheque RC ON RC.ReceiptChequeId = RCI.ReceiptChequeRef
               JOIN RPA.ReceiptHeader RH ON RC.ReceiptHeaderRef = RH.ReceiptHeaderId
      WHERE RFC.Type = 1
        AND RH.State = 4

      UNION ALL

      SELECT *
      FROM (SELECT RecordType           = 8
                 , EntityID             = RC.RefundChequeId
                 , EntityItemID         = RCI.RefundChequeItemId
                 ,                        RC.FiscalYearRef
                 ,                        RC.Number
                 , PartyRef             = RC.DlRef
                 ,                        RC.VoucherRef
                 ,                        null Description
                 , Amount               = RCI.Amount
                 ,                        RC.CurrencyRef
                 , AmountInBaseCurrency = RCI.AmountInBaseCurrency
                 , Date                 = RC.Date
                 , PartyRoleType        = CASE
                                              WHEN RH.Type = 1 /*دريافت از مشتري*/ THEN 1
                                              WHEN RH.Type = 16 /*دريافت از تاميين كننده*/ THEN 2
                                              WHEN RH.Type = 2 /*دريافت از ساير*/ THEN 4
                                              WHEN RH.Type = 8 /*دريافت از واسط*/ THEN 3
                                              WHEN RH.Type = 64 THEN 5
                                              END
                 , CustomerRemainFactor = CASE WHEN RH.Type = 1 THEN 1 ELSE 0 END
                 , VendorRemainFactor   = CASE WHEN RH.Type = 16 THEN 1 ELSE 0 END
                 , BrokerFactor         = CASE WHEN RH.Type = 8 THEN 1 ELSE 0 END
                 , OtherFactor          = CASE WHEN RH.Type = 2 THEN 1 ELSE 0 END
                 , PettyCashFactor      = CASE WHEN RH.Type = 64 THEN 1 ELSE 0 END
            FROM RPA.RefundCheque RC
                     JOIN RPA.vwRefundChequeItem RCI ON RC.RefundChequeId = RCI.RefundChequeRef
                     JOIN RPA.ReceiptHeader RH ON RH.ReceiptHeaderId = RCI.ReceiptHeaderRef
            WHERE RC.Type = 1 /*استرداد چك دريافتني*/AND RH.State <> 4) a
      WHERE a.AmountInBaseCurrency > 0

      UNION ALL

      SELECT a.RecordType
           , a.EntityID
           , a.EntityItemID
           , a.FiscalYearRef
           , a.Number
           , a.PartyRef
           , a.VoucherRef
           , a.Description
           , a.Amount
           , a.CurrencyRef
           , a.AmountInBaseCurrency
           , a.Date
           , PartyRoleType        = CASE
                                        WHEN a.PaymentType = 1 THEN 1
                                        WHEN a.PaymentType = 256 THEN 2
                                        WHEN a.PaymentType = 2 THEN 4
                                        WHEN a.PaymentType = 128 THEN 3
                                        WHEN a.PaymentType = 64 THEN 5
          END
           , CustomerRemainFactor = CASE WHEN a.PaymentType = 1 THEN -1 ELSE 0 END
           , VendorRemainFactor   = CASE WHEN a.PaymentType = 256 THEN -1 ELSE 0 END
           , BrokerFactor         = CASE WHEN a.PaymentType = 128 THEN -1 ELSE 0 END
           , OtherFactor          = CASE WHEN a.PaymentType = 2 THEN -1 ELSE 0 END
           , PettyCashFactor      = CASE WHEN A.PaymentType = 64 THEN -1 ELSE 0 END
      FROM (SELECT RecordType           = 4
                 , EntityID             = RC.RefundChequeId
                 , EntityItemID         = RCI.RefundChequeItemId
                 ,                        RC.FiscalYearRef
                 ,                        RC.Number
                 , PartyRef             = RC.DlRef
                 ,                        RC.VoucherRef
                 ,                        null Description
                 , Amount               = RCI.Amount
                 ,                        RC.CurrencyRef
                 , AmountInBaseCurrency = RCI.AmountInBaseCurrency
                 , Date                 = RC.Date
                 , PaymentType          =(SELECT PH.Type
                                          FROM RPA.ReceiptChequeHistory RCH
                                                   JOIN RPA.ReceiptChequeHistory PRCH
                                                        ON PRCH.ReceiptChequeHistoryId = RCH.ReceiptChequeHistoryRef
                                                   JOIN RPA.PaymentChequeOther PCO
                                                        ON PCO.PaymentChequeOtherId = PRCH.PaymentChequeOtherRef
                                                   JOIN RPA.PaymentHeader PH ON PH.PaymentHeaderId = PCO.PaymentHeaderRef
                                          WHERE RCH.ReceiptChequeRef = RCI.ReceiptChequeRef
                                            AND RCH.RefundChequeItemRef = RCI.RefundChequeItemID)
                 , CustomerRemainFactor = CASE WHEN RH.Type = 1 THEN -1 ELSE 0 END
                 , VendorRemainFactor   = CASE WHEN RH.Type = 16 THEN -1 ELSE 0 END
                 , BrokerFactor         = CASE WHEN RH.Type = 8 THEN -1 ELSE 0 END
                 , OtherFactor          = CASE WHEN RH.Type = 2 THEN -1 ELSE 0 END
                 , PettyCashFactor      = CASE WHEN RH.Type = 64 THEN -1 ELSE 0 END
            FROM RPA.RefundCheque RC
                     JOIN RPA.vwRefundChequeItem RCI ON RC.RefundChequeId = RCI.RefundChequeRef
                     JOIN RPA.ReceiptHeader RH ON RH.ReceiptHeaderId = RCI.ReceiptHeaderRef
            WHERE RC.Type = 4 /*استرداد برگشت چك خرج شده*/
           ) a
      WHERE a.AmountInBaseCurrency > 0
      ) AllData
WHERE AllData.PartyRoleType = 2
AND AllData.FiscalYearRef = @FiscalYearRef
AND (@PartyDLRef = -1 OR @PartyDLRef = AllData.PartyRef)
AND (@FromDate IS NULL OR @FromDate <= AllData.Date)
AND (@ToDate IS NULL OR AllData.Date <= @ToDate)

