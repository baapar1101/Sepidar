if  exists (select 1 from sys.columns where object_id=object_id('RPA.BankAccount') and
						[name] = 'BlockedAmount')
	UPDATE Rpa.BankAccount
	SET BlockedAmount =  Rpa.fnCalcBankAccountBlockedAmount(BankAccountId)
	Where BlockedAmount IS NULL

GO


