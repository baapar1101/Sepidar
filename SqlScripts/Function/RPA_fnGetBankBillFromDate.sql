If Object_ID('RPA.fnGetBankBillFromDate') Is Not Null
	Drop Function RPA.fnGetBankBillFromDate
GO



-- =========================================================
-- Author:		Abdolah Zavari	
-- Create date: 24 Esfand 1387
-- Description:	It finds previous bank bill date (FromDate) of a  
--              selected bank account up to selected date.
-- =========================================================

CREATE FUNCTION [RPA].[fnGetBankBillFromDate] 
(
	@BankAccountRef int, @Date datetime
)
RETURNS datetime
AS
BEGIN
	RETURN 
	CASE WHEN EXISTS
          (SELECT   1
             FROM   RPA.BankBill b1
             WHERE  b1.BankAccountRef = @BankAccountRef AND b1.Date < @Date) 
			THEN
			  (SELECT   MAX(Date)
				 FROM   RPA.BankBill b2
				 WHERE  b2.BankAccountRef = @BankAccountRef AND b2.Date < @Date) 		
		WHEN EXISTS
          (SELECT   1
             FROM   RPA.Reconciliation b1
             WHERE  b1.BankAccountRef = @BankAccountRef AND State = 4) 
			THEN
			  (SELECT   MAX(Date)
				 FROM   RPA.Reconciliation b2
				 WHERE  b2.BankAccountRef = @BankAccountRef AND State = 4) 
		ELSE
          (SELECT   FirstDate
             FROM   Rpa.BankAccount a
             WHERE  a.BankAccountId = @BankAccountRef) 
		END
		
END



