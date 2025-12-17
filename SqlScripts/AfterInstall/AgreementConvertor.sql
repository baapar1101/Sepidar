BEGIN TRANSACTION MainTran
	IF (EXISTS(SELECT 1 FROM sys.columns WHERE Object_ID = Object_ID('SLS.Invoice') AND [Name] = 'Agreements') AND EXISTS(SELECT 1 FROM sys.columns WHERE Object_ID = Object_ID('DST.Order') AND [Name] = 'Agreements'))
	BEGIN
		BEGIN TRANSACTION ConvertTran
		BEGIN TRY
			DECLARE @AgreementTitle		  NVARCHAR(256);
			DECLARE @InvoiceRef		  	  int;
			DECLARE @OrderRef		   	  int;
			DECLARE @AgreementId		  int;
			DECLARE @AgreementIdTemp      int;
			SET @AgreementId = 1;
			SET @AgreementIdTemp = 0;
			DECLARE @cursorDeclarationQuery NVARCHAR(400);
			SET @cursorDeclarationQuery = 
			'DECLARE [ConvertorCursor] CURSOR FOR  
			(
			SELECT
			[Agreements],
			[InvoiceId],
			NULL AS [OrderId]
			FROM [SLS].[Invoice]
			WHERE Agreements IS NOT NULL
			UNION 
			SELECT
			[Agreements],
			NULL AS [InvoiceId],
			[OrderId]
			FROM [DST].[Order]
			WHERE Agreements IS NOT NULL
			)';
			EXEC sp_executesql @cursorDeclarationQuery;

			OPEN [ConvertorCursor] 
			FETCH NEXT FROM [ConvertorCursor] INTO @AgreementTitle, @InvoiceRef, @OrderRef
			WHILE @@FETCH_STATUS = 0  
			BEGIN
				SELECT TOP 1 @AgreementIdTemp = [AgreementId] FROM [DST].[Agreement] WHERE Title = @AgreementTitle
				IF (@AgreementIdTemp = 0)
				BEGIN
					EXEC FMK.spGetNextId 'DST.Agreement', @Id = @AgreementId OUTPUT
					INSERT INTO [DST].[Agreement]
					(AgreementId, Title, Title_En, Creator, CreationDate, LastModifier, LastModificationDate, [Version])
					VALUES (@AgreementId, @AgreementTitle, @AgreementTitle, 1, CONVERT(datetime2(0),GETDATE()), 1, CONVERT(datetime2(0),GETDATE()), 1);
				END
				IF (@InvoiceRef IS NOT NULL)
				BEGIN
					SELECT TOP 1 @AgreementIdTemp = [AgreementId] FROM [DST].[Agreement] WHERE Title = @AgreementTitle
					UPDATE [SLS].[Invoice] SET AgreementRef = @AgreementIdTemp WHERE InvoiceId = @InvoiceRef;
				END
				IF (@OrderRef IS NOT NULL)
				BEGIN
					SELECT TOP 1 @AgreementIdTemp = [AgreementId] FROM [DST].[Agreement] WHERE Title = @AgreementTitle
					UPDATE [DST].[Order] SET AgreementRef = @AgreementIdTemp WHERE OrderID = @OrderRef;
				END
				SET @AgreementIdTemp = 0;
				FETCH NEXT FROM [ConvertorCursor] INTO @AgreementTitle, @InvoiceRef, @OrderRef
			END 

			CLOSE [ConvertorCursor]  
			DEALLOCATE [ConvertorCursor]
			
		COMMIT TRANSACTION ConvertTran
		END TRY
		BEGIN CATCH
			IF (@@TRANCOUNT > 1) 
			ROLLBACK
		END CATCH
	END
	GO
	IF (EXISTS(SELECT 1 FROM sys.columns WHERE Object_ID = Object_ID('SLS.Invoice') AND [Name] = 'Agreements') AND EXISTS(SELECT 1 FROM sys.columns WHERE Object_ID = Object_ID('DST.Order') AND [Name] = 'Agreements'))
	BEGIN
		BEGIN TRANSACTION DeleteColumnsTran
		BEGIN TRY
			DECLARE @deleteOldAgreementColumnsQuery NVARCHAR(400);
			SET @deleteOldAgreementColumnsQuery =
			'IF EXISTS (SELECT 1 FROM sys.columns WHERE object_id = object_id(''SLS.Invoice'') AND [name] = ''Agreements'')
			BEGIN
				ALTER TABLE [SLS].[Invoice] DROP COLUMN [Agreements]
			END
			IF EXISTS (SELECT 1 FROM sys.columns WHERE object_id = object_id(''DST.Order'') AND [name] = ''Agreements'')
			BEGIN
				ALTER TABLE [DST].[Order] DROP COLUMN [Agreements]
			END'
			EXEC sp_executesql @deleteOldAgreementColumnsQuery;
		COMMIT TRANSACTION DeleteColumnsTran
		END TRY
		BEGIN CATCH
			IF (@@TRANCOUNT > 1)
				ROLLBACK
		END CATCH
	COMMIT TRANSACTION MainTran
	END
IF (@@TRANCOUNT > 0) ROLLBACK
