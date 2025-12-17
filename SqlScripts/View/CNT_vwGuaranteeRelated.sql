If Object_ID('CNT.vwGuaranteeRelated') Is Not Null
	Drop View CNT.vwGuaranteeRelated
GO
CREATE VIEW CNT.vwGuaranteeRelated
AS
SELECT        GR.GuaranteeRelatedID, GR.ParentGuaranteeRef, GR.ChildGuaranteeRef,
						 RefrencedG.GuaranteeID, RefrencedG.Date, RefrencedG.DocumentNumber,
						 RefrencedG.TenderRef, RefrencedG.ContractRef,
						 RefrencedG.DlRef, D.Code AS DLCode, D.Title AS DLTitle, D.Title_En AS DLTitle_En,
                         RefrencedG.WarrantyRef, W.Title AS WarrantyTitle, W.Title_En AS WarrantyTitle_En, 
						 RefrencedG.Regard, RefrencedG.Price, RefrencedG.DueDate, RefrencedG.DeliveryDate, RefrencedG.FurtherInfo, RefrencedG.Description, RefrencedG.Description_En, 
                         RefrencedG.BankAccountRef, Bank.Title + ' ' + BankBranch.Title + ' ' + BankAccount.AccountNo AS BankAccountTitle, 
                         Bank.Title_En + ' ' + BankBranch.Title_En + ' ' + BankAccount.AccountNo AS BankAccountTitle_En, 
						 BankAccount.DlCode AS BankAccountDlCode, BankAccount.DlRef AS BankAccountDlRef, 						 
						 RefrencedG.Number,  RefrencedG.State, 
						 RefrencedG.Version, RefrencedG.Creator, RefrencedG.CreationDate, RefrencedG.LastModifier, RefrencedG.LastModificationDate, 
						 RefrencedG.FiscalYearRef, RefrencedG.OldContractWarrantyItemId						 
FROM            CNT.GuaranteeRelated AS GR INNER JOIN    
						CNT.vwGuarantee AS RefrencedG on GR.ChildGuaranteeRef = RefrencedG.GuaranteeID INNER JOIN
						 ACC.DL AS D ON D.DLId = RefrencedG.DlRef INNER JOIN  
						 CNT.Warranty AS W ON W.warrantyID = RefrencedG.WarrantyRef LEFT OUTER JOIN                   
                         CNT.vwTender AS T ON T.TenderID = RefrencedG.TenderRef LEFT OUTER JOIN                         
                         CNT.vwContract AS C ON C.ContractID = RefrencedG.ContractRef LEFT OUTER JOIN						 
                         RPA.vwBankAccount AS BankAccount ON RefrencedG.BankAccountRef = BankAccount.BankAccountId LEFT OUTER JOIN
                         RPA.BankBranch BankBranch ON BankAccount.BankBranchRef = BankBranch.BankBranchId LEFT OUTER JOIN
                         RPA.Bank Bank ON BankBranch.BankRef = Bank.BankId
						