If Object_ID('CNT.vwContractSupportingInsurance') Is Not Null
	Drop View CNT.vwContractSupportingInsurance
GO
CREATE VIEW [CNT].[vwContractSupportingInsurance]
AS
SELECT CSI.ContractSupportingInsuranceID, CSI.ContractRef, CSI.RowNumber, CSI.BranchCode, CSI.BranchTitle, CSI.BranchTitle_En, CSI.WorkshopCode,
	   CSI.Description, CSI.Description_En,
	   C.Title AS ContractTitle, C.Title_En AS ContractTitle_En
	
FROM
CNT.ContractSupportingInsurance AS CSI	INNER JOIN 
CNT.Contract AS C ON CSI.ContractRef = C.ContractID 

