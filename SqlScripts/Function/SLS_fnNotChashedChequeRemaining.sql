
IF OBJECT_ID('SLS.fnNotChashedChequeRemaining') IS NOT NULL
	DROP FUNCTION SLS.fnNotChashedChequeRemaining
GO

CREATE FUNCTION SLS.fnNotChashedChequeRemaining
(
   @FiscalYearRef INT
)
RETURNS TABLE
RETURN
      SELECT  PartyDLRef
        ,SUM(ISNULL(ChequeAmount,0)) TotalChequeAmount
      FROM 
           (
             SELECT R.Date ReceiptDate
                   ,R.DlRef PartyDLRef
                   ,RC.AmountInBaseCurrency ChequeAmount
                   ,RC.IsGuarantee
                   ,RCH.Date 

             FROM RPA.ReceiptHeader R 
             JOIN RPA.ReceiptCheque RC 
               ON R.ReceiptHeaderId = RC.ReceiptHeaderRef
             JOIN (SELECT * 
                   FROM RPA.vwReceiptChequeHistory H 
                   WHERE H.ReceiptChequeHistoryId =  
                                                   (SELECT TOP 1 ReceiptChequeHistoryId 
                                                    FROM RPA.vwReceiptChequeHistory HH
                                                    WHERE HH.ReceiptChequeRef = H.ReceiptChequeRef
                                                    ORDER BY HH.Date DESC)
                   )RCH
               ON RCH.ReceiptChequeRef = RC.ReceiptChequeId
  
             WHERE R.FiscalYearRef = @FiscalYearRef
			       AND RC.IsGuarantee = 0
                   AND RCH.State IN(1,2,8)
				   AND R.Type = 1

           ) as B

      GROUP BY PartyDLREf
      
GO