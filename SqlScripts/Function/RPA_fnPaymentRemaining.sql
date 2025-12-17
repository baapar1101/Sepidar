
IF OBJECT_ID('RPA.fnPaymentRemaining') IS NOT NULL
	DROP FUNCTION RPA.fnPaymentRemaining
GO

CREATE FUNCTION RPA.fnPaymentRemaining()
RETURNS TABLE
RETURN
	(SELECT PH.PaymentHeaderId, (ISNULL(PH.PaymentAmount, 0) - ISNULL(PSItem.SumAmount, 0) ) RemainingAmount,
	(ISNULL(PSItem.SumAmount, 0) ) TotalReceivedAmount
	 FROM RPA.PaymentHeader PH
		LEFT JOIN(SELECT sum(PSI.Amount) SumAmount, psi.DebitEntityType, PSI.DebitEntityRef
					FROM rpa.PartyAccountSettlementItem PSI  
					INNER JOIN rpa.PartyAccountSettlement PS ON PS.PartyAccountSettlementID = PSI.PartyAccountSettlementRef 
					WHERE  PSI.DebitEntityType = 2 
					GROUP BY psi.DebitEntityType, PSI.DebitEntityRef
					)AS PSItem ON PH.PaymentHeaderId = PSItem.DebitEntityRef and PSItem.DebitEntityType = 2)

					
		
GO
