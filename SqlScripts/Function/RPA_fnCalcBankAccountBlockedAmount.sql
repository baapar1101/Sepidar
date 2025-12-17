

GO


if object_id('Rpa.fnCalcBankAccountBlockedAmount') is not null
drop function Rpa.fnCalcBankAccountBlockedAmount
go

CREATE FUNCTION Rpa.fnCalcBankAccountBlockedAmount 
(
	@BankAccountId Int
)
RETURNS decimal(34,0)
AS
BEGIN
	DECLARE @Result decimal(34,0)
	Set @result = 0


	Select @Result =  ISNULL(SUM(ISNULL(DecreaseAmount, 0)), 0)
	FROM RPA.vwBankAccountGuaranteeCashDeposit 
	WHERE  BankAccountRef = @BankAccountId

	RETURN @Result 
End