
----------Update contract's OnAccount
UPDATE CNT.[ContractPreReceiptItem]  SET [Type] = 2 /*PreReceipt*/
WHERE [Type] = 1 /*OnAccount*/
GO
---------Update status pre prices

IF EXISTS (SELECT 1 FROM sys.columns where object_id=object_id('CNT.Status') and
				[name] = 'OnAccount')
BEGIN
EXECUTE
('
	--first
	UPDATE CNT.[Status] SET PreReceipt = PreReceipt + OnAccount
	WHERE OnAccount > 0
	--second
	UPDATE CNT.[Status] SET OnAccount = 0
	WHERE OnAccount > 0
')
END

---------Drop status column
IF EXISTS (SELECT 1 FROM sys.columns where object_id=object_id('CNT.Status') and
				[name] = 'OnAccount')
BEGIN
EXECUTE
('
	IF NOT Exists (SELECT 1 FROM CNT.Status S WHERE S.OnAccount > 0)
	BEGIN
		ALTER TABLE [CNT].[Status] DROP COLUMN OnAccount
	END
')
END

