--<<FileName:AST_ChangeDepreciationMethodItem.sql>>--
--<< TABLE DEFINITION >>--

If Object_ID('AST.ChangeDepreciationMethodItem') Is Null
CREATE TABLE [AST].[ChangeDepreciationMethodItem](
	[ChangeDepreciationMethodItemId]		[INT] 			 NOT NULL,
	[ChangeDepreciationMethodRef]			[INT] 			 NOT NULL,
	[CostPartRef]							[INT] 			 NOT NULL,
	[CostPartTransactionRef]				[INT] 			 NOT NULL,
	[DepreciationMethodType]				[INT]			 NOT NULL,
	[DepreciationRate]						[DECIMAL]  (5,2) NOT NULL,
	[UsefulLife]							[DECIMAL](30,25) NOT NULL,
	[MaxDepreciableBookValue]				[DECIMAL] (19,4) NOT NULL,
	[AssetElapsedLife]						[DECIMAL](30,25) NOT NULL,
	[AccumulatedDepreciation]				[DECIMAL] (19,4) NOT NULL,
	[DepreciableBookValue]					[DECIMAL] (19,4) NOT NULL,

) ON [PRIMARY]
 
--TEXTIMAGE_ON [SGBlob_Data]
--When a table has text, ntext, image, varchar(max), nvarchar(max), varbinary(max), xml or large user defined type columns uncomment above code
GO
--<< ADD CLOLUMNS >>--

IF COLUMNPROPERTY(object_id('AST.ChangeDepreciationMethodItem'), 'AssetElapsedLife' , 'AllowsNull') IS NULL
begin
	ALTER TABLE AST.ChangeDepreciationMethodItem ADD [AssetElapsedLife] [DECIMAL] (30,25) NULL 
end
GO

--<<Sample>>--
--<< ALTER COLUMNS >>--

IF  COLUMNPROPERTY(object_id('AST.ChangeDepreciationMethodItem'), 'UsefulLife' , 'Precision') <> 30 OR
    COLUMNPROPERTY(object_id('AST.ChangeDepreciationMethodItem'), 'UsefulLife' , 'Scale'    ) <> 25
BEGIN
	ALTER TABLE AST.ChangeDepreciationMethodItem ALTER COLUMN [UsefulLife] [DECIMAL](30,25)	NOT	NULL
END
GO


--<< PRIMARYKEY DEFINITION >>--

If not Exists (select 1 from sys.objects where name = 'PK_ChangeDepreciationMethodItemId')
ALTER TABLE [AST].[ChangeDepreciationMethodItem] ADD  CONSTRAINT [PK_ChangeDepreciationMethodItemId] PRIMARY KEY CLUSTERED 
(
	[ChangeDepreciationMethodItemId] ASC
) ON [PRIMARY]
GO

--<< DEFAULTS CHECKS DEFINITION >>--

--<< RULES DEFINITION >>--

--<< INDEXES DEFINITION >>--

--<< FOREIGNKEYS DEFINITION >>--

If not Exists (select 1 from sys.objects where name = 'FK_ChangeDepreciationMethodItem_ChangeDepreciationMethodRef')
	ALTER TABLE [AST].[ChangeDepreciationMethodItem]  ADD  CONSTRAINT [FK_ChangeDepreciationMethodItem_ChangeDepreciationMethodRef] FOREIGN KEY([ChangeDepreciationMethodRef])
			REFERENCES [AST].[ChangeDepreciationMethod] ([ChangeDepreciationMethodId])
			ON UPDATE CASCADE
			ON DELETE CASCADE

GO

If not Exists (select 1 from sys.objects where name = 'FK_ChangeDepreciationMethodItem_CostPartTransactionRef')
	ALTER TABLE [AST].[ChangeDepreciationMethodItem]  ADD  CONSTRAINT [FK_ChangeDepreciationMethodItem_CostPartTransactionRef] FOREIGN KEY([CostPartTransactionRef])
			REFERENCES [AST].[CostPartTransaction] ([CostPartTransactionId])

GO
--<< DROP OBJECTS >>--
 IF COLUMNPROPERTY(object_id('AST.ChangeDepreciationMethodItem'), 'AssetRemainingUsefulLife' , 'AllowsNull') IS NOT NULL
begin
	ALTER TABLE AST.ChangeDepreciationMethodItem DROP COLUMN [AssetRemainingUsefulLife] 
end
GO


IF  COLUMNPROPERTY(object_id('AST.ChangeDepreciationMethodItem'), 'SalvageValue' , 'AllowsNull') IS NOT NULL
BEGIN
	ALTER TABLE AST.ChangeDepreciationMethodItem  DROP COLUMN [SalvageValue] 
END
GO