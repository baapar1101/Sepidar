--<<FileName:AST_Asset.sql>>--
--<< TABLE DEFINITION >>--

If Object_ID('AST.Asset') Is Null
CREATE TABLE [AST].[Asset](
	[AssetId]				[INT]			NOT NULL,
	[PlaqueNumber]			[NVARCHAR](250) NOT NULL,
	[OldPlaqueNumber]		[NVARCHAR](250)		NULL,
	[PlaqueSerial]			[INT]				NULL,
	[Title]					[NVARCHAR](250) NOT NULL,
	[Title_En]				[NVARCHAR](250) NOT NULL,
	[State]					[INT] 			NOT NULL,
	[AssetGroupRef]			[INT] 			NOT NULL,
	[CostCenterDlRef]			[INT] 			NOT NULL,
	[EmplacementRef]		[INT] 				NULL,
	[ReceiverPartyRef]		[INT] 				NULL,
	[Description]			[NVARCHAR](250)		NULL,
	[Details]				[NVARCHAR](250)		NULL,
	[Version]				[INT] 			NOT NULL,
	[Creator]				[INT] 			NOT NULL,
	[CreationDate]			[DATETIME]		NOT NULL,
	[LastModifier]			[INT]			NOT NULL,
	[LastModificationDate]	[DATETIME]		NOT NULL,
	[IsInitial]				[BIT]			NOT NULL
) ON [PRIMARY]

--TEXTIMAGE_ON [SGBlob_Data]
--When a table has text, ntext, image, varchar(max), nvarchar(max), varbinary(max), xml or large user defined type columns uncomment above code
GO
--<< ADD CLOLUMNS >>--
IF NOT EXISTS (SELECT 1 FROM sys.columns WHERE object_id=object_id('AST.Asset') AND
				[name] = 'Description')
BEGIN
    ALTER TABLE AST.Asset ADD [Description] [NVARCHAR](250) NULL
END	

Go

IF NOT EXISTS (SELECT 1 FROM sys.columns WHERE object_id=object_id('AST.Asset') AND
				[name] = 'Details')
BEGIN
    ALTER TABLE AST.Asset ADD [Details] [NVARCHAR](250) NULL
END				
Go
IF NOT EXISTS (SELECT 1 FROM sys.columns WHERE object_id=object_id('AST.Asset') AND
				[name] = 'CostCenterDlRef')
BEGIN
    ALTER TABLE AST.Asset ADD [CostCenterDlRef] [Int] NULL
END	

Go
--<<Sample>>--
/*if not exists (select 1 from sys.columns where object_id=object_id('AST.Asset') and
				[name] = 'ColumnName')
begin
    Alter table AST.Asset Add ColumnName DataType Nullable
end
GO*/

--<< ALTER COLUMNS >>--

--<< PRIMARYKEY DEFINITION >>--

If not Exists (select 1 from sys.objects where name = 'PK_Asset')
ALTER TABLE [AST].[Asset] ADD  CONSTRAINT [PK_Asset] PRIMARY KEY CLUSTERED 
(
	[AssetId] ASC
) ON [PRIMARY]
GO

--<< DEFAULTS CHECKS DEFINITION >>--

--<< RULES DEFINITION >>--

--<< INDEXES DEFINITION >>--
IF NOT EXISTS (SELECT 1 FROM sys.indexes WHERE name = 'UX_Asset_PlaqueNumber')
CREATE UNIQUE NONCLUSTERED INDEX [UX_Asset_PlaqueNumber] ON [AST].[Asset] 
(
	[PlaqueNumber] ASC
) ON [PRIMARY]

GO

--<< FOREIGNKEYS DEFINITION >>--

If not Exists (select 1 from sys.objects where name = 'FK_AST_Asset_AssetGroupRef')
ALTER TABLE [AST].[Asset]  ADD  CONSTRAINT [FK_AST_Asset_AssetGroupRef] FOREIGN KEY([AssetGroupRef])
REFERENCES [AST].[AssetGroup] ([AssetGroupID])

GO
/*If not Exists (select 1 from sys.objects where name = 'FK_AST_Asset_CostCenterRef')
ALTER TABLE [AST].[Asset]  ADD  CONSTRAINT [FK_AST_Asset_CostCenterRef] FOREIGN KEY([CostCenterRef])
REFERENCES [GNR].[CostCenter] ([CostCenterId])

GO*/



If not Exists (select 1 from sys.objects where name = 'FK_AST_Asset_CostCenterDlRef')
ALTER TABLE [AST].[Asset]  ADD  CONSTRAINT [FK_AST_Asset_CostCenterDlRef] FOREIGN KEY([CostCenterDlRef])
REFERENCES [Acc].[DL] ([DlId])

GO
If not Exists (select 1 from sys.objects where name = 'FK_AST_Asset_EmplacementRef')
ALTER TABLE [AST].[Asset]  ADD  CONSTRAINT [FK_AST_Asset_EmplacementRef] FOREIGN KEY([EmplacementRef])
REFERENCES [AST].[Emplacement] ([EmplacementId])

GO
If not Exists (select 1 from sys.objects where name = 'FK_AST_Asset_ReceiverPartyRef')
ALTER TABLE [AST].[Asset]  ADD  CONSTRAINT [FK_AST_Asset_ReceiverPartyRef] FOREIGN KEY(ReceiverPartyRef)
REFERENCES [GNR].[Party] ([PartyId])

GO

--<< DROP OBJECTS >>--
If  Exists (select 1 from sys.objects where name = 'FK_AST_Asset_CostCenterRef')
ALTER TABLE [AST].[Asset]  Drop CONSTRAINT [FK_AST_Asset_CostCenterRef] 
Go


IF  EXISTS (SELECT 1 FROM sys.columns WHERE object_id=object_id('AST.Asset') AND
				[name] = 'CostCenterRef')
BEGIN
    ALTER TABLE AST.Asset ALTER COLUMN [CostCenterRef] [Int] NULL 
END	

Go
