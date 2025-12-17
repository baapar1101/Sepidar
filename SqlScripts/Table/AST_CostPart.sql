--<<FileName:AST_CostPart.sql>>--
--<< TABLE DEFINITION >>--

If Object_ID('AST.CostPart') Is Null
CREATE TABLE [AST].[CostPart](
	[CostPartId]							[INT] 			 NOT NULL,
	[AssetRef]								[INT] 			 NOT NULL,
	[CostPartType]							[INT] 			 NOT NULL,
	[TotalCost]								[DECIMAL](19,4)  NOT NULL,
	[AccumulatedDepreciation]				[DECIMAL](19,4)  NOT NULL,
	[EstablishmentAccumulatedDepreciation]  [DECIMAL](19,4)  NOT NULL,
	[EffectiveDate]							[DATETIME]		 NOT NULL,
	[DepreciationRate]						[DECIMAL] (5,2)  NOT NULL,
	[DepreciationMethodType]				[INT]			 NOT NULL,
	[UsefulLife]							[DECIMAL](30,25) NOT NULL,
	[MaxDepreciableBookValue]				[DECIMAL](19,4)	 NOT NULL,
	[SalvageValue]							[DECIMAL](19,2)  NOT NULL,
	[AcquisingElapsedLife]					[DECIMAL](30,25)	NULL,
	[DepreciationState]						[INT]			 NOT	NULL,
	[IsInitial]								[BIT]			 NOT NULL
) ON [PRIMARY]

--TEXTIMAGE_ON [SGBlob_Data]
--When a table has text, ntext, image, varchar(max), nvarchar(max), varbinary(max), xml or large user defined type columns uncomment above code
GO
--<< ADD CLOLUMNS >>--

--<<Sample>>--
/*if not exists (select 1 from sys.columns where object_id=object_id('AST.CostPart') and
				[name] = 'ColumnName')
begin
    Alter table AST.CostPart Add ColumnName DataType Nullable
end
GO*/

--<< ALTER COLUMNS >>--
IF  COLUMNPROPERTY(object_id('AST.CostPart'), 'UsefulLife' , 'Precision') <> 30 OR
    COLUMNPROPERTY(object_id('AST.CostPart'), 'UsefulLife' , 'Scale'    ) <> 25
BEGIN
	ALTER TABLE AST.CostPart ALTER COLUMN [UsefulLife] [DECIMAL](30,25)	NOT	NULL
END
GO
IF  COLUMNPROPERTY(object_id('AST.CostPart'), 'AcquisingElapsedLife' , 'Precision') <> 30 OR
    COLUMNPROPERTY(object_id('AST.CostPart'), 'AcquisingElapsedLife' , 'Scale'    ) <> 25
BEGIN
	ALTER TABLE AST.CostPart ALTER COLUMN [AcquisingElapsedLife] [DECIMAL](30,25)		NULL
END
GO
--<< PRIMARYKEY DEFINITION >>--

If not Exists (select 1 from sys.objects where name = 'PK_CostPart')
ALTER TABLE [AST].[CostPart] ADD  CONSTRAINT [PK_CostPart] PRIMARY KEY CLUSTERED 
(
	[CostPartId] ASC
) ON [PRIMARY]
GO

--<< DEFAULTS CHECKS DEFINITION >>--

--<< RULES DEFINITION >>--

--<< INDEXES DEFINITION >>--

--<< FOREIGNKEYS DEFINITION >>--

If not Exists (select 1 from sys.objects where name = 'FK_AST_CostPart_AssetRef')
	ALTER TABLE [AST].[CostPart]  ADD  CONSTRAINT [FK_AST_CostPart_AssetRef] FOREIGN KEY([AssetRef])
			REFERENCES [AST].[Asset] ([AssetID])
			ON UPDATE CASCADE
			ON DELETE CASCADE

GO
--<< DROP OBJECTS >>--

IF(COLUMNPROPERTY(OBJECT_ID('AST.CostPart'),'EstablishmentAccumulatedDepreciation', 'PRECISION') IS NULL )
BEGIN
	ALTER TABLE AST .[CostPart]
	ADD  [EstablishmentAccumulatedDepreciation]  [DECIMAL](19,4)  NOT NULL DEFAULT(0)
END

 
 