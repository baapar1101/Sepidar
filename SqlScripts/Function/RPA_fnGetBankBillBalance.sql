If Object_ID('RPA.fnGetBankBillBalance') Is Not Null
	Drop Function RPA.fnGetBankBillBalance
GO



-- =========================================================
-- Author:		Abdolah Zavari	
-- Create date: 24 Esfand 1387
-- Description:	It calculates balance of selected 
--              bank account up to selected date.
-- =========================================================

CREATE FUNCTION [RPA].[fnGetBankBillBalance] 
(
	@BankAccountRef int, @Date datetime
)
RETURNS decimal(19, 4) --currency
AS
BEGIN
	RETURN 
	CASE WHEN EXISTS
		  (SELECT  1
		   FROM    RPA.BankBill b1
		   WHERE   b1.Date < @Date AND b1.BankAccountRef = @BankAccountRef) 
		THEN 
		  ((SELECT ISNULL(BillFirstAmount, 0)
			FROM   Rpa.BankAccount a
			WHERE  a.BankAccountId = @BankAccountRef) +
		  (SELECT  SUM(Credit) - SUM(Debit)
		   FROM    RPA.vwBankBillItem bbi
		   WHERE   bbi.BankBillDate < @Date AND bbi.BankAccountRef = @BankAccountRef )) 
		ELSE
		  (SELECT  ISNULL(BillFirstAmount, 0)
		   FROM    Rpa.BankAccount a
		   WHERE   a.BankAccountId = @BankAccountRef) 
		END 
END




