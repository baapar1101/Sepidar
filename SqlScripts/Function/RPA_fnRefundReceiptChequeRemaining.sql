
IF OBJECT_ID('RPA.fnRefundReceiptChequeRemaining') IS NOT NULL
	DROP FUNCTION RPA.fnRefundReceiptChequeRemaining
GO

CREATE FUNCTION RPA.fnRefundReceiptChequeRemaining(@PartyType int)
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
				JOIN RPA.ReceiptHeader RH ON RH.ReceiptHeaderId = RI.ReceiptHeaderRef
				WHERE RH.Type =  @PartyType
				GROUP BY RefundChequeRef
			) RCI ON RC.RefundChequeID = RCI.RefundChequeRef

		LEFT JOIN(SELECT sum(PSI.Amount) SumAmount, psi.DebitEntityType, PSI.DebitEntityRef
					FROM rpa.PartyAccountSettlementItem PSI  
					INNER JOIN rpa.PartyAccountSettlement PS ON PS.PartyAccountSettlementID = PSI.PartyAccountSettlementRef 
					WHERE  PSI.DebitEntityType = 7 
					GROUP BY psi.DebitEntityType, PSI.DebitEntityRef
					)AS PSItem ON RC.RefundChequeId = PSItem.DebitEntityRef and PSItem.DebitEntityType = 7
					WHERE Type = 1)

					
		
GO
