IF OBJECT_ID('RPA.fnGetPettyCashRemaining') IS NOT NULL
	DROP FUNCTION [RPA].[fnGetPettyCashRemaining]
GO
CREATE FUNCTION [RPA].[fnGetPettyCashRemaining] (@fiscalYearRef INT, @pettyCashId INT, @ToDate DATETIME = NULL)
RETURNS @T TABLE(PettyCashId INT, MaximumCredit decimal(19,4), Remaining DECIMAL(19,4), RemainingInBaseCurrency DECIMAL(19,4), ApprovedRemaining DECIMAL(19,4), ApprovedRemainingInBaseCurrency DECIMAL(19,4))
AS
BEGIN

DECLARE @installFiscalYear INT
SELECT @installFiscalYear = [VALUE] FROM FMK.[Configuration] WHERE [key] = 'PettyCashInstallFiscalYear'

INSERT INTO @T
SELECT PC.PettyCashId
      ,PC.MaximumCredit
      ,Remaining = ISNULL(PH.Amount, 0) + PC.FirstAmount + ISNULL(RPC.Amount, 0) 
                 + ISNULL(RFC.Amount, 0) - ISNULL(RH.Amount, 0) - ISNULL(PCB.Amount, 0)
      ,RemainingInBaseCurrency = ISNULL(PH.AmountInBaseCurrency, 0) + PC.FirstAmountInBaseCurrency + ISNULL(RPC.AmountInBaseCurrency, 0) 
                               + ISNULL(RFC.AmountInBaseCurrency, 0) - ISNULL(RH.AmountInBaseCurrency, 0) - ISNULL(PCB.AmountInBaseCurrency, 0)
      ,ApprovedRemaining = ISNULL(PH.Amount, 0) + PC.FirstAmount + ISNULL(RPC.Amount, 0)
                         + ISNULL(RFC.Amount, 0) - ISNULL(RH.Amount, 0) - ISNULL(PCB.ApprovedAmount, 0)
      ,ApprovedRemainingInBaseCurrency = ISNULL(PH.AmountInBaseCurrency, 0) + PC.FirstAmountInBaseCurrency + ISNULL(RPC.AmountInBaseCurrency, 0)
                                       + ISNULL(RFC.AmountInBaseCurrency, 0) - ISNULL(RH.AmountInBaseCurrency, 0) - ISNULL(PCB.ApprovedAmountInBaseCurrency, 0)
FROM      (SELECT PCash.PettyCashId
                 ,PCash.CurrencyRef
                 ,DL.DLId DLRef
                 ,FirstAmount = CASE WHEN @installFiscalYear = @fiscalYearRef THEN FirstAmount ELSE  0 END
                 ,FirstAmountInBaseCurrency = CASE WHEN @installFiscalYear = @fiscalYearRef THEN (FirstAmount * [PCASH].[Rate]) ELSE  0 END
                 ,PCash.MaximumCredit
           FROM RPA.PettyCash PCash
           JOIN GNR.Party P ON P.PartyId = PCash.PartyRef
           JOIN ACC.DL DL ON P.DlRef = DL.DLId
           WHERE @pettyCashId = -1 OR @pettyCashId = PettyCashId
            
          ) AS PC
LEFT JOIN (SELECT PettyCashRef
                 ,Amount                       = SUM(TotalAmount)
                 ,AmountInBaseCurrency         = SUM(TotalAmountInBaseCurrency)
                 ,ApprovedAmount               = SUM(CASE WHEN State = 2 THEN  TotalAmount ELSE  0 END)
                 ,ApprovedAmountInBaseCurrency = SUM(CASE WHEN State = 2 THEN  TotalAmountInBaseCurrency ELSE  0 END)
           FROM RPA.PettyCashBill
           WHERE FiscalYearRef = @fiscalYearRef
               AND (@ToDate IS NULL OR [Date] <= @ToDate)
           GROUP BY PettyCashRef
          ) AS PCB ON PCB.PettyCashRef = PC.PettyCashId
LEFT JOIN (SELECT [RPC].[PettyCashRef]
                 ,[Amount] = SUM([RPC].[Amount])
				 ,[AmountInBaseCurrency]= SUM([RPC].[AmountInBaseCurrency])
				 FROM [RPA].[ReceiptPettyCash] AS [RPC]
				 INNER JOIN [RPA].[ReceiptHeader] AS [RH] ON [RPC].[ReceiptHeaderRef] = [RH].[ReceiptHeaderId]
				 WHERE [RH].[FiscalYearRef] = @fiscalYearRef
					AND (@ToDate IS NULL OR [RH].[Date] <= @ToDate)
				 GROUP BY [RPC].[PettyCashRef]
) AS [RPC] ON [RPC].[PettyCashRef] = [PC].[PettyCashId]
LEFT JOIN (SELECT CurrencyRef
                 ,DlRef
                 ,Amount = SUM(TotalAmount)
                 ,AmountInBaseCurrency = SUM(TotalAmountInBaseCurrency)
           FROM RPA.vwReceiptHeader
           WHERE Type = 64 AND FiscalYearRef = @fiscalYearRef AND IsInitial = 0
               AND (@ToDate IS NULL OR [Date] <= @ToDate)
           GROUP BY CurrencyRef, DlRef
          ) AS RH ON RH.CurrencyRef = PC.CurrencyRef AND RH.DlRef = PC.DLRef
LEFT JOIN (SELECT CurrencyRef
                 ,DlRef
                 ,Amount = SUM(TotalAmount)
                 ,AmountInBaseCurrency = SUM(TotalAmountInBaseCurrency)
           FROM RPA.VwPaymentHeader
           WHERE [Type] = 2048 AND FiscalYearRef = @fiscalYearRef AND IsInitial = 0
               AND (@ToDate IS NULL OR [Date] <= @ToDate)
           GROUP BY CurrencyRef, DlRef
          ) AS PH ON PH.CurrencyRef = PC.CurrencyRef AND PH.DlRef = PC.DLRef 
LEFT JOIN (
	SELECT CurrencyRef
           ,DlRef
           ,Amount = SUM(R.Amount)
           ,AmountInBaseCurrency = SUM(R.AmountInBaseCurrency)
	FROM
		(
			SELECT
			    [RefundItem].[CurrencyRef],
			    [RefundItem].[OriginalDLRef] AS [DlRef],
			    Amount = -[RefundItem].[Amount],
			    AmountInBaseCurrency = -[RefundItem].[AmountInBaseCurrency]
			FROM
			    [RPA].[vwRefundCheque] AS [Refund]
			    INNER JOIN [RPA].[vwRefundChequeItem] AS [RefundItem] ON [Refund].[RefundChequeId] = [RefundItem].[RefundChequeRef]
			    INNER JOIN [RPA].[PaymentCheque] AS [Cheque] ON [RefundItem].[PaymentChequeRef] = [Cheque].[PaymentChequeId]
			    INNER JOIN [RPA].[PaymentHeader] AS [Payment] ON [Cheque].[PaymentHeaderRef] = [Payment].[PaymentHeaderId]
			WHERE
			    [Refund].[Type] = 2
			    AND [Payment].[Type] = 2048
				AND [Refund].[FiscalYearRef] = @fiscalYearRef
			
			UNION ALL
			
			SELECT
			    [RefundItem].[CurrencyRef],
			    [RefundItem].[OriginalDLRef] AS [DlRef],
			    Amount = [RefundItem].[Amount],
			    AmountInBaseCurrency = [RefundItem].[AmountInBaseCurrency] 
			FROM
			    [RPA].[vwRefundCheque] AS [Refund]
			    INNER JOIN [RPA].[vwRefundChequeItem] AS [RefundItem] ON [Refund].[RefundChequeId] = [RefundItem].[RefundChequeRef]
			    INNER JOIN [RPA].[ReceiptCheque] AS [Cheque] ON [RefundItem].[ReceiptChequeRef] = [Cheque].[ReceiptChequeId]
			    INNER JOIN [RPA].[ReceiptHeader] AS [Receipt] ON [Cheque].[ReceiptHeaderRef] = [Receipt].[ReceiptHeaderId]
			WHERE
			    [Refund].[Type] = 1
			    AND [Receipt].[Type] = 64
				AND [Refund].[FiscalYearRef] = @fiscalYearRef
			
			UNION ALL
			
			SELECT
			    [RefundItem].[CurrencyRef],
			    [Refund].[DlRef] AS [DlRef],
			    Amount = -[RefundItem].[Amount],
			    AmountInBaseCurrency = -[RefundItem].[AmountInBaseCurrency]
			FROM
			    [RPA].[vwRefundCheque] AS [Refund]
			    INNER JOIN [RPA].[vwRefundChequeItem] AS [RefundItem] ON [Refund].[RefundChequeId] = [RefundItem].[RefundChequeRef]
			    INNER JOIN [RPA].[ReceiptCheque] AS [Cheque] ON [RefundItem].[ReceiptChequeRef] = [Cheque].[ReceiptChequeId]
			    INNER JOIN [RPA].[ReceiptChequeHistory] AS [history] ON [RefundItem].RefundChequeItemId = [history].[RefundChequeItemRef]
			    INNER JOIN [RPA].[PaymentChequeOther] AS [ChequeOther] ON [ChequeOther].ReceiptChequeRef = [Cheque].[ReceiptChequeId]
			    INNER JOIN [RPA].[ReceiptChequeHistory] AS [prvhistory] ON [ChequeOther].PaymentChequeOtherId = [prvhistory].[PaymentChequeOtherRef] AND [history].[ReceiptChequeHistoryRef] = [prvHistory].[ReceiptChequeHistoryId]
			    INNER JOIN [RPA].[PaymentHeader] AS [Payment] ON [ChequeOther].[PaymentHeaderRef] = [Payment].[PaymentHeaderId]
			WHERE
			    [Refund].[Type] = 4
			    AND [Payment].[Type] = 2048
				AND [Refund].[FiscalYearRef] = @fiscalYearRef
		) AS R
	GROUP BY R.CurrencyRef, R.DlRef
) AS [RFC] ON [RFC].[CurrencyRef] = [PC].[CurrencyRef] AND [RFC].[DlRef] = [PC].[DlRef]

RETURN
END

GO
