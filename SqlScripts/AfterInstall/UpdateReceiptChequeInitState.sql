Update Chq
Set InitState = CASE WHEN (Submit.HeaderState = 4 AND Chq.State = 1) THEN 1 
					WHEN (Submit.HeaderState = 4 AND  Chq.State > 1) THEN 2 
					ELSE 1 END 

From Rpa.ReceiptCheque Chq left outer join 
     Rpa.ReceiptChequeBankingItem Submit on Submit.ReceiptChequeRef = Chq.ReceiptChequeId
Where InitState is null

Go