If Object_ID('RPA.vwBankAccountGuaranteeCashDeposit') Is Not Null
	Drop View RPA.vwBankAccountGuaranteeCashDeposit
GO
CREATE VIEW Rpa.vwBankAccountGuaranteeCashDeposit
AS

SELECT		BankAccountRef, 0 AS IncreaseAmount, PureAmount AS DecreaseAmount, 60 AS DocSpecificationRef, GuaranteeId AS DocRef, 
			Date As Date, 'سپرده نقدي ضمانت نامه' AS DocDescription, 'Cash Deposit For Guarantee' AS DocDescription_En, 
			'' Number, DocumentNumber HeaderNumber, Description, Description_En, -1 * PureAmount AmountInBaseCurrency, 1 Rate, null ReceiptPaymentType
FROM		CNT.vwGuarantee
WHERE		WarrantyRef = -5 AND State <> 3 AND PureAmount <> 0



