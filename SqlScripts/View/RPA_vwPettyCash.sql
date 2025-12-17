If Object_ID('RPA.vwPettyCash') Is Not Null
	Drop View RPA.vwPettyCash
GO
CREATE VIEW RPA.vwPettyCash
AS

SELECT      
	PettyCash.PettyCashId,
	PettyCash.Title_En,
	PettyCash.Title,
	PettyCash.PartyRef,
	PettyCash.CurrencyRef,
	PettyCash.IsActive, 
	PettyCash.FirstAmount,
	PettyCash.MaximumCredit,
	Currency.Title AS CurrencyTitle,
	Currency.Title_En AS CurrencyTitle_En ,
	PettyCash.[Version],
	PettyCash.Rate,
	DL.Title AS DlTitle, 
	DL.Title_En AS DlTitle_En,
	DL.Code AS DlCode,
	P.DlRef ,
	PettyCash.AccountSLRef ,
	ACC.FullCode AS AccountSLCode ,
	ACC.Title AS AccountSLTitle,
    ACC.Title_En AS AccountSLTitle_En ,
	PettyCash.Creator,
	PettyCash.CreationDate,
	PettyCash.LastModifier,
	PettyCash.LastModificationDate
	
FROM  RPA.PettyCash AS PettyCash 
INNER JOIN GNR.Currency AS Currency 
	ON Currency.CurrencyID = PettyCash.CurrencyRef 
INNER JOIN GNR.Party AS P
	ON P.PartyId = PettyCash.PartyRef
INNER JOIN ACC.DL DL 
	ON P.DlRef = DL.DLId
LEFT JOIN  ACC.vwAccount AS ACC 
	ON PettyCash.AccountSLRef=ACC.AccountId