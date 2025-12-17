If Object_ID('GNR.vwShred') Is Not Null
	Drop View GNR.vwShred
GO
CREATE VIEW GNR.vwShred
AS
SELECT     GNR.Shred.ShredID, GNR.Shred.Number, GNR.Shred.[Key],
		   --GNR.Shred.Target,
		   CASE 
		   WHEN  GNR.Shred.[Key] = 1 THEN (SELECT CAST(I.Number AS NVARCHAR(MAX)) FROM SLS.Invoice I WHERE I.InvoiceId = GNR.Shred.TargetRef)
		   WHEN GNR.Shred.[Key] = 2 OR GNR.Shred.[Key] = 8 THEN (SELECT CAST(IPI.Number AS NVARCHAR(MAX)) FROM INV.InventoryPurchaseInvoice IPI WHERE IPI.InventoryPurchaseInvoiceID = GNR.Shred.TargetRef)
		   WHEN GNR.Shred.[Key] = 3 THEN (SELECT CAST(IR.Number AS NVARCHAR(MAX)) FROM INV.InventoryReceipt IR WHERE IR.InventoryReceiptID= GNR.Shred.TargetRef)
		   WHEN GNR.Shred.[Key] = 4 THEN (SELECT CAST(L.Title AS NVARCHAR(MAX)) FROM PAY.Loan L WHERE L.LoanID = GNR.Shred.TargetRef)
		   WHEN GNR.Shred.[Key] = 5 OR GNR.Shred.[Key] = 6 OR GNR.Shred.[Key] = 7 THEN (SELECT CAST(DL.Code AS NVARCHAR(MAX))FROM ACC.DL DL WHERE DL.DLId = GNR.Shred.TargetRef)
		   ELSE NULL END  [Target],
		   GNR.Shred.TargetRef, GNR.Shred.DLRef, ACC.DL.Code AS DLCode, 
                      ACC.DL.Title AS DLTitle, ACC.DL.Title_En AS DLTitle_En, GNR.Shred.Date, GNR.Shred.Amount, GNR.Shred.InterestAmount, GNR.Shred.TotalAmount, 
                      GNR.Shred.RemainedAmount, GNR.Shred.PenaltyRate, GNR.Shred.CurrencyRef, GNR.Currency.PrecisionCount, GNR.Shred.Creator, 
                      GNR.Shred.CreationDate, GNR.Shred.LastModifier, GNR.Shred.LastModificationDate, GNR.Shred.Version, GNR.Currency.Title AS CurrencyTitle, 
                      GNR.Currency.Title_En AS CurrencyTitle_En, GNR.Currency.PrecisionCount AS CurrencyPrecisionCount, GNR.Shred.RPType,
					  (SELECT COUNT(*) FROM GNR.ShredItem WHERE GNR.ShredItem.ShredRef = GNR.Shred.ShredID) AS ShredItemCount, 
					  (SELECT COUNT(*) FROM GNR.ShredItem WHERE GNR.ShredItem.ShredRef = GNR.Shred.ShredID AND GNR.ShredItem.Status = 2) AS NotPaidShredItemCount,	
					  (SELECT SUM(GNR.ShredItem.PenaltyAmount) FROM GNR.ShredItem WHERE GNR.ShredItem.ShredRef = GNR.Shred.ShredID) AS PenaltyAmount,
					  GNR.Shred.InterestAccountSLRef,InterestACC.FullCode AS InterestAccountCode, InterestACC.Title AS InterestAccountTitle,
					 GNR.Shred.PenaltyAccountSLRef,PenaltyACC.FullCode AS PenaltyAccountCode, PenaltyACC.Title AS PenaltyAccountTitle
FROM ACC.DL 
	INNER JOIN GNR.Shred ON ACC.DL.DLId = GNR.Shred.DLRef 
	INNER JOIN GNR.Currency ON GNR.Shred.CurrencyRef = GNR.Currency.CurrencyID
	LEFT OUTER JOIN ACC.vwAccount AS InterestACC ON InterestACC.AccountId = GNR.Shred.InterestAccountSLRef
	LEFT OUTER JOIN ACC.vwAccount AS PenaltyACC ON PenaltyACC.AccountId = GNR.Shred.PenaltyAccountSLRef

