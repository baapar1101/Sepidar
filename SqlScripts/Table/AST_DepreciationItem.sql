--D:\AppSrc\SmallBusiness\DVP\Source\FixedAsset\AssetManagement\DBObjects\Table\AST_DepreciationItem.sql
--select * from AST.DepreciationItem
--select * from AST.vwDepreciationItem

--<<FileName:AST_DepreciationItem.sql>>--
--<< TABLE DEFINITION >>--
-- DROP TABLE [AST].[DepreciationItem]
GO
IF OBJECT_ID('AST.DepreciationItem') IS NULL
	CREATE TABLE [AST].[DepreciationItem](
		[DepreciationItemID]     	    [int] 			 NOT NULL,
		[DepreciationRef] 			    [int] 			 NOT NULL,
		[CostPartRef]            		[int] 			 NOT NULL,
		[CostPartTransactionRef]	    [int] 			 NOT NULL,
		[LastCostPartTransactionRef]	[int] 			 NOT NULL,

		[CalculationDate]               [datetime]       NOT NULL,
		[DepreciationValue]				[decimal](19,4)  NOT NULL,
		[Duration]      				[int]			 NOT NULL,

		[AccumulatedDepreciation]   	[decimal](19,4)	 NOT NULL,
		[DepreciationState]				[int]			 NOT NULL,
		[AssetElapsedLife] 				[DECIMAL](30,25)	 NULL,
		[RemainingRoundingDepreciation] [DECIMAL](30,25) NOT NULL,

		[pDepreciationRate]				[DECIMAL](30,25) NOT NULL,
		[pUsefulLife]					[DECIMAL](30,25) NOT NULL,
		[pRemainingBookValue]			[decimal](19,4)	 NOT NULL
	)
GO
--<< ADD CLOLUMNS >>--

--<< ALTER COLUMNS >>--

IF COLUMNPROPERTY(object_id('AST.DepreciationItem'), 'RemainingRoundingDepreciation' , 'AllowsNull') IS NULL
begin
	ALTER TABLE AST.DepreciationItem ADD [RemainingRoundingDepreciation] [DECIMAL] (30,25) NULL 
end
GO
IF COLUMNPROPERTY(object_id('AST.DepreciationItem'), 'RemainingRoundingDepreciation' , 'AllowsNull') = 1
begin
    UPDATE AST.DepreciationItem  SET [RemainingRoundingDepreciation] = 0 WHERE [RemainingRoundingDepreciation] IS NULL
	ALTER TABLE AST.DepreciationItem ALTER COLUMN [RemainingRoundingDepreciation] [DECIMAL] (30,25) NOT NULL 
end
GO
IF COLUMNPROPERTY(object_id('AST.DepreciationItem'), 'CalculationDate' , 'AllowsNull') = 0
begin
	ALTER TABLE AST.DepreciationItem ALTER COLUMN [CalculationDate] [datetime] NULL
end
GO
IF COLUMNPROPERTY(object_id('AST.DepreciationItem'), 'CreationDate' , 'AllowsNull') = 0
begin
	ALTER TABLE AST.DepreciationItem ALTER COLUMN [CreationDate] [datetime] NULL
end
GO

IF  COLUMNPROPERTY(object_id('AST.DepreciationItem'), 'UsefulLife' , 'Precision') <> 30 OR
    COLUMNPROPERTY(object_id('AST.DepreciationItem'), 'UsefulLife' , 'Scale'    ) <> 25
BEGIN
	ALTER TABLE AST.DepreciationItem ALTER COLUMN [UsefulLife] [DECIMAL](30,25)	NOT	NULL
END
GO

IF  COLUMNPROPERTY(object_id('AST.DepreciationItem'), 'AcquisingElapsedLife' , 'Precision') <> 30 OR
    COLUMNPROPERTY(object_id('AST.DepreciationItem'), 'AcquisingElapsedLife' , 'Scale'    ) <> 25
BEGIN
	ALTER TABLE AST.DepreciationItem ALTER COLUMN [AcquisingElapsedLife] [DECIMAL](30,25)		NULL
END
GO

IF  COLUMNPROPERTY(object_id('AST.DepreciationItem'), 'AssetElapsedLife' , 'Precision') <> 30 OR
    COLUMNPROPERTY(object_id('AST.DepreciationItem'), 'AssetElapsedLife' , 'Scale'    ) <> 25
BEGIN
	ALTER TABLE AST.DepreciationItem ALTER COLUMN [AssetElapsedLife] [DECIMAL](30,25)		NULL
END
GO
--<< PRIMARYKEY DEFINITION >>--

GO
If not Exists (select 1 from sys.objects where name = 'PK_AST_DepreciationItem')
	ALTER TABLE [AST].[DepreciationItem]  ADD  CONSTRAINT [PK_AST_DepreciationItem] PRIMARY KEY CLUSTERED 
	([DepreciationItemID] ASC
	) ON [PRIMARY]
GO

--<< DEFAULTS CHECKS DEFINITION >>--

--<< RULES DEFINITION >>--

--<< INDEXES DEFINITION >>--

--<< FOREIGNKEYS DEFINITION >>--

IF NOT EXISTS (select 1 from sys.objects where name = 'FK_AST_DepreciationItem_DepreciationRef')
	ALTER TABLE [AST].[DepreciationItem]  ADD  CONSTRAINT [FK_AST_DepreciationItem_DepreciationRef] 
		FOREIGN KEY([DepreciationRef])
		REFERENCES [AST].[Depreciation] ([DepreciationID])
		ON UPDATE CASCADE
		ON DELETE CASCADE
GO

IF NOT EXISTS (select 1 from sys.objects where name = 'FK_AST_DepreciationItem_CostPartRef')
	ALTER TABLE [AST].[DepreciationItem]  ADD  CONSTRAINT [FK_AST_DepreciationItem_CostPartRef] 
		FOREIGN KEY([CostPartRef])
		REFERENCES [AST].[CostPart] ([CostPartID])
GO

IF NOT EXISTS (select 1 from sys.objects where name = 'FK_AST_DepreciationItem_CostPartTransactionRef')
	ALTER TABLE [AST].[DepreciationItem]  ADD  CONSTRAINT [FK_AST_DepreciationItem_CostPartTransactionRef] 
		FOREIGN KEY([CostPartTransactionRef])
		REFERENCES [AST].[CostPartTransaction] ([CostPartTransactionID])
GO

IF NOT EXISTS (select 1 from sys.objects where name = 'FK_AST_DepreciationItem_LastCostPartTransactionRef')
	ALTER TABLE [AST].[DepreciationItem]  ADD  CONSTRAINT [FK_AST_DepreciationItem_LastCostPartTransactionRef] 
		FOREIGN KEY([LastCostPartTransactionRef])
		REFERENCES [AST].[CostPartTransaction] ([CostPartTransactionID])
GO

--<< DROP OBJECTS >>--
