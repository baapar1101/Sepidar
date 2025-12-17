If Object_ID('RPA.vwPaymentChequeOther') Is Not Null
	Drop View RPA.vwPaymentChequeOther
GO
CREATE VIEW RPA.vwPaymentChequeOther
AS
SELECT     PCO.PaymentChequeOtherId
         , PCO.ReceiptChequeRef
		 , RC.Number
		 , RC.SecondNumber
		 , RC.IsGuarantee
		 , RC.AccountNo
		 , RC.Amount
		 , RC.Date
		 , PCO.Description
		 , PCO.Description_En
		 , RC.BranchCode
		 , RC.BranchTitle
		 , PCO.PaymentHeaderRef
		 , PCO.HeaderNumber
		 , PCO.HeaderDate
		 , RC.AmountInBaseCurrency
		 , RC.CurrencyRef
		 , RC.Rate
		 , RC.DlRef
		 , RC.BankAccountTitle
		 , RC.BankAccountTitle_En
		 , RH.DlRef AS ChequeHeaderDLRef
		 , RH.DlCode AS ChequeHeaderDLCode
		 , RC.SayadCode
		 , RC.ChequeOwner
               
FROM         RPA.PaymentChequeOther AS PCO
INNER JOIN  RPA.vwReceiptCheque AS RC 
  ON PCO.ReceiptChequeRef = RC.ReceiptChequeId 
INNER JOIN  RPA.vwReceiptHeader RH 
  ON RH.ReceiptHeaderId = RC.ReceiptHeaderRef
