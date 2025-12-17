--<<FileName:AST_RepairItem.sql>>--
--<< TABLE DEFINITION >>--

If Object_ID('AST.RepairItem') IS NULL
CREATE TABLE [AST].[RepairItem](
	[RepairItemId]				[INT] 			NOT NULL,
	[RepairRef]					[INT] 			NOT NULL,
	[AssetRef]					[INT] 			NOT NULL,
	[CostPartRef]				[INT] 			NOT NULL,
	[CostPartType]				[INT] 			NOT NULL,
	[AssetTransactionRef]		[INT] 				NOT NULL,
	[DepreciationMethodType]	[INT]			NOT NULL,
	[DepreciationRate]			[DECIMAL] (5,2) NOT NULL,
	[UsefulLife]				[DECIMAL](38,25)NOT NULL,
	[MaxDepreciableBookValue]	[DECIMAL](19,4)	NOT NULL,
	[SalvageValue]				[DECIMAL](19,4) NOT NULL,
	[TotalCost]          		[DECIMAL](19,4) NOT NULL,
	[EffectiveDate]				[DateTime]		NOT NULL,

) ON [PRIMARY]

GO
 
--TEXTIMAGE_ON [SGBlob_Data]
--When a table has text, ntext, image, varchar(max), nvarchar(max), varbinary(max), xml or large user defined type columns uncomment above code
GO
--<< ADD CLOLUMNS >>--

IF COLUMNPROPERTY(object_id('AST.RepairItem'), 'AssetRemainingUsefulLife' , 'AllowsNull') IS NOT NULL 
BEGIN 
	ALTER TABLE AST.RepairItem DROP COlumn [AssetRemainingUsefulLife]
END
GO

IF COLUMNPROPERTY(object_id('AST.RepairItem'), 'AcquisingElapsedLife' , 'AllowsNull') IS NOT NULL 
BEGIN 
	ALTER TABLE AST.RepairItem DROP COlumn [AcquisingElapsedLife]
END
GO

--<<Sample>>--
--<< ALTER COLUMNS >>--
IF  COLUMNPROPERTY(object_id('AST.RepairItem'), 'UsefulLife' , 'Precision') <> 38 OR
    COLUMNPROPERTY(object_id('AST.RepairItem'), 'UsefulLife' , 'Scale'    ) <> 25
BEGIN
	ALTER TABLE AST.RepairItem ALTER COlumn [UsefulLife] [DECIMAL](38,25)	NOT	NULL
END
GO
--<< PRIMARYKEY DEFINITION >>--

If NOT Exists (select 1 from sys.objects where name = 'PK_RepairItemId')
ALTER TABLE [AST].[RepairItem] ADD  CONSTRAINT [PK_RepairItemId] PRIMARY KEY CLUSTERED 
(
	[RepairItemId] ASC
) ON [PRIMARY]
GO

--<< DEFAULTS CHECKS DEFINITION >>--

--<< RULES DEFINITION >>--

--<< INDEXES DEFINITION >>--

--<< FOREIGNKEYS DEFINITION >>--

If NOT Exists (select 1 from sys.objects where name = 'FK_Repair_RepairItem_RepairRef')
	ALTER TABLE [AST].[RepairItem]  ADD  CONSTRAINT [FK_Repair_RepairItem_RepairRef] FOREIGN KEY([RepairRef])
			REFERENCES [AST].[Repair] ([RepairId])
			ON UPDATE CASCADE
			ON DELETE CASCADE

GO

If NOT Exists (select 1 from sys.objects where name = 'FK_Asset_RepairItem_AssetRef')
	ALTER TABLE [AST].[RepairItem]  ADD  CONSTRAINT [FK_Asset_RepairItem_AssetRef] FOREIGN KEY([AssetRef])
			REFERENCES [AST].[Asset] ([AssetId])

GO

If not Exists (select 1 from sys.objects where name = 'FK_RepairItem_AssetTransactionRef')
ALTER TABLE [AST].[RepairItem]  ADD  CONSTRAINT [FK_RepairItem_AssetTransactionRef] FOREIGN KEY([AssetTransactionRef])
REFERENCES [AST].[AssetTransaction] ([AssetTransactionId])

GO




--<< DROP OBJECTS >>--
 