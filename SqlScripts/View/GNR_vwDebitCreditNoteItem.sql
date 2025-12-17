If Object_ID('GNR.vwDebitCreditNoteItem') Is Not Null
	Drop View GNR.vwDebitCreditNoteItem
GO
CREATE VIEW GNR.vwDebitCreditNoteItem
AS
SELECT     I.DebitCreditNoteItemID, I.DebitCreditNoteRef, I.RowID, I.DebitSLRef, DebitSL.FullCode AS DebitSLCode, DebitSL.Title AS DebitSLTitle, 
                      DebitSL.Title_En AS DebitSLTitle_En, DebitSL.HasDL AS DebitSLHasDL, I.DebitDLRef, DebitDL.Code AS DebitDLCode, DebitDL.Title AS DebitDLTitle, 
                      DebitDL.Title_En AS DebitDLTitle_En, I.CreditSLRef, CreditSL.FullCode AS CreditSLCode, CreditSL.Title AS CreditSLTitle, 
                      CreditSL.Title_En AS CreditSLTitle_En, CreditSL.HasDL AS CreditSLHasDL, I.CreditDLRef, CreditDL.Code AS CreditDLCode, 
                      CreditDL.Title AS CreditDLTitle, CreditDL.Title_En AS CreditDLTitle_En, I.Amount, I.Rate, I.Description, I.Version, I.Description_En, 
                      I.AmountInBaseCurrency, I.CreditType, I.DebitType
FROM         GNR.DebitCreditNoteItem AS I INNER JOIN
                      ACC.vwAccount AS CreditSL ON I.CreditSLRef = CreditSL.AccountId INNER JOIN
                      ACC.vwAccount AS DebitSL ON I.DebitSLRef = DebitSL.AccountId LEFT OUTER JOIN
                      ACC.DL AS DebitDL ON I.DebitDLRef = DebitDL.DLId LEFT OUTER JOIN
                      ACC.DL AS CreditDL ON I.CreditDLRef = CreditDL.DLId

