	--<<FileName:DST_HotDistributionItem.sql>>--

	--<< TABLE DEFINITION >>--
	IF OBJECT_ID('DST.HotDistributionItem') IS NULL
	CREATE TABLE [DST].[HotDistributionItem]
	(
		[HotDistributionItemId]	[INT] 				NOT NULL,
		[HotDistributionRef]	[INT] 				NOT NULL,
		[ItemRef]				[INT] 				NOT NULL,
		[TracingRef]			[INT] 				NULL,	
		[TransferQuantity] 		[DECIMAL](19, 4)	NOT NULL,
		[InputQuantity] 		[DECIMAL](19, 4)	NOT NULL,
		[Quantity] 		AS		ISNULL([TransferQuantity], 0)+ ISNULL([InputQuantity], 0) ,
		[TransferSecondaryQuantity] [DECIMAL](19, 4)  NULL,
		[InputSecondaryQuantity]	[DECIMAL](19, 4) NULL ,
		[SecondaryQuantity]	AS	[TransferSecondaryQuantity]+[InputSecondaryQuantity]
	) 
	ON [PRIMARY]

	--TEXTIMAGE_ON [SGBlob_Data]
	--When a table has text, ntext, image, varchar(max), nvarchar(max), varbinary(max), xml or large user defined type columns uncomment above code
	GO
	--<< ADD CLOLUMNS >>--

	--<<Sample>>--
	IF NOT EXISTS (SELECT 1 FROM SYS.COLUMNS WHERE oBJECT_ID=OBJECT_ID('DST.HotDistributionItem') AND
					[name] = 'InputQuantity')
	BEGIN
		EXEC sp_rename 'DST.HotDistributionItem.Quantity', 'InputQuantity', 'COLUMN';
	END
	GO
	IF NOT EXISTS (SELECT 1 FROM SYS.COLUMNS WHERE OBJECT_ID=OBJECT_ID('DST.HotDistributionItem') AND
					[name] = 'TransferQuantity')
	BEGIN
		ALTER TABLE DST.HotDistributionItem ADD TransferQuantity [DECIMAL](19, 4) NOT NULL DEFAULT 0
	END
	GO
	IF NOT EXISTS (SELECT 1 FROM SYS.COLUMNS WHERE oBJECT_ID=OBJECT_ID('DST.HotDistributionItem') AND
					[name] = 'InputSecondaryQuantity')
	BEGIN
		EXEC sp_rename 'DST.HotDistributionItem.SecondaryQuantity', 'InputSecondaryQuantity', 'COLUMN';
	END
	GO
	IF NOT EXISTS (SELECT 1 FROM SYS.COLUMNS WHERE OBJECT_ID=OBJECT_ID('DST.HotDistributionItem') AND
					[name] = 'TransferSecondaryQuantity')
	BEGIN
		ALTER TABLE DST.HotDistributionItem ADD TransferSecondaryQuantity [DECIMAL](19, 4)   NULL
	END
	GO
	IF NOT EXISTS (SELECT 1 FROM SYS.COLUMNS WHERE OBJECT_ID=OBJECT_ID('DST.HotDistributionItem') AND
					[name] = 'Quantity')
	BEGIN
		ALTER TABLE DST.HotDistributionItem ADD Quantity AS ISNULL([TransferQuantity], 0)+ ISNULL([InputQuantity], 0) 
	END
	GO
	IF NOT EXISTS (SELECT 1 FROM SYS.COLUMNS WHERE OBJECT_ID=OBJECT_ID('DST.HotDistributionItem') AND
					[name] = 'SecondaryQuantity')
	BEGIN
		ALTER TABLE DST.HotDistributionItem ADD SecondaryQuantity AS	[TransferSecondaryQuantity]+[InputSecondaryQuantity]
	END
	GO
	--<< ALTER COLUMNS >>--

	/* Sample
	IF EXISTS(SELECT 1 FROM SYS.COLUMNS WHERE OBJECT_ID=OBJECT_ID('SLS.Quotation') AND
					[name] = 'NetPriceInBaseCurrency' AND is_Computed = 1)
	BEGIN
		IF EXISTS (SELECT 1 FROM sys.columns WHERE object_id=object_id('SLS.Quotation') AND
				[name] = 'PriceInBaseCurrency')
		BEGIN
			ALTER TABLE SLS.Quotation DROP COLUMN PriceInBaseCurrency
		END
	END
	*/

	--<< PRIMARYKEY DEFINITION >>--
	IF NOT EXISTS (SELECT 1 FROM sys.objects WHERE name = 'PK_HotDistributionItem')
	ALTER TABLE [DST].[HotDistributionItem] ADD CONSTRAINT [PK_HotDistributionItem] PRIMARY KEY CLUSTERED 
	(
		[HotDistributionItemId] ASC
	) 
	ON [PRIMARY]
	GO

	--<< DEFAULTS CHECKS DEFINITION >>--

	--<< RULES DEFINITION >>--

	--<< INDEXES DEFINITION >>--
	IF NOT EXISTS (SELECT 1 FROM sys.indexes WHERE NAME = 'UIX_HotDistributionItem_ItemRef_TracingRef')
	CREATE UNIQUE NONCLUSTERED INDEX [UIX_HotDistributionItem_ItemRef_TracingRef] ON [DST].[HotDistributionItem] 
	(	
		[HotDistributionRef] ASC,
		[ItemRef] ASC,
		[TracingRef] ASC
	) ON [PRIMARY]

	GO

	--<< FOREIGNKEYS DEFINITION >>--
	IF NOT EXISTS (SELECT 1	FROM sys.objects WHERE name = 'FK_HotDistributionItem_HotDistributionRef')
		ALTER TABLE [DST].[HotDistributionItem] ADD CONSTRAINT [FK_HotDistributionItem_HotDistributionRef] FOREIGN KEY ([HotDistributionRef])
		REFERENCES [DST].[HotDistribution] ([HotDistributionId])
		ON DELETE CASCADE

	GO

	IF NOT EXISTS (SELECT 1 FROM sys.objects WHERE name = 'FK_HotDistributionItem_ItemRef')
		ALTER TABLE [DST].[HotDistributionItem] ADD CONSTRAINT [FK_HotDistributionItem_ItemRef] FOREIGN KEY([ItemRef])
		REFERENCES [INV].[Item] ([ItemID])

	GO

	IF NOT EXISTS (SELECT 1 FROM sys.objects WHERE name = 'FK_HotDistributionItem_TracingRef')
		ALTER TABLE [DST].[HotDistributionItem] ADD CONSTRAINT [FK_HotDistributionItem_TracingRef] FOREIGN KEY([TracingRef])
		REFERENCES [INV].[Tracing] ([TracingID])

	GO

	--<< DROP OBJECTS >>--
