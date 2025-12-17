If Object_ID('CNT.vwGuaranteeOperation') Is Not Null
	Drop View CNT.vwGuaranteeOperation
GO
CREATE VIEW CNT.vwGuaranteeOperation
AS
SELECT					 GOP.GuaranteeOperationID, GOP.GuaranteeRef, GOP.Date, GOP.ExtensionDate, GOP.Type, GOP.Price, GOP.State, GOP.FiscalYearRef, 
						GOP.Description, GOP.Description_En,
						 GOP.VoucherRef, V.Number VoucherNumber, V.Date VoucherDate, 
						 GOP.PaymentRef, P.Number PaymnetNumber, P.Date PaymentDate,
						 GOP.ReceiptRef, R.Number ReceiptNumber, R.Date ReceiptDate,
						 GOP.RefundChequeRef, RCF.Number RefundChequeNumber, RCF.Date RefundChequeDate,
						 GOP.Version, GOP.Creator, GOP.CreationDate, GOP.LastModifier, GOP.LastModificationDate,
						 G.GuaranteeID, G.Date AS GuaranteeDate, G.DocumentNumber GuaranteeDocumentNumber, G.TenderRef, G.ContractRef, G.DlRef, 
                         D.Code AS DLCode, D.Title AS DLTitle, D.Title_En AS DLTitle_En, G.WarrantyRef, W.Title AS WarrantyTitle, W.Title_En AS WarrantyTitle_En, 
						 G.Regard, G.Price AS GuaranteePrice, G.DueDate AS GuaranteeDueDate, 
                         G.DeliveryDate AS GuaranteeDeliveryDate, G.FurtherInfo, G.Description GuaranteeDescription, G.Description_En GuaranteeDescription_En, 
						 G.BankAccountRef, Bank.Title + ' ' + BankBranch.Title + ' ' + BankAccount.AccountNo AS BankAccountTitle, 
                         Bank.Title_En + ' ' + BankBranch.Title_En + ' ' + BankAccount.AccountNo AS BankAccountTitle_En, BankAccount.DlCode AS BankAccountDlCode, 
						 BankAccount.DlRef AS BankAccountDlRef, 
						 G.Number,  G.State AS GuaranteeState, G.PureAmount GuaranteePureAmount, G.Nature, G.SlRef
FROM            CNT.GuaranteeOperation AS GOP INNER JOIN
                         CNT.vwGuarantee AS G ON G.GuaranteeID = GOP.GuaranteeRef INNER JOIN
                         ACC.DL AS D ON D.DLId = G.DlRef INNER JOIN
                         CNT.Warranty AS W ON W.warrantyID = G.WarrantyRef LEFT OUTER JOIN
                         CNT.vwTender AS T ON T.TenderID = G.TenderRef LEFT OUTER JOIN
                         CNT.vwContract AS C ON C.ContractID = G.ContractRef LEFT OUTER JOIN
                         RPA.vwBankAccount AS BankAccount ON G.BankAccountRef = BankAccount.BankAccountId LEFT OUTER JOIN
                         RPA.BankBranch AS BankBranch ON BankAccount.BankBranchRef = BankBranch.BankBranchId LEFT OUTER JOIN
                         RPA.Bank AS Bank ON BankBranch.BankRef = Bank.BankId LEFT OUTER JOIN 
						ACC.Voucher V ON V.VoucherId  = GOP.VoucherRef LEFT OUTER JOIN 
						RPA.PaymentHeader P ON P.PaymentHeaderId = GOP.PaymentRef LEFT OUTER JOIN 
						RPA.ReceiptHeader R ON R.ReceiptHeaderId = GOP.ReceiptRef LEFT OUTER JOIN 
						RPA.RefundCheque RCF ON RCF.RefundChequeId = GOP.RefundChequeRef