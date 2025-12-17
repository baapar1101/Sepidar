
IF OBJECT_ID('GNR.fnCreditNoteRemaining') IS NOT NULL
	DROP FUNCTION GNR.fnCreditNoteRemaining
GO

CREATE FUNCTION GNR.fnCreditNoteRemaining(@CreditDlRef int, @CreditDlType int)
RETURNS TABLE
RETURN
	(SELECT DCH.DebitCreditNoteID, (ISNULL(SUM(DCI.Amount), 0) - ISNULL(PSItem.SumAmount, 0) ) RemainingAmount,
	(ISNULL(PSItem.SumAmount, 0) ) TotalReceivedAmount
	 FROM Gnr.vwDebitCreditNoteItem DCI 
	 inner join 
	 Gnr.vwDebitCreditNote DCH 
	 ON DCH.DebitCreditNoteID = DCI.DebitCreditNoteRef 
	 and DCI.CreditDLRef = @CreditDlRef
		LEFT JOIN
		(SELECT ISNULL(sum(ISNULL(PSI.Amount,0)),0) SumAmount, psi.CreditEntityType, PSI.CreditEntityRef
					FROM rpa.PartyAccountSettlementItem PSI  
					INNER JOIN rpa.vwPartyAccountSettlement PS 
					
					ON PS.PartyAccountSettlementID = PSI.PartyAccountSettlementRef and PS.PartyDLCode  =  (select Code from ACC.dl where DLId=@CreditDlRef)
					WHERE  PSI.CreditEntityType = 25
					GROUP BY psi.CreditEntityType, PSI.CreditEntityRef
					)AS PSItem
					
					ON DCH.DebitCreditNoteID = PSItem.CreditEntityRef and PSItem.CreditEntityType = 25 and DCI.CreditType = @CreditDlType
					group by DCH.DebitCreditNoteID, PSItem.SumAmount )				

					
		
GO
