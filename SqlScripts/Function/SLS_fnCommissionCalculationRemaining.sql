
IF OBJECT_ID('SLS.fnCommissionCalculationRemaining') IS NOT NULL
	DROP FUNCTION SLS.fnCommissionCalculationRemaining
GO

CREATE FUNCTION SLS.fnCommissionCalculationRemaining()
RETURNS TABLE
RETURN
	SELECT CC.CommissionCalculationID, 
		(ISNULL(CCI.Amount, 0) - ISNULL(PSItem.SumAmount, 0)) RemainingAmount,
		(ISNULL(PSItem.SumAmount, 0) ) TotalReceivedAmount
	FROM SLS.CommissionCalculation CC
		INNER JOIN (SELECT CommissionCalculationRef , Sum(Amount) Amount
					From SLS.CommissionCalculationItem 
					Group By CommissionCalculationRef) CCI ON CC.CommissionCalculationId = CCI.CommissionCalculationRef
		LEFT JOIN(SELECT sum(PSI.Amount) SumAmount, psi.CreditEntityRef, PSI.CreditEntityType
					FROM rpa.PartyAccountSettlementItem PSI  
					INNER JOIN rpa.PartyAccountSettlement PS ON PS.PartyAccountSettlementID = PSI.PartyAccountSettlementRef 
					WHERE  PSI.CreditEntityType = 21 
					GROUP BY psi.CreditEntityRef, PSI.CreditEntityType
					)AS PSItem ON CC.CommissionCalculationID = PSItem.CreditEntityRef AND PSItem.CreditEntityType = 21
			  
GO

