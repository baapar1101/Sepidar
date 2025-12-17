If Object_ID('PAY.vwPayrollConfiguration') Is Not Null
	Drop View PAY.vwPayrollConfiguration
GO
CREATE VIEW PAY.vwPayrollConfiguration
AS
SELECT     PAY.PayrollConfiguration.PayrollConfigurationId, PAY.PayrollConfiguration.TopDailyInsurance, PAY.PayrollConfiguration.EmployeeInsurancePercent, 
                      PAY.PayrollConfiguration.EmployerInsurancePercent, PAY.PayrollConfiguration.UnemploymentInsurancePercent, 
                      PAY.PayrollConfiguration.HardWorkInsurance, PAY.PayrollConfiguration.SocialSecurityAccountRef, ACC.vwAccount.Title AS SocialSecurityAccountTitle, 
                      ACC.vwAccount.Title_En AS SocialSecurityAccountTitle_En, ACC.vwAccount.FullCode AS SocialSecurityAccountCode, 
                      PAY.PayrollConfiguration.PaymentSocialSecurityAccountRef, Account_1.Title AS PaymentSocialSecurityAccountTitle, 
                      Account_1.Title_En AS PaymentSocialSecurityAccountTitle_En, Account_1.FullCode AS PaymentSocialSecurityAccountCode, 
                      PAY.PayrollConfiguration.NonTaxableSocialSecurityPercent, PAY.PayrollConfiguration.SupportingInsurancePercent, 
                      PAY.PayrollConfiguration.PaymentInsuranceAccountRef, Account_11.Title AS PaymentInsuranceAccountTitle, 
                      Account_11.Title_En AS PaymentInsuranceAccountTitle_En, Account_11.FullCode AS PaymentInsuranceAccountCode, 
                      PAY.PayrollConfiguration.SupportingInsuranceEmployeeElementRef, Element.Title AS SupportingInsuranceEmployeeElementTitle, 
                      PAY.PayrollConfiguration.SupportingInsuranceEmployerElementRef, Element_1.Title AS SupportingInsuranceEmployerElementTitle, 
                      PAY.PayrollConfiguration.SupportingInsuranceCostAccountRef, Account_2.Title AS SupportingInsuranceCostAccountTitle, 
                      Account_2.Title_En AS SupportingInsuranceCostAccountTitle_En, Account_2.FullCode AS SupportingInsuranceCostAccountCode, 
                      PAY.PayrollConfiguration.PaymentSupportingInsuranceAccountRef, Account_3.Title AS PaymentSupportingInsuranceAccountTitle, 
                      Account_3.Title_En AS PaymentSupportingInsuranceAccountTitle_En, Account_3.FullCode AS PaymentSupportingInsuranceAccountCode, 
                      PAY.PayrollConfiguration.TopMonthlyLeave, PAY.PayrollConfiguration.TransferYearlyLeave, PAY.PayrollConfiguration.LeaveCostAccountRef, 
                      Account_4.Title AS LeaveCostAccountTitle, Account_4.Title_En AS LeaveCostAccountTitle_En, Account_4.FullCode AS LeaveCostAccountCode, 
                      PAY.PayrollConfiguration.LeaveSavingAccountRef, Account_5.Title AS LeaveSavingAccountTitle, Account_5.Title_En AS LeaveSavingAccountTitle_En, 
                      Account_5.FullCode AS LeaveSavingAccountCode, PAY.PayrollConfiguration.TopNewYearBonus, PAY.PayrollConfiguration.NewYearBonusBaseFactor, 
                      PAY.PayrollConfiguration.NonTaxableNewYearBonus, PAY.PayrollConfiguration.NonTaxbleBonusRelatedToWorkTime, 
                      PAY.PayrollConfiguration.NewYearBonuCostAccountRef, Account_6.Title AS NewYearBonuCostAccountTitle, 
                      Account_6.Title_En AS NewYearBonuCostAccountTitle_En, Account_6.FullCode AS NewYearBonuCostAccountCode, 
                      PAY.PayrollConfiguration.WorkingHistoryYearlyDay, PAY.PayrollConfiguration.WorkingHistorySavingAccountRef, 
                      Account_7.Title AS WorkingHistorySavingAccountTitle, Account_7.Title_En AS WorkingHistorySavingAccountTitle_En, 
                      Account_7.FullCode AS WorkingHistorySavingAccountCode, PAY.PayrollConfiguration.WorkingHistoryCostAccountRef, 
                      Account_8.Title AS WorkingHistoryCostAccountTitle, Account_8.Title_En AS WorkingHistoryCostAccountTitle_En, 
                      Account_8.FullCode AS WorkingHistoryCostAccountCode, PAY.PayrollConfiguration.PaymentRound, 
                      PAY.PayrollConfiguration.PaymentAccountRef, Account_9.Title AS PaymentAccountTitle, Account_9.Title_En AS PaymentAccountTitle_En, 
                      Account_9.FullCode AS PaymentAccountCode, PAY.PayrollConfiguration.PaymentRoundAccountRef, Account_10.Title AS PaymentRoundAccountTitle, 
                      Account_10.Title_En AS PaymentRoundAccountTitle_En, Account_10.FullCode AS PaymentRoundAccountCode,
                      PAY.PayrollConfiguration.EmployeesCurrentAccountRef, Account_12.FullCode AS EmployeesCurrentAccountCode, Account_12.Title AS EmployeesCurrentAccountTitle, Account_12.Title_En AS EmployeesCurrentAccountTitle_En,
                      PAY.PayrollConfiguration.LoanAccountRef, Account_13.FullCode AS LoanAccountCode, Account_13.Title AS LoanAccountTitle, Account_13.Title_En AS LoanAccountTitle_En,PAY.PayrollConfiguration.CalculateNegativeTax,
                      PAY.PayrollConfiguration.ShowAvailableLeaveInPayFish, PAY.PayrollConfiguration.UnemploymentAccountRef, Account_14.Title AS UnemploymentAccountTitle,
					  Account_14.Title_En AS UnemploymentAccountTitle_En, Account_14.FullCode AS UnemploymentAccountCode, PAY.PayrollConfiguration.HealthInsurancePercent
FROM         PAY.PayrollConfiguration LEFT OUTER JOIN
                      ACC.vwAccount ON PAY.PayrollConfiguration.SocialSecurityAccountRef = ACC.vwAccount.AccountId LEFT OUTER JOIN
                      ACC.vwAccount AS Account_1 ON PAY.PayrollConfiguration.PaymentSocialSecurityAccountRef = Account_1.AccountId LEFT OUTER JOIN
                      ACC.vwAccount AS Account_2 ON PAY.PayrollConfiguration.SupportingInsuranceCostAccountRef = Account_2.AccountId LEFT OUTER JOIN
                      ACC.vwAccount AS Account_3 ON PAY.PayrollConfiguration.PaymentSupportingInsuranceAccountRef = Account_3.AccountId LEFT OUTER JOIN
                      ACC.vwAccount AS Account_4 ON PAY.PayrollConfiguration.LeaveCostAccountRef = Account_4.AccountId LEFT OUTER JOIN
                      ACC.vwAccount AS Account_5 ON PAY.PayrollConfiguration.LeaveSavingAccountRef = Account_5.AccountId LEFT OUTER JOIN
                      ACC.vwAccount AS Account_6 ON PAY.PayrollConfiguration.NewYearBonuCostAccountRef = Account_6.AccountId LEFT OUTER JOIN
                      ACC.vwAccount AS Account_7 ON PAY.PayrollConfiguration.WorkingHistorySavingAccountRef = Account_7.AccountId LEFT OUTER JOIN
                      ACC.vwAccount AS Account_8 ON PAY.PayrollConfiguration.WorkingHistoryCostAccountRef = Account_8.AccountId LEFT OUTER JOIN
                      ACC.vwAccount AS Account_9 ON PAY.PayrollConfiguration.PaymentAccountRef = Account_9.AccountId LEFT OUTER JOIN
                      ACC.vwAccount AS Account_10 ON PAY.PayrollConfiguration.PaymentRoundAccountRef = Account_10.AccountId LEFT OUTER JOIN
                      ACC.vwAccount AS Account_11 ON PAY.PayrollConfiguration.PaymentInsuranceAccountRef = Account_11.AccountId LEFT OUTER JOIN
                      ACC.vwAccount AS Account_12 ON PAY.PayrollConfiguration.EmployeesCurrentAccountRef = Account_12.AccountId LEFT OUTER JOIN
					  ACC.vwAccount AS Account_13 ON PAY.PayrollConfiguration.LoanAccountRef = Account_13.AccountId LEFT OUTER JOIN
					  ACC.vwAccount AS Account_14 ON PAY.PayrollConfiguration.UnemploymentAccountRef = Account_14.AccountId LEFT OUTER JOIN
                      PAY.Element AS Element ON PAY.PayrollConfiguration.SupportingInsuranceEmployeeElementRef = Element.ElementId LEFT OUTER JOIN
                      PAY.Element AS Element_1 ON PAY.PayrollConfiguration.SupportingInsuranceEmployerElementRef = Element_1.ElementId 