If Object_ID('GNR.spReviewPartyRemainder') Is Not Null
    Drop Procedure GNR.spReviewPartyRemainder
GO

-- declare @EntityType int,@EntityId int,@EntityItemID int,@Debit int,@PartyRef int,@ContainsCheque bit,@FromDate datetime,@ToDate datetime,@CustomerPermission bit,@VendorPermission bit,@BrokerPermission bit,@OtherPermission bit,@FiscalYearRef int,@FilterFiscalYear int,@SystemCurrency int
-- select @EntityType = -1,
--        @EntityId = -1,
--        @EntityItemID = -1,
--        @Debit = -1,
--        @PartyRef = -1,
--        @ContainsCheque = 1,
--        @FromDate = '2021-03-20 00:00:00',
--        @ToDate = '2022-03-21 00:00:00',
--        @CustomerPermission = 1,
--        @VendorPermission = 1,
--        @BrokerPermission = 1,
--        @OtherPermission = 1,
--        @FiscalYearRef = 2,
--        @FilterFiscalYear = 2,
--        @SystemCurrency = 1

-- exec GNR.spReviewPartyRemainder @SystemCurrency,
--                                 @ContainsCheque,
--                                 @FiscalYearRef,
--                                 @FilterFiscalYear,
--                                 @PartyRef

-- drop procedure GNR.spReviewPartyRemainder


CREATE PROCEDURE [GNR].[spReviewPartyRemainder] @SystemCurrency int,
                                                @ContainsCheque bit,
                                                @FiscalYearRef int,
                                                @FilterFiscalYear int,
                                                @PartyRef int,
                                                @PettyCashInstallFiscalYear int = -1
AS

BEGIN
    SELECT *
    FROM (
             SELECT RecordType           = 20
                  , EntityID             = V.VoucherId
                  , EntityItemID         = VI.VoucherItemID
                  , FiscalYearRef
                  , Number               = V.Number
                  , PartyRef             = VI.DLRef
                  , VoucherRef           = NULL
                  , Description          = V.Description
                  , Amount               = Case
                                               when VI.CurrencyRef is null Then ABS(VI.Credit + VI.Debit)
                                               else ISNULL(ABS(VI.CurrencyCredit + VI.CurrencyDebit), 0)
                 End
                  , CurrencyRef          = ISNULL(VI.CurrencyRef, 1)
                  , AmountInBaseCurrency = ABS(VI.Credit + VI.Debit)
                  , Date                 = V.Date
                  , PartyRoleType        = 4
                  , CustomerRemainFactor = 0
                  , VendorRemainFactor   = 0
                  , BrokerFactor         = 0
                  , OtherFactor          = CASE WHEN VI.Debit <> 0 THEN 1 ELSE -1 END
                  , PettyCashFactor      = 0
             FROM ACC.VoucherItem VI
                      JOIN ACC.Voucher V ON V.VoucherId = VI.VoucherRef
                      JOIN ACC.DL DL ON VI.DLRef = DL.DLId
             WHERE (V.Type = 1 OR V.Type = 6)
               AND VI.IssuerEntityName = 'SG.Accounting.VoucherManagement.Common.DsVoucher, SG.Accounting.VoucherManagement.Common, Version=1.0.0.0, Culture=neutral, PublicKeyToken=null'
               AND DL.Type = 2
             UNION ALL

             SELECT RecordType           = 21
                  , EntityID             = CS.CostStatementID
                  , EntityItemId         = 0
                  , CS.FiscalYearRef
                  , Number               = CS.Number
                  , PartyRef             = CS.FundResponderDLRef
                  , VoucherRef           = CS.VoucherRef
                  , Description          = CS.Description
                  , Amount               = (SELECT SUM(CSI.Price)
                                            FROM CNT.CostStatementItem CSI
                                            WHERE CS.CostStatementID = CSI.CostStatementRef)
                  , CurrencyRef          = @SystemCurrency
                  , AmountInBaseCurrency = (SELECT SUM(CSI.Price)
                                            FROM CNT.CostStatementItem CSI
                                            WHERE CS.CostStatementID = CSI.CostStatementRef)
                  , Date                 = CS.Date
                  , PartyRoleType        = 4
                  , CustomerRemainFactor = 0
                  , VendorRemainFactor   = 0
                  , BrokerRemainFactor   = 0
                  , OtherRemainFactor    = -1
                  , PettyCashFactor      = 0
             FROM CNT.CostStatement CS
                      JOIN ACC.DL DL ON DL.DLId = CS.FundResponderDLRef AND DL.Type = 2
             UNION ALL
             SELECT RecordType           = 21
                  , EntityId             = CSI.CostStatementRef
                  , EntityItemId         = CSI.CostStatementItemID
                  , CS.FiscalYearRef
                  , Number               = CS.Number
                  , PartyRef             = P.DLRef
                  , VoucherRef           = CS.VoucherRef
                  , Description          = CS.Description
                  , Amount               = CSI.Price
                  , CurrencyRef          = @SystemCurrency
                  , AmountInBaseCurreny  = CSI.Price
                  , Date                 = CS.Date
                  , PartyRoleType        = 4
                  , CustomerRemainFactor = 0
                  , VendorRemainFactor   = 0
                  , BrokerRemainFactor   = 0
                  , OtherRemainFactor    = -1
                  , PettyCashFactor      = 0
             FROM CNT.CostStatementItem CSI
                      JOIN CNT.CostStatement CS ON CSI.CostStatementRef = CS.CostStatementID
                      JOIN GNR.Party P ON P.PartyId = CSI.PartyRef
             WHERE CS.Type = 2
             UNION ALL
             SELECT RecordType           =22
                  , EntityID             = S.StatusID
                  , EntityItemID         = 0
                  , S.FiscalYearRef
                  , Number               = S.Number
                  , PartyRef             = P.DlRef
                  , VoucherRef           = S.VoucherRef
                  , Description          = NULL
                  , Amount               = CASE
                                               WHEN StatusRefType = 3 THEN -1 *
                                                                           (S.ConfirmedCost - (S.Insurance + S.Tax + S.GoodJob + S.DecCoef) +
                                                                            (S.VAT + S.IncCoef + S.Duty))
                                               ELSE (S.ConfirmedCost - (S.Insurance + S.Tax + S.GoodJob + S.DecCoef) +
                                                     (S.VAT + S.IncCoef + S.Duty)) END
                  , CurrecnyRef          = @SystemCurrency
                  , AmountInBaseCurrency = CASE
                                               WHEN StatusRefType = 3 THEN -1 *
                                                                           (S.ConfirmedCost - (S.Insurance + S.Tax + S.GoodJob + S.DecCoef) +
                                                                            (S.VAT + S.IncCoef + S.Duty))
                                               ELSE (S.ConfirmedCost - (S.Insurance + S.Tax + S.GoodJob + S.DecCoef) +
                                                     (S.VAT + S.IncCoef + S.Duty)) END
                  , Date                 = S.Date
                  , PartyRoleType        = 4
                  , CustomerRemainFactor = 0
                  , VendorRemainFactor   = 0
                  , BrokerRemainFactor   = 0
                  , OtherRemainFactor    = 1
                  , PettyCashFactor      = 0
             FROM CNT.vwStatus S
                      JOIN CNT.Contract C ON C.ContractID = S.ContractRef
                      JOIN GNR.Party P ON P.PartyID = C.ContractorPartyRef
             WHERE S.ConfirmationState = 2
               AND S.Nature = 1

             UNION ALL
             SELECT RecordType           =22
                  , EntityID             = S.StatusID
                  , EntityItemID         = 0
                  , S.FiscalYearRef
                  , Number               = S.Number
                  , PartyRef             = P.DlRef
                  , VoucherRef           = S.VoucherRef
                  , Description          = NULL
                  , Amount               = CASE
                                               WHEN StatusRefType = 3 THEN (
                                                       S.ConfirmedCost - (S.Insurance + S.Tax + S.GoodJob + S.DecCoef) +
                                                       (S.VAT + S.IncCoef + S.Duty))
                                               ELSE -1 *
                                                    (S.ConfirmedCost - (S.Insurance + S.Tax + S.GoodJob + S.DecCoef) +
                                                     (S.VAT + S.IncCoef + S.Duty)) END
                  , CurrecnyRef          = @SystemCurrency
                  , AmountInBaseCurrency = CASE
                                               WHEN StatusRefType = 3 THEN (
                                                       S.ConfirmedCost - (S.Insurance + S.Tax + S.GoodJob + S.DecCoef) +
                                                       (S.VAT + S.IncCoef + S.Duty))
                                               ELSE -1 *
                                                    (S.ConfirmedCost - (S.Insurance + S.Tax + S.GoodJob + S.DecCoef) +
                                                     (S.VAT + S.IncCoef + S.Duty)) END
                  , Date                 = S.Date
                  , PartyRoleType        = 4
                  , CustomerRemainFactor = 0
                  , VendorRemainFactor   = 0
                  , BrokerRemainFactor   = 0
                  , OtherRemainFactor    = 1
                  , PettyCashFactor      = 0
             FROM CNT.vwStatus S
                      JOIN CNT.Contract C ON C.ContractID = S.ContractRef
                      JOIN GNR.Party P ON P.PartyID = C.ContractorPartyRef
             WHERE S.ConfirmationState = 2
               AND S.Nature = 2


             UNION ALL

             SELECT RecordType           = 34
                  , EntityID             = AR.AcquisitionReceiptID
                  , EntityItemID         = 0
                  , AR.FiscalYearRef
                  , AR.Number
                  , PartyDLRef           = AR.AccountingDLRef
                  , AR.VoucherRef
                  , Description          = ''
                  , Amount               = SUM(ARI.TotalCost)
                  , AR.CurrencyRef
                  , AmountInBaseCurrency = SUM(ARI.TotalCostInBaseCurrency)
                  , Date                 = AR.Date
                  , PartyRoleType        = 4
                  , CustomerRemainFactor = 0
                  , VendorRemainFactor   = 0
                  , BrokerFactor         = 0
                  , OtherFactor          = -1
                  , PettyCashFactor      = 0
             FROM AST.AcquisitionReceipt AR
                      INNER JOIN AST.AcquisitionReceiptItem ARI
                                 ON AR.AcquisitionReceiptID = ARI.AcquisitionReceiptRef
             WHERE AR.AccountingDLRef IS NOT NULL
               AND NOT EXISTS(Select 1
                              from AST.vwAcquisitionRelatedPurchaseInvoice AI
                              WHERE ARI.AcquisitionReceiptItemID = AI.AcquisitionReceiptItemRef)
             GROUP BY AR.AcquisitionReceiptID, AR.FiscalYearRef, AR.Number, AR.AccountingDLRef, AR.Date, AR.VoucherRef,
                      AR.CurrencyRef

             UNION ALL

             SELECT RecordType           = 35
                  , EntityID             = S.SaleID
                  , EntityItemID         = 0
                  , S.FiscalYearRef
                  , S.Number
                  , PartyDLRef           = P.DLRef
                  , S.VoucherRef
                  , Description          = ''
                  , Amount               = SUM(SI.SalePrice) + ISNULL(SUM(SI.Tax), 0) + ISNULL(SUM(SI.Duty), 0)
                  , S.CurrencyRef
                  , AmountInBaseCurrency = SUM(SI.SalePriceInBaseCurrency) + ISNULL(SUM(SI.TaxInBaseCurrency), 0) +
                                           ISNULL(SUM(SI.DutyInBaseCurrency), 0)
                  , Date                 = S.Date
                  , PartyRoleType        = 4
                  , CustomerRemainFactor = 0
                  , VendorRemainFactor   = 0
                  , BrokerFactor         = 0
                  , OtherFactor          = 1
                  , PettyCashFactor      = 0
             FROM AST.Sale S
                      INNER JOIN AST.SaleItem SI
                                 ON S.SaleID = SI.SaleRef
                      JOIN GNR.Party P
                           ON P.PartyId = S.PartyRef

             GROUP BY S.SaleID, S.FiscalYearRef, s.Number, P.DLRef, s.CurrencyRef, S.Date, s.VoucherRef

             UNION ALL

             SELECT RecordType           = 36
                  , EntityID             = R.RepairId
                  , EntityItemID         = 0
                  ,                        R.FiscalYearRef
                  ,                        R.Number
                  , PartyDLRef           = R.DLRef
                  ,                        R.VoucherRef
                  , Description          = ''
                  , Amount               = SUM(RI.TotalCost)
                  ,                        0 CurrencyRef
                  , AmountInBaseCurrency = SUM(RI.TotalCost)
                  , Date                 = R.Date
                  , PartyRoleType        = 4
                  , CustomerRemainFactor = 0
                  , VendorRemainFactor   = 0
                  , BrokerFactor         = 0
                  , OtherFactor          = -1
                  , PettyCashFactor      = 0
             FROM AST.Repair R
                      INNER JOIN AST.RepairItem RI
                                 ON R.RepairId = RI.RepairRef
                                     AND NOT EXISTS(Select 1
                                                    from AST.vwRepairRelatedPurchaseInvoice AI
                                                    WHERE RI.RepairItemId = AI.RepairItemRef)
             GROUP BY R.RepairId, R.FiscalYearRef, R.Number, R.DLRef, R.VoucherRef, R.Date

             UNION ALL
             SELECT RecordType           = 10
                  , EntityID             = DCN.DebitCreditNoteID
                  , EntityItemID         = DCNI.DebitCreditNoteItemID
                  , DCN.FiscalYearRef
                  , DCN.Number
                  , PartyRef             = DCNI.CreditDLRef
                  , DCN.VoucherRef
                  , Description          = DCN.Description
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
                      JOIN GNR.DebitCreditNoteItem DCNI ON DCN.DebitCreditNoteID = DCNI.DebitCreditNoteRef
             WHERE DCNI.CreditType <> 5

             UNION ALL
             
             SELECT RecordType           = 11
                  , EntityID             = DCN.DebitCreditNoteID
                  , EntityItemID         = DCNI.DebitCreditNoteItemID
                  , DCN.FiscalYearRef
                  , DCN.Number
                  , PartyRef             = DCNI.DebitDLRef
                  , DCN.VoucherRef
                  , Description          = DCN.Description
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
                      JOIN GNR.DebitCreditNoteItem DCNI ON DCN.DebitCreditNoteID = DCNI.DebitCreditNoteRef

             UNION ALL

             SELECT RecordType           = 29
                  , EntityID             = -1
                  , EntityItemID         = 0
                  , POB.FiscalYearRef
                  , Number               = NULL
                  , PartyRef             = P.DLRef
                  , VoucherRef           = NULL
                  , Description          = NULL
                  , Amount               = NULL
                  , CurrencyRef          = @SystemCurrency
                  , AmountInBaseCurrency =
                 CASE
                     WHEN POB.OpeningBalanceType = 1 THEN POB.OpeningBalance
                     WHEN POB.OpeningBalanceType = 2 THEN -POB.OpeningBalance
                     END
                  , Date                 = NULL
                  , PartyRoleType        = 1
                  , CustomerRemainFactor = 1
                  , VendorRemainFactor   = 0
                  , BrokerFactor         = 0
                  , OtherFactor          = 0
                  , PettyCashFactor      = 0
             FROM GNR.PartyOpeningBalance POB
                      JOIN GNR.Party P ON POB.PartyRef = P.PartyID
             WHERE POB.Type = 0
               AND POB.OpeningBalance <> 0
               AND POB.FiscalYearRef = @FiscalYearRef

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
                  , CurrencyRef          = @SystemCurrency
                  , AmountInBaseCurrency =
                 CASE
                     WHEN POB.OpeningBalanceType = 1 THEN POB.OpeningBalance
                     WHEN POB.OpeningBalanceType = 2 THEN -POB.OpeningBalance
                     END
                  , Date                 = NULL
                  , PartyRoleType        = 2
                  , CustomerRemainFactor = 0
                  , VendorRemainFactor   = 1
                  , BrokerFactor         = 0
                  , OtherFactor          = 0
                  , PettyCashFactor      = 0
             FROM GNR.PartyOpeningBalance POB
                      JOIN GNR.Party P ON POB.PartyRef = P.PartyID
             WHERE POB.Type = 1
               AND POB.OpeningBalance <> 0
               AND POB.FiscalYearRef = @FiscalYearRef

             UNION ALL

             SELECT RecordType           = 31
                  , EntityID             = -1
                  , EntityItemID         = 0
                  , POB.FiscalYearRef
                  , Number               = NULL
                  , PartyRef             = P.DLRef
                  , VoucherRef           = NULL
                  , Description          = NULL
                  , Amount               = NULL
                  , CurrencyRef          = @SystemCurrency
                  , AmountInBaseCurrency =
                 CASE
                     WHEN POB.OpeningBalanceType = 1 THEN POB.OpeningBalance
                     WHEN POB.OpeningBalanceType = 2 THEN -POB.OpeningBalance
                     END
                  , Date                 = NULL
                  , PartyRoleType        = 3
                  , CustomerRemainFactor = 0
                  , VendorRemainFactor   = 0
                  , BrokerFactor         = 1
                  , OtherFactor          = 0
                  , PettyCashFactor      = 0
             FROM GNR.PartyOpeningBalance POB
                      JOIN GNR.Party P ON POB.PartyRef = P.PartyID
             WHERE POB.Type = 2
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
                  , CurrencyRef          = @SystemCurrency
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
                      JOIN GNR.ShredItem SH ON SH.ShredRef = S.ShredId
             WHERE ([Key] IN (1, 2, 3, 6, 7, 8))
                OR ([Key] = 4 AND SH.ReceiptRef IS NOT NULL)
             GROUP BY S.ShredID, S.Number, S.DLRef, S.[Key], S.Date
             HAVING SUM(SH.InterestAmount) > 0
                 OR SUM(SH.PenaltyAmount) > 0

             UNION ALL

             SELECT RecordType           = 19
                  , EntityID             = S.ShredID
                  , EntityItemID         = 0
                  , FiscalYearRef        = (SELECT FY.FiscalYearId
                                            FROM FMK.FiscalYear FY
                                            WHERE S.Date >= FY.StartDate
                                              AND S.Date <= FY.EndDate)
                  , Number               = S.Number
                  , PartyRef             = S.DLRef
                  , VoucherRef           = NULL
                  , Description          = NULL
                  , Amount               = ISNULL(SUM(SH.Amount), 0)
                  , CurrencyRef          = @SystemCurrency
                  , AmountInBaseCurrency =ISNULL(SUM(SH.Amount), 0)
                  , Date                 = S.Date
                  , PartyRoleType        = 4
                  , CustomerRemainFactor = 0
                  , VendorRemainFactor   = 0
                  , BrokerFactor         = 0
                  , OtherFactor          = 1
                  , PettyCashFactor      = 0
             FROM GNR.ShredItem SH
                      JOIN GNR.Shred S ON S.ShredID = SH.ShredRef
             WHERE S.[Key] = 4
               AND SH.ReceiptRef IS NOT NULL
             GROUP BY S.ShredID, S.Number, S.DLRef, S.Date
             UNION ALL
             SELECT RecordType           = 17
                  , EntityID             = IPI.InventoryPurchaseInvoiceID
                  , EntityItemID         = 0
                  , IPI.FiscalYearRef
                  , IPI.Number
                  , PartyDLRef           = IPI.VendorDLRef
                  , VoucherRef           = IPI.AccountingVoucherRef
                  , Description
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
                  , Description          = IR.Description
                  , Amount               = (SELECT SUM(ISNULL(IRI.Price, 0) + ISNULL(IRI.Tax, 0) + ISNULL(IRI.Duty, 0))
                                            FROM INV.InventoryReceiptItem IRI
                                            WHERE IR.InventoryReceiptID = IRI.InventoryReceiptRef)
                  , CurrencyRef          = @SystemCurrency
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
                  , Description          = IR.Description
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
                  , Description          = IR.Description
                  , Amount               = (SELECT SUM((ISNULL(IRI.TransportDuty, 0) + ISNULL(IRI.TransportPrice, 0) +
                                                        ISNULL(IRI.TransportTax, 0)))
                                            FROM INV.InventoryReceiptItem IRI
                                            WHERE IR.InventoryReceiptID = IRI.InventoryReceiptRef)
                  , CurrencyRef          = @SystemCurrency
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
                       AND (IRI.TransportPrice <> 0 OR IRI.TransportTax <> 0 OR IRI.TransportDuty <> 0)
                 )
               AND IsReturn = 0
               AND IR.TransporterDLRef IS NOT NULL
             UNION ALL
             SELECT RecordType           = 37/*AssetPurchaseInvoice*/, EntityID = IPI.InventoryPurchaseInvoiceID
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
                  , PartyRoleType        = 4 /*Other*/
                  , CustomerRemainFactor = 0
                  , VendorRemainFactor   = 0
                  , BrokerFactor         = 0
                  , OtherFactor          = -1
                  , PettyCashFactor      = 0
             FROM INV.vwAssetPurchaseInvoice IPI
             WHERE 1 = 1

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
                  , CurrencyRef          = @SystemCurrency
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
             FROM (
                      SELECT RecordType           = 6
                           , EntityID             = PH.PaymentHeaderID
                           , EntityItemID         = 0
                           , PH.FiscalYearRef
                           , PH.Number
                           , PartyRef             = PH.DlRef
                           , PH.VoucherRef
                           , Description          = PH.Description
                           , Amount               = PH.Amount + ISNULL(PH.Discount, 0)
                          + ISNULL(
                                                            (
                                                                SELECT SUM(PC.Amount)
                                                                FROM RPA.PaymentCheque PC
                                                                WHERE PC.PaymentHeaderRef = PH.PaymentHeaderId
                                                                  AND PC.State IN (1, 2)
                                                            ), 0)
                          + ISNULL(
                                                            (
                                                                SELECT SUM(RC.Amount)
                                                                FROM RPA.PaymentChequeOther PCO
                                                                         JOIN RPA.ReceiptCheque RC ON RC.ReceiptChequeID = PCO.ReceiptChequeRef
                                                                WHERE PCO.PaymentHeaderRef = PH.PaymentHeaderID
                                                            ), 0)
                          + ISNULL(
                                                            (
                                                                SELECT SUM(PD.Amount)
                                                                FROM RPA.PaymentDraft PD
                                                                WHERE PD.PaymentHeaderRef = PH.PaymentHeaderId
                                                            ), 0)
                           , PH.CurrencyRef
                           , AmountInBaseCurrency = PH.AmountInBaseCurrency + ISNULL(PH.DiscountInBaseCurrency, 0)
                          + ISNULL(
                                                            (
                                                                SELECT SUM(PC.AmountInBaseCurrency)
                                                                FROM RPA.PaymentCheque PC
                                                                WHERE PC.PaymentHeaderRef = PH.PaymentHeaderId
                                                                  AND PC.State IN (1, 2)
                                                            ), 0)
                          + ISNULL(
                                                            (
                                                                SELECT SUM(RC.AmountInBaseCurrency)
                                                                FROM RPA.PaymentChequeOther PCO
                                                                         JOIN RPA.ReceiptCheque RC ON RC.ReceiptChequeID = PCO.ReceiptChequeRef
                                                                WHERE PCO.PaymentHeaderRef = PH.PaymentHeaderID
                                                            ), 0)
                          + ISNULL(
                                                            (
                                                                SELECT SUM(PD.AmountInBaseCurrency)
                                                                FROM RPA.PaymentDraft PD
                                                                WHERE PD.PaymentHeaderRef = PH.PaymentHeaderId
                                                            ), 0)
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
                         OR (PH.Amount <> 0)
                  ) a
             WHERE AmountInBaseCurrency > 0

             UNION ALL

             SELECT RecordType           = 7
                  , EntityId             = RefundChequeId
                  , EntityItemID         = RCI.RefundChequeItemID
                  ,                        RFC.FiscalYearRef
                  ,                        RFC.Number
                  , PartyRef             = RFC.DlRef
                  ,                        RFC.VoucherRef
                  , Description          = RFC.Description 
                  , Amount               =
                                           (
                                               SELECT PC.Amount
                                               FROM RPA.RefundChequeItem RCI1
                                                        JOIN RPA.PaymentCheque PC1 ON PC1.PaymentChequeId = RCI1.PaymentChequeRef
                                               WHERE RCI1.RefundChequeItemId = RCI.RefundChequeItemId
                                           )
                  ,                        PC.CurrencyRef
                  , AmountInBaseCurrency =
                                           (
                                               SELECT AmountInBaseCurrency
                                               FROM RPA.RefundChequeItem RCI1
                                                        JOIN RPA.PaymentCheque PC1 ON PC1.PaymentChequeId = RCI1.PaymentChequeRef
                                               WHERE RCI1.RefundChequeItemId = RCI.RefundChequeItemId
                                           )
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
                      JOIN RPA.RefundCheque RFC ON RFC.RefundChequeId = RCI.RefundChequeRef
                      JOIN RPA.PaymentCheque PC ON PC.PaymentChequeId = RCI.PaymentChequeRef
                      JOIN RPA.PaymentHeader PH ON PC.PaymentHeaderRef = PH.PaymentHeaderId
             WHERE RFC.Type = 2 AND PH.State = 4

             UNION ALL

             SELECT *
             FROM (
                      SELECT RecordType           = 9
                           , EntityID             = RC.RefundChequeId
                           , EntityItemID         = RCI.RefundChequeItemId
                           ,                        RC.FiscalYearRef
                           ,                        RC.Number
                           , PartyRef             = RC.DlRef
                           ,                        RC.VoucherRef
                           , Description          = RC.Description 
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
                        AND PH.State <> 4
                  ) a
             WHERE a.AmountInBaseCurrency > 0
             UNION ALL

             SELECT *
             FROM (
                      SELECT RecordType           = 3
                           , EntityID             = RH.ReceiptHeaderID
                           , EntityItemID         = 0
                           , RH.FiscalYearRef
                           , RH.Number
                           , PartyRef             = RH.DlRef
                           , RH.VoucherRef
                           , Description          = RH.Description
                           , Amount               = RH.Amount + RH.Discount
                          + ISNULL(
                                                            (
                                                                SELECT SUM(RC.Amount)
                                                                FROM RPA.ReceiptCheque RC
                                                                WHERE RC.ReceiptHeaderRef = RH.ReceiptHeaderID
                                                                  AND (
                                                                        (RH.FiscalYearRef <> @FiscalYearRef And
                                                                         RC.State IN (1, 2, 4, 8, 16, 32, 64)
                                                                            )
                                                                        OR
                                                                        (RH.FiscalYearRef = @FilterFiscalYear AND
                                                                         ((RC.State IN (1, 2, 8) AND @containsCheque = 1) OR
                                                                          RC.State IN (4, 16, 32, 64))
                                                                            )
                                                                    )
                                                            ), 0)
                          + ISNULL(
                                                            (
                                                                SELECT SUM(RD.Amount)
                                                                FROM RPA.ReceiptDraft RD
                                                                WHERE RD.ReceiptHeaderRef = RH.ReceiptHeaderID
                                                            ), 0)
                          + ISNULL(
                                                            (
                                                                SELECT SUM(Amount)
                                                                FROM RPA.ReceiptPos RP
                                                                WHERE RP.ReceiptHeaderRef = RH.ReceiptHeaderId
                                                            ), 0)
                          + ISNULL(
                                                            (
                                                                SELECT SUM(Amount)
                                                                FROM RPA.ReceiptPettyCash RPC
                                                                WHERE RPC.ReceiptHeaderRef = RH.ReceiptHeaderId
                                                            ), 0)

                           , RH.CurrencyRef
                           , AmountInBaseCurrency = RH.AmountInBaseCurrency + ISNULL(RH.DiscountInBaseCurrency, 0)
                          + ISNULL(
                                                            (
                                                                SELECT SUM(RC.AmountInBaseCurrency)
                                                                FROM RPA.ReceiptCheque RC
                                                                WHERE RC.ReceiptHeaderRef = RH.ReceiptHeaderID
                                                                  AND (
                                                                        (RH.FiscalYearRef <> @FiscalYearRef And
                                                                         RC.State IN (1, 2, 4, 8, 16, 32, 64)
                                                                            )
                                                                        OR
                                                                        (RH.FiscalYearRef = @FilterFiscalYear AND
                                                                         ((RC.State IN (1, 2, 8) AND @containsCheque = 1) OR
                                                                          RC.State IN (4, 16, 32, 64))
                                                                            )
                                                                    )
                                                            ), 0)
                          + ISNULL(
                                                            (
                                                                SELECT SUM(RD.AmountInBaseCurrency)
                                                                FROM RPA.ReceiptDraft RD
                                                                WHERE RD.ReceiptHeaderRef = RH.ReceiptHeaderID
                                                            ), 0)
                          + ISNULL(
                                                            (
                                                                SELECT SUM(AmountInBaseCurrency)
                                                                FROM RPA.ReceiptPos RP
                                                                WHERE RP.ReceiptHeaderRef = RH.ReceiptHeaderId
                                                            ), 0)
                          + ISNULL(
                                                            (
                                                                SELECT SUM(AmountInBaseCurrency)
                                                                FROM RPA.ReceiptPettyCash RPC
                                                                WHERE RPC.ReceiptHeaderRef = RH.ReceiptHeaderId
                                                            ), 0)

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
                        AND RH.Type IN (1, 2, 8, 16, 32, 64)
                  ) a
             WHERE a.AmountInBaseCurrency > 0

             UNION ALL

             SELECT *
             FROM (
                      SELECT RecordType           = 3
                           , EntityID             = RH.ReceiptHeaderID
                           , EntityItemID         = 0
                           , RH.FiscalYearRef
                           , RH.Number
                           , PartyRef             = RH.DlRef
                           , RH.VoucherRef
                           , Description          = RH.Description
                           , Amount               = -ISNULL(
                              (
                                  SELECT SUM(RC.Amount)
                                  FROM RPA.ReceiptCheque RC
                                  WHERE RC.ReceiptHeaderRef = RH.ReceiptHeaderID
                                    AND RC.State IN (1, 2, 8)
                              ), 0)
                           , RH.CurrencyRef
                           , AmountInBaseCurrency = -ISNULL(
                              (
                                  SELECT SUM(RC.AmountInBaseCurrency)
                                  FROM RPA.ReceiptCheque RC
                                  WHERE RC.ReceiptHeaderRef = RH.ReceiptHeaderID
                                    AND RC.State IN (1, 2, 8)
                              ), 0)
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
                        AND RH.FiscalYearRef = @FiscalYearRef
                  ) a
             WHERE a.AmountInBaseCurrency <> 0
             UNION ALL

             SELECT RecordType           = 5
                  , EntityId             = RefundChequeId
                  , EntityItemID         = RCI.RefundChequeItemID
                  ,                        RFC.FiscalYearRef
                  ,                        RFC.Number
                  , PartyRef             = RFC.DlRef
                  ,                        RFC.VoucherRef
                  , Description          = RFC.Description 
                  , Amount               =
                                           (
                                               SELECT RC.Amount
                                               FROM RPA.RefundChequeItem RCI1
                                                        JOIN RPA.ReceiptCheque RC1 ON RC1.ReceiptChequeId = RCI1.ReceiptChequeRef
                                               WHERE RCI1.RefundChequeItemId = RCI.RefundChequeItemId
                                           )
                  ,                        RC.CurrencyRef
                  , AmountInBaseCurrency =
                                           (
                                               SELECT AmountInBaseCurrency
                                               FROM RPA.RefundChequeItem RCI1
                                                        JOIN RPA.ReceiptCheque RC1 ON RC1.ReceiptChequeId = RCI1.ReceiptChequeRef
                                               WHERE RCI1.RefundChequeItemId = RCI.RefundChequeItemId
                                           )
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
                      JOIN RPA.RefundCheque RFC ON RFC.RefundChequeId = RCI.RefundChequeRef
                      JOIN RPA.ReceiptCheque RC ON RC.ReceiptChequeId = RCI.ReceiptChequeRef
                      JOIN RPA.ReceiptHeader RH ON RC.ReceiptHeaderRef = RH.ReceiptHeaderId
             WHERE RFC.Type = 1
               AND RH.State = 4

             UNION ALL

             SELECT *
             FROM (
                      SELECT RecordType           = 8
                           , EntityID             = RC.RefundChequeId
                           , EntityItemID         = RCI.RefundChequeItemId
                           ,                        RC.FiscalYearRef
                           ,                        RC.Number
                           , PartyRef             = RC.DlRef
                           ,                        RC.VoucherRef
                           , Description          = RC.Description 
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
                      WHERE RC.Type = 1 /*استرداد چك دريافتني*/AND RH.State <> 4
                  ) a
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
                                               WHEN (a.PaymentType = 64 OR a.PaymentType = 2048) THEN 5
                 END
                  , CustomerRemainFactor = CASE WHEN a.PaymentType = 1 THEN -1 ELSE 0 END
                  , VendorRemainFactor   = CASE WHEN a.PaymentType = 256 THEN -1 ELSE 0 END
                  , BrokerFactor         = CASE WHEN a.PaymentType = 128 THEN -1 ELSE 0 END
                  , OtherFactor          = CASE WHEN a.PaymentType = 2 THEN -1 ELSE 0 END
                  , PettyCashFactor      = CASE WHEN (A.PaymentType = 64 OR A.PaymentType = 2048) THEN -1 ELSE 0 END
             FROM (
                      SELECT RecordType           = 4
                           , EntityID             = RC.RefundChequeId
                           , EntityItemID         = RCI.RefundChequeItemId
                           ,                        RC.FiscalYearRef
                           ,                        RC.Number
                           , PartyRef             = RC.DlRef
                           ,                        RC.VoucherRef
                           , Description          = RC.Description 
                           , Amount               = RCI.Amount
                           ,                        RC.CurrencyRef
                           , AmountInBaseCurrency = RCI.AmountInBaseCurrency
                           , Date                 = RC.[Date]
                           , PaymentType          = (
                                                        SELECT [PH].[Type]
                                                        FROM RPA.ReceiptChequeHistory RCH
                                                            JOIN RPA.ReceiptChequeHistory PRCH
                                                                 ON PRCH.ReceiptChequeHistoryId = RCH.ReceiptChequeHistoryRef
                                                            JOIN RPA.PaymentChequeOther PCO
                                                                 ON PCO.PaymentChequeOtherId = PRCH.PaymentChequeOtherRef
                                                            JOIN RPA.PaymentHeader PH ON PH.PaymentHeaderId = PCO.PaymentHeaderRef
                                                        WHERE RCH.ReceiptChequeRef = RCI.ReceiptChequeRef
                                                          AND RCH.RefundChequeItemRef = RCI.RefundChequeItemID)
                           , CustomerRemainFactor = CASE WHEN RH.[Type] = 1 THEN -1 ELSE 0 END
                           , VendorRemainFactor   = CASE WHEN RH.[Type] = 16 THEN -1 ELSE 0 END
                           , BrokerFactor         = CASE WHEN RH.[Type] = 8 THEN -1 ELSE 0 END
                           , OtherFactor          = CASE WHEN RH.[Type] = 2 THEN -1 ELSE 0 END
                           , PettyCashFactor      = CASE WHEN (RH.[Type] = 64 
                                                                OR 
                                                                (
                                                                    SELECT [PH].[Type]
                                                                        FROM RPA.ReceiptChequeHistory RCH
                                                                            JOIN RPA.ReceiptChequeHistory PRCH
                                                                                 ON PRCH.ReceiptChequeHistoryId = RCH.ReceiptChequeHistoryRef
                                                                            JOIN RPA.PaymentChequeOther PCO
                                                                                 ON PCO.PaymentChequeOtherId = PRCH.PaymentChequeOtherRef
                                                                            JOIN RPA.PaymentHeader PH ON PH.PaymentHeaderId = PCO.PaymentHeaderRef
                                                                        WHERE RCH.ReceiptChequeRef = RCI.ReceiptChequeRef
                                                                          AND RCH.RefundChequeItemRef = RCI.RefundChequeItemID
                                                                )= 2048) THEN -1 ELSE 0 END
                      FROM RPA.RefundCheque RC
                                JOIN RPA.vwRefundChequeItem RCI ON RC.RefundChequeId = RCI.RefundChequeRef
                                JOIN RPA.ReceiptHeader RH ON RH.ReceiptHeaderId = RCI.ReceiptHeaderRef
                      WHERE RC.[Type] = 4 /*استرداد برگشت چك خرج شده*/
                  ) a
             WHERE a.AmountInBaseCurrency > 0
             UNION ALL
             SELECT RecordType           = 1
                  , EntityID             = I.InvoiceID
                  , EntityItemID         = 0
                  , I.FiscalYearRef
                  , I.Number
                  , PartyDLRef           = P.DLRef
                  , I.VoucherRef
                  , Description          = I.Description
                  , Amount               = I.NetPrice
                  , CurrencyRef
                  , AmountInBaseCurrency = I.NetPriceInBaseCurrency
                  , Date                 = I.Date
                  , PartyRoleType        = 1
                  , CustomerRemainFactor = 1
                  , VendorRemainFactor   = 0
                  , BrokerFactor         = 0
                  , OtherFactor          = 0
                  , PettyCashFactor      = 0
             FROM SLS.Invoice I
                      JOIN GNR.Party P ON P.PartyId = I.CustomerPartyRef
             WHERE I.State = 1
             UNION ALL
             SELECT RecordType           = 15
                  , EntityID             = I.InvoiceID
                  , EntityItemID         = 0
                  , I.FiscalYearRef
                  , I.Number
                  , PartyRef             = P.DLRef
                  , I.VoucherRef
                  , I.Description
                  , Amount               = IB.Commission
                  , CurrencyRef          = I.CurrencyRef
                  , AmountInBaseCurrency = IB.CommissionInBaseCurrency
                  , Date                 = I.Date
                  , PartyRoleType        = 3
                  , CustomerRemainFactor = 0
                  , VendorRemainFactor   = 0
                  , BrokerFactor         = -1
                  , OtherFactor          = 0
                  , PettyCashFactor      = 0
             FROM SLS.InvoiceBroker IB
                      JOIN SLS.Invoice I ON IB.InvoiceRef = I.InvoiceId
                      JOIN GNR.Party P ON P.PartyId = IB.PartyRef
             WHERE I.State = 1
             UNION ALL

             SELECT RecordType           = 33
                  , EntityID             = cc.CommissionCalculationID
                  , EntityItemID         = 0
                  , cc.FiscalYearRef
                  , Number               = NULL
                  , PartyRef             = P.DLRef
                  , VoucherRef           = cc.AccountingVoucherRef
                  , Description          = cc.CommissionTitle
                  , Amount               = cc.Amount
                  , CurrencyRef          = @SystemCurrency
                  , AmountInBaseCurrency = cc.Amount
                  , Date                 = cc.ToDate
                  , PartyRoleType        = 3
                  , CustomerRemainFactor = 0
                  , VendorRemainFactor   = 0
                  , BrokerFactor         = -1
                  , OtherFactor          = 0
                  , PettyCashFactor      = 0
             FROM SLS.vwCommissionCalculation cc
                      LEFT JOIN GNR.Party P ON P.PartyId = cc.BrokerPartyRef
             
             UNION ALL

             SELECT RecordType           =2
                  , EntityID             = RI.ReturnedInvoiceID
                  , EntityItemID         = 0
                  , RI.FiscalYearRef
                  , RI.Number
                  , PartyRef             = P.DLRef
                  , RI.VoucherRef
                  , Description          = RI.Description
                  , Amount               = RI.NetPrice
                  , CurrencyRef
                  , AmountInBaseCurrency = RI.NetPriceInBaseCurrency
                  , Date                 = RI.Date
                  , PartyRoleType        = 1
                  , CustomerRemainFactor = -1
                  , VendorRemainFactor   = 0
                  , BrokerFactor         = 0
                  , OtherFactor          = 0
                  , PettyCashFactor      = 0
             FROM SLS.ReturnedInvoice RI
                      JOIN GNR.Party P ON P.PartyId = RI.CustomerPartyRef

             UNION ALL

             SELECT RecordType           = 16
                  , EntityID             = RI.ReturnedInvoiceId
                  , EntityItemID         = 0
                  , RI.FiscalYearRef
                  , RI.Number
                  , PartyRef             = P.DLRef
                  , RI.VoucherRef
                  , RI.Description
                  , Amount               = IB.Commission
                  , CurrencyRef          = RI.CurrencyRef
                  , AmountInBaseCurrency = IB.CommissionInBaseCurrency
                  , Date                 = RI.Date
                  , PartyRoleType        = 3
                  , CustomerRemainFactor = 0
                  , VendorRemainFactor   = 0
                  , BrokerFactor         = 1
                  , OtherFactor          = 0
                  , PettyCashFactor      = 0
             FROM SLS.ReturnedInvoiceBroker IB
                      JOIN SLS.ReturnedInvoice RI ON IB.ReturnedInvoiceRef = RI.ReturnedInvoiceId
                      JOIN GNR.Party P ON P.PartyId = IB.PartyRef

             UNION ALL

			 SELECT RecordType           = 46
                  , EntityID             = RH.ReceiptHeaderId
                  , EntityItemID         = 0
                  , FiscalYearRef        = RH.FiscalYearRef
                  , Number               = RH.Number
                  , PartyRef             = PT.DLRef
                  , VoucherRef           = RH.VoucherRef
                  , Description          = RPC.[Description]
                  , Amount               = RPC.Amount
                  , CurrencyRef          = RPC.CurrencyRef
                  , AmountInBaseCurrency = RPC.AmountInBaseCurrency
                  , Date                 = RH.[Date]
                  , PartyRoleType        = 5
                  , CustomerRemainFactor = 0
                  , VendorRemainFactor   = 0
                  , BrokerFactor         = 0
                  , OtherFactor          = 0
                  , PettyCashFactor      = 1
               FROM RPA.ReceiptPettyCash RPC
               INNER JOIN RPA.PettyCash PTC ON RPC.PettyCashRef = PTC.PettyCashId
               INNER JOIN RPA.ReceiptHeader RH ON RPC.ReceiptHeaderRef = RH.ReceiptHeaderId
               INNER JOIN GNR.Party PT ON PTC.PartyRef = PT.PartyId
			   WHERE (PT.DLRef = @PartyRef OR @PartyRef = -1)
             
             UNION ALL

               SELECT RecordType           = 45
                  , EntityID             = PTB.PettyCashBillId
                  , EntityItemID         = 0
                  , FiscalYearRef        = PTB.FiscalYearRef
                  , Number               = PTB.Number
                  , PartyRef             = PT.DLRef
                  , VoucherRef           = PTB.VoucherRef
                  , Description          = PTB.[Description]
                  , Amount               = PTB.TotalAmount
                  , CurrencyRef          = PTC.CurrencyRef
                  , AmountInBaseCurrency = PTB.TotalAmountInBaseCurrency
                  , Date                 = PTB.[Date]
                  , PartyRoleType        = 5
                  , CustomerRemainFactor = 0
                  , VendorRemainFactor   = 0
                  , BrokerFactor         = 0
                  , OtherFactor          = 0
                  , PettyCashFactor      = -1
               FROM RPA.PettyCashBill PTB
               INNER JOIN RPA.PettyCash PTC ON PTB.PettyCashRef = PTC.PettyCashId
               INNER JOIN GNR.Party PT ON PTC.PartyRef = PT.PartyId
               WHERE PTB.[State] = 2
               
             UNION ALL

               SELECT RecordType           = 44
                  , EntityID             = 0
                  , EntityItemID         = 0
                  , FiscalYearRef        = @FilterFiscalYear
                  , Number               = 0
                  , PartyRef             = PT.DLRef
                  , VoucherRef           = 0
                  , Description          = NULL
                  , Amount               = PTC.FirstAmount
                  , CurrencyRef          = PTC.CurrencyRef
                  , AmountInBaseCurrency = ROUND(PTC.Rate * PTC.FirstAmount, CU.PrecisionCount)
                  , Date                 = NULL
                  , PartyRoleType        = 5
                  , CustomerRemainFactor = 0
                  , VendorRemainFactor   = 0
                  , BrokerFactor         = 0
                  , OtherFactor          = 0
                  , PettyCashFactor      = 1
               FROM RPA.PettyCash PTC
               INNER JOIN GNR.Currency CU ON PTC.CurrencyRef = CU.CurrencyID
               INNER JOIN GNR.Party PT ON PTC.PartyRef = PT.PartyId
               WHERE (@PettyCashInstallFiscalYear = @FilterFiscalYear) AND PTC.FirstAmount > 0
         ) AllData
    WHERE @PartyRef = -1
       OR PartyRef = @PartyRef
END
