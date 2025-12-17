If Object_ID('RPA.vwBankBranch') Is Not Null
	Drop View RPA.vwBankBranch
GO
CREATE VIEW RPA.vwBankBranch
AS
SELECT     Branch.BankBranchId, Branch.BankRef, Branch.Code, Branch.Title, Bank.Title AS BankTitle, Branch.Title_En, Branch.Version, Branch.Creator, 
			Branch.CreationDate, Branch.LastModifier, Branch.LastModificationDate, GNR.Location.Title AS LocationTitle, Branch.LocationRef,
			Bank.Title_En AS BankTitle_En
FROM         RPA.BankBranch AS Branch INNER JOIN
                      RPA.Bank AS Bank ON Bank.BankId = Branch.BankRef Left Outer JOIN
                      GNR.Location ON Branch.LocationRef = GNR.Location.LocationId AND Branch.LocationRef = GNR.Location.LocationId

