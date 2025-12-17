
IF OBJECT_ID('RPA.fnReturnChequeOtherRemaining') IS NOT NULL
	DROP FUNCTION RPA.fnReturnChequeOtherRemaining
GO

CREATE FUNCTION RPA.fnReturnChequeOtherRemaining(@PartyType int)
RETURNS TABLE
RETURN
	(SELECT RC.RefundChequeId, (ISNULL(RCI.TotalAmount, 0) - ISNULL(PSItem.SumAmount, 0) ) RemainingAmount,
	(ISNULL(PSItem.SumAmount, 0) ) TotalReceivedAmount
	 FROM RPA.vwRefundCheque RC
	 INNER JOIN
			(
				SELECT RefundChequeRef,
					    SUM(RI.Amount) TotalAmount, SUM(RI.AmountInBaseCurrency) TotalAmountInBaseCurrency
				FROM RPA.vwRefundChequeItem RI INNER JOIN  
									RPA.vwPaymentChequeOther PC ON PC.ReceiptChequeRef = RI.ReceiptChequeRef INNER JOIN  
									RPA.PaymentHeader P ON P.PaymentHeaderID = PC.PaymentHeaderRef                               
				WHERE P.Type =  @PartyType
				GROUP BY RefundChequeRef
			) RCI ON RC.RefundChequeID = RCI.RefundChequeRef

		LEFT JOIN(SELECT sum(PSI.Amount) SumAmount, psi.CreditEntityType, PSI.CreditEntityRef
					FROM rpa.PartyAccountSettlementItem PSI  
					INNER JOIN rpa.PartyAccountSettlement PS ON PS.PartyAccountSettlementID = PSI.PartyAccountSettlementRef 
					WHERE  PSI.CreditEntityType = 27 
					GROUP BY psi.CreditEntityType, PSI.CreditEntityRef
					)AS PSItem ON RC.RefundChequeId = PSItem.CreditEntityRef and PSItem.CreditEntityType = 27
					WHERE Type = 4)

					
		
GO
