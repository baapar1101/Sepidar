If Object_ID('PAY.vwContract') Is Not Null
	Drop View PAY.vwContract
GO
CREATE VIEW PAY.vwContract
AS
SELECT    C.ContractId, C.PersonnelRef, C.WorkSiteRef,  C.JobRef, C.TaxGroupRef, C.TaxBranchRef, C.InsuranceBranchRef, 
          C.SupportingInsuranceBranchRef, C.ContractType, C.Number, C.IssueDate, C.ExpireDate, C.EndDate, C.EmploymentDate, C.EmploymentType, 
          C.NonTaxableAmount, C.HasInsurance, C.HasHardJob, C.HasSupportingInsurance, C.Version, C.Creator, C.CreationDate, C.LastModifier, 
          C.LastModificationDate, InsuranceBranch.BranchTitle AS InsuranceBranchTitle, InsuranceBranch.BranchDLRef AS InsuranceBranchDlRef, 
          InsuranceBranch.BranchCode AS InsuranceBranchCode, SupportingInsuranceBranch.BranchTitle AS SupportingInsuranceBranchTitle, 
          SupportingInsuranceBranch.BranchDLRef AS SupportingInsuranceBranchDlRef, SupportingInsuranceBranch.BranchCode AS SupportingInsuranceBranchCode, 
          TaxBranch.BranchTitle AS TaxBranchTitle, TaxBranch.BranchDLRef AS TaxBranchDlRef, TaxBranch.BranchCode AS TaxBranchCode, 
          TaxBranch.AdjustmentType AS TaxBranchAdjustmentType, J.Title AS JobTitle, J.Code AS JobCode, PAY.TaxGroup.Title AS TaxGroupTitle, 
          W.Title AS WorksiteTitle,W.Title_En AS WorksiteTitle_En, W.Code AS WorkSiteCode, Dl.Title AS CostCenterTitle, Dl.Title_En AS CostCenterTitle_En, C.CostCenterDLRef, Dl.Code AS CostCenterCode, 
          PERS.DLTitle AS PersonnelTitle, PERS.DLCode AS PersonnelCode, PERS.LocationTitle AS PersonnelBirthLocationTitle ,PERS.FirstName AS PersonnelFirstName, PERS.LastName AS PersonnelLastName, 
          PERS.FatherName AS PersonnelFatherName, PERS.BirthIdentity AS PersonnelBirthIdentity, PERS.BirthDate AS PersonnelBirthDate, 
          PERS.EducationDegree AS PersonnelEducationDegree, PERS.EducationField AS PersonnelEducationField, C.Description, 
          PERS.DlRef AS PersonnelDLRef, PERS.IdentificationCode AS PersonnelIdentificationCode, PERS.Sex AS PersonnelSex,PERS.BankTitle_En AS PersonnelBankTitle_En, 
          PERS.BankTitle AS PersonnelBankTitle, PERS.BankBranchCode AS PersonnelBankBranchCode, PERS.BranchTitle AS PersonnelBranchTitle, 
          PERS.BranchTitle_En AS PersonnelBranchTitle_En, PERS.AccountTypeTitle AS PersonnelAccountTypeTitle, 
          PERS.AccountTypeTitle_En AS PersonnelAccountTypeTitle_En, PERS.AccountNo AS PersonnelAccountNo, 
          PERS.AccountTypeRef AS PersonnelAccountTypeRef, PERS.BankBranchRef AS PersonnelBankBranchRef, PERS.BankRef AS PersonnelBankRef,
		  PERS.IsActive AS PersonnelIsActive,
		  C.TaxDiscountType , CASE WHEN C.TaxDiscountType > 0 THEN 1 ELSE 0 END AS HasTaxDiscount,
		  PA.LocationTitle PartyLocationTitle, PA.Address PartyAddress, C.HasEmployerInsuranceException, C.HasUnemploymentException,c.HasUnemployeeException,C.EmployerInsuranceExceptionPercent,
          (SELECT TOP 1 (SUM(CASE WHEN ISNULL(BonusClass,0) = 2 /*ElementClass.Bonus*/ THEN BonusValue 
								   ELSE 0 
							  END) + 
						   SUM(CASE WHEN ISNULL(OtherClass,0) = 2 /*ElementClass.Bonus*/ THEN OtherValue 
							   ELSE 0 
							   END)) BonusSum  
		   FROM PAY.Contract C2  
				LEFT JOIN (SELECT InnerCEB.ContractRef,E.Class BonusClass,0 OtherClass,InnerCEB.Value BonusValue ,0 OtherValue
							FROM Pay.vwContractElementBonus InnerCEB   
								INNER JOIN PAY.Element E ON InnerCEB.ElementRef = E.ElementId AND E.Class = 2 /*ElementClass.Bonus*/
							
							UNION ALL
							
							SELECT InnerCEO.ContractRef,0 BonusClass,E.Class OtherClass,0 BonusValue,InnerCEO.Value OtherValue
							FROM Pay.vwContractElementOther InnerCEO   
								INNER JOIN PAY.Element E On InnerCEO.ElementRef = E.ElementId AND E.Class = 2 /*ElementClass.Bonus*/
							) CEB ON C2.ContractId = CEB.ContractRef
			WHERE C2.ContractId = C.ContractId    
			GROUP BY C2.ContractId) BonusSum,
			(SELECT TOP 1 SUM(CASE WHEN ISNULL(OtherClass,0) = 3 THEN OtherValue ELSE 0 END) LeakageSum
				FROM PAY.Contract C2
				LEFT JOIN (Select InnerCEO.ContractRef OtherContractRef,E.Class OtherClass,InnerCEO.Value OtherValue From Pay.vwContractElementOther InnerCEO
							INNER JOIN PAY.Element E On InnerCEO.ElementRef = E.ElementId)	CEO ON C2.ContractId = CEO.OtherContractRef
				WHERE C2.ContractId = C.ContractId
				GROUP BY C2.ContractId) LeakageSum,
			ISNULL((SELECT TOP 1 0 FROM PAY.Contract InnerC
						WHERE InnerC.PersonnelRef = C.PersonnelRef 
								AND InnerC.IssueDate > C.IssueDate),1) IsLastContract,
			C.SupportingInsuranceName
			
			, C.PiofyEmploymentType
			, C.IsEmployer 
						
FROM  PAY.Contract AS C INNER JOIN
                      PAY.vwPersonnel AS PERS ON C.PersonnelRef = PERS.PersonnelId INNER JOIN
                      PAY.Worksite AS W ON C.WorkSiteRef = W.WorksiteId INNER JOIN
                      [ACC].[DL] AS DL ON C.CostCenterDlRef = DL.DlId INNER JOIN
                      PAY.Job AS J ON C.JobRef = J.JobId INNER JOIN
                      PAY.TaxGroup ON C.TaxGroupRef = PAY.TaxGroup.TaxGroupId INNER JOIN
                      PAY.vwBranch AS TaxBranch ON C.TaxBranchRef = TaxBranch.BranchId LEFT OUTER JOIN
                      PAY.vwBranch AS InsuranceBranch ON C.InsuranceBranchRef = InsuranceBranch.BranchId LEFT OUTER JOIN
                      PAY.vwBranch AS SupportingInsuranceBranch ON C.SupportingInsuranceBranchRef = SupportingInsuranceBranch.BranchId
	LEFT JOIN Gnr.vwPartyAddress PA ON PERS.PartyRef = PA.PartyRef AND PA.IsMain = 1

