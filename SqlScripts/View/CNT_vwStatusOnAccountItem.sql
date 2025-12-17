If Object_ID('CNT.vwStatusOnAccountItem') Is Not Null
	Drop View CNT.vwStatusOnAccountItem
GO
CREATE VIEW CNT.vwStatusOnAccountItem
AS
SELECT     SOAI.StatusOnAccountItemID, 
		   SOAI.ReceiptRef, 
		   SOAI.StatusRef,
		   SOAI.PaymentRef, 
		   SOAI.Date, 
		   SOAI.Price, 
		   SOAI.Type, 
		   SOAI.Description, 
		   SOAI.Description_En, 
		   RH.Number ReceiptNumber,	  
		   PH.Number PaymentNumber,
		   CASE		WHEN SOAI.ReceiptRef IS NOT NULL THEN RH.AccountSlRef 
					WHEN SOAI.PaymentRef IS NOT NULL THEN PH.AccountSlRef 
					ELSE Null 
		   END AccountSlRef,
		   CASE		WHEN SOAI.ReceiptRef IS NOT NULL THEN RH.AccountCode 
					WHEN SOAI.PaymentRef IS NOT NULL THEN PH.AccountCode 
					ELSE Null 
		   END AccountCode,
		   CASE		WHEN SOAI.ReceiptRef IS NOT NULL THEN RH.AccountTitle 
					WHEN SOAI.PaymentRef IS NOT NULL THEN PH.AccountTitle 
					ELSE Null 
		   END AccountTitle,
		   CASE		WHEN SOAI.ReceiptRef IS NOT NULL THEN RH.AccountTitle_En 
					WHEN SOAI.PaymentRef IS NOT NULL THEN PH.AccountTitle_En 
					ELSE Null 
		   END AccountTitle_En

FROM         CNT.StatusOnAccountItem AS SOAI LEFT OUTER JOIN
             RPA.vwReceiptHeader AS RH ON SOAI.ReceiptRef = RH.ReceiptHeaderId LEFT OUTER JOIN
             RPA.vwPaymentHeader AS PH ON SOAI.PaymentRef = PH.PaymentHeaderId