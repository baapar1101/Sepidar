IF OBJECT_ID('SLS.fnInvoiceRemaining') IS NOT NULL
	DROP FUNCTION SLS.fnInvoiceRemaining
GO

CREATE FUNCTION SLS.fnInvoiceRemaining()
RETURNS TABLE
RETURN
	(SELECT I.InvoiceID, Case WHEN ISNULL(I.state ,0) = 2 THEN 0
						ELSE (ISNULL(I.NetPrice, 0) - ISNULL(SH.ShredAmount,0) - ISNULL(ROTS.ReceiptsOtherThanShred, 0)) 
						END	RemainingAmount,
		(ISNULL(PSItem.SumAmount, 0)) TotalReceivedAmount
	FROM SLS.Invoice I
		LEFT JOIN(SELECT SUM(PSI.Amount) SumAmount, PSI.DebitEntityRef
					FROM RPA.PartyAccountSettlementItem PSI  
					WHERE  PSI.DebitEntityType = 1
					GROUP BY PSI.DebitEntityRef
					)AS PSItem ON I.InvoiceId = PSItem.DebitEntityRef
		LEFT JOIN(SELECT S.ShredID, S.TargetRef, S.Amount AS ShredAmount  
					FROM GNR.Shred AS S
					WHERE S.[Key] = 1)AS SH ON SH.TargetRef = I.InvoiceId
		LEFT JOIN(SELECT PASI.DebitEntityRef, SUM(PASI.Amount) ReceiptsOtherThanShred
					FROM RPA.PartyAccountSettlementItem PASI  
						LEFT JOIN GNR.ShredItem AS SI ON SI.PartySettlementRef = PASI.PartyAccountSettlementRef
						WHERE PASI.DebitEntityType = 1 AND  SI.PartySettlementRef IS NULL
						GROUP BY PASI.DebitEntityRef) AS ROTS ON I.InvoiceId = ROTS.DebitEntityRef
		)
GO