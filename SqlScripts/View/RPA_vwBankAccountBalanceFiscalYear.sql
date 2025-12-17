If Object_ID('RPA.vwBankAccountBalanceFiscalYear') Is Not Null
	Drop View RPA.vwBankAccountBalanceFiscalYear
GO
CREATE VIEW Rpa.vwBankAccountBalanceFiscalYear
AS
SELECT     BankAccountId AS BankAccountRef, FirstAmount AS IncreaseAmount, 0 AS DecreaseAmount, 1 AS DocSpecificationRef, BankAccountId AS DocRef, 
           FirstDate AS Date, 'موجودي اوليه' AS DocDescription, 'First Balance' AS DocDescription_En, '' Number, '' HeaderNumber, '' ItemDescription, '' ItemDescription_En, 
			Round (FirstAmount * Rate, GNR.fnGetSystemCurrencyPrecisionCount()) AmountInBaseCurrency, Rate, null ReceiptPaymentType, 
			Case When (Config2.ReceiptAndPaymentInstallFiscalYear <> 0)
					then (Config2.ReceiptAndPaymentInstallFiscalYear)  
					else (Select Top 1 FiscalYearId From Fmk.FiscalYear Order by StartDate) End FiscalYearRef, 0 AS DocItemRef
FROM         RPA.BankAccount
				left outer join
				(Select top 1 Case When IsNumeric(value) = 1 then  convert(int, value)
								else 0	end ReceiptAndPaymentInstallFiscalYear                      
				from fmk.Configuration 
				Where [key] = 'ReceiptAndPaymentInstallFiscalYear') Config2 on 1 = 1



UNION ALL
SELECT     BankAccountId AS BankAccountRef, Rpa.BankAccountBalance.Balance AS IncreaseAmount, 0 AS DecreaseAmount, 1 AS DocSpecificationRef, BankAccountId AS DocRef, 
           Fmk.FiscalYear.StartDate - 1 AS Date, 'موجودي اوليه' AS DocDescription, 'First Balance' AS DocDescription_En, '' Number, '' HeaderNumber, '' ItemDescription, '' ItemDescription_En, 
			Round (Rpa.BankAccountBalance.Balance * Rate, 0) AmountInBaseCurrency, Rate, null ReceiptPaymentType, FiscalYearRef, 0 AS DocItemRef
FROM         RPA.BankAccount inner join
				GNR.Currency ON RPA.BankAccount.CurrencyRef = GNR.Currency.CurrencyId inner join 
			Rpa.BankAccountBalance On Rpa.BankAccountBalance.BankAccountRef = RPA.BankAccount.BankAccountId  inner join
			Fmk.FiscalYear On Fmk.FiscalYear.FiscalYearId = Rpa.BankAccountBalance.FiscalYearRef



UNION ALL
SELECT     Draft.BankAccountRef, Draft.Amount AS IncreaseAmount, 0 AS DecreaseAmount, 12 AS DocSpecificationRef, Draft.ReceiptHeaderRef AS DocRef, Draft.HeaderDate AS Date, 
                      'حواله' AS DocDescription, 'Draft' AS Description_En, Convert(nvarchar(20), Draft.Number),
			Draft.HeaderNumber, Draft.Description, Draft.Description_En, Draft.AmountInBaseCurrency, Draft.Rate, Header.Type, Header.FiscalYearRef, 0 AS DocItemRef
FROM         RPA.ReceiptDraft Draft INNER JOIN 
			RPA.ReceiptHeader Header ON Header.ReceiptHeaderId = Draft.ReceiptHeaderRef

UNION ALL
SELECT      Draft.BankAccountRef, 0 AS IncreaseAmountm,
            Draft.Amount AS DecreaseAmount,
			22 AS DocSpecificationRef, Draft.PaymentHeaderRef AS DocRef, Draft.HeaderDate AS Date,  
            'اعلاميه برداشت' AS DocDescription, 'Draft' AS Description_En, Draft.Number, Draft.HeaderNumber,  
			Draft.Description, Draft.Description_En,
            -1 * Draft.AmountInBaseCurrency,
            Draft.Rate, Header.Type, Header.FiscalYearRef, Draft.PaymentDraftId AS DocItemRef
FROM        RPA.PaymentDraft Draft
            INNER JOIN RPA.PaymentHeader Header ON Header.PaymentHeaderId = Draft.PaymentHeaderRef

UNION ALL
SELECT     itm.BankAccountRef, Chq.Amount AS IncreaseAmount, 0 AS DecreaseAmount, 32 AS DocSpecificationRef, itm.ReceiptChequeBankingRef AS DocRef, 
           itm.HeaderDate AS Date, 'وصول چك' AS DocDescription, 'Achieved Cheque' AS Description_En,
			Chq.Number, itm.HeaderNumber, Chq.Description, Chq.Description_En, Chq.AmountInBaseCurrency, Chq.Rate, Header.Type, banking.FiscalYearRef, 0 AS DocItemRef
FROM         RPA.ReceiptChequeBankingItem AS itm INNER JOIN
             RPA.ReceiptChequeBanking AS banking ON itm.ReceiptChequeBankingRef = banking.ReceiptChequeBankingId INNER JOIN 
             RPA.ReceiptCheque AS Chq ON itm.ReceiptChequeRef = Chq.ReceiptChequeId INNER JOIN 
			RPA.ReceiptHeader Header ON Header.ReceiptHeaderId = chq.ReceiptHeaderRef
WHERE     (itm.State = 4)

UNION ALL
SELECT     itm.BankAccountRef, 0 AS IncreaseAmount, Chq.Amount AS DecreaseAmount, 41 AS DocSpecificationRef, itm.PaymentChequeBankingRef AS DocRef,
			itm.HeaderDate AS Date, ' وصول چك پرداختني' AS DocDescription, 'Achieved Payment Cheque' AS Description_En, 
			chq.Number, itm.HeaderNumber, Chq.Description, Chq.Description_En, -1 * Chq.AmountInBaseCurrency, Chq.Rate, Header.Type, Header.FiscalYearRef, 0 AS DocItemRef
FROM         RPA.PaymentChequeBankingItem AS itm INNER JOIN
            RPA.PaymentCheque AS Chq ON itm.PaymentChequeRef = Chq.PaymentChequeId  INNER JOIN 
			RPA.PaymentHeader Header ON Header.PaymentHeaderId = chq.PaymentHeaderRef

UNION ALL
SELECT     Chq.BankAccountRef, 0 AS IncreaseAmount, Chq.Amount AS DecreaseAmount, 21 AS DocSpecificationRef, Chq.PaymentHeaderRef AS DocRef, 
            Chq.HeaderDate AS Date, ' چك پرداختني روز' AS DocDescription, 'Payment Day Cheque' AS Description_En,
			Chq.Number, Chq.HeaderNumber, Chq.Description, Chq.Description_En, -1 * Chq.AmountInBaseCurrency, Chq.Rate, Header.Type, Header.FiscalYearRef, 0 AS DocItemRef
FROM         RPA.PaymentCheque AS Chq INNER JOIN
                      RPA.PaymentHeader AS Header ON Header.PaymentHeaderId = Chq.PaymentHeaderRef
WHERE     (Chq.DurationType = 2) AND (Header.State <> 4) AND  (Chq.State <> 4) AND (Chq.IsGuarantee = 0) AND (NOT EXISTS
                          (SELECT     1 AS Expr1
                             FROM         RPA.PaymentChequeBankingItem AS X
                             WHERE     (Chq.PaymentChequeId = PaymentChequeRef)))
UNION ALL
SELECT     Chq.BankAccountRef, Chq.Amount AS IncreaseAmount, 0 AS DecreaseAmount, 52 AS DocSpecificationRef, itm.RefundChequeRef AS DocRef, 
			itm.HeaderDate, ' استرداد چك روز' AS DocDescription, 'Refund Payment Cheque' AS Description_En, Chq.Number, itm.HeaderNumber,
			Chq.Description, Chq.Description_En, Chq.AmountInBaseCurrency, Chq.Rate, Header.Type, Header.FiscalYearRef, 0 AS DocItemRef
FROM         RPA.RefundChequeItem AS itm INNER JOIN                   
			RPA.PaymentCheque AS Chq ON itm.PaymentChequeRef = Chq.PaymentChequeId  INNER JOIN 
			RPA.PaymentHeader Header ON Header.PaymentHeaderId = chq.PaymentHeaderRef
WHERE     (Chq.DurationType = 2) AND (Chq.IsGuarantee = 0)



