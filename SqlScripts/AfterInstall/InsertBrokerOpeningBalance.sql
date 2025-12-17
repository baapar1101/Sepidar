
IF NOT EXISTS (SELECT
    *
  FROM GNR.PartyOpeningBalance
  WHERE Type = 2)
BEGIN

  DECLARE @FirstBrokerFiscalYear int,
          @PreviousFiscalYear int,
          @LastCloseSaleFiscalYear int,
          @EndDate datetime


  SELECT TOP 1
    @LastCloseSaleFiscalYear = Y.FiscalYearId
  FROM GNR.[vwClosingOperation] Clo
  INNER JOIN FMK.FiscalYear Y
    ON Clo.FiscalYearRef = Y.FiscalYearId
  WHERE ClosingGroup = 4
  AND State = 1
  ORDER BY Y.FiscalYearId DESC
  IF (@LastCloseSaleFiscalYear > 0)
  BEGIN
    SELECT TOP 1
      @FirstBrokerFiscalYear = FiscalYearId
    FROM FMK.FiscalYear
    WHERE FiscalYearId > @LastCloseSaleFiscalYear
    ORDER BY FiscalYearId ASC

    DECLARE @SystemCurrency int

    SELECT
      @EndDate = EndDate
    FROM FMK.FiscalYear
    WHERE FiscalYearId = @LastCloseSaleFiscalYear
    SELECT
      @SystemCurrency = Value
    FROM fmk.Configuration
    WHERE [key] = 'SystemCurrency'
    IF (@SystemCurrency = 0)
      SET @SystemCurrency = 1;

    DECLARE @ToDate datetime,
            @ContainsCheque bit,
            @FiscalYearRef int



    SELECT
      @ToDate = @EndDate,
      @ContainsCheque = 1,
      @FiscalYearRef = @LastCloseSaleFiscalYear



    IF OBJECT_ID('tempdb.dbo.#t', 'U') IS NOT NULL
      DROP TABLE #t;

    IF OBJECT_ID('tempdb.dbo.#p', 'U') IS NOT NULL
      DROP TABLE #p;

    SELECT
      * INTO #t
    FROM (SELECT
      RecordType = 10,
      EntityID = DCN.DebitCreditNoteID,
      EntityItemID = DCNI.DebitCreditNoteItemID,
      DCN.FiscalYearRef,
      DCN.Number,
      PartyRef = DCNI.CreditDLRef,
      DCN.VoucherRef,
      Description = DCNI.Description,
      Amount = DCNI.Amount,
      CurrencyRef,
      AmountInBaseCurrency = DCNI.AmountInBaseCurrency,
      Date = DCN.Date,
      PartyRoleType =
                     CASE
                       WHEN DCNI.CreditType = 2 THEN 1
                       WHEN DCNI.CreditType = 1 THEN 2
                       WHEN DCNI.CreditType = 3 THEN 4
                       WHEN DCNI.CreditType = 4 THEN 3
                     END,
      CustomerRemainFactor =
                            CASE
                              WHEN DCNI.CreditType = 2 THEN -1
                              ELSE 0
                            END,
      VendorRemainFactor =
                          CASE
                            WHEN DCNI.CreditType = 1 THEN -1
                            ELSE 0
                          END,
      BrokerFactor =
                    CASE
                      WHEN DCNI.CreditType = 4 THEN -1
                      ELSE 0
                    END,
      OtherFactor =
                   CASE
                     WHEN DCNI.CreditType = 3 THEN -1
                     ELSE 0
                   END
    FROM GNR.DebitCreditNote DCN
    JOIN GNR.DebitCreditNoteItem DCNI
      ON DCN.DebitCreditNoteID = DCNI.DebitCreditNoteRef
    UNION ALL
    SELECT
      RecordType = 11,
      EntityID = DCN.DebitCreditNoteID,
      EntityItemID = DCNI.DebitCreditNoteItemID,
      DCN.FiscalYearRef,
      DCN.Number,
      PartyRef = DCNI.DebitDLRef,
      DCN.VoucherRef,
      Description = DCNI.Description,
      Amount = DCNI.Amount,
      CurrencyRef,
      AmountInBaseCurrency = DCNI.AmountInBaseCurrency,
      Date = DCN.Date,
      PartyRoleType =
                     CASE
                       WHEN DCNI.DebitType = 2 THEN 1
                       WHEN DCNI.DebitType = 1 THEN 2
                       WHEN DCNI.DebitType = 3 THEN 4
                       WHEN DCNI.DebitType = 4 THEN 3
                     END,
      CustomerRemainFactor =
                            CASE
                              WHEN DCNI.DebitType = 2 THEN 1
                              ELSE 0
                            END,
      VendorRemainFactor =
                          CASE
                            WHEN DCNI.DebitType = 1 THEN 1
                            ELSE 0
                          END,
      BrokerFactor =
                    CASE
                      WHEN DCNI.DebitType = 4 THEN 1
                      ELSE 0
                    END,
      OtherFactor =
                   CASE
                     WHEN DCNI.DebitType = 3 THEN 1
                     ELSE 0
                   END
    FROM GNR.DebitCreditNote DCN
    JOIN GNR.DebitCreditNoteItem DCNI
      ON DCN.DebitCreditNoteID = DCNI.DebitCreditNoteRef
    UNION ALL

    SELECT
      RecordType = 31,
      EntityID = -1,
      EntityItemID = 0,
      POB.FiscalYearRef,
      Number = NULL,
      PartyRef = P.DLRef,
      VoucherRef = NULL,
      Description = NULL,
      Amount = NULL,
      CurrencyRef = @SystemCurrency,
      AmountInBaseCurrency =
                            CASE
                              WHEN POB.OpeningBalanceType = 1 THEN POB.OpeningBalance
                              WHEN POB.OpeningBalanceType = 2 THEN -POB.OpeningBalance
                            END,
      Date = NULL,
      PartyRoleType = 3,
      CustomerRemainFactor = 0,
      VendorRemainFactor = 0,
      BrokerFactor = 1,
      OtherFactor = 0
    FROM GNR.PartyOpeningBalance POB
    JOIN GNR.Party P
      ON POB.PartyRef = P.PartyID
    WHERE POB.Type = 2
    AND POB.OpeningBalance <> 0
    AND POB.FiscalYearRef = @FiscalYearRef
    UNION ALL

    SELECT
      *
    FROM (SELECT
      RecordType = 6,
      EntityID = PH.PaymentHeaderID,
      EntityItemID = 0,
      PH.FiscalYearRef,
      PH.Number,
      PartyRef = PH.DlRef,
      PH.VoucherRef,
      Description = PH.Description,
      Amount = PH.Amount + ISNULL(PH.Discount, 0)
      + ISNULL((SELECT
        SUM(PC.Amount)
      FROM RPA.PaymentCheque PC
      WHERE PC.PaymentHeaderRef = PH.PaymentHeaderId
      AND PC.State IN (1, 2)), 0)
      + ISNULL((SELECT
        SUM(RC.Amount)
      FROM RPA.PaymentChequeOther PCO
      JOIN RPA.ReceiptCheque RC
        ON RC.ReceiptChequeID = PCO.ReceiptChequeRef
      WHERE PCO.PaymentHeaderRef = PH.PaymentHeaderID), 0)
      + ISNULL((SELECT
        SUM(PD.Amount)
      FROM RPA.PaymentDraft PD
      WHERE PD.PaymentHeaderRef = PH.PaymentHeaderId), 0),
      PH.CurrencyRef,
      AmountInBaseCurrency = PH.AmountInBaseCurrency + ISNULL(PH.DiscountInBaseCurrency, 0)
      + ISNULL((SELECT
        SUM(PC.AmountInBaseCurrency)
      FROM RPA.PaymentCheque PC
      WHERE PC.PaymentHeaderRef = PH.PaymentHeaderId
      AND PC.State IN (1, 2)), 0)
      + ISNULL((SELECT
        SUM(RC.AmountInBaseCurrency)
      FROM RPA.PaymentChequeOther PCO
      JOIN RPA.ReceiptCheque RC
        ON RC.ReceiptChequeID = PCO.ReceiptChequeRef
      WHERE PCO.PaymentHeaderRef = PH.PaymentHeaderID), 0)
      + ISNULL((SELECT
        SUM(PD.AmountInBaseCurrency)
      FROM RPA.PaymentDraft PD
      WHERE PD.PaymentHeaderRef = PH.PaymentHeaderId), 0),
      Date = PH.Date,
      PartyRoleType =
                     CASE
                       WHEN PH.Type = 1 THEN 1
                       WHEN PH.Type = 256 THEN 2
                       WHEN PH.Type = 2 THEN 4
                       WHEN PH.Type = 128 THEN 3
                     END,
      CustomerRemainFactor =
                            CASE
                              WHEN PH.Type = 1 THEN 1
                              ELSE 0
                            END,
      VendorRemainFactor =
                          CASE
                            WHEN PH.Type = 256 THEN 1
                            ELSE 0
                          END,
      BrokerFactor =
                    CASE
                      WHEN PH.Type = 128 THEN 1
                      ELSE 0
                    END,
      OtherFactor =
                   CASE
                     WHEN PH.Type = 2 THEN 1
                     ELSE 0
                   END
    FROM RPA.PaymentHeader PH
    WHERE (PH.State <> 4
    AND PH.Type <> 64)
    OR (PH.Amount <> 0)) a
    WHERE AmountInBaseCurrency > 0

    UNION ALL

    SELECT
      RecordType = 7,
      EntityId = RefundChequeId,
      EntityItemID = RCI.RefundChequeItemID,
      RFC.FiscalYearRef,
      RFC.Number,
      PartyRef = RFC.DlRef,
      RFC.VoucherRef,
      NULL AS Description,
      Amount = (SELECT
        PC.Amount
      FROM RPA.RefundChequeItem RCI1
      JOIN RPA.PaymentCheque PC1
        ON PC1.PaymentChequeId = RCI1.PaymentChequeRef
      WHERE RCI1.RefundChequeItemId = RCI.RefundChequeItemId),
      PC.CurrencyRef,
      AmountInBaseCurrency = (SELECT
        AmountInBaseCurrency
      FROM RPA.RefundChequeItem RCI1
      JOIN RPA.PaymentCheque PC1
        ON PC1.PaymentChequeId = RCI1.PaymentChequeRef
      WHERE RCI1.RefundChequeItemId = RCI.RefundChequeItemId),
      RFC.Date,
      PartyRoleType =
                     CASE
                       WHEN PH.Type = 1 THEN 1
                       WHEN PH.Type = 256 THEN 2
                       WHEN PH.Type = 2 THEN 4
                       WHEN PH.Type = 128 THEN 3
                     END,
      CustomerRemainFactor =
                            CASE
                              WHEN PH.Type = 1 THEN -1
                              ELSE 0
                            END,
      VendorRemainFactor =
                          CASE
                            WHEN PH.Type = 256 THEN -1
                            ELSE 0
                          END,
      BrokerFactor =
                    CASE
                      WHEN PH.Type = 128 THEN -1
                      ELSE 0
                    END,
      OtherFactor =
                   CASE
                     WHEN PH.Type = 2 THEN -1
                     ELSE 0
                   END
    FROM RPA.RefundChequeItem RCI
    JOIN RPA.RefundCheque RFC
      ON RFC.RefundChequeId = RCI.RefundChequeRef
    JOIN RPA.PaymentCheque PC
      ON PC.PaymentChequeId = RCI.PaymentChequeRef
    JOIN RPA.PaymentHeader PH
      ON PC.PaymentHeaderRef = PH.PaymentHeaderId
    WHERE RFC.Type = 2
    AND PH.State = 4

    UNION ALL

    SELECT
      *
    FROM (SELECT
      RecordType = 9,
      EntityID = RC.RefundChequeId,
      EntityItemID = RCI.RefundChequeItemId,
      RC.FiscalYearRef,
      RC.Number,
      PartyRef = RC.DlRef,
      RC.VoucherRef,
      NULL Description,
      Amount = RCI.Amount,
      RC.CurrencyRef,
      AmountInBaseCurrency = RCI.AmountInBaseCurrency,
      Date = RC.Date,
      PartyRoleType =
                     CASE
                       WHEN PH.Type = 1 /*œ—Ì«›  «“ „‘ —Ì*/ THEN 1
                       WHEN PH.Type = 256 /*œ—Ì«›  «“  «„ÌÌ‰ ﬂ‰‰œÂ*/ THEN 2
                       WHEN PH.Type = 2 /*œ—Ì«›  «“ ”«Ì—*/ THEN 4
                       WHEN PH.Type = 128 /*Ê«”ÿ*/ THEN 3
                     END,
      CustomerRemainFactor =
                            CASE
                              WHEN PH.Type = 1 THEN -1
                              ELSE 0
                            END,
      VendorRemainFactor =
                          CASE
                            WHEN PH.Type = 256 THEN -1
                            ELSE 0
                          END,
      BrokerFactor =
                    CASE
                      WHEN PH.Type = 128 THEN -1
                      ELSE 0
                    END,
      OtherFactor =
                   CASE
                     WHEN PH.Type = 2 THEN -1
                     ELSE 0
                   END
    FROM RPA.RefundCheque RC
    JOIN RPA.vwRefundChequeItem RCI
      ON RC.RefundChequeId = RCI.RefundChequeRef
    JOIN RPA.PaymentHeader PH
      ON PH.PaymentHeaderId = RCI.PaymentHeaderRef
    WHERE RC.Type = 2 /*«” —œ«œ çﬂ Å—œ«Œ ‰Ì*/ AND PH.State <> 4) a
    WHERE a.AmountInBaseCurrency > 0
    UNION ALL

    SELECT
      *
    FROM (SELECT
      RecordType = 3,
      EntityID = RH.ReceiptHeaderID,
      EntityItemID = 0,
      RH.FiscalYearRef,
      RH.Number,
      PartyRef = RH.DlRef,
      RH.VoucherRef,
      Description = RH.Description,
      Amount = RH.Amount + RH.Discount
      + ISNULL((SELECT
        SUM(RC.Amount)
      FROM RPA.ReceiptCheque RC
      WHERE RC.ReceiptHeaderRef = RH.ReceiptHeaderID
      AND ((RC.State IN (1, 2, 8)
      AND @containsCheque = 1)
      OR (RC.State IN (4, 16, 32, 64)))), 0)
      + ISNULL((SELECT
        SUM(RD.Amount)
      FROM RPA.ReceiptDraft RD
      WHERE RD.ReceiptHeaderRef = RH.ReceiptHeaderID), 0)
      + ISNULL((SELECT
        SUM(Amount)
      FROM RPA.ReceiptPos RP
      WHERE RP.ReceiptHeaderRef = RH.ReceiptHeaderId), 0),
      RH.CurrencyRef,
      AmountInBaseCurrency = RH.AmountInBaseCurrency + ISNULL(RH.DiscountInBaseCurrency, 0)
      + ISNULL((SELECT
        SUM(RC.AmountInBaseCurrency)
      FROM RPA.ReceiptCheque RC
      WHERE RC.ReceiptHeaderRef = RH.ReceiptHeaderID
      AND ((RC.State IN (1, 2, 8)
      AND @containsCheque = 1)
      OR (RC.State IN (4, 16, 32, 64)))), 0)
      + ISNULL((SELECT
        SUM(RD.AmountInBaseCurrency)
      FROM RPA.ReceiptDraft RD
      WHERE RD.ReceiptHeaderRef = RH.ReceiptHeaderID), 0)
      + ISNULL((SELECT
        SUM(AmountInBaseCurrency)
      FROM RPA.ReceiptPos RP
      WHERE RP.ReceiptHeaderRef = RH.ReceiptHeaderId), 0),
      Date = RH.Date,
      PartyRoleType =
                     CASE
                       WHEN RH.Type = 1 THEN 1
                       WHEN RH.Type = 16 THEN 2
                       WHEN RH.Type = 2 THEN 4
                       WHEN RH.Type = 8 THEN 3
                     END,
      CustomerRemainFactor =
                            CASE
                              WHEN RH.Type = 1 THEN -1
                              ELSE 0
                            END,
      VendorRemainFactor =
                          CASE
                            WHEN RH.Type = 16 THEN -1
                            ELSE 0
                          END,
      BrokerFactor =
                    CASE
                      WHEN RH.Type = 8 THEN -1
                      ELSE 0
                    END,
      OtherFactor =
                   CASE
                     WHEN RH.Type = 2 THEN -1
                     ELSE 0
                   END
    FROM RPA.ReceiptHeader RH
    WHERE (RH.State <> 4)
    AND RH.Type IN (1, 2, 8, 16, 32)) a
    WHERE a.AmountInBaseCurrency > 0

    UNION ALL

    SELECT
      RecordType = 5,
      EntityId = RefundChequeId,
      EntityItemID = RCI.RefundChequeItemID,
      RFC.FiscalYearRef,
      RFC.Number,
      PartyRef = RFC.DlRef,
      RFC.VoucherRef,
      NULL AS Description,
      Amount = (SELECT
        RC.Amount
      FROM RPA.RefundChequeItem RCI1
      JOIN RPA.ReceiptCheque RC1
        ON RC1.ReceiptChequeId = RCI1.ReceiptChequeRef
      WHERE RCI1.RefundChequeItemId = RCI.RefundChequeItemId),
      RC.CurrencyRef,
      AmountInBaseCurrency = (SELECT
        AmountInBaseCurrency
      FROM RPA.RefundChequeItem RCI1
      JOIN RPA.ReceiptCheque RC1
        ON RC1.ReceiptChequeId = RCI1.ReceiptChequeRef
      WHERE RCI1.RefundChequeItemId = RCI.RefundChequeItemId),
      RFC.Date,
      PartyRoleType =
                     CASE
                       WHEN RH.Type = 1 THEN 1
                       WHEN RH.Type = 16 THEN 2
                       WHEN RH.Type = 2 THEN 4
                       WHEN RH.Type = 8 THEN 3
                     END,
      CustomerRemainFactor =
                            CASE
                              WHEN RH.Type = 1 THEN 1
                              ELSE 0
                            END,
      VendorRemainFactor =
                          CASE
                            WHEN RH.Type = 16 THEN 1
                            ELSE 0
                          END,
      BrokerFactor =
                    CASE
                      WHEN RH.Type = 8 THEN 1
                      ELSE 0
                    END,
      OtherFactor =
                   CASE
                     WHEN RH.Type = 2 THEN 1
                     ELSE 0
                   END
    FROM RPA.RefundChequeItem RCI
    JOIN RPA.RefundCheque RFC
      ON RFC.RefundChequeId = RCI.RefundChequeRef
    JOIN RPA.ReceiptCheque RC
      ON RC.ReceiptChequeId = RCI.ReceiptChequeRef
    JOIN RPA.ReceiptHeader RH
      ON RC.ReceiptHeaderRef = RH.ReceiptHeaderId
    WHERE RFC.Type = 1
    AND RH.State = 4

    UNION ALL

    SELECT
      *
    FROM (SELECT
      RecordType = 8,
      EntityID = RC.RefundChequeId,
      EntityItemID = RCI.RefundChequeItemId,
      RC.FiscalYearRef,
      RC.Number,
      PartyRef = RC.DlRef,
      RC.VoucherRef,
      NULL Description,
      Amount = RCI.Amount,
      RC.CurrencyRef,
      AmountInBaseCurrency = RCI.AmountInBaseCurrency,
      Date = RC.Date,
      PartyRoleType =
                     CASE
                       WHEN RH.Type = 1 /*œ—Ì«›  «“ „‘ —Ì*/ THEN 1
                       WHEN RH.Type = 16 /*œ—Ì«›  «“  «„ÌÌ‰ ﬂ‰‰œÂ*/ THEN 2
                       WHEN RH.Type = 2 /*œ—Ì«›  «“ ”«Ì—*/ THEN 4
                       WHEN RH.Type = 8 /*œ—Ì«›  «“ Ê«”ÿ*/ THEN 3
                     END,
      CustomerRemainFactor =
                            CASE
                              WHEN RH.Type = 1 THEN 1
                              ELSE 0
                            END,
      VendorRemainFactor =
                          CASE
                            WHEN RH.Type = 16 THEN 1
                            ELSE 0
                          END,
      BrokerFactor =
                    CASE
                      WHEN RH.Type = 8 THEN 1
                      ELSE 0
                    END,
      OtherFactor =
                   CASE
                     WHEN RH.Type = 2 THEN 1
                     ELSE 0
                   END
    FROM RPA.RefundCheque RC
    JOIN RPA.vwRefundChequeItem RCI
      ON RC.RefundChequeId = RCI.RefundChequeRef
    JOIN RPA.ReceiptHeader RH
      ON RH.ReceiptHeaderId = RCI.ReceiptHeaderRef
    WHERE RC.Type = 1 /*«” —œ«œ çﬂ œ—Ì«› ‰Ì*/ AND RH.State <> 4) a
    WHERE a.AmountInBaseCurrency > 0
    UNION ALL

    SELECT
      a.RecordType,
      a.EntityID,
      a.EntityItemID,
      a.FiscalYearRef,
      a.Number,
      a.PartyRef,
      a.VoucherRef,
      a.Description,
      a.Amount,
      a.CurrencyRef,
      a.AmountInBaseCurrency,
      a.Date,
      PartyRoleType =
                     CASE
                       WHEN a.PaymentType = 1 THEN 1
                       WHEN a.PaymentType = 256 THEN 2
                       WHEN a.PaymentType = 2 THEN 4
                       WHEN a.PaymentType = 128 THEN 3
                     END,
      CustomerRemainFactor =
                            CASE
                              WHEN a.PaymentType = 1 THEN -1
                              ELSE 0
                            END,
      VendorRemainFactor =
                          CASE
                            WHEN a.PaymentType = 256 THEN -1
                            ELSE 0
                          END,
      BrokerFactor =
                    CASE
                      WHEN a.PaymentType = 128 THEN -1
                      ELSE 0
                    END,
      OtherFactor =
                   CASE
                     WHEN a.PaymentType = 2 THEN -1
                     ELSE 0
                   END
    FROM (SELECT
      RecordType = 4,
      EntityID = RC.RefundChequeId,
      EntityItemID = RCI.RefundChequeItemId,
      RC.FiscalYearRef,
      RC.Number,
      PartyRef = RC.DlRef,
      RC.VoucherRef,
      NULL Description,
      Amount = RCI.Amount,
      RC.CurrencyRef,
      AmountInBaseCurrency = RCI.AmountInBaseCurrency,
      Date = RC.Date,
      PaymentType = (SELECT
        PH.Type
      FROM RPA.ReceiptChequeHistory RCH
      JOIN RPA.ReceiptChequeHistory PRCH
        ON PRCH.ReceiptChequeHistoryId = RCH.ReceiptChequeHistoryRef
      JOIN RPA.PaymentChequeOther PCO
        ON PCO.PaymentChequeOtherId = PRCH.PaymentChequeOtherRef
      JOIN RPA.PaymentHeader PH
        ON PH.PaymentHeaderId = PCO.PaymentHeaderRef
      WHERE RCH.ReceiptChequeRef = RCI.ReceiptChequeRef
      AND RCH.RefundChequeItemRef = RCI.RefundChequeItemID),
      CustomerRemainFactor =
                            CASE
                              WHEN RH.Type = 1 THEN -1
                              ELSE 0
                            END,
      VendorRemainFactor =
                          CASE
                            WHEN RH.Type = 16 THEN -1
                            ELSE 0
                          END,
      BrokerFactor =
                    CASE
                      WHEN RH.Type = 8 THEN -1
                      ELSE 0
                    END,
      OtherFactor =
                   CASE
                     WHEN RH.Type = 2 THEN -1
                     ELSE 0
                   END
    FROM RPA.RefundCheque RC
    JOIN RPA.vwRefundChequeItem RCI
      ON RC.RefundChequeId = RCI.RefundChequeRef
    JOIN RPA.ReceiptHeader RH
      ON RH.ReceiptHeaderId = RCI.ReceiptHeaderRef
    WHERE RC.Type = 4 /*«” —œ«œ »—ê‘  çﬂ Œ—Ã ‘œÂ*/
    ) a
    WHERE a.AmountInBaseCurrency > 0


    UNION ALL

    SELECT
      RecordType = 33,
      EntityID = cc.CommissionCalculationID,
      EntityItemID = 0,
      cc.FiscalYearRef,
      Number = NULL,
      PartyRef = P.DLRef,
      VoucherRef = cc.AccountingVoucherRef,
      Description = cc.CommissionTitle,
      Amount = cc.Amount,
      CurrencyRef = @SystemCurrency,
      AmountInBaseCurrency = cc.Amount,
      Date = cc.ToDate,
      PartyRoleType = 3,
      CustomerRemainFactor = 0,
      VendorRemainFactor = 0,
      BrokerFactor = -1,
      OtherFactor = 0
    FROM SLS.vwCommissionCalculation cc
    LEFT JOIN GNR.Party P
      ON P.PartyId = cc.BrokerPartyRef) a


    SELECT
      * INTO #p
    FROM (SELECT
      PartyID,
      PartyDLRef = p.DlRef,
      DL.Code,
      DLTitle = DL.Title,
      BrokerRemain = (SELECT
        SUM(BrokerFactor * ISNULL(AmountInBaseCurrency, 0))
      FROM #t
      WHERE FiscalYearRef = @FiscalYearRef
      AND PartyRef = p.DLRef
      AND BrokerFactor <> 0
      AND (Date <= @ToDate
      OR Date IS NULL))



    FROM #t t
    JOIN GNR.Party P
      ON P.DLRef = t.PartyRef
    LEFT JOIN GNR.PartyAddress PA
      ON PA.PartyRef = P.PartyId
      AND PA.IsMain = 1
    LEFT JOIN GNR.PartyPhone PH
      ON PH.PartyRef = P.PartyId
      AND PH.IsMain = 1
    LEFT JOIN ACC.DL DL
      ON DL.DLId = P.DLRef

    WHERE (t.Date <= @ToDate
    OR t.Date IS NULL)
    AND p.IsBroker = 1
    GROUP BY PartyID,
             p.DLRef,
             DL.Code,
             DL.Title) a
    WHERE BrokerRemain IS NOT NULL




    DECLARE @RecordCount int = 0
    DECLARE @ItemId int

    DECLARE @Step int = 0
    DECLARE @ID int = 0
    SELECT
      @RecordCount = COUNT(1)
    FROM #p


    EXEC [FMK].[spGetNextId] @tablename = 'GNR.PartyOpeningBalance',
                             @id = @ItemId OUTPUT,
                             @incvalue = @RecordCount

    SET @Step = @ItemId - @RecordCount
    SELECT
      @ID = @Step


    INSERT INTO GNR.PartyOpeningBalance ([PartyOpeningBalanceID],
    [Type],
    [OpeningBalance],
    [PartyRef],
    [FiscalYearRef],
    [OpeningBalanceType],
    [FeedFromClosingOperation])
      SELECT
        ROW_NUMBER() OVER (ORDER BY PartyID) + @ID,
        2,
        ABS(BrokerRemain),
        PartyID,
        @FirstBrokerFiscalYear,
        CASE
          WHEN BrokerRemain < 0 THEN 2
          ELSE 1
        END,
        0

      FROM #p




    IF @RecordCount > 0
      UPDATE fmk.IDGeneration
      SET LastId = (SELECT
        MAX(PartyOpeningBalanceID)
      FROM GNR.PartyOpeningBalance)
      WHERE TableName = 'GNR.PartyOpeningBalance'

  END
END