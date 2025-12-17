If Object_ID('RPA.vwBankBillItem') Is Not Null
	Drop View RPA.vwBankBillItem
GO
/*order by number
select * from rpa.vwbankaccount*/
CREATE VIEW RPA.vwBankBillItem
AS
SELECT     RPA.BankBillItem.BankBillItemId, RPA.BankBillItem.BankBillRef, RPA.BankBillItem.VoucherNumber, RPA.BankBillItem.VoucherDate, 
                      RPA.BankBillItem.Debit, RPA.BankBillItem.Credit, RPA.BankBillItem.Description, RPA.BankBillItem.Description_En, RPA.BankBillItem.Version, 
                      RPA.BankBill.Date AS BankBillDate, RPA.BankBill.BankAccountRef
FROM         RPA.BankBill INNER JOIN
                      RPA.BankBillItem ON RPA.BankBill.BankBillId = RPA.BankBillItem.BankBillRef

