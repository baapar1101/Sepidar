If Object_ID('RPA.vwCashBalanceFiscalYear') Is Not Null
	Drop View RPA.vwCashBalanceFiscalYear
GO
CREATE VIEW RPA.vwCashBalanceFiscalYear
AS
SELECT     CashId AS CashRef, FirstAmount AS IncreaseAmount, 0 AS DecreaseAmount, 2 AS DocSpecificationRef, CashId AS DocRef, FirstDate AS Date, 
                      'موجودي اوليه' AS DocDescription, 'First Balance' AS DocDescription_En, '' AS Number, '' AS ItemDescription, '' AS ItemDescription_En, 
                      round(FirstAmount * Rate, GNR.fnGetSystemCurrencyPrecisionCount()) AS AmountInBaseCurrency, Rate, NULL ReceiptPaymentType,
					Case When (Config2.ReceiptAndPaymentInstallFiscalYear <> 0)
					then (Config2.ReceiptAndPaymentInstallFiscalYear)  
					else (Select Top 1 FiscalYearId From Fmk.FiscalYear Order by StartDate) End FiscalYearRef
FROM         RPA.Cash 
				left outer join
				(Select top 1 Case When IsNumeric(value) = 1 then  convert(int, value)
								else 0	end ReceiptAndPaymentInstallFiscalYear                      
				from fmk.Configuration 
				Where [key] = 'ReceiptAndPaymentInstallFiscalYear') Config2 on 1 = 1

UNION ALL
SELECT     CashId AS CashRef, Rpa.CashBalance.Balance AS IncreaseAmount, 0 AS DecreaseAmount, 2 AS DocSpecificationRef, CashId AS DocRef, 
                      Fmk.FiscalYear.StartDate - 1 AS Date, 'موجودي اوليه' AS DocDescription, 'First Balance' AS DocDescription_En, '' AS Number, '' AS ItemDescription, 
                      '' AS ItemDescription_En, round(Rpa.CashBalance.Balance * Rate, 0) AS AmountInBaseCurrency, Rate, NULL ReceiptPaymentType, 
                      FiscalYearRef
FROM         RPA.Cash INNER JOIN
                      Rpa.CashBalance ON Rpa.CashBalance.CashRef = RPA.Cash.CashId INNER JOIN
                      Fmk.FiscalYear ON Fmk.FiscalYear.FiscalYearId = Rpa.CashBalance.FiscalYearRef
UNION ALL
SELECT     CashRef, Amount AS IncreaseAmount, 0 AS DecreaseAmount, 10 AS DocSpecificationRef, ReceiptHeaderId AS DocRef, Date, 
                      'رسيد دريافت' AS DocDescription, 'Receipt Cash' AS Description_En, Cast(Number as nvarchar(max)), Description, Description_En, AmountInBaseCurrency, Rate, 
                      Type ReceiptPaymetType, RPA.ReceiptHeader.FiscalYearRef
FROM         RPA.ReceiptHeader
WHERE     (Amount > 0)
UNION ALL
SELECT     CashRef, 0 AS IncreaseAmount, Amount AS DecreaseAmount, 20 AS DocSpecificationRef, PaymentHeaderId AS DocRef, Date, 
                      'اعلاميه پرداخت' AS DocDescription, 'Payment Cash' AS Description_En, Cast(Number as nvarchar(max)), Description, Description_En, - 1 * AmountInBaseCurrency, Rate, 
                      Type ReceiptPaymetType, RPA.PaymentHeader.FiscalYearRef
FROM         RPA.PaymentHeader
WHERE     (Amount > 0)
UNION ALL
SELECT     Header.CashRef, Item.Amount AS IncreaseAmount, 0 AS DecreaseAmount, 34 AS DocSpecificationRef, Header.ReceiptChequeBankingId AS DocRef, 
                      Header.Date, 'نقد كردن چك' AS DocDescription, 'Cash Cheque' AS Description_En, Item.Number, Item.Description, Item.Description_En, 
                      Item.AmountInBaseCurrency, Item.Rate, Receipt.Type, Header.FiscalYearRef
FROM         RPA.ReceiptChequeBanking AS Header INNER JOIN
                      RPA.vwReceiptChequeBankingItem AS Item ON Header.ReceiptChequeBankingId = Item.ReceiptChequeBankingRef INNER JOIN
                      RPA.ReceiptCheque AS Chq ON Chq.ReceiptChequeId = Item.ReceiptChequeRef INNER JOIN
                      RPA.ReceiptHeader Receipt ON Receipt.ReceiptHeaderId = Chq.ReceiptHeaderRef
WHERE     (Header.Type = 3)