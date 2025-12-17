UPDATE CNT.[Status] SET ConfirmationDate = [Date], ConfirmationState = 2 /*Confirmed*/
WHERE StatusID IN
			(SELECT StatusID  
			 FROM CNT.[Status] S
			 WHERE S.VoucherRef is not null      
			   AND S.ConfirmationState = 1 /*Register (Default)*/
			   AND S.ConfirmationDate is null
			 )