
 IF object_Id('AST.Emplacement') IS NOT NULL 
 BEGIN 
	IF NOT EXISTS (SELECT * FROM AST.Emplacement WHERE EmplacementId = -1)
		BEGIN 
			INSERT INTO AST.Emplacement([EmplacementId],[Code],[Title],[Title_EN],[ParentRef],[Description],[Description_EN],
				[Version],[Creator],[CreationDate],[LastModifier],[LastModificationDate])
			VALUES(-1, '', N'سرشاخه', N'Root', NULL, '', '', 
				1, 1, GETDATE(), 1, GETDATE())
		END 
 END
 
 