If Object_ID('RPA.vwBankBill') Is Not Null
	Drop View RPA.vwBankBill
GO
/*order by number
select * from rpa.vwbankaccount
order by number*/
CREATE VIEW RPA.vwBankBill
AS
SELECT     bb.BankBillId, bb.Number, bb.Date, bb.FiscalYearRef, bb.BankAccountRef, bb.Description, bb.Description_En, bb.Version, bb.Creator, bb.CreationDate, 
           bb.LastModifier, bb.LastModificationDate,
           ba.BankAccountTitle AS BankAccountTitle,
           ba.CurrencyTitle AS BankAccountCurrencyTitle, 
           RPA.fnGetBankBillFromDate(bb.BankAccountRef, bb.Date) AS FromDate, RPA.fnGetBankBillBalance(bb.BankAccountRef, bb.Date) AS Balance,
           ba.BankAccountTitle_En,
           ba.CurrencyTitle AS BankAccountCurrencyTitle_En 
           
FROM     RPA.BankBill AS bb INNER JOIN
           RPA.vwBankAccount AS ba ON bb.BankAccountRef = ba.BankAccountId

