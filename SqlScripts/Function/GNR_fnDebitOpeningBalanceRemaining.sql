
IF OBJECT_ID('GNR.fnDebitOpeningBalanceRemaining') IS NOT NULL
	DROP FUNCTION GNR.fnDebitOpeningBalanceRemaining
GO

CREATE FUNCTION GNR.fnDebitOpeningBalanceRemaining(@PartType int)
RETURNS TABLE
RETURN
	(SELECT POB.PartyOpeningBalanceID, (ISNULL(POB.OpeningBalance, 0) - ISNULL(PSItem.SumAmount, 0) ) RemainingAmount,
	(ISNULL(PSItem.SumAmount, 0) ) TotalReceivedAmount
	 FROM GNR.PartyOpeningBalance POB
		LEFT JOIN(SELECT sum(PSI.Amount) SumAmount, psi.DebitEntityType, PSI.DebitEntityRef
					FROM rpa.PartyAccountSettlementItem PSI  
					INNER JOIN rpa.PartyAccountSettlement PS ON PS.PartyAccountSettlementID = PSI.PartyAccountSettlementRef 
					WHERE  PSI.DebitEntityType = 5 
					GROUP BY psi.DebitEntityType, PSI.DebitEntityRef
					)AS PSItem ON POB.PartyOpeningBalanceID = PSItem.DebitEntityRef and PSItem.DebitEntityType = 5
					WHERE Type = @PartType)

					
		
GO
