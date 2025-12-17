
IF OBJECT_ID('RPA.fnReceiptRemaining') IS NOT NULL
	DROP FUNCTION RPA.fnReceiptRemaining
GO

CREATE FUNCTION RPA.fnReceiptRemaining()
RETURNS TABLE
RETURN
	(SELECT RH.ReceiptHeaderId, (ISNULL(RH.ReceiptAmount, 0) - ISNULL(PSItem.SumAmount, 0) ) RemainingAmount,
	(ISNULL(PSItem.SumAmount, 0) ) TotalReceivedAmount
	 FROM RPA.ReceiptHeader RH
		LEFT JOIN(SELECT sum(PSI.Amount) SumAmount, psi.CreditEntityType, PSI.CreditEntityRef
					FROM rpa.PartyAccountSettlementItem PSI  
					INNER JOIN rpa.PartyAccountSettlement PS ON PS.PartyAccountSettlementID = PSI.PartyAccountSettlementRef 
					WHERE  PSI.CreditEntityType = 23 
					GROUP BY psi.CreditEntityType, PSI.CreditEntityRef
					)AS PSItem ON RH.ReceiptHeaderId = PSItem.CreditEntityRef and PSItem.CreditEntityType = 23)

					
		
GO
