If Object_ID('PAY.vwPersonnel') Is Not Null
	Drop View PAY.vwPersonnel
GO
CREATE VIEW PAY.vwPersonnel
AS
SELECT  PERS.PersonnelId, PERS.PartyRef, PERS.BirthIdentity, PERS.BirthLocationRef, PERS.FatherName, P.BirthDate, PERS.Nationality, 
      PERS.MarriageStatus, PERS.StatusDate, PERS.Children, PERS.FamilyCount, PERS.EducationDegree, PERS.EducationField, PERS.InsuranceNumber, 
      PERS.SupportInsuranceNumber, PERS.InsuranceDay, PERS.MilitaryStatus, PERS.BankRef, PERS.BankBranchRef, PERS.AccountTypeRef, 
      PERS.AccountNo, GNR.Location.Title AS LocationTitle, GNR.Location.Title_En AS LocationTitle_En, RPA.Bank.Title AS BankTitle, 
      RPA.Bank.Title_En AS BankTitle_En, RPA.BankBranch.Code BankBranchCode , RPA.BankBranch.Title AS BranchTitle, RPA.BankBranch.Title_En AS BranchTitle_En, 
      RPA.AccountType.Title AS AccountTypeTitle,RPA.AccountType.[Type] BankAccountType , RPA.AccountType.Title_En AS AccountTypeTitle_En, PERS.BirthSerial, P.DLTitle, P.DLTitle_En, 
      P.DLCode, P.IsEmployee, PERS.Sex, P.IdentificationCode, P.IsActive, P.DlRef, 
      P.Name AS FirstName,P.Name_En AS FirstName_En, P.LastName,P.LastName_En,PERS.EmployeeStatus,PERS.ReferenceNumber
FROM  PAY.Personnel AS PERS 
	LEFT JOIN RPA.Bank ON PERS.BankRef = RPA.Bank.BankId 
	LEFT JOIN RPA.BankBranch ON PERS.BankBranchRef = RPA.BankBranch.BankBranchId 
	LEFT JOIN RPA.AccountType ON PERS.AccountTypeRef = RPA.AccountType.AccountTypeId 
	LEFT OUTER JOIN GNR.Location ON PERS.BirthLocationRef = GNR.Location.LocationId 
	INNER JOIN GNR.vwParty AS P ON PERS.PartyRef = P.PartyId 