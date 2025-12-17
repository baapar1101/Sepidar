
UPDATE RPA.ReceiptHeader SET CashRef = (SELECT TOP 1 CashID FROM RPA.Cash C WHERE C.CurrencyRef = CurrencyRef ORDER BY CashID)
WHERE [State] = 4 AND CashRef IS NULL

UPDATE RC SET CashRef = HeaderCashRef FROM
(
      SELECT RC.*, RH.CashRef AS HeaderCashRef FROM
            RPA.ReceiptCheque RC
            INNER JOIN RPA.ReceiptHeader RH
            ON RC.ReceiptHeaderRef=RH.ReceiptHeaderID
      WHERE RC.CashRef IS NULL OR RC.CashRef <> RH.CashRef
) RC