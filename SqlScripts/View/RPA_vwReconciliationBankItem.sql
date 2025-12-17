If Object_ID('RPA.vwReconciliationBankItem') Is Not Null
	Drop View RPA.vwReconciliationBankItem
GO
CREATE VIEW RPA.vwReconciliationBankItem
AS
SELECT     ReconciliationBankItemId, BankBillItemRef, RelationNo, Number, Date, Debit, Credit, ReconciliationRef, CASE WHEN (RelationNo IS NOT NULL) 
                      THEN 1 ELSE 0 END AS IsPassed, ReconciliationBankItemRef
FROM         RPA.ReconciliationBankItem

