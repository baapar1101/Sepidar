If Object_ID('RPA.vwReconciliationItem') Is Not Null
	Drop View RPA.vwReconciliationItem
GO
CREATE VIEW RPA.vwReconciliationItem
AS
SELECT     ReconciliationItemId, ReceiptDraftRef, PaymentDraftRef, ReceiptChequeBankingItemRef, PaymentChequeBankingItemRef, PaymentChequeRef, 
                      RefundChequeItemRef, RelationNo, Type, Date, Number, Debit, Credit, ReconciliationRef, CASE WHEN (RelationNo IS NOT NULL) 
                      THEN 1 ELSE 0 END AS IsPassed, ReconciliationItemRef
FROM         RPA.ReconciliationItem

