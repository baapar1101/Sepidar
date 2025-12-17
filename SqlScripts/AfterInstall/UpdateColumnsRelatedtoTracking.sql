
--Update tracking columns for SLS.ProductPack
UPDATE SLS.ProductPack SET Creator = 1, LastModifier = 1, CreationDate = GETDATE(), LastModificationDate = GETDATE()
	WHERE Creator IS NULL AND LastModifier IS NULL AND CreationDate IS NULL AND LastModificationDate IS NULL
