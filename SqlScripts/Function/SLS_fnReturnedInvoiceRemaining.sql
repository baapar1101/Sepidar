
IF OBJECT_ID('SLS.fnReturnedInvoiceRemaining') IS NOT NULL
	DROP FUNCTION SLS.fnReturnedInvoiceRemaining
GO

CREATE FUNCTION SLS.fnReturnedInvoiceRemaining()
RETURNS TABLE
RETURN
	(SELECT RI.ReturnedInvoiceId, (ISNULL(RI.NetPrice, 0) - ISNULL(PSItem.SumAmount, 0) ) RemainingAmount,
	(ISNULL(PSItem.SumAmount, 0) ) TotalReceivedAmount
	 FROM SLS.ReturnedInvoice RI
		LEFT JOIN(SELECT sum(PSI.Amount) SumAmount, psi.CreditEntityType, PSI.CreditEntityRef
					FROM rpa.PartyAccountSettlementItem PSI  
					INNER JOIN rpa.PartyAccountSettlement PS ON PS.PartyAccountSettlementID = PSI.PartyAccountSettlementRef 
					WHERE  PSI.CreditEntityType = 22 
					GROUP BY psi.CreditEntityType, PSI.CreditEntityRef
					)AS PSItem ON RI.ReturnedInvoiceId = PSItem.CreditEntityRef and PSItem.CreditEntityType = 22)

					
		
GO
