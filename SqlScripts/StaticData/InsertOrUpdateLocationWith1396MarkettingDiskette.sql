
IF (SELECT COUNT(*) FROM GNR.[Location]) > 2
BEGIN
	declare @Id int = NULL
	exec [FMK].[spGetNextId] 'GNR.Location', @Id OUTPUT
	
	IF NOT EXISTS (SELECT [Title] FROM [GNR].[Location] WHERE [Title] = N'شهر قدس' AND [Type] = 3 AND [Parent] = 10)
	BEGIN
		set @Id = @Id + 1
		INSERT INTO [GNR].[Location] ([LocationId], [Title], [Title_En], [Code], [Parent], [Type], [Version], [Creator], [CreationDate], [LastModifier], [LastModificationDate], [MinistryofFinanceCode], [TaxFileCode])
		VALUES (@Id, N'شهر قدس', N'شهر قدس', NULL, 10, N'3', 1, 1, GETDATE(), 1, GETDATE(), N'1007300', NULL)
	END

	IF NOT EXISTS (SELECT [Title] FROM [GNR].[Location] WHERE [Title] = N'بهارستان' AND [Type] = '3' AND [Parent] = 10)
	BEGIN
		set @Id = @Id + 1
		INSERT INTO [GNR].[Location] ([LocationId], [Title], [Title_En], [Code], [Parent], [Type], [Version], [Creator], [CreationDate], [LastModifier], [LastModificationDate], [MinistryofFinanceCode], [TaxFileCode])
		VALUES (@Id, N'بهارستان', N'بهارستان', NULL, 10, N'3', 1, 1, GETDATE(), 1, GETDATE(), N'1007400', NULL)
	END

	IF NOT EXISTS (SELECT [Title] FROM [GNR].[Location] WHERE [Title] = N'پرديس' AND [Type] = '3' AND [Parent] = 10)
	BEGIN
		set @Id = @Id + 1
		INSERT INTO [GNR].[Location] ([LocationId], [Title], [Title_En], [Code], [Parent], [Type], [Version], [Creator], [CreationDate], [LastModifier], [LastModificationDate], [MinistryofFinanceCode], [TaxFileCode])
		VALUES (@Id, N'پرديس', N'پرديس', NULL, 10, N'3', 1, 1, GETDATE(), 1, GETDATE(), N'1099909', NULL)
	END

	IF NOT EXISTS (SELECT [Title] FROM [GNR].[Location] WHERE [Title] = N'سيسخت' AND [Type] = '3' AND [Parent] = 22)
	BEGIN
		set @Id = @Id + 1
		INSERT INTO [GNR].[Location] ([LocationId], [Title], [Title_En], [Code], [Parent], [Type], [Version], [Creator], [CreationDate], [LastModifier], [LastModificationDate], [MinistryofFinanceCode], [TaxFileCode])
		VALUES (@Id, N'سيسخت', N'سيسخت', NULL, 22, N'3', 1, 1, GETDATE(), 1, GETDATE(), N'2801500', NULL)
	END

	IF NOT EXISTS (SELECT [Title] FROM [GNR].[Location] WHERE [Title] = N'طبس' AND [Type] = '3' AND [Parent] = 15)
	BEGIN
		set @Id = @Id + 1
		INSERT INTO [GNR].[Location] ([LocationId], [Title], [Title_En], [Code], [Parent], [Type], [Version], [Creator], [CreationDate], [LastModifier], [LastModificationDate], [MinistryofFinanceCode], [TaxFileCode])
		VALUES (@Id, N'طبس', N'طبس', NULL, 15, N'3', 1, 1, GETDATE(), 1, GETDATE(), N'3108000', NULL)
	END

	IF NOT EXISTS (SELECT [Title] FROM [GNR].[Location] WHERE [Title] = N'كوثر' AND [Type] = '3' AND [Parent] = 6)
	BEGIN
		set @Id = @Id + 1
		INSERT INTO [GNR].[Location] ([LocationId], [Title], [Title_En], [Code], [Parent], [Type], [Version], [Creator], [CreationDate], [LastModifier], [LastModificationDate], [MinistryofFinanceCode], [TaxFileCode])
		VALUES (@Id, N'كوثر', N'كوثر', NULL, 6, N'3', 1, 1, GETDATE(), 1, GETDATE(), N'6106500', NULL)
	END

	/******************/

	IF NOT EXISTS (SELECT [Title] FROM [GNR].[Location] WHERE [Title] = N'روماني' AND [Type] = '1')
	BEGIN
		set @Id = @Id + 1
		INSERT INTO [GNR].[Location] ([LocationId], [Title], [Title_En], [Code], [Parent], [Type], [Version], [Creator], [CreationDate], [LastModifier], [LastModificationDate], [MinistryofFinanceCode], [TaxFileCode])
		VALUES (@Id, N'روماني', N'روماني', NULL, 1, N'1', 1, 1, GETDATE(), 1, GETDATE(), N'9801003', NULL)
	END
	ELSE
		UPDATE [GNR].[Location] SET [MinistryofFinanceCode] = N'9801003' WHERE [Title] = N'روماني' AND [Type] = '1'

	IF NOT EXISTS (SELECT [Title] FROM [GNR].[Location] WHERE [Title] = N'برزيل' AND [Type] = '1') 
	BEGIN 
		set @Id = @Id + 1
		INSERT INTO [GNR].[Location] ([LocationId], [Title], [Title_En], [Code], [Parent], [Type], [Version], [Creator], [CreationDate], [LastModifier], [LastModificationDate], [MinistryofFinanceCode], [TaxFileCode])
		VALUES (@Id, N'برزيل', N'برزيل', NULL, 1, N'1', 1, 1, GETDATE(), 1, GETDATE(), N'9801004', NULL)
	END 
	ELSE
		UPDATE [GNR].[Location] SET [MinistryofFinanceCode] = N'9801004' WHERE [Title] = N'برزيل' AND [Type] = '1'

	IF NOT EXISTS (SELECT [Title] FROM [GNR].[Location] WHERE [Title] = N'ژاپن' AND [Type] = '1') 
	BEGIN 
		set @Id = @Id + 1
		INSERT INTO [GNR].[Location] ([LocationId], [Title], [Title_En], [Code], [Parent], [Type], [Version], [Creator], [CreationDate], [LastModifier], [LastModificationDate], [MinistryofFinanceCode], [TaxFileCode])
		VALUES (@Id, N'ژاپن', N'ژاپن', NULL, 1, N'1', 1, 1, GETDATE(), 1, GETDATE(), N'9801009', NULL)
	END 
	ELSE
		UPDATE [GNR].[Location] SET [MinistryofFinanceCode] = N'9801009' WHERE [Title] = N'ژاپن' AND [Type] = '1'

	IF NOT EXISTS (SELECT [Title] FROM [GNR].[Location] WHERE [Title] = N'فنلاند' AND [Type] = '1')
	BEGIN
		set @Id = @Id + 1
		INSERT INTO [GNR].[Location] ([LocationId], [Title], [Title_En], [Code], [Parent], [Type], [Version], [Creator], [CreationDate], [LastModifier], [LastModificationDate], [MinistryofFinanceCode], [TaxFileCode])
		VALUES (@Id, N'فنلاند', N'فنلاند', NULL, 1, N'1', 1, 1, GETDATE(), 1, GETDATE(), N'9801020', NULL)
	END 
	ELSE
		UPDATE [GNR].[Location] SET [MinistryofFinanceCode] = N'9801020' WHERE [Title] = N'فنلاند' AND [Type] = '1'

	IF NOT EXISTS (SELECT [Title] FROM [GNR].[Location] WHERE [Title] = N'آرژانتين' AND [Type] = '1')
	BEGIN
		set @Id = @Id + 1
		INSERT INTO [GNR].[Location] ([LocationId], [Title], [Title_En], [Code], [Parent], [Type], [Version], [Creator], [CreationDate], [LastModifier], [LastModificationDate], [MinistryofFinanceCode], [TaxFileCode])
		VALUES (@Id, N'آرژانتين', N'آرژانتين', NULL, 1, N'1', 1, 1, GETDATE(), 1, GETDATE(), N'9801021', NULL)
	END 
	ELSE
		UPDATE [GNR].[Location] SET [MinistryofFinanceCode] = N'9801021' WHERE [Title] = N'آرژانتين' AND [Type] = '1'

	IF NOT EXISTS (SELECT [Title] FROM [GNR].[Location] WHERE [Title] = N'كانادا' AND [Type] = '1')
	BEGIN
		set @Id = @Id + 1
		INSERT INTO [GNR].[Location] ([LocationId], [Title], [Title_En], [Code], [Parent], [Type], [Version], [Creator], [CreationDate], [LastModifier], [LastModificationDate], [MinistryofFinanceCode], [TaxFileCode])
		VALUES (@Id, N'كانادا', N'كانادا', NULL, 1, N'1', 1, 1, GETDATE(), 1, GETDATE(), N'9801022', NULL)
	END 
	ELSE
		UPDATE [GNR].[Location] SET [MinistryofFinanceCode] = N'9801022' WHERE [Title] = N'كانادا' AND [Type] = '1'

	IF NOT EXISTS (SELECT [Title] FROM [GNR].[Location] WHERE [Title] = N'تايلند' AND [Type] = '1')
	BEGIN
		set @Id = @Id + 1
		INSERT INTO [GNR].[Location] ([LocationId], [Title], [Title_En], [Code], [Parent], [Type], [Version], [Creator], [CreationDate], [LastModifier], [LastModificationDate], [MinistryofFinanceCode], [TaxFileCode])
		VALUES (@Id, N'تايلند', N'تايلند', NULL, 1, N'1', 1, 1, GETDATE(), 1, GETDATE(), N'9801023', NULL)
	END 
	ELSE
		UPDATE [GNR].[Location] SET [MinistryofFinanceCode] = N'9801023' WHERE [Title] = N'تايلند' AND [Type] = '1'

	IF NOT EXISTS (SELECT [Title] FROM [GNR].[Location] WHERE [Title] = N'يونان' AND [Type] = '1')
	BEGIN
		set @Id = @Id + 1
		INSERT INTO [GNR].[Location] ([LocationId], [Title], [Title_En], [Code], [Parent], [Type], [Version], [Creator], [CreationDate], [LastModifier], [LastModificationDate], [MinistryofFinanceCode], [TaxFileCode])
		VALUES (@Id, N'يونان', N'يونان', NULL, 1, N'1', 1, 1, GETDATE(), 1, GETDATE(), N'9801103', NULL)
	END 
	ELSE
		UPDATE [GNR].[Location] SET [MinistryofFinanceCode] = N'9801103' WHERE [Title] = N'يونان' AND [Type] = '1'

	IF NOT EXISTS (SELECT [Title] FROM [GNR].[Location] WHERE [Title] = N'سوئيس' AND [Type] = '1')
	BEGIN
		set @Id = @Id + 1
		INSERT INTO [GNR].[Location] ([LocationId], [Title], [Title_En], [Code], [Parent], [Type], [Version], [Creator], [CreationDate], [LastModifier], [LastModificationDate], [MinistryofFinanceCode], [TaxFileCode])
		VALUES (@Id, N'سوئيس', N'سوئيس', NULL, 1, N'1', 1, 1, GETDATE(), 1, GETDATE(), N'9802010', NULL)
	END 
	ELSE
		UPDATE [GNR].[Location] SET [MinistryofFinanceCode] = N'9802010' WHERE [Title] = N'سوئيس' AND [Type] = '1'

	IF NOT EXISTS (SELECT [Title] FROM [GNR].[Location] WHERE [Title] = N'دانمارك' AND [Type] = '1')
	BEGIN
		set @Id = @Id + 1
		INSERT INTO [GNR].[Location] ([LocationId], [Title], [Title_En], [Code], [Parent], [Type], [Version], [Creator], [CreationDate], [LastModifier], [LastModificationDate], [MinistryofFinanceCode], [TaxFileCode])
		VALUES (@Id, N'دانمارك', N'دانمارك', NULL, 1, N'1', 1, 1, GETDATE(), 1, GETDATE(), N'9802011', NULL)
	END 
	ELSE
		UPDATE [GNR].[Location] SET [MinistryofFinanceCode] = N'9802011' WHERE [Title] = N'دانمارك' AND [Type] = '1'

	IF NOT EXISTS (SELECT [Title] FROM [GNR].[Location] WHERE [Title] = N'يوگوسلاوي' AND [Type] = '1')
	BEGIN
		set @Id = @Id + 1
		INSERT INTO [GNR].[Location] ([LocationId], [Title], [Title_En], [Code], [Parent], [Type], [Version], [Creator], [CreationDate], [LastModifier], [LastModificationDate], [MinistryofFinanceCode], [TaxFileCode])
		VALUES (@Id, N'يوگوسلاوي', N'يوگوسلاوي', NULL, 1, N'1', 1, 1, GETDATE(), 1, GETDATE(), N'9802012', NULL)
	END 
	ELSE
		UPDATE [GNR].[Location] SET [MinistryofFinanceCode] = N'9802012' WHERE [Title] = N'يوگوسلاوي' AND [Type] = '1'

	IF NOT EXISTS (SELECT [Title] FROM [GNR].[Location] WHERE [Title] = N'قزاقستان' AND [Type] = '1')
	BEGIN
		set @Id = @Id + 1
		INSERT INTO [GNR].[Location] ([LocationId], [Title], [Title_En], [Code], [Parent], [Type], [Version], [Creator], [CreationDate], [LastModifier], [LastModificationDate], [MinistryofFinanceCode], [TaxFileCode])
		VALUES (@Id, N'قزاقستان', N'قزاقستان', NULL, 1, N'1', 1, 1, GETDATE(), 1, GETDATE(), N'9802014', NULL)
	END 
	ELSE
		UPDATE [GNR].[Location] SET [MinistryofFinanceCode] = N'9802014' WHERE [Title] = N'قزاقستان' AND [Type] = '1'

	IF NOT EXISTS (SELECT [Title] FROM [GNR].[Location] WHERE [Title] = N'اسپانيا' AND [Type] = '1')
	BEGIN
		set @Id = @Id + 1
		INSERT INTO [GNR].[Location] ([LocationId], [Title], [Title_En], [Code], [Parent], [Type], [Version], [Creator], [CreationDate], [LastModifier], [LastModificationDate], [MinistryofFinanceCode], [TaxFileCode])
		VALUES (@Id, N'اسپانيا', N'اسپانيا', NULL, 1, N'1', 1, 1, GETDATE(), 1, GETDATE(), N'9802016', NULL)
	END 
	ELSE
		UPDATE [GNR].[Location] SET [MinistryofFinanceCode] = N'9802016' WHERE [Title] = N'اسپانيا' AND [Type] = '1'

	IF NOT EXISTS (SELECT [Title] FROM [GNR].[Location] WHERE [Title] = N'گرجستان' AND [Type] = '1')
	BEGIN
		set @Id = @Id + 1
		INSERT INTO [GNR].[Location] ([LocationId], [Title], [Title_En], [Code], [Parent], [Type], [Version], [Creator], [CreationDate], [LastModifier], [LastModificationDate], [MinistryofFinanceCode], [TaxFileCode])
		VALUES (@Id, N'گرجستان', N'گرجستان', NULL, 1, N'1', 1, 1, GETDATE(), 1, GETDATE(), N'9802017', NULL)
	END 
	ELSE
		UPDATE [GNR].[Location] SET [MinistryofFinanceCode] = N'9802017' WHERE [Title] = N'گرجستان' AND [Type] = '1'

	IF NOT EXISTS (SELECT [Title] FROM [GNR].[Location] WHERE [Title] = N'قزاقستان' AND [Type] = '1')
	BEGIN
		set @Id = @Id + 1
		INSERT INTO [GNR].[Location] ([LocationId], [Title], [Title_En], [Code], [Parent], [Type], [Version], [Creator], [CreationDate], [LastModifier], [LastModificationDate], [MinistryofFinanceCode], [TaxFileCode])
		VALUES (@Id, N'قزاقستان', N'قزاقستان', NULL, 1, N'1', 1, 1, GETDATE(), 1, GETDATE(), N'9802018', NULL)
	END 
	ELSE
		UPDATE [GNR].[Location] SET [MinistryofFinanceCode] = N'9802018' WHERE [Title] = N'قزاقستان' AND [Type] = '1'

	IF NOT EXISTS (SELECT [Title] FROM [GNR].[Location] WHERE [Title] = N'تايوان' AND [Type] = '1')
	BEGIN
		set @Id = @Id + 1
		INSERT INTO [GNR].[Location] ([LocationId], [Title], [Title_En], [Code], [Parent], [Type], [Version], [Creator], [CreationDate], [LastModifier], [LastModificationDate], [MinistryofFinanceCode], [TaxFileCode])
		VALUES (@Id, N'تايوان', N'تايوان', NULL, 1, N'1', 1, 1, GETDATE(), 1, GETDATE(), N'9802019', NULL)
	END 
	ELSE
		UPDATE [GNR].[Location] SET [MinistryofFinanceCode] = N'9802019' WHERE [Title] = N'تايوان' AND [Type] = '1'

	IF NOT EXISTS (SELECT [Title] FROM [GNR].[Location] WHERE [Title] = N'تاجيكستان' AND [Type] = '1')
	BEGIN
		set @Id = @Id + 1
		INSERT INTO [GNR].[Location] ([LocationId], [Title], [Title_En], [Code], [Parent], [Type], [Version], [Creator], [CreationDate], [LastModifier], [LastModificationDate], [MinistryofFinanceCode], [TaxFileCode])
		VALUES (@Id, N'تاجيكستان', N'تاجيكستان', NULL, 1, N'1', 1, 1, GETDATE(), 1, GETDATE(), N'9802021', NULL)
	END 
	ELSE
		UPDATE [GNR].[Location] SET [MinistryofFinanceCode] = N'9802021' WHERE [Title] = N'تاجيكستان' AND [Type] = '1'

	IF NOT EXISTS (SELECT [Title] FROM [GNR].[Location] WHERE [Title] = N'عمان' AND [Type] = '1')
	BEGIN
		set @Id = @Id + 1
		INSERT INTO [GNR].[Location] ([LocationId], [Title], [Title_En], [Code], [Parent], [Type], [Version], [Creator], [CreationDate], [LastModifier], [LastModificationDate], [MinistryofFinanceCode], [TaxFileCode])
		VALUES (@Id, N'عمان', N'عمان', NULL, 1, N'1', 1, 1, GETDATE(), 1, GETDATE(), N'9802352', NULL)
	END 
	ELSE
		UPDATE [GNR].[Location] SET [MinistryofFinanceCode] = N'9802352' WHERE [Title] = N'عمان' AND [Type] = '1'

	IF NOT EXISTS (SELECT [Title] FROM [GNR].[Location] WHERE [Title] = N'اكراين' AND [Type] = '1')
	BEGIN
		set @Id = @Id + 1
		INSERT INTO [GNR].[Location] ([LocationId], [Title], [Title_En], [Code], [Parent], [Type], [Version], [Creator], [CreationDate], [LastModifier], [LastModificationDate], [MinistryofFinanceCode], [TaxFileCode])
		VALUES (@Id, N'اكراين', N'اكراين', NULL, 1, N'1', 1, 1, GETDATE(), 1, GETDATE(), N'9802522', NULL)
	END 
	ELSE
		UPDATE [GNR].[Location] SET [MinistryofFinanceCode] = N'9802522' WHERE [Title] = N'اكراين' AND [Type] = '1'

	IF NOT EXISTS (SELECT [Title] FROM [GNR].[Location] WHERE [Title] = N'لهستان' AND [Type] = '1')
	BEGIN
		set @Id = @Id + 1
		INSERT INTO [GNR].[Location] ([LocationId], [Title], [Title_En], [Code], [Parent], [Type], [Version], [Creator], [CreationDate], [LastModifier], [LastModificationDate], [MinistryofFinanceCode], [TaxFileCode])
		VALUES (@Id, N'لهستان', N'لهستان', NULL, 1, N'1', 1, 1, GETDATE(), 1, GETDATE(), N'9802523', NULL)
	END 
	ELSE
		UPDATE [GNR].[Location] SET [MinistryofFinanceCode] = N'9802523' WHERE [Title] = N'لهستان' AND [Type] = '1'

	IF NOT EXISTS (SELECT [Title] FROM [GNR].[Location] WHERE [Title] = N'سريلانكا' AND [Type] = '1')
	BEGIN
		set @Id = @Id + 1
		INSERT INTO [GNR].[Location] ([LocationId], [Title], [Title_En], [Code], [Parent], [Type], [Version], [Creator], [CreationDate], [LastModifier], [LastModificationDate], [MinistryofFinanceCode], [TaxFileCode])
		VALUES (@Id, N'سريلانكا', N'سريلانكا', NULL, 1, N'1', 1, 1, GETDATE(), 1, GETDATE(), N'9802524', NULL)
	END 
	ELSE
		UPDATE [GNR].[Location] SET [MinistryofFinanceCode] = N'9802524' WHERE [Title] = N'سريلانكا' AND [Type] = '1'

	IF NOT EXISTS (SELECT [Title] FROM [GNR].[Location] WHERE [Title] = N'ونزوئلا' AND [Type] = '1')
	BEGIN
		set @Id = @Id + 1
		INSERT INTO [GNR].[Location] ([LocationId], [Title], [Title_En], [Code], [Parent], [Type], [Version], [Creator], [CreationDate], [LastModifier], [LastModificationDate], [MinistryofFinanceCode], [TaxFileCode])
		VALUES (@Id, N'ونزوئلا', N'ونزوئلا', NULL, 1, N'1', 1, 1, GETDATE(), 1, GETDATE(), N'9802525', NULL)
	END 
	ELSE
		UPDATE [GNR].[Location] SET [MinistryofFinanceCode] = N'9802525' WHERE [Title] = N'ونزوئلا' AND [Type] = '1'

	IF NOT EXISTS (SELECT [Title] FROM [GNR].[Location] WHERE [Title] = N'نيوزيلند' AND [Type] = '1')
	BEGIN
		set @Id = @Id + 1
		INSERT INTO [GNR].[Location] ([LocationId], [Title], [Title_En], [Code], [Parent], [Type], [Version], [Creator], [CreationDate], [LastModifier], [LastModificationDate], [MinistryofFinanceCode], [TaxFileCode])
		VALUES (@Id, N'نيوزيلند', N'نيوزيلند', NULL, 1, N'1', 1, 1, GETDATE(), 1, GETDATE(), N'9802526', NULL)
	END 
	ELSE
		UPDATE [GNR].[Location] SET [MinistryofFinanceCode] = N'9802526' WHERE [Title] = N'نيوزيلند' AND [Type] = '1'

	IF NOT EXISTS (SELECT [Title] FROM [GNR].[Location] WHERE [Title] = N'بنگلادش' AND [Type] = '1')
	BEGIN
		set @Id = @Id + 1
		INSERT INTO [GNR].[Location] ([LocationId], [Title], [Title_En], [Code], [Parent], [Type], [Version], [Creator], [CreationDate], [LastModifier], [LastModificationDate], [MinistryofFinanceCode], [TaxFileCode])
		VALUES (@Id, N'بنگلادش', N'بنگلادش', NULL, 1, N'1', 1, 1, GETDATE(), 1, GETDATE(), N'9802527', NULL)
	END 
	ELSE
		UPDATE [GNR].[Location] SET [MinistryofFinanceCode] = N'9802527' WHERE [Title] = N'بنگلادش' AND [Type] = '1'

	IF NOT EXISTS (SELECT [Title] FROM [GNR].[Location] WHERE [Title] = N'نيجريه' AND [Type] = '1')
	BEGIN
		set @Id = @Id + 1
		INSERT INTO [GNR].[Location] ([LocationId], [Title], [Title_En], [Code], [Parent], [Type], [Version], [Creator], [CreationDate], [LastModifier], [LastModificationDate], [MinistryofFinanceCode], [TaxFileCode])
		VALUES (@Id, N'نيجريه', N'نيجريه', NULL, 1, N'1', 1, 1, GETDATE(), 1, GETDATE(), N'9802528', NULL)
	END 
	ELSE
		UPDATE [GNR].[Location] SET [MinistryofFinanceCode] = N'9802528' WHERE [Title] = N'نيجريه' AND [Type] = '1'

	IF NOT EXISTS (SELECT [Title] FROM [GNR].[Location] WHERE [Title] = N'مجارستان' AND [Type] = '1')
	BEGIN
		set @Id = @Id + 1
		INSERT INTO [GNR].[Location] ([LocationId], [Title], [Title_En], [Code], [Parent], [Type], [Version], [Creator], [CreationDate], [LastModifier], [LastModificationDate], [MinistryofFinanceCode], [TaxFileCode])
		VALUES (@Id, N'مجارستان', N'مجارستان', NULL, 1, N'1', 1, 1, GETDATE(), 1, GETDATE(), N'9802529', NULL)
	END 
	ELSE
		UPDATE [GNR].[Location] SET [MinistryofFinanceCode] = N'9802529' WHERE [Title] = N'مجارستان' AND [Type] = '1'

	IF NOT EXISTS (SELECT [Title] FROM [GNR].[Location] WHERE [Title] = N'بلغارستان' AND [Type] = '1')
	BEGIN
		set @Id = @Id + 1
		INSERT INTO [GNR].[Location] ([LocationId], [Title], [Title_En], [Code], [Parent], [Type], [Version], [Creator], [CreationDate], [LastModifier], [LastModificationDate], [MinistryofFinanceCode], [TaxFileCode])
		VALUES (@Id, N'بلغارستان', N'بلغارستان', NULL, 1, N'1', 1, 1, GETDATE(), 1, GETDATE(), N'9806001', NULL)
	END 
	ELSE
		UPDATE [GNR].[Location] SET [MinistryofFinanceCode] = N'9806001' WHERE [Title] = N'بلغارستان' AND [Type] = '1'

	IF NOT EXISTS (SELECT [Title] FROM [GNR].[Location] WHERE [Title] = N'اندونزي' AND [Type] = '1')
	BEGIN
		set @Id = @Id + 1
		INSERT INTO [GNR].[Location] ([LocationId], [Title], [Title_En], [Code], [Parent], [Type], [Version], [Creator], [CreationDate], [LastModifier], [LastModificationDate], [MinistryofFinanceCode], [TaxFileCode])
		VALUES (@Id, N'اندونزي', N'اندونزي', NULL, 1, N'1', 1, 1, GETDATE(), 1, GETDATE(), N'9806002', NULL)
	END ELSE
		UPDATE [GNR].[Location] SET [MinistryofFinanceCode] = N'9806002' WHERE [Title] = N'اندونزي' AND [Type] = '1'

	IF NOT EXISTS (SELECT [Title] FROM [GNR].[Location] WHERE [Title] = N'ويتنام' AND [Type] = '1')
	BEGIN
		set @Id = @Id + 1
		INSERT INTO [GNR].[Location] ([LocationId], [Title], [Title_En], [Code], [Parent], [Type], [Version], [Creator], [CreationDate], [LastModifier], [LastModificationDate], [MinistryofFinanceCode], [TaxFileCode])
		VALUES (@Id, N'ويتنام', N'ويتنام', NULL, 1, N'1', 1, 1, GETDATE(), 1, GETDATE(), N'9806003', NULL)
	END 
	ELSE
		UPDATE [GNR].[Location] SET [MinistryofFinanceCode] = N'9806003' WHERE [Title] = N'ويتنام' AND [Type] = '1'

	IF NOT EXISTS (SELECT [Title] FROM [GNR].[Location] WHERE [Title] = N'آلباني' AND [Type] = '1')
	BEGIN
		set @Id = @Id + 1
		INSERT INTO [GNR].[Location] ([LocationId], [Title], [Title_En], [Code], [Parent], [Type], [Version], [Creator], [CreationDate], [LastModifier], [LastModificationDate], [MinistryofFinanceCode], [TaxFileCode])
		VALUES (@Id, N'آلباني', N'آلباني', NULL, 1, N'1', 1, 1, GETDATE(), 1, GETDATE(), N'9806004', NULL)
	END 
	ELSE
		UPDATE [GNR].[Location] SET [MinistryofFinanceCode] = N'9806004' WHERE [Title] = N'آلباني' AND [Type] = '1'

	IF NOT EXISTS (SELECT [Title] FROM [GNR].[Location] WHERE [Title] = N'پرتغال' AND [Type] = '1')
	BEGIN
		set @Id = @Id + 1
		INSERT INTO [GNR].[Location] ([LocationId], [Title], [Title_En], [Code], [Parent], [Type], [Version], [Creator], [CreationDate], [LastModifier], [LastModificationDate], [MinistryofFinanceCode], [TaxFileCode])
		VALUES (@Id, N'پرتغال', N'پرتغال', NULL, 1, N'1', 1, 1, GETDATE(), 1, GETDATE(), N'9806005', NULL)
	END 
	ELSE
		UPDATE [GNR].[Location] SET [MinistryofFinanceCode] = N'9806005' WHERE [Title] = N'پرتغال' AND [Type] = '1'

	IF NOT EXISTS (SELECT [Title] FROM [GNR].[Location] WHERE [Title] = N'جمهوري چك' AND [Type] = '1')
	BEGIN
		set @Id = @Id + 1
		INSERT INTO [GNR].[Location] ([LocationId], [Title], [Title_En], [Code], [Parent], [Type], [Version], [Creator], [CreationDate], [LastModifier], [LastModificationDate], [MinistryofFinanceCode], [TaxFileCode])
		VALUES (@Id, N'جمهوري چك', N'جمهوري چك', NULL, 1, N'1', 1, 1, GETDATE(), 1, GETDATE(), N'9806006', NULL)
	END 
	ELSE
		UPDATE [GNR].[Location] SET [MinistryofFinanceCode] = N'9806006' WHERE [Title] = N'جمهوري چك' AND [Type] = '1'

	IF NOT EXISTS (SELECT [Title] FROM [GNR].[Location] WHERE [Title] = N'بلاروس' AND [Type] = '1')
	BEGIN
		set @Id = @Id + 1
		INSERT INTO [GNR].[Location] ([LocationId], [Title], [Title_En], [Code], [Parent], [Type], [Version], [Creator], [CreationDate], [LastModifier], [LastModificationDate], [MinistryofFinanceCode], [TaxFileCode])
		VALUES (@Id, N'بلاروس', N'بلاروس', NULL, 1, N'1', 1, 1, GETDATE(), 1, GETDATE(), N'9806007', NULL)
	END 
	ELSE
		UPDATE [GNR].[Location] SET [MinistryofFinanceCode] = N'9806007' WHERE [Title] = N'بلاروس' AND [Type] = '1'

	IF NOT EXISTS (SELECT [Title] FROM [GNR].[Location] WHERE [Title] = N'سنگاپور' AND [Type] = '1')
	BEGIN
		set @Id = @Id + 1
		INSERT INTO [GNR].[Location] ([LocationId], [Title], [Title_En], [Code], [Parent], [Type], [Version], [Creator], [CreationDate], [LastModifier], [LastModificationDate], [MinistryofFinanceCode], [TaxFileCode])
		VALUES (@Id, N'سنگاپور', N'سنگاپور', NULL, 1, N'1', 1, 1, GETDATE(), 1, GETDATE(), N'9806008', NULL)
	END 
	ELSE
		UPDATE [GNR].[Location] SET [MinistryofFinanceCode] = N'9806008' WHERE [Title] = N'سنگاپور' AND [Type] = '1'

	IF NOT EXISTS (SELECT [Title] FROM [GNR].[Location] WHERE [Title] = N'يمن' AND [Type] = '1')
	BEGIN
		set @Id = @Id + 1
		INSERT INTO [GNR].[Location] ([LocationId], [Title], [Title_En], [Code], [Parent], [Type], [Version], [Creator], [CreationDate], [LastModifier], [LastModificationDate], [MinistryofFinanceCode], [TaxFileCode])
		VALUES (@Id, N'يمن', N'يمن', NULL, 1, N'1', 1, 1, GETDATE(), 1, GETDATE(), N'9806009', NULL)
	END 
	ELSE
		UPDATE [GNR].[Location] SET [MinistryofFinanceCode] = N'9806009' WHERE [Title] = N'يمن' AND [Type] = '1'

	IF NOT EXISTS (SELECT [Title] FROM [GNR].[Location] WHERE [Title] = N'گواتمالا' AND [Type] = '1')
	BEGIN
		set @Id = @Id + 1
		INSERT INTO [GNR].[Location] ([LocationId], [Title], [Title_En], [Code], [Parent], [Type], [Version], [Creator], [CreationDate], [LastModifier], [LastModificationDate], [MinistryofFinanceCode], [TaxFileCode])
		VALUES (@Id, N'گواتمالا', N'گواتمالا', NULL, 1, N'1', 1, 1, GETDATE(), 1, GETDATE(), N'9806010', NULL)
	END 
	ELSE
		UPDATE [GNR].[Location] SET [MinistryofFinanceCode] = N'9806010' WHERE [Title] = N'گواتمالا' AND [Type] = '1'

	IF NOT EXISTS (SELECT [Title] FROM [GNR].[Location] WHERE [Title] = N'اكوادور' AND [Type] = '1')
	BEGIN
		set @Id = @Id + 1
		INSERT INTO [GNR].[Location] ([LocationId], [Title], [Title_En], [Code], [Parent], [Type], [Version], [Creator], [CreationDate], [LastModifier], [LastModificationDate], [MinistryofFinanceCode], [TaxFileCode])
		VALUES (@Id, N'اكوادور', N'اكوادور', NULL, 1, N'1', 1, 1, GETDATE(), 1, GETDATE(), N'9806011', NULL)
	END 
	ELSE
		UPDATE [GNR].[Location] SET [MinistryofFinanceCode] = N'9806011' WHERE [Title] = N'اكوادور' AND [Type] = '1'

	IF NOT EXISTS (SELECT [Title] FROM [GNR].[Location] WHERE [Title] = N'نروژ' AND [Type] = '1')
	BEGIN
		set @Id = @Id + 1
		INSERT INTO [GNR].[Location] ([LocationId], [Title], [Title_En], [Code], [Parent], [Type], [Version], [Creator], [CreationDate], [LastModifier], [LastModificationDate], [MinistryofFinanceCode], [TaxFileCode])
		VALUES (@Id, N'نروژ', N'نروژ', NULL, 1, N'1', 1, 1, GETDATE(), 1, GETDATE(), N'9806012', NULL)
	END 
	ELSE
		UPDATE [GNR].[Location] SET [MinistryofFinanceCode] = N'9806012' WHERE [Title] = N'نروژ' AND [Type] = '1'

	IF NOT EXISTS (SELECT [Title] FROM [GNR].[Location] WHERE [Title] = N'لوكزامبورگ' AND [Type] = '1')
	BEGIN
		set @Id = @Id + 1
		INSERT INTO [GNR].[Location] ([LocationId], [Title], [Title_En], [Code], [Parent], [Type], [Version], [Creator], [CreationDate], [LastModifier], [LastModificationDate], [MinistryofFinanceCode], [TaxFileCode])
		VALUES (@Id, N'لوكزامبورگ', N'لوكزامبورگ', NULL, 1, N'1', 1, 1, GETDATE(), 1, GETDATE(), N'9806013', NULL)
	END 
	ELSE
		UPDATE [GNR].[Location] SET [MinistryofFinanceCode] = N'9806013' WHERE [Title] = N'لوكزامبورگ' AND [Type] = '1'

	IF NOT EXISTS (SELECT [Title] FROM [GNR].[Location] WHERE [Title] = N'قبرس' AND [Type] = '1')
	BEGIN
		set @Id = @Id + 1
		INSERT INTO [GNR].[Location] ([LocationId], [Title], [Title_En], [Code], [Parent], [Type], [Version], [Creator], [CreationDate], [LastModifier], [LastModificationDate], [MinistryofFinanceCode], [TaxFileCode])
		VALUES (@Id, N'قبرس', N'قبرس', NULL, 1, N'1', 1, 1, GETDATE(), 1, GETDATE(), N'9806014', NULL)
	END 
	ELSE
		UPDATE [GNR].[Location] SET [MinistryofFinanceCode] = N'9806014' WHERE [Title] = N'قبرس' AND [Type] = '1'
	IF NOT EXISTS (SELECT [Title] FROM [GNR].[Location] WHERE [Title] = N'آبهاي بين المللي' AND [Type] = '1')
	BEGIN
		set @Id = @Id + 1
		INSERT INTO [GNR].[Location] ([LocationId], [Title], [Title_En], [Code], [Parent], [Type], [Version], [Creator], [CreationDate], [LastModifier], [LastModificationDate], [MinistryofFinanceCode], [TaxFileCode])
		VALUES (@Id, N'آبهاي بين المللي', N'آبهاي بين المللي', NULL, 1, N'1', 1, 1, GETDATE(), 1, GETDATE(), N'9806015', NULL)
	END 
	ELSE
		UPDATE [GNR].[Location] SET [MinistryofFinanceCode] = N'9806015' WHERE [Title] = N'آبهاي بين المللي' AND [Type] = '1'

	declare @LastId int = (SELECT IsNull(MAX(LocationId), 0) + 1 FROM GNR.[Location])
	exec [FMK].[spSetLastId] 'GNR.Location', @LastId
END
