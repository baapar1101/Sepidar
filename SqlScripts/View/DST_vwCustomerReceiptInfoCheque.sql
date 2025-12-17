IF OBJECT_ID('DST.vwCustomerReceiptInfoCheque') IS NOT NULL
	DROP VIEW DST.vwCustomerReceiptInfoCheque
GO

CREATE VIEW DST.vwCustomerReceiptInfoCheque
AS

SELECT
    CRIC.CustomerReceiptInfoChequeId
    ,CRIC.CustomerReceiptInfoRef
    ,CRIC.Amount
    ,CRIC.BankRef
    ,CRIC.Date
    ,CRIC.Number
    ,CRIC.SayadCode
    ,CRIC.AccountNo
    ,B.Title BankTitle
FROM DST.CustomerReceiptInfoCheque as CRIC
JOIN RPA.Bank B on B.BankId = CRIC.BankRef
