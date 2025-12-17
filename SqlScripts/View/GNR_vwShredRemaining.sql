
IF OBJECT_ID('GNR.vwShredRemaining') IS NOT NULL
	DROP VIEW GNR.vwShredRemaining
GO

CREATE VIEW GNR.vwShredRemaining
AS
	(SELECT  S.ShredID
			,S.[Date] 
			,S.Number
			,CASE 
				WHEN PSItem.DebitEntityType = 8 
				THEN SUM(ISNULL(SI.InterestAmount,0)) + SUM(ISNULL(SI.PenaltyAmount, 0))
				ELSE NULL
			 END  AS InterestPenaltyTotalAmount
			,CASE 
				WHEN PSItem.DebitEntityType = 8 
				THEN SUM(ISNULL(SI.InterestAmount, 0)) + SUM(ISNULL(SI.PenaltyAmount,0)) - ISNULL(PSItem.SumAmount, 0)
				ELSE NULL 
			 END AS InterestPenaltyRemainingAmount
			,CASE 
				WHEN PSItem.DebitEntityType = 8 
				THEN ISNULL(PSItem.SumAmount, 0)
				ELSE NULL
			 END AS InterestPenaltyTotalReceivedAmount
			,S.Amount AS ShredTotalAmount
			,CASE 
				WHEN PSItem.DebitEntityType = 9 OR PSItem.DebitEntityType = 10
				THEN ISNULL(PSItem.SumAmount, 0)
				ELSE 0
			 END AS ShredTotalReceivedAmount
			,CASE 
				WHEN PSItem.DebitEntityType = 9 OR PSItem.DebitEntityType = 10
				THEN S.Amount - ISNULL(PSItem.SumAmount, 0)
				ELSE S.Amount
			 END AS ShredRemainingAmount
	 FROM GNR.vwShred S
	    INNER JOIN GNR.ShredItem SI 
	      ON S.ShredID = SI.ShredRef
		LEFT JOIN(SELECT SUM(PSI.Amount) SumAmount, psi.DebitEntityRef, PSI.DebitEntityType
				  FROM RPA.PartyAccountSettlementItem PSI  
				   INNER JOIN RPA.PartyAccountSettlement PS 
				     ON PS.PartyAccountSettlementID = PSI.PartyAccountSettlementRef 
				  GROUP BY psi.DebitEntityRef, PSI.DebitEntityType
				 )AS PSItem 
		  ON S.ShredID = PSItem.DebitEntityRef 
			AND PSItem.DebitEntityType = 
				CASE WHEN S.[Key] = 1 /*Invoice*/ THEN 8  /*ShredInvoiceInterestAndPenaltyItem*/
					 WHEN S.[Key] = 4 /**Personel Loan*/ THEN 9 /*ShredPersonelLoan*/
					 WHEN S.[key] = 6 /*Other Receivable*/ THEN 10 /*ShredOtherReceivable*/
				     ELSE NULL 
				END
	  GROUP BY 	S.ShredID, S.[Date], S.Number , PSItem.SumAmount, PSItem.DebitEntityType, S.Amount
		
	)
GO