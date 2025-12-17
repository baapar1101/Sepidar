If Object_ID('PAY.vwCalculation') Is Not Null
	Drop View PAY.vwCalculation
GO
CREATE VIEW PAY.vwCalculation
AS
SELECT     
	      PAY.Calculation.CalculationId,
		  PAY.Calculation.ElementRef, 
		  PAY.Element.Title AS ElementTitle,
		  PAY.Element.Title_En AS ElementTitle_En, 
		  P.IdentificationCode,
          PAY.Calculation.PersonnelRef,
		  P.DLTitle,
		  P.DLTitle_En,
		  P.DLCode, 
		  PAY.Calculation.Date, 
          PAY.Calculation.Value,
		  PAY.Element.Type AS ElementType,
		  PAY.Element.Class AS ElementClass,
		  PAY.Calculation.Type, 
          PAY.Calculation.BranchRef,
		  branch.BranchDLRef,
		  branch.CostCenterDLRef BranchCostCenterDLRef,
          branch.CostCenterDLTitle BranchCostCenterDLTitle,
		  branch.CostCenterDLCode BranchCostCenterDLCode,
          PAY.Calculation.Month,
		  PAY.Calculation.Year,
		  PAY.Calculation.ContractRef,
		  PAY.Calculation.VoucherRef,
		  Acc.Voucher.Number VoucherNumber,
		  Acc.Voucher.Date VoucherDate,
		  P.DlRef,
		  PAY.Element.AccountRef ElementAccountRef,
		  PAY.Element.DlType ElementDlType,
		  PAY.Element.NormalType ElementNormalType,
		  PAY.Element.PaymentAccountRef ElementPaymentAccountRef, 
		  PAY.Element.PaymentDlType ElementPaymentDlType,
	      PAY.Element.DisplayOrder ElementDisplayOrder, 
		  P.AccountNo,
		  p.BankTitle,
		  p.BankTitle_En,
		  P.BranchTitle,
		  P.BranchTitle_En, 
		  P.AccountTypeTitle,
		  P.AccountTypeTitle_En
FROM      PAY.Calculation INNER JOIN
          PAY.Element ON PAY.Calculation.ElementRef = PAY.Element.ElementId 
          LEFT JOIN PAY.vwPersonnel P ON PAY.Calculation.PersonnelRef = P.PersonnelId
		  LEFT OUTER JOIN Acc.Voucher ON PAY.Calculation.VoucherRef =  Acc.Voucher.VoucherId		  
		  LEFT OUTER JOIN PAY.vwBranch branch ON branch.BranchId = PAY.Calculation.BranchRef


