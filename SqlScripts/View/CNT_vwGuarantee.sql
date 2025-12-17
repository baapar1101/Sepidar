If Object_ID('CNT.vwGuarantee') Is Not Null
	Drop View CNT.vwGuarantee
GO
CREATE VIEW CNT.vwGuarantee
AS
SELECT G.GuaranteeID, G.Date, G.DocumentNumber,
                         G.TenderRef, G.ContractRef,
                         G.DlRef, D.Code AS DLCode, D.Title AS DLTitle, D.Title_En AS DLTitle_En,
                         G.WarrantyRef, W.Title AS WarrantyTitle, W.Title_En AS WarrantyTitle_En, 
						 g.SLref, sl.FullCode SlCode,  sl.Title SLTitle, sl.Title_En SLTitle_En,
                         G.Regard, G.Price, ISNULL(GP.ExtensionDate, G.DueDate )DueDate, G.DeliveryDate, G.FurtherInfo, G.Description, G.Description_En, 
                         G.BankAccountRef, Bank.Title + ' ' + BankBranch.Title + ' ' + BankAccount.AccountNo AS BankAccountTitle, 
                         Bank.Title_En + ' ' + BankBranch.Title_En + ' ' + BankAccount.AccountNo AS BankAccountTitle_En, 
                         BankAccount.DlCode AS BankAccountDlCode, BankAccount.DlRef AS BankAccountDlRef,                                           
                         G.Number, 
                         G.BankBranchRef, BB.Title + ' ' + B.Title AS BankBranchTitle, BB.Title_En + ' ' + B.Title_En AS BankBranchTitle_En,
                         G.State, G.Version, G.Creator, G.CreationDate, G.LastModifier, G.LastModificationDate, G.FiscalYearRef, G.OldContractWarrantyItemId,
                         Price - isnull(GH.TotalReducedAmount ,0) AS ReducableAmount, Price - isnull(GH.TotalReducedAmount,0) AS PureAmount,
                         G.VoucherRef, V.Number VoucherNumber, V.Date VoucherDate,
                         G.PaymentRef, P.Number PaymnetNumber, P.Date PaymentDate, G.Nature,
						 G.ReceiptRef, R.Number ReceiptNumber, R.Date ReceiptDate,
						 G.BankRef, BR.Title AS BankTitle, BR.Title_En AS BankTitle_En, G.AccountNo
FROM            CNT.Guarantee AS G LEFT OUTER JOIN
						(select  GuaranteeRef , Max(ExtensionDate)ExtensionDate
							FROM CNT.GuaranteeOperation Where [Type] =1
							Group by GuaranteeRef )GP ON G.GuaranteeID = GP.GuaranteeRef   INNER JOIN    
                         ACC.DL AS D ON D.DLId = G.DlRef INNER JOIN  
                         CNT.Warranty AS W ON W.warrantyID = G.WarrantyRef LEFT OUTER JOIN                                                                        
						 ACC.vwAccount  AS Sl ON Sl.AccountId = G.SLref LEFT OUTER JOIN		
                         RPA.vwBankAccount AS BankAccount ON G.BankAccountRef = BankAccount.BankAccountId LEFT OUTER JOIN
                         RPA.BankBranch BankBranch ON BankAccount.BankBranchRef = BankBranch.BankBranchId LEFT OUTER JOIN
                         RPA.Bank Bank ON BankBranch.BankRef = Bank.BankId LEFT OUTER JOIN
                         RPA.BankBranch BB ON G.BankBranchRef = BB.BankBranchId LEFT OUTER JOIN
                         RPA.Bank B ON BB.BankRef = B.BankId LEFT OUTER JOIN
                                         (
                                                SELECT GuaranteeRef, SUM(Price) TotalReducedAmount                                                              
                                                FROM CNT.GuaranteeOperation OP
                                                GROUP BY GuaranteeRef             
                                         ) GH ON GH.GuaranteeRef = G.GuaranteeID LEFT OUTER JOIN 
                         ACC.Voucher V ON V.VoucherId  = G.VoucherRef LEFT OUTER JOIN 
                         RPA.PaymentHeader P ON P.PaymentHeaderId = G.PaymentRef LEFT OUTER JOIN 
                         RPA.ReceiptHeader R ON R.ReceiptHeaderId = G.ReceiptRef LEFT OUTER JOIN 
						 RPA.Bank BR ON G.BankRef = BR.BankId
WHERE (G.ContractRef IS NOT NULL AND EXISTS(SELECT ContractId FROM CNT.vwcontract AS C WHERE C.ContractId=G.ContractRef ))
    OR(G.TenderRef IS NOT NULL   AND Exists(Select TenderID   From CNT.vwTender AS T WHERE  T.TenderID = G.TenderRef))
	OR(G.TenderRef IS NULL AND G.ContractRef IS NULL )