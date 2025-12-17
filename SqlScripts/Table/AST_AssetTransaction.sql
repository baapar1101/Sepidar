--<<FileName:AST_AssetTransactiont.sql>>--
--<< TABLE DEFINITION >>--

IF OBJECT_ID('AST.AssetTransaction') IS NULL
	CREATE TABLE [AST].[AssetTransaction](
		[AssetTransactionID]  [int] 		NOT NULL,
		[TransactionType]     [int] 		NOT NULL,
		[AssetTransactionRef] [int] 		    NULL,
		[AssetRef]            [int] 		NOT NULL,
		[AssetState]          [int] 		NOT NULL,
		[CostCenterDlRef]     [int] 		NULL,
		[AssetGroupRef]       [int] 		NOT NULL,
		[EmplacementRef]      [int] 			NULL,
		[ReceiverPartyRef]    [int]				NULL,
		[FiscalYearRef]       [int] 		NOT NULL,
		[ActivityDate]        [datetime]	NOT NULL,
		[ActivityNumber]      [int]				NULL,
		[ActivityRef]		  [int]			NOT NULL
		--[ActivityState] [int] NOT NULL,
		
	)
--TEXTIMAGE_ON [SGBlob_Data]
--When a table has text, ntext, image, varchar(max), nvarchar(max), varbinary(max), xml or large user defined type columns uncomment above code
GO
--<< ADD CLOLUMNS >>--

--<<Sample>>--

if not exists (select 1 from sys.columns where object_id=object_id('AST.AssetTransaction') and
				[name] = 'CostCenterDlRef')
begin
    Alter table AST.AssetTransaction Add CostCenterDlRef INT Null
end
GO
--<< ALTER COLUMNS >>--

--<< PRIMARYKEY DEFINITION >>--

GO
If not Exists (select 1 from sys.objects where name = 'PK_AST_AssetTransaction')
	ALTER TABLE [AST].[AssetTransaction]  ADD  CONSTRAINT [PK_AST_AssetTransaction] PRIMARY KEY CLUSTERED 
	([AssetTransactionID]ASC
) ON [PRIMARY]
GO

--<< DEFAULTS CHECKS DEFINITION >>--

--<< RULES DEFINITION >>--

--<< INDEXES DEFINITION >>--

--<< FOREIGNKEYS DEFINITION >>--

IF NOT EXISTS (select 1 from sys.objects where name = 'FK_AST_AssetTransaction_AssetRef')
	ALTER TABLE [AST].[AssetTransaction]  ADD  CONSTRAINT [FK_AST_AssetTransaction_AssetRef] 
		FOREIGN KEY([AssetRef])
		REFERENCES [AST].[Asset] ([AssetID])
GO

IF NOT EXISTS (select 1 from sys.objects where name = 'FK_AST_AssetTransaction_AssetTransactionRef')
	ALTER TABLE [AST].[AssetTransaction]  ADD  CONSTRAINT [FK_AST_AssetTransaction_AssetTransactionRef] 
		FOREIGN KEY([AssetTransactionRef])
		REFERENCES [AST].[AssetTransaction] ([AssetTransactionID])
GO


IF NOT EXISTS (select 1 from sys.objects where name = 'FK_AST_AssetTransaction_CostCenterDlRef')
	ALTER TABLE [AST].[AssetTransaction]  ADD  CONSTRAINT [FK_AST_AssetTransaction_CostCenterDlRef] 
		FOREIGN KEY([CostCenterDlRef])
		REFERENCES [ACC].[DL] ([DlID])
GO

IF NOT EXISTS (select 1 from sys.objects where name = 'FK_AST_AssetTransaction_AssetGroupRef')
	ALTER TABLE [AST].[AssetTransaction]  ADD  CONSTRAINT [FK_AST_AssetTransaction_AssetGroupRef] 
		FOREIGN KEY([AssetGroupRef])
		REFERENCES [AST].[AssetGroup] ([AssetGroupID])
GO

IF NOT EXISTS (select 1 from sys.objects where name = 'FK_AST_AssetTransaction_EmplacementRef')
	ALTER TABLE [AST].[AssetTransaction]  ADD  CONSTRAINT [FK_AST_AssetTransaction_EmplacementRef] 
		FOREIGN KEY([EmplacementRef])
		REFERENCES [AST].[Emplacement] ([EmplacementID])
GO

IF NOT EXISTS (select 1 from sys.objects where name = 'FK_AST_AssetTransaction_ReceiverPartyRef')
	ALTER TABLE [AST].[AssetTransaction]  ADD  CONSTRAINT [FK_AST_AssetTransaction_ReceiverPartyRef] 
		FOREIGN KEY([ReceiverPartyRef])
		REFERENCES [GNR].[Party] ([PartyID])
GO

IF NOT EXISTS (select 1 from sys.objects where name = 'FK_AST_AssetTransaction_FiscalYearRef')
	ALTER TABLE [AST].[AssetTransaction]  ADD  CONSTRAINT [FK_AST_AssetTransaction_FiscalYearRef] 
		FOREIGN KEY([FiscalYearRef])
		REFERENCES [FMK].[FiscalYear] ([FiscalYearID])
GO


--<< DROP OBJECTS >>--

IF  EXISTS (select 1 from sys.objects where name = 'FK_AST_AssetTransaction_CostCenterRef')
	ALTER TABLE [AST].[AssetTransaction]  DROP  CONSTRAINT [FK_AST_AssetTransaction_CostCenterRef] 
		
GO

if  exists (select 1 from sys.columns where object_id=object_id('AST.AssetTransaction') and
				[name] = 'CostCenterRef')
begin
    Alter table AST.AssetTransaction ALTER COLUMN CostCenterRef INT Null
end
GO