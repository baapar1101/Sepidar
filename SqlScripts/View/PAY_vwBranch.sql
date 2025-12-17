If Object_ID('PAY.vwBranch') Is Not Null
	Drop View PAY.vwBranch
GO
CREATE VIEW PAY.vwBranch
AS
SELECT    PAY.Branch.BranchId, PAY.Branch.BranchPartyRef, PAY.Branch.Code, PAY.Branch.ContractNumber, PAY.Branch.AdjustmentType, 
          PAY.Branch.Version, PAY.Branch.Creator, PAY.Branch.CreationDate, PAY.Branch.LastModifier, PAY.Branch.LastModificationDate, 
          GNR.vwParty.DLCode AS BranchCode, GNR.vwParty.DLTitle AS BranchTitle, GNR.vwParty.DLTitle_En AS BranchTitle_En, 
          GNR.vwParty.DLRef AS BranchDLRef, PAY.Branch.NoInsurancePersonsCount, PAY.Branch.Type,
          dl.DLId CostCenterDLRef,dl.Title CostCenterDLTitle,dl.Code CostCenterDLCode,Company,WorkshopName,WorkshopAddress
FROM  GNR.vwParty 
		INNER JOIN PAY.Branch ON GNR.vwParty.PartyId = PAY.Branch.BranchPartyRef		
		LEFT OUTER JOIN ACC.DL dl ON dl.DLId = PAY.Branch.CostCenterDlRef			
