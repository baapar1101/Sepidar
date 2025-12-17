

If Object_ID('RPA.vwPaymentChequeHistory') Is Not Null
	Drop View RPA.vwPaymentChequeHistory
GO
CREATE VIEW RPA.vwPaymentChequeHistory
AS
SELECT     History.PaymentChequeHistoryId, History.State, History.Type, History.Date, History.DurationType, History.PaymentChequeHistoryRef, 
                      History.PaymentChequeRef, History.PaymentChequeBankingItemRef, History.RefundChequeItemRef, Item.HeaderNumber, Item.HeaderDate, 
                      Item.PaymentHeaderRef AS HeaderRef, RPA.vwPaymentHeader.DlTitle, RPA.vwPaymentHeader.DLTitle_En, RPA.vwPaymentHeader.CashTitle, 
                      RPA.vwPaymentHeader.CashTitle_En, RPA.vwPaymentHeader.FiscalYearRef AS DocumentFiscalYearRef
FROM         RPA.PaymentChequeHistory AS History INNER JOIN
                      RPA.PaymentCheque AS Item ON Item.PaymentChequeId = History.PaymentChequeRef AND History.Type = 21 LEFT OUTER JOIN
                      RPA.vwPaymentHeader ON Item.PaymentHeaderRef = RPA.vwPaymentHeader.PaymentHeaderId

UNION ALL
SELECT     History.PaymentChequeHistoryId, History.State, History.Type, History.Date, History.DurationType, History.PaymentChequeHistoryRef, 
                      History.PaymentChequeRef, History.PaymentChequeBankingItemRef, History.RefundChequeItemRef, Item.HeaderNumber, Item.HeaderDate, 
                      Item.PaymentChequeBankingRef AS HeaderRef, RPA.vwPaymentCheque.DlTitle, RPA.vwPaymentCheque.DlTitle_En, NULL AS CashTitle, NULL AS CashTitle_En,
                      PCB.FiscalYearRef
FROM         RPA.PaymentChequeHistory AS History INNER JOIN
                      RPA.PaymentChequeBankingItem AS Item ON Item.PaymentChequeBankingItemId = History.PaymentChequeBankingItemRef LEFT OUTER JOIN
                      RPA.vwPaymentCheque ON Item.PaymentChequeRef = RPA.vwPaymentCheque.PaymentChequeId LEFT OUTER JOIN
                      RPA.PaymentChequeBanking PCB ON PCB.PaymentChequeBankingId = Item.PaymentChequeBankingRef

UNION ALL

SELECT     History.PaymentChequeHistoryId, History.State, History.Type, History.Date, History.DurationType, History.PaymentChequeHistoryRef, 
                      History.PaymentChequeRef, History.PaymentChequeBankingItemRef, History.RefundChequeItemRef, Item.HeaderNumber, Item.HeaderDate, 
                      Item.RefundChequeRef AS HeaderRef, RPA.vwRefundCheque.DlTitle, RPA.vwRefundCheque.DlTitle_En, NULL AS CashTitle, NULL AS CashTitle_En,
                      RPA.vwRefundCheque.FiscalYearRef
FROM         RPA.PaymentChequeHistory AS History INNER JOIN
                      RPA.RefundChequeItem AS Item ON Item.RefundChequeItemID = History.RefundChequeItemRef LEFT OUTER JOIN
                      RPA.vwRefundCheque ON Item.RefundChequeRef = RPA.vwRefundCheque.RefundChequeId
                      