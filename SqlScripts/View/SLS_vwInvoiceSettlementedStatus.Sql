IF OBJECT_ID('SLS.vwInvoiceSettlementedStatus') IS NOT NULL
  DROP View SLS.vwInvoiceSettlementedStatus
GO
Create View SLS.vwInvoiceSettlementedStatus
AS
/*
	SELECT PS.Code , PS.Title , PS.Title , b.LocaleName
	FROM FMK.Lookup PS
	LEFT JOIN FMK.LookupLocale PS ON I.LookupID = b.LookupRef AND LocaleName = 'en'
	WHERE type = 'ReceiptChequeState'

		4	æÕæá			Achieved
		16	äÞÏ ÔÏå			Cashed
		32	ÎÑÌ ÔÏå			SubmitToOther

	*	1	äÒÏ ÕäÏæÞ		InCash
	*	2	æÇÐÇÑ Èå ÈÇäß	SubmitedToBank
	*	8	æÇÎæÇÓÊ			Protested
	*	64	ÇÓÊÑÏÇÏ			Refunded
*/
	SELECT InvoiceRef = I.InvoiceId, 
	       IsSettlementedExcludeCheques = case when InvRem.RemainingAmount = 0 then 1 else 0 end,
	       IsSettlementedIncludeCheques = case when InvRem.RemainingAmount = 0 AND ISNULL(NotAchievedChequeCount,0) = 0 then 1 else 0 end
	
	FROM SLS.Invoice I
	  LEFT JOIN (
	  		      SELECT DPSI.DebitEntityRef as InvoiceRef 
	  		      	     ,NotAchievedChequeCount = SUM(CASE WHEN RC.State in (1,2,8,64) THEN 1 ELSE 0 END)
	  		    
	  		      FROM      RPA.PartyAccountSettlementItem DPSI
	  		        LEFT JOIN RPA.PartyAccountSettlement     PS 
	  		          ON DPSI.PartyAccountSettlementRef = PS.PartyAccountSettlementID
	  		        INNER JOIN RPA.PartyAccountSettlementItem CPSI
	  		          ON CPSI.PartyAccountSettlementRef = PS.PartyAccountSettlementID
	  		        LEFT JOIN RPA.ReceiptCheque RC 
	  		          ON    CPSI.CreditEntityType = 23 /*Receipt*/
	  		            AND CPSI.CreditEntityRef = RC.ReceiptHeaderRef
	  		      
	  		      WHERE   DPSI.DebitEntityType = 1 /*Invoice*/ 
	  		          AND DPSI.DebitEntityRef IS NOT NULL  /*=> InvoiceRef*/
	  		      
	  		      GROUP BY DPSI.DebitEntityRef
	  	        )Settlements 
		ON I.InvoiceId = Settlements.InvoiceRef
	  LEFT JOIN SLS.fnInvoiceRemaining() InvRem 
	    ON I.InvoiceId = InvRem.InvoiceID
GO
