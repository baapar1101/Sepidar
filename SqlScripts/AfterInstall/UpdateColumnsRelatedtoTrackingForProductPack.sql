
--Update tracking columns for RPA.POS
UPDATE RPA.POS SET Creator = 1, LastModifier = 1, CreationDate = GETDATE(), LastModificationDate = GETDATE()
	WHERE Creator IS NULL AND LastModifier IS NULL AND CreationDate IS NULL AND LastModificationDate IS NULL

--Update tracking columns for RPA.Cash
UPDATE RPA.CASH SET Creator = 1, LastModifier = 1, CreationDate = GETDATE(), LastModificationDate = GETDATE()
	WHERE Creator IS NULL AND LastModifier IS NULL AND CreationDate IS NULL AND LastModificationDate IS NULL

--Update tracking columns for RPA.BankAccount
UPDATE RPA.BankAccount SET Creator = 1, LastModifier = 1, CreationDate = GETDATE(), LastModificationDate = GETDATE()
	WHERE Creator IS NULL AND LastModifier IS NULL AND CreationDate IS NULL AND LastModificationDate IS NULL

--Update tracking columns for RPA.ChequeBook
UPDATE RPA.ChequeBook SET Creator = 1, LastModifier = 1, CreationDate = GETDATE(), LastModificationDate = GETDATE()
	WHERE Creator IS NULL AND LastModifier IS NULL AND CreationDate IS NULL AND LastModificationDate IS NULL