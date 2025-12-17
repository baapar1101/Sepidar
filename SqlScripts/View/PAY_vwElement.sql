If Object_ID('PAY.vwElement') Is Not Null
	Drop View PAY.vwElement
GO
CREATE VIEW PAY.vwElement
AS
SELECT     PAY.Element.ElementId, PAY.Element.Title, PAY.Element.Title_En, PAY.Element.Class, PAY.Element.Type, PAY.Element.NormalType, 
          PAY.Element.AccountRef, ACC.vwAccount.FullCode AS AccountCode, ACC.vwAccount.Title AS AccountTitle, ACC.vwAccount.Title_En AS AccountTitle_En, 		  
		  ACC.vwAccount.HasDl, PAY.Element.DlType, 
          PAY.Element.PaymentAccountRef, PaymentAccount.FullCode AS PaymentAccountCode, PaymentAccount.Title AS PaymentAccountTitle, PaymentAccount.Title_En AS PaymentAccountTitle_En, 		  
		  PaymentAccount.HasDl PaymentHasDl, ISNULL(PAY.Element.PaymentDlType, 0) PaymentDlType, 
          PAY.Element.InsuranceCoverage, PAY.Element.Taxable, PAY.Element.UnrelatedToWorkingTime, 
          PAY.Element.CalculateForMinWorkingTime, PAY.Element.CalculateForMinBase, PAY.Element.Coefficient, PAY.Element.FixPoint, 
          PAY.Element.DenominatorsType, PAY.Element.Denominators, PAY.Element.SavingRemainder, PAY.Element.IsActive, PAY.Element.Version, 
          PAY.Element.Creator, PAY.Element.CreationDate, PAY.Element.LastModifier, PAY.Element.LastModificationDate, PAY.Element.DisplayOrder, ElementTaxType
FROM        PAY.Element LEFT OUTER JOIN
			ACC.vwAccount  ON PAY.Element.AccountRef = ACC.vwAccount.AccountId LEFT OUTER JOIN
            ACC.vwAccount  PaymentAccount ON PAY.Element.PaymentAccountRef = PaymentAccount.AccountId

WHERE     (PAY.Element.ElementId > 0)  


