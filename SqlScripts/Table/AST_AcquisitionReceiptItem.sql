--<<FileName:AST_AcquisitionReceiptItem.sql>>--
--<< TABLE DEFINITION >>--

If Object_ID('AST.AcquisitionReceiptItem') Is Null
CREATE TABLE [AST].[AcquisitionReceiptItem](
	[AcquisitionReceiptItemID]  [INT]				NOT NULL,
	[AcquisitionReceiptRef]		[INT]				NOT NULL,
	[PlaqueNumber]				[NVARCHAR](250) 	NOT NULL,
	[OldPlaqueNumber]			[NVARCHAR](250)			NULL,
	[Title]						[NVARCHAR](250) 	NOT NULL,
	[Title_En]					[NVARCHAR](250) 		NULL,
	[AssetGroupRef]				[INT]				NOT NULL,
	[AssetRef]					[INT]				NOT NULL,
	[CostCenterDlRef]				[INT] 				NULL,
	[EmplacementRef]			[INT] 					NULL,
	[ReceiverPartyRef]			[INT] 					NULL,
	[Description]				[NVARCHAR] (250)		NULL,
	[Details]					[NVARCHAR] (250)		NULL,	
	[UtilizationDate]			[DATETIME]			NOT NULL,
	[AccumulatedDepreciation]	[DECIMAL](19, 4)	NOT NULL,
	[TotalCost]					[DECIMAL](19, 4)	NOT NULL,
	[TotalCostInBasecurrency]	[DECIMAL](19, 4)	NOT NULL,
	[DepreciationRate]			[DECIMAL] (5, 2)	NOT NULL,
	[DepreciationMethodType]	[INT]				NOT NULL,
	[UsefulLife]				[DECIMAL](38,25)	NOT NULL,
	[MaxDepreciableBookValue]	[DECIMAL](19,4)		NOT NULL,
	[SalvageValue]				[DECIMAL](19, 4)	NOT NULL,
	[AssetTransactionRef]		[INT]				NOT NULL
) ON [PRIMARY] 

--TEXTIMAGE_ON [SGBlob_Data]
--When a table has text, ntext, image, varchar(max), nvarchar(max), varbinary(max), xml or large user defined type columns uncomment above code
GO
--<< ADD CLOLUMNS >>--
IF  COLUMNPROPERTY(object_id('AST.AcquisitionReceiptItem'), 'UsefulLife' , 'Precision') <> 38 OR
    COLUMNPROPERTY(object_id('AST.AcquisitionReceiptItem'), 'UsefulLife' , 'Scale'    ) <> 25
BEGIN
	ALTER TABLE AST.AcquisitionReceiptItem ALTER COLUMN [UsefulLife] [DECIMAL](38,25)	NOT	NULL
END

GO

IF NOT EXISTS (select 1 from sys.columns WHERE object_id=object_id('AST.AcquisitionReceiptItem') AND
				[name] = 'Description')
BEGIN
    ALTER TABLE AST.AcquisitionReceiptItem Add [Description] NVARCHAR (250) NULL
END

GO

IF NOT EXISTS (select 1 from sys.columns where object_id=object_id('AST.AcquisitionReceiptItem') AND
				[name] = 'Details')
BEGIN
    ALTER TABLE AST.AcquisitionReceiptItem Add [Details] NVARCHAR (250) NULL
END

GO
IF NOT EXISTS (select 1 from sys.columns WHERE object_id=object_id('AST.AcquisitionReceiptItem') AND
				[name] = 'CostCenterDlRef')
BEGIN
    ALTER TABLE AST.AcquisitionReceiptItem Add [CostCenterDlRef] INT NULL
END

GO



--<< ALTER COLUMNS >>--

--<< PRIMARYKEY DEFINITION >>--

If not Exists (select 1 from sys.objects where name = 'PK_AcquisitionReceiptItem')
ALTER TABLE [AST].[AcquisitionReceiptItem] ADD  CONSTRAINT [PK_AcquisitionReceiptItem] PRIMARY KEY CLUSTERED 
(
	[AcquisitionReceiptItemID] ASC
) ON [PRIMARY]
GO

--<< DEFAULTS CHECKS DEFINITION >>--

--<< RULES DEFINITION >>--

--<< INDEXES DEFINITION >>--

--<< FOREIGNKEYS DEFINITION >>--

If not Exists (select 1 from sys.objects where name = 'FK_AST_AcquisitionReceiptItem_AcquisitionReceiptRef')
	ALTER TABLE [AST].[AcquisitionReceiptItem]  ADD  CONSTRAINT [FK_AST_AcquisitionReceiptItem_AcquisitionReceiptRef] 
		FOREIGN KEY([AcquisitionReceiptRef])
		REFERENCES [AST].[AcquisitionReceipt] ([AcquisitionReceiptID])
		ON UPDATE CASCADE
		ON DELETE CASCADE
GO

If not Exists (select 1 from sys.objects where name = 'FK_AST_AcquisitionReceiptItem_AssetGroupRef')
	ALTER TABLE [AST].[AcquisitionReceiptItem]  ADD  CONSTRAINT [FK_AST_AcquisitionReceiptItem_AssetGroupRef] 
		FOREIGN KEY([AssetGroupRef])
		REFERENCES [AST].[AssetGroup] ([AssetGroupID])
GO

If not Exists (select 1 from sys.objects where name = 'FK_AST_AcquisitionReceiptItem_AssetRef')
	ALTER TABLE [AST].[AcquisitionReceiptItem]  ADD  CONSTRAINT [FK_AST_AcquisitionReceiptItem_AssetRef] 
		FOREIGN KEY([AssetRef])
		REFERENCES [AST].[Asset] ([AssetID])
GO

If not Exists (select 1 from sys.objects where name = 'FK_AST_AcquisitionReceiptItem_CostCenterDlRef')
	ALTER TABLE [AST].[AcquisitionReceiptItem]  ADD  CONSTRAINT [FK_AST_AcquisitionReceiptItem_CostCenterDlRef] 
		FOREIGN KEY([CostCenterDlRef])
		REFERENCES [ACC].[DL] ([DlId])
GO

If not Exists (select 1 from sys.objects where name = 'FK_AST_AcquisitionReceiptItem_EmplacementRef')
	ALTER TABLE [AST].[AcquisitionReceiptItem]  ADD  CONSTRAINT [FK_AST_AcquisitionReceiptItem_EmplacementRef] 
		FOREIGN KEY([EmplacementRef])
		REFERENCES [AST].[Emplacement] ([EmplacementId])
Go

If not Exists (select 1 from sys.objects where name = 'FK_AST_AcquisitionReceiptItem_ReceiverPartyRef')
	ALTER TABLE [AST].[AcquisitionReceiptItem]  ADD  CONSTRAINT [FK_AST_AcquisitionReceiptItem_ReceiverPartyRef] 
		FOREIGN KEY([ReceiverPartyRef])
		REFERENCES [GNR].[Party] ([PartyId])
Go

If not Exists (select 1 from sys.objects where name = 'FK_AST_AcquisitionReceiptItem_AssetTransactionRef')
	ALTER TABLE [AST].[AcquisitionReceiptItem]  ADD  CONSTRAINT [FK_AST_AcquisitionReceiptItem_AssetTransactionRef] 
		FOREIGN KEY([AssetTransactionRef])
		REFERENCES [AST].[AssetTransaction] ([AssetTransactionId])
Go

--<< DROP OBJECTS >>--
If  Exists (select 1 from sys.objects where name = 'FK_AST_AcquisitionReceiptItem_CostCenterRef')
	ALTER TABLE [AST].[AcquisitionReceiptItem]  DROP  CONSTRAINT [FK_AST_AcquisitionReceiptItem_CostCenterRef] 
GO


IF  EXISTS (select 1 from sys.columns WHERE object_id=object_id('AST.AcquisitionReceiptItem') AND
				[name] = 'CostCenterRef')
BEGIN
    ALTER TABLE AST.AcquisitionReceiptItem ALTER COLUMN [CostCenterRef] INT NULL
END

GO