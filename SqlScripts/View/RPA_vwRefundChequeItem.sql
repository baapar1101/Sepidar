If Object_ID('RPA.vwRefundChequeItem') Is Not Null
	Drop View RPA.vwRefundChequeItem
GO
CREATE VIEW RPA.vwRefundChequeItem
AS
SELECT    Refund.RefundChequeItemID
          , Refund.ReceiptChequeRef
		  , Refund.PaymentChequeRef
		  , Refund.RefundChequeRef
		  , Receipt.Number
		  , Receipt.Date
          , Receipt.SecondNumber
		  , Receipt.SayadCode
		  , Receipt.DlRef AS OriginalDLRef
		  , Receipt.DlCode AS OriginalDLCode
		  , Receipt.Description
		  , Receipt.Description_En
		  , Receipt.BankAccountTitle
		  , Receipt.BankAccountTitle_En
		  , Receipt.Amount, 
          1 AS DurationType
		  , NULL AS BankAccountRef
		  , Receipt.AmountInBaseCurrency
		  , Receipt.CurrencyRef
		  , Receipt.Rate
		  , Receipt.ReceiptHeaderRef
		  , NULL AS PaymentHeaderRef
		  , Receipt.IsGuarantee
		  , Refund.HeaderDate
		  , Refund.HeaderNumber
		  , Refund.State
		  , Refund.RefundDescription
		  , Refund.RefundDescription_En
		  , Receipt.ChequeOwner

FROM              RPA.RefundChequeItem AS Refund 
  INNER JOIN      RPA.vwReceiptCheque AS Receipt ON Receipt.ReceiptChequeId = Refund.ReceiptChequeRef

UNION ALL

SELECT    Refund.RefundChequeItemID
        , Refund.ReceiptChequeRef
		, Refund.PaymentChequeRef
		, Refund.RefundChequeRef
		, Payment.Number
		, Payment.Date
        , Payment.SecondNumber
		, Payment.SayadCode
		, Payment.DlRef  AS OriginalDLRef
		, Payment.DlCode	AS OriginalDLCode
		, Payment.Description
		, Payment.Description_En
		, Payment.BankAccountTitle
		, Payment.BankAccountTitle_En
		, Payment.Amount
		, Payment.DurationType
		, Payment.BankAccountRef, 
          Payment.AmountInBaseCurrency
		, Payment.CurrencyRef
		, Payment.Rate
		, NULL AS ReceiptHeaderRef
		, Payment.PaymentHeaderRef, 
          Payment.IsGuarantee
		, Refund.HeaderDate
		, Refund.HeaderNumber
		, Refund.State
		, Refund.RefundDescription
		, Refund.RefundDescription_En
		, NULL AS ChequeOwner

FROM            RPA.RefundChequeItem AS Refund 
  INNER JOIN    RPA.vwPaymentCheque AS Payment ON Payment.PaymentChequeId = Refund.PaymentChequeRef

