--<<FileName:AST_CostPartTransaction.sql>>--
--<< TABLE DEFINITION >>--

IF OBJECT_ID('AST.CostPartTransaction') IS NULL
	CREATE TABLE [AST].[CostPartTransaction](
		[CostPartTransactionID]     	[int] 			NOT NULL,
		[AssetTransactionRef] 			[int] 			NOT NULL,
		[CostPartRef]            		[int] 			NOT NULL,
		[TotalCost]          			[decimal](19,4) NOT NULL,
		[DepreciationMethodType]    	[int] 			NOT NULL,
		[UsefulLife]       				[decimal](30,25) NOT NULL,
		[MaxDepreciableBookValue]		[DECIMAL](19,4)	NOT NULL,
		[DepreciationRate]      		[decimal](5,2)	NOT NULL,
		[EffectiveDate]    				[datetime]		NOT	NULL,
		[AccumulatedDepreciation]   	[decimal](19,4)	NOT NULL,
		[DepreciationValue]				[decimal](19,4) NOT NULL,
		[CreationDate]        			[datetime]		    NULL,
		[Duration]      				[int]			NOT	NULL,
		[CalculationDate]				[datetime]		    NULL,
		[DepreciationState]				[int]			NOT NULL,
		[SalvageValue]					[decimal](19,4) NOT NULL,
		[AcquisingElapsedLife]			[DECIMAL](30,25)	NULL,
		[AssetElapsedLife] 				[DECIMAL](30,25)	NULL,
		[RemainingRoundingDepreciation] [DECIMAL](30,25) NOT NULL 
	)
--TEXTIMAGE_ON [SGBlob_Data]
--When a table has text, ntext, image, varchar(max), nvarchar(max), varbinary(max), xml or large user defined type columns uncomment above code
GO
--<< ADD CLOLUMNS >>--

--<<Sample>>--
/*if not exists (select 1 from sys.columns where object_id=object_id('AST.CostPartTransaction') and
				[name] = 'ColumnName')
begin
    Alter table AST.CostPartTransaction Add ColumnName DataType Nullable
end
GO*/

--<< ALTER COLUMNS >>--

IF COLUMNPROPERTY(object_id('AST.CostPartTransaction'), 'RemainingRoundingDepreciation' , 'AllowsNull') IS NULL
begin
	ALTER TABLE AST.CostPartTransaction ADD [RemainingRoundingDepreciation] [DECIMAL] (30,25) NULL 
end
GO
IF COLUMNPROPERTY(object_id('AST.CostPartTransaction'), 'RemainingRoundingDepreciation' , 'AllowsNull') = 1
begin
    UPDATE AST.CostPartTransaction  SET [RemainingRoundingDepreciation] = 0 WHERE [RemainingRoundingDepreciation] IS NULL
	ALTER TABLE AST.CostPartTransaction ALTER COLUMN [RemainingRoundingDepreciation] [DECIMAL] (30,25) NOT NULL 
end
GO
IF COLUMNPROPERTY(object_id('AST.CostPartTransaction'), 'CalculationDate' , 'AllowsNull') = 0
begin
	ALTER TABLE AST.CostPartTransaction ALTER COLUMN [CalculationDate] [datetime] NULL
end
GO
IF COLUMNPROPERTY(object_id('AST.CostPartTransaction'), 'CreationDate' , 'AllowsNull') = 0
begin
	ALTER TABLE AST.CostPartTransaction ALTER COLUMN [CreationDate] [datetime] NULL
end
GO

IF  COLUMNPROPERTY(object_id('AST.CostPartTransaction'), 'UsefulLife' , 'Precision') <> 30 OR
    COLUMNPROPERTY(object_id('AST.CostPartTransaction'), 'UsefulLife' , 'Scale'    ) <> 25
BEGIN
	ALTER TABLE AST.CostPartTransaction ALTER COLUMN [UsefulLife] [DECIMAL](30,25)	NOT	NULL
END
GO

IF  COLUMNPROPERTY(object_id('AST.CostPartTransaction'), 'AcquisingElapsedLife' , 'Precision') <> 30 OR
    COLUMNPROPERTY(object_id('AST.CostPartTransaction'), 'AcquisingElapsedLife' , 'Scale'    ) <> 25
BEGIN
	ALTER TABLE AST.CostPartTransaction ALTER COLUMN [AcquisingElapsedLife] [DECIMAL](30,25)		NULL
END
GO

IF  COLUMNPROPERTY(object_id('AST.CostPartTransaction'), 'AssetElapsedLife' , 'Precision') <> 30 OR
    COLUMNPROPERTY(object_id('AST.CostPartTransaction'), 'AssetElapsedLife' , 'Scale'    ) <> 25
BEGIN
	ALTER TABLE AST.CostPartTransaction ALTER COLUMN [AssetElapsedLife] [DECIMAL](30,25)		NULL
END
GO
--<< PRIMARYKEY DEFINITION >>--

GO
If not Exists (select 1 from sys.objects where name = 'PK_AST_CostPartTransaction')
	ALTER TABLE [AST].[CostPartTransaction]  ADD  CONSTRAINT [PK_AST_CostPartTransaction] PRIMARY KEY CLUSTERED 
	([CostPartTransactionID] ASC
	) ON [PRIMARY]
GO

--<< DEFAULTS CHECKS DEFINITION >>--

--<< RULES DEFINITION >>--

--<< INDEXES DEFINITION >>--

--<< FOREIGNKEYS DEFINITION >>--

IF NOT EXISTS (select 1 from sys.objects where name = 'FK_AST_CostPartTransaction_AssetTransactionRef')
	ALTER TABLE [AST].[CostPartTransaction]  ADD  CONSTRAINT [FK_AST_CostPartTransaction_AssetTransactionRef] 
		FOREIGN KEY([AssetTransactionRef])
		REFERENCES [AST].[AssetTransaction] ([AssetTransactionID])
		ON UPDATE CASCADE
		ON DELETE CASCADE
GO

IF NOT EXISTS (select 1 from sys.objects where name = 'FK_AST_CostPartTransaction_CostPartRef')
	ALTER TABLE [AST].[CostPartTransaction]  ADD  CONSTRAINT [FK_AST_CostPartTransaction_CostPartRef] 
		FOREIGN KEY([CostPartRef])
		REFERENCES [AST].[CostPart] ([CostPartID])
GO

--<< DROP OBJECTS >>--

