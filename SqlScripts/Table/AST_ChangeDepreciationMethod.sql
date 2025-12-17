--<<FileName:AST_Asset.sql>>--
--<< TABLE DEFINITION >>--

If Object_ID('AST.ChangeDepreciationMethod') Is Null
CREATE TABLE [AST].[ChangeDepreciationMethod](
	[ChangeDepreciationMethodId]	[INT]			NOT NULL,
	[Date]							[Datetime]		NOT NULL,
	[Number]						[INT]			NOT NULL,
	[AssetRef]						[INT]			NOT NULL,
	[AssetTransactionRef]			[INT]			NOT NULL,
	[FiscalYearRef]					[INT]			NOT NULL,
	[Description]					NVARCHAR(4000)	NULL,
	[Description_En]				NVARCHAR(4000)	NULL,
	[Version]						[INT] 			NOT NULL,
	[Creator]						[INT] 			NOT NULL,
	[CreationDate]					[DATETIME]		NOT NULL,
	[LastModifier]					[INT]			NOT NULL,
	[LastModificationDate]			[DATETIME]		NOT NULL,
) ON [PRIMARY]

--TEXTIMAGE_ON [SGBlob_Data]
--When a table has text, ntext, image, varchar(max), nvarchar(max), varbinary(max), xml or large user defined type columns uncomment above code
GO
--<< ADD CLOLUMNS >>--
--<<Sample>>--
--<< ALTER COLUMNS >>--
--<< PRIMARYKEY DEFINITION >>--

If not Exists (select 1 from sys.objects where name = 'PK_ChangeDepreciationMethodID')
ALTER TABLE [AST].[ChangeDepreciationMethod] ADD  CONSTRAINT [PK_ChangeDepreciationMethodId] PRIMARY KEY CLUSTERED 
(
	[ChangeDepreciationMethodId] ASC
) ON [PRIMARY]
GO

--<< DEFAULTS CHECKS DEFINITION >>--
--<< RULES DEFINITION >>--
--<< INDEXES DEFINITION >>--
--<< FOREIGNKEYS DEFINITION >>--

If not Exists (select 1 from sys.objects where name = 'FK_ChangeDepreciationMethod_AssetTransactionRef')
ALTER TABLE [AST].[ChangeDepreciationMethod]  ADD  CONSTRAINT [FK_ChangeDepreciationMethod_AssetTransactionRef] FOREIGN KEY([AssetTransactionRef])
REFERENCES [AST].[AssetTransaction] ([AssetTransactionId])

GO
If not Exists (select 1 from sys.objects where name = 'FK_ChangeDepreciationMethod_AssetRef')
ALTER TABLE [AST].[ChangeDepreciationMethod]  ADD  CONSTRAINT [FK_ChangeDepreciationMethod_AssetRef] FOREIGN KEY([AssetRef])
REFERENCES [AST].[Asset] ([AssetId])

GO
If not Exists (select 1 from sys.objects where name = 'FK_ChangeDepreciationMethod_FiscalYearRef')
ALTER TABLE [AST].[ChangeDepreciationMethod]  ADD  CONSTRAINT [FK_ChangeDepreciationMethod_FiscalYearRef] FOREIGN KEY([FiscalYearRef])
REFERENCES [FMK].[FiscalYear] ([FiscalYearId])

GO

--<< DROP OBJECTS >>--
