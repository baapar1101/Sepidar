
IF OBJECT_ID('RPA.fnRefundPaymentChequeRemaining') IS NOT NULL
	DROP FUNCTION RPA.fnRefundPaymentChequeRemaining
GO

CREATE FUNCTION RPA.fnRefundPaymentChequeRemaining(@PartyType int)
RETURNS TABLE
RETURN
	(SELECT RC.RefundChequeId, (ISNULL(RCI.TotalAmount, 0) - ISNULL(PSItem.SumAmount, 0) ) RemainingAmount,
	(ISNULL(PSItem.SumAmount, 0) ) TotalReceivedAmount
	 FROM RPA.vwRefundCheque RC
	 INNER JOIN
			(
				SELECT RefundChequeRef,
					    SUM(RI.Amount) TotalAmount, SUM(RI.AmountInBaseCurrency) TotalAmountInBaseCurrency
				FROM RPA.vwRefundChequeItem RI
				JOIN RPA.PaymentHeader PH ON PH.PaymentHeaderId = RI.PaymentHeaderRef
                WHERE PH.Type =  @PartyType
				GROUP BY RefundChequeRef
			) RCI ON RC.RefundChequeID = RCI.RefundChequeRef

		LEFT JOIN(SELECT sum(PSI.Amount) SumAmount, psi.CreditEntityType, PSI.CreditEntityRef
					FROM rpa.PartyAccountSettlementItem PSI  
					INNER JOIN rpa.PartyAccountSettlement PS ON PS.PartyAccountSettlementID = PSI.PartyAccountSettlementRef 
					WHERE  PSI.CreditEntityType = 26 
					GROUP BY psi.CreditEntityType, PSI.CreditEntityRef
					)AS PSItem ON RC.RefundChequeId = PSItem.CreditEntityRef and PSItem.CreditEntityType = 26
					WHERE Type = 2)

					
		
GO
