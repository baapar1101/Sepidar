
IF OBJECT_ID('GNR.fnDebitNoteRemaining') IS NOT NULL
	DROP FUNCTION GNR.fnDebitNoteRemaining
GO

CREATE FUNCTION GNR.fnDebitNoteRemaining(@DebitDlRef int, @DebitDlType int)
RETURNS TABLE
RETURN
	(SELECT DCH.DebitCreditNoteID, (ISNULL(SUM(DCI.Amount), 0) - ISNULL(PSItem.SumAmount, 0) ) RemainingAmount,
	(ISNULL(PSItem.SumAmount, 0) ) TotalReceivedAmount
	 FROM Gnr.vwDebitCreditNoteItem DCI inner join Gnr.vwDebitCreditNote DCH ON DCH.DebitCreditNoteID = DCI.DebitCreditNoteRef and DCI.DebitDLRef = @DebitDlRef
		LEFT JOIN(SELECT ISNULL(sum(ISNULL(PSI.Amount,0)),0) SumAmount, psi.DebitEntityType, PSI.DebitEntityRef
					FROM rpa.PartyAccountSettlementItem PSI  
					INNER JOIN rpa.vwPartyAccountSettlement PS ON PS.PartyAccountSettlementID = PSI.PartyAccountSettlementRef and PS.PartyDLCode =  (select Code from ACC.dl where DLId=@DebitDlRef)
					WHERE  PSI.DebitEntityType = 6
					GROUP BY psi.DebitEntityType, PSI.DebitEntityRef
					)AS PSItem ON DCH.DebitCreditNoteID = PSItem.DebitEntityRef and PSItem.DebitEntityType = 6 and DCI.DebitType = @DebitDlType
					group by DCH.DebitCreditNoteID, PSItem.SumAmount )			

					
		
GO
