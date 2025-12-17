If Object_ID('RPA.vwCashBalance') Is Not Null
	Drop View RPA.vwCashBalance
GO
CREATE VIEW RPA.vwCashBalance
AS
SELECT     CashId AS CashRef, FirstAmount AS IncreaseAmount, 0 AS DecreaseAmount, 2 AS DocSpecificationRef, CashId AS DocRef, FirstDate AS Date, 
            'موجودي اوليه' AS DocDescription, 'First Balance' AS DocDescription_En, '' AS Number, 
			'' AS ItemDescription, '' AS ItemDescription_En,  round(FirstAmount * Rate , GNR.fnGetSystemCurrencyPrecisionCount()) AS AmountInBaseCurrency, Rate, null ReceiptPaymentType
FROM         RPA.Cash

UNION ALL
SELECT     CashRef, Amount AS IncreaseAmount, 0 AS DecreaseAmount, 10 AS DocSpecificationRef, ReceiptHeaderId AS DocRef, Date, 
			'رسيد دريافت' AS DocDescription, 'Receipt Cash' AS Description_En, CAST(Number as nvarchar), Description, Description_En, 
			AmountInBaseCurrency, Rate, Type ReceiptPaymetType
FROM         RPA.ReceiptHeader
WHERE     (Amount > 0)
UNION ALL
SELECT     Header.CashRef, Item.Amount AS IncreaseAmount, 0 AS DecreaseAmount, 34 AS DocSpecificationRef, Header.ReceiptChequeBankingId AS DocRef, 
		   Header.Date, 'نقد كردن چك' AS DocDescription, 'Cash Cheque' AS Description_En, CAST(Item.Number AS nvarchar), Item.Description, Item.Description_En, Item.AmountInBaseCurrency, 
           Item.Rate, Receipt.Type
FROM         RPA.ReceiptChequeBanking AS Header INNER JOIN
			RPA.vwReceiptChequeBankingItem AS Item ON Header.ReceiptChequeBankingId = Item.ReceiptChequeBankingRef INNER JOIN
			RPA.ReceiptCheque AS Chq ON Chq.ReceiptChequeId = Item.ReceiptChequeRef INNER JOIN
			RPA.ReceiptHeader Receipt ON Receipt.ReceiptHeaderId = Chq.ReceiptHeaderRef
WHERE     (Header.Type = 3)UNION ALL
SELECT     CashRef, 0 AS IncreaseAmount, Amount AS DecreaseAmount, 20 AS DocSpecificationRef, PaymentHeaderId AS DocRef, Date, 
			'اعلاميه پرداخت' AS DocDescription, 'Payment Cash' AS Description_En,CAST( Number AS nvarchar), Description, 
			Description_En, AmountInBaseCurrency, Rate, Type ReceiptPaymetType
FROM         RPA.PaymentHeader
WHERE     (Amount > 0)
