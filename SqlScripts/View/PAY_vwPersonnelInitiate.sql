IF OBJECT_ID('PAY.vwPersonnelInitiate') Is Not Null
	DROP VIEW PAY.vwPersonnelInitiate
GO
CREATE VIEW PAY.vwPersonnelInitiate  
AS  
SELECT     PAY.PersonnelInitiate.PersonnelInitiateId, PAY.PersonnelInitiate.PersonnelRef, PAY.PersonnelInitiate.SumYearlyWorkingTimeDay,   
  PAY.PersonnelInitiate.SumYearlyTaxableIncome, PAY.PersonnelInitiate.SumYearlyTax,   
  PAY.PersonnelInitiate.WorkHistoryDay, PAY.PersonnelInitiate.WorkHistorySaving, PAY.PersonnelInitiate.LeaveRemain,   
  Party.Name + ' ' + Party.LastName AS FullName, Party.Name_En + ' ' + Party.LastName_En AS FullName_En, PAY.PersonnelInitiate.Version,   
  PAY.PersonnelInitiate.Creator, PAY.PersonnelInitiate.CreationDate, PAY.PersonnelInitiate.LastModifier, PAY.PersonnelInitiate.LastModificationDate,   
  PAY.PersonnelInitiate.Type, PAY.PersonnelInitiate.PaymentRound, PAY.PersonnelInitiate.BaseDate,   
  PAY.PersonnelInitiate.NewyearBonusWorkingTime, PAY.PersonnelInitiate.NewyearBonusSaving, PAY.PersonnelInitiate.Date, Party.DlCode,  
  Party.DlTitle, Party.DlTitle_En
FROM  PAY.PersonnelInitiate 
INNER JOIN  PAY.Personnel ON PAY.PersonnelInitiate.PersonnelRef = PAY.Personnel.PersonnelId 
INNER JOIN  GNR.vwParty Party ON PAY.Personnel.PartyRef = Party.PartyId