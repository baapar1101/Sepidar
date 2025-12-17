If Object_ID('RPA.vwReceiptChequeHistory') Is Not Null
	Drop View RPA.vwReceiptChequeHistory
GO
CREATE VIEW RPA.vwReceiptChequeHistory
AS
SELECT     History.ReceiptChequeHistoryId, History.State, History.Type, History.Date, History.ReceiptChequeHistoryRef, History.ReceiptChequeRef, 
                      History.ReceiptChequeBankingItemRef, History.PaymentChequeOtherRef, History.RefundChequeItemRef, RPA.ReceiptCheque.HeaderDate, 
                      RPA.ReceiptCheque.HeaderNumber, RPA.ReceiptCheque.ReceiptHeaderRef AS HeaderRef, RPA.vwReceiptHeader.DlTitle, 
                      RPA.vwReceiptHeader.DlTitle_En, RPA.vwReceiptHeader.CashTitle, RPA.vwReceiptHeader.CashTitle_En,
                      RPA.vwReceiptHeader.FiscalYearRef AS DocumentFiscalYearRef
FROM         RPA.ReceiptChequeHistory AS History INNER JOIN
                      RPA.ReceiptCheque ON History.ReceiptChequeRef = RPA.ReceiptCheque.ReceiptChequeId LEFT OUTER JOIN
                      RPA.vwReceiptHeader ON RPA.ReceiptCheque.ReceiptHeaderRef = RPA.vwReceiptHeader.ReceiptHeaderId
WHERE     (History.Type = 11) OR
                      (History.Type = 14)
UNION ALL
SELECT     History.ReceiptChequeHistoryId, History.State, History.Type, History.Date, History.ReceiptChequeHistoryRef, History.ReceiptChequeRef, 
                      History.ReceiptChequeBankingItemRef, History.PaymentChequeOtherRef, History.RefundChequeItemRef, Item.HeaderDate, Item.HeaderNumber, 
                      Item.ReceiptChequeBankingRef AS HeaderRef, null as DlTitle, null as DlTitle_En, RPA.vwReceiptChequeBanking.CashTitle, RPA.vwReceiptChequeBanking.CashTitle_En,
                      RPA.vwReceiptChequeBanking.FiscalYearRef
FROM         RPA.ReceiptChequeHistory AS History INNER JOIN
                      RPA.ReceiptChequeBankingItem AS Item ON History.ReceiptChequeBankingItemRef = Item.ReceiptChequeBankingItemId LEFT OUTER JOIN
                      RPA.vwReceiptChequeBanking ON Item.ReceiptChequeBankingRef = RPA.vwReceiptChequeBanking.ReceiptChequeBankingId
UNION ALL

SELECT     History.ReceiptChequeHistoryId, History.State, History.Type, History.Date, History.ReceiptChequeHistoryRef, History.ReceiptChequeRef, 
                      History.ReceiptChequeBankingItemRef, History.PaymentChequeOtherRef, History.RefundChequeItemRef, Item.HeaderDate, Item.HeaderNumber, 
                      Item.PaymentHeaderRef AS HeaderRef, RPA.vwPaymentHeader.DlTitle, RPA.vwPaymentHeader.DLTitle_En, RPA.vwPaymentHeader.CashTitle,
                       RPA.vwPaymentHeader.CashTitle_En, RPA.vwPaymentHeader.FiscalYearRef
FROM         RPA.ReceiptChequeHistory AS History INNER JOIN
                      RPA.PaymentChequeOther AS Item ON History.PaymentChequeOtherRef = Item.PaymentChequeOtherId LEFT OUTER JOIN
                      RPA.vwPaymentHeader ON Item.PaymentHeaderRef = RPA.vwPaymentHeader.PaymentHeaderId
UNION ALL

SELECT     History.ReceiptChequeHistoryId, History.State, History.Type, History.Date, History.ReceiptChequeHistoryRef, History.ReceiptChequeRef, 
                      History.ReceiptChequeBankingItemRef, History.PaymentChequeOtherRef, History.RefundChequeItemRef, Item.HeaderDate, Item.HeaderNumber, 
                      Item.RefundChequeRef AS HeaderRef, RPA.vwRefundCheque.DlTitle, RPA.vwRefundCheque.DlTitle_En, NULL AS CashTitle, NULL AS CashTitle_En,
                      RPA.vwRefundCheque.FiscalYearRef
FROM         RPA.ReceiptChequeHistory AS History INNER JOIN
                      RPA.RefundChequeItem AS Item ON History.RefundChequeItemRef = Item.RefundChequeItemID LEFT OUTER JOIN
                      RPA.vwRefundCheque ON Item.RefundChequeRef = RPA.vwRefundCheque.RefundChequeId






