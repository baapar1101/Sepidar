
IF OBJECT_ID('GNR.fnCreditOpeningBalanceRemaining') IS NOT NULL
	DROP FUNCTION GNR.fnCreditOpeningBalanceRemaining
GO

CREATE FUNCTION GNR.fnCreditOpeningBalanceRemaining(@PartType int)
RETURNS TABLE
RETURN
	(SELECT POB.PartyOpeningBalanceID, (ISNULL(POB.OpeningBalance, 0) - ISNULL(PSItem.SumAmount, 0) ) RemainingAmount,
	(ISNULL(PSItem.SumAmount, 0) ) TotalReceivedAmount
	 FROM GNR.PartyOpeningBalance POB
		LEFT JOIN(SELECT sum(PSI.Amount) SumAmount, psi.CreditEntityType, PSI.CreditEntityRef
					FROM rpa.PartyAccountSettlementItem PSI  
					INNER JOIN rpa.PartyAccountSettlement PS ON PS.PartyAccountSettlementID = PSI.PartyAccountSettlementRef 
					WHERE  PSI.CreditEntityType = 24 
					GROUP BY psi.CreditEntityType, PSI.CreditEntityRef
					)AS PSItem ON POB.PartyOpeningBalanceID = PSItem.CreditEntityRef and PSItem.CreditEntityType = 24
					WHERE Type = @PartType)

					
		
GO
