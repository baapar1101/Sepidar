-- TODO:
-- check rpa install fiscal year
-- TEST REFUND

-- DECLARE @FiscalYearId int = 2;
-- DECLARE @FromDate datetime,@ToDate datetime;
-- SELECT @FromDate = StartDate, @ToDate = EndDate FROM FMK.FiscalYear WHERE FiscalYearId = @FiscalYearId
-- -- SELECT @FromDate=''2024-03-20 00:00:00'',@ToDate=''2025-03-20 00:55:00'', @FiscalYearId = 2

IF CAST(SERVERPROPERTY('productversion') AS VARCHAR(20)) >= '14.'
BEGIN
    EXEC SP_EXECUTESQL N'
IF OBJECT_ID(''MRP.spUpdateReceivableCommitmentsFact'', ''P'') IS NOT NULL
    DROP PROCEDURE MRP.spUpdateReceivableCommitmentsFact
'
END
GO

IF CAST(SERVERPROPERTY('productversion') AS VARCHAR(20)) >= '14.'
BEGIN
    EXEC SP_EXECUTESQL N'
CREATE PROCEDURE MRP.spUpdateReceivableCommitmentsFact
    @FromDate DATETIME,
    @ToDate DATETIME
AS

DECLARE @FiscalYearID INT = (SELECT TOP 1 FiscalYearId FROM FMK.FiscalYear WHERE StartDate <= @FromDate AND EndDate >= @ToDate);
DECLARE @FiscalYearStartDate DATE = CAST((SELECT TOP 1 StartDate FROM FMK.FiscalYear WHERE FiscalYearId = @FiscalYearID) AS date);

WITH [Transactions] AS (
    SELECT
        CAST(SHI.UsanceDate AS date) AS [Date],
        CASE
            WHEN [Key] = 1 THEN (SHI.Amount + SHI.InterestAmount + SHI.PenaltyAmount) * Invoice.Rate -- TEST THIS RATE THING!
            ELSE SHI.Amount + SHI.InterestAmount + SHI.PenaltyAmount
        END AS Loan,
        NULL AS ContractRef,
        0 AS ContractingStatus,
        NULL AS BankAccountRef,
        0 AS SubmitedToBankCheque,
        NULL AS CashRef,
        0 AS InCashCheque,
        0 AS ProtestedCheque,
        NULL AS PartyRef,
        0 AS CustomerRemaining,
        0 AS IsCustomerOpening
    FROM GNR.ShredItem SHI
    INNER JOIN GNR.Shred SH ON SH.ShredID = SHI.ShredRef
    LEFT JOIN SLS.Invoice Invoice ON SH.[Key] = 1 AND SH.TargetRef = Invoice.InvoiceId
    WHERE SHI.Status = 2
        AND SH.[Key] IN (1, 4, 6)
        AND SHI.UsanceDate >= @FromDate
        AND SHI.UsanceDate <= @ToDate

    UNION ALL

    SELECT
        CAST(S.ConfirmationDate AS date) AS [Date],
        0 AS Loan,
        S.ContractRef,
        S.NotSettled AS ContractingStatus,
        NULL AS BankAccountRef,
        0 AS SubmitedToBankCheque,
        NULL AS CashRef,
        0 AS InCashCheque,
        0 AS ProtestedCheque,
        NULL AS PartyRef,
        0 AS CustomerRemaining,
        0 AS IsCustomerOpening
    FROM CNT.[vwStatus] S
    WHERE S.Nature = 1
        AND S.ConfirmationState = 2
        AND S.ConfirmationDate >= @FromDate
        AND S.ConfirmationDate <= @ToDate
        AND S.NotSettled > 0
        AND S.FiscalYearRef = @FiscalYearID

    UNION ALL

    SELECT
        CAST(RC.[Date] AS date) AS [Date],
        0 AS Loan,
        NULL AS ContractRef,
        0 AS ContractingStatus,
        ChequeBankAccount.BankAccountRef AS BankAccountRef,
        CASE WHEN RC.[State] = 2 THEN RC.AmountInBaseCurrency ELSE 0 END AS SubmitedToBankCheque,
        RC.CashRef AS CashRef,
        CASE WHEN RC.[State] = 1 THEN RC.AmountInBaseCurrency ELSE 0 END AS InCashCheque,
        CASE WHEN RC.[State] = 8 THEN RC.AmountInBaseCurrency ELSE 0 END AS ProtestedCheque,
        NULL AS PartyRef,
        0 AS CustomerRemaining,
        0 AS IsCustomerOpening
    FROM RPA.ReceiptCheque RC
    INNER JOIN RPA.ReceiptHeader RH ON RC.ReceiptHeaderRef = RH.ReceiptHeaderId
    OUTER APPLY (
        SELECT TOP 1 RCB.BankAccountRef
        FROM RPA.ReceiptChequeHistory RCH
        LEFT JOIN RPA.ReceiptChequeBankingItem RCBI ON RCH.ReceiptChequeBankingItemRef = RCBI.ReceiptChequeBankingItemId
        LEFT JOIN RPA.ReceiptChequeBanking RCB ON RCBI.ReceiptChequeBankingRef = RCB.ReceiptChequeBankingId
        WHERE RC.ReceiptChequeId = RCH.ReceiptChequeRef
        ORDER BY RCH.ReceiptChequeHistoryId DESC
    ) ChequeBankAccount
    WHERE RH.[FiscalYearRef] = @FiscalYearID AND RC.[State] IN (1, 2, 8) AND RC.IsGuarantee = 0 AND RC.[Date] BETWEEN @FromDate AND @ToDate

    UNION ALL

    SELECT
        CAST(TR.[Date] AS date) AS [Date],
        0 AS Loan,
        NULL AS ContractRef,
        0 AS ContractingStatus,
        NULL AS BankAccountRef,
        0 AS SubmitedToBankCheque,
        NULL AS CashRef,
        0 AS InCashCheque,
        0 AS ProtestedCheque,
        P.PartyId AS PartyRef,
        CreditDebit * AmountInBaseCurrency AS CustomerRemaining,
        0 AS IsCustomerOpening
    FROM GNR.fnGetPartyCustomerTransactions(
        -1,
        1,
        @FiscalYearID,
        @FromDate,
        @ToDate) TR
    INNER JOIN GNR.Party P ON TR.PartyDLRef = P.DLRef

    UNION ALL

    SELECT
        @FiscalYearStartDate AS [Date],
        0 AS Loan,
        NULL AS ContractRef,
        0 AS ContractingStatus,
        NULL AS BankAccountRef,
        0 AS SubmitedToBankCheque,
        NULL AS CashRef,
        0 AS InCashCheque,
        0 AS ProtestedCheque,
        P.PartyId AS PartyRef,
        CASE
            WHEN POB.OpeningBalanceType = 1 THEN 1
            WHEN POB.OpeningBalanceType = 2 THEN -1
        END * POB.OpeningBalance AS CustomerRemaining,
        1 AS IsCustomerOpening
      FROM GNR.PartyOpeningBalance POB
               JOIN GNR.Party P ON POB.PartyRef = P.PartyID
      WHERE @FiscalYearStartDate BETWEEN @FromDate AND @ToDate
        AND POB.Type = 0
        AND POB.OpeningBalance <> 0
        AND POB.FiscalYearRef = @FiscalYearID
)

INSERT INTO MRP.ReceivableCommitmentsFact
SELECT *
FROM [Transactions]

/*
ReceiptChequeState
{
    InCash = 1, --نزد صندوق
    SubmitedToBank = 2, --واگذار به بانك
    Achieved = 4, --وصول
    Protested = 8, --واخواست
    Cashed = 16, --نقد شده
    SubmitToOther = 32, --خرج شده
    Refunded = 64 --استرداد
}

RpaDocType
{
    BankAccount = 1, --موجودي اوليه
    Cash = 2, --موجودي اوليه
    Pos = 3, --موجودي اوليه
    ReceiptHeader = 10, --رسيد دريافت
    ReceiptCheque = 11, --دريافت چك
    ReceiptDraft = 12, --حواله
    ReceiptPos = 13, --دريافت از كارت خوان
    ReceiptProtestedCheque = 14, --دريافت چك واخواستي
    ReceiptPettyCash = 15, --شارژ تنخواه
    PaymentHeader = 20, --اعلاميه پرداخت
    PaymentCheque = 21, --پرداخت چك
    PaymentDraft = 22, --اعلاميه برداشت
    PaymentChequeOther = 23, --خرج كردن چك
    VoidCheque = 24, --ابطال چك
    ReceiptChequeBanking = 30, --عمليات بانكي چك
    Submit = 31, --واگذار به بانك
    Achieve = 32, --وصول چك
    Protest = 33, --واخواست چك
    ChequeCash = 34, --نقد كردن چك
    PaymentChequeCash =41, --وصول چك پرداختني
    RefundCheque = 50, --استرداد چك
    RefundReceiptCheque = 51, --استرداد چك دريافتني
    RefundPaymentCheque = 52, --استرداد چك پرداختني
    ReturnChequeOther = 53, --برگشت چك خرج شده
    ProtestReturnChequeOther = 54, --برگشت چك خرج شده واخواستي
    CashDeposit = 60, --سپرده نقدي ضمانت نامه
    PosSettlementReceipt = 61, --تسويه كارت خوان
    BankFEE = 62, --كارمزد بانكي
    PettyCash=70 --موجودي اوليه
}
*/
'
END
GO