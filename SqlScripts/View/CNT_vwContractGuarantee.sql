If Object_ID('CNT.vwContractGuarantee') Is Not Null
	Drop View CNT.vwContractGuarantee
GO
CREATE VIEW [CNT].[vwContractGuarantee]
AS
SELECT        G.GuaranteeID, G.Date, G.DocumentNumber, G.TenderRef, G.ContractRef, G.DlRef, G.DLCode, G.DLTitle, G.DLTitle_En, G.WarrantyRef, G.WarrantyTitle, G.WarrantyTitle_En, G.Regard, G.Price, G.DueDate, G.DeliveryDate, 
                         G.FurtherInfo, G.Description, G.Description_En, G.BankAccountRef, G.BankAccountTitle, G.BankAccountTitle_En, G.BankAccountDlCode, G.BankAccountDlRef, G.Number,  G.State, 
                         G.OldContractWarrantyItemId, G.ReducableAmount, G.PureAmount, G.VoucherRef, G.VoucherNumber, G.VoucherDate, G.PaymentRef, G.PaymnetNumber, 
                         G.PaymentDate, C.ContractID, C.Date AS ContractDate, 
                         C.DocumentNumber AS ContractNumber, C.FiscalYearRef AS ContractFiscalYearRef, C.CancelDate,
						 C.Title AS ContractTitle, C.Title_En AS ContractTitle_En
FROM            CNT.vwGuarantee AS G INNER JOIN
                         CNT.vwContract AS C ON G.ContractRef = C.ContractID
