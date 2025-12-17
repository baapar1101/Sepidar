IF OBJECT_ID('SLS.vwCommissionCalculation') IS NOT NULL
	DROP VIEW SLS.vwCommissionCalculation
GO
CREATE VIEW SLS.vwCommissionCalculation
AS
	Select  cc.CommissionCalculationID 
	       ,cc.CommissionRef 
	       ,cc.BrokerPartyRef 
	       ,cc.FromDate
	       ,cc.ToDate
	       ,c.Title CommissionTitle 
	       ,c.Title_En CommissionTitle_En 
	       ,p.FullName BrokerFullName 
		   ,p.BrokerGroupingRef
           ,p.BrokerGroupingCode
           ,p.BrokerGroupingTitle
           ,p.BrokerGroupingTitle_En
	       ,BrokerFullName_En  = p.Name_En + ' ' + ISNULL(p.LastName_En, '')
	       ,cc.SLRef
		   ,slAcc.Title SLTitle 
		   ,slAcc.FullCode SLCode 
		   ,cc.DLRef
		   ,dlAcc.Title DLTitle 
		   ,dlAcc.Code DLCode  
		   ,cc.AccountingVoucherRef
	       ,cc.FiscalYearRef
	       ,cc.Version
	       ,cc.Creator
	       ,cc.CreationDate
	       ,cc.LastModifier
	       ,cc.LastModificationDate
		   ,v.Number AS VoucherNumber
		   ,v.Date AS VoucherDate
	       ,p.DLRef AS PartyDLRef
		   ,p.DLCode BrokerPartyDLCode
		   ,p.DLTitle BrokerPartyDLTitle
	       ,s.Amount
	       ,CCRemaining.RemainingAmount
	
	From      SLS.CommissionCalculation cc
	LEFT JOIN SLS.Commission c 
	  ON cc.CommissionRef  = c.CommissionId
	LEFT JOIN ACC.Voucher v 
	  ON cc.AccountingVoucherRef = V.VoucherId 
	LEFT JOIN GNR.vwParty p 
	  ON cc.BrokerPartyRef = p.PartyId
	LEFT JOIN ACC.vwAccount slAcc
	  ON slAcc.AccountId = cc.SLRef
	LEFT JOIN ACC.DL dlAcc
	  ON dlAcc.DLId = cc.DLRef              
	LEFT JOIN (
				Select CommissionCalculationRef , Amount = Sum(Amount) 
				From SLS.CommissionCalculationItem 
				Group By CommissionCalculationRef
	          )s 
	  ON cc.CommissionCalculationId = s.CommissionCalculationRef
	INNER JOIN SLS.fnCommissionCalculationRemaining() CCRemaining 
	  ON CCRemaining.CommissionCalculationID = cc.CommissionCalculationID

GO
