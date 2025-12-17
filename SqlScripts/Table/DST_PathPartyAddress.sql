--<<FileName:DST_PathPartyAddress.sql>>--

--<< TABLE DEFINITION >>--
IF Object_ID('DST.PathPartyAddress') IS NULL
CREATE TABLE [DST].[PathPartyAddress](
	[PathPartyAddressId]	[INT]		NOT NULL,
	[RowOrder]				[INT]		NOT NULL,
	[AreaAndPathRef]		[INT]		NOT NULL,
	[PartyAddressRef]		[INT]		NOT NULL,
	[Version]				[INT]		NOT NULL,
	[Creator]				[INT]		NOT NULL,
	[CreationDate]			[DATETIME]	NOT NULL,
	[LastModifier]			[INT]		NOT NULL,
	[LastModificationDate]	[DATETIME]	NOT NULL
) ON [PRIMARY]

--TEXTIMAGE_ON [SGBlob_Data]
--When a table has text, ntext, image, varchar(max), nvarchar(max), varbinary(max), xml or large user defined type columns uncomment above code
GO

--<< ADD CLOLUMNS >>--

--<<Sample>>--
/*if not exists (select 1 from sys.columns where object_id=object_id('DST.PathPartyAddress') and
				[name] = 'ColumnName')
begin
    Alter table DST.PathPartyAddress Add ColumnName DataType Nullable
end
GO*/
IF NOT EXISTS (SELECT 1 FROM sys.columns WHERE OBJECT_ID=OBJECT_ID('DST.PathPartyAddress') AND
				[Name] = 'RowOrder')
BEGIN
    ALTER TABLE DST.[PathPartyAddress] ADD [RowOrder] [INT] NOT NULL DEFAULT -1	--- Remove before Release
END

GO
--<< ALTER COLUMNS >>--

--<< PRIMARYKEY DEFINITION >>--
IF NOT EXISTS (SELECT 1 FROM sys.objects WHERE NAME = 'PK_PathPartyAddress')
ALTER TABLE [DST].[PathPartyAddress] ADD CONSTRAINT [PK_PathPartyAddress] PRIMARY KEY CLUSTERED 
(
	[PathPartyAddressId] ASC
) ON [PRIMARY]
GO

--<< DEFAULTS CHECKS DEFINITION >>--

--<< RULES DEFINITION >>--

--<< INDEXES DEFINITION >>--
IF NOT EXISTS (SELECT 1 FROM sys.indexes WHERE NAME = 'UIX_PathPartyAddress_AreaAndPathRef_PartyAddressRef')
CREATE UNIQUE NONCLUSTERED INDEX [UIX_PathPartyAddress_AreaAndPathRef_PartyAddressRef] ON [DST].[PathPartyAddress] 
(
	[AreaAndPathRef]	ASC,
	[PartyAddressRef]	ASC
) ON [PRIMARY]

GO

IF NOT EXISTS (SELECT 1 FROM sys.indexes WHERE NAME = 'UIX_PathPartyAddress_PartyAddressRef')
CREATE UNIQUE NONCLUSTERED INDEX [UIX_PathPartyAddress_PartyAddressRef] ON [DST].[PathPartyAddress] 
(
	[PartyAddressRef]	ASC
) ON [PRIMARY]

GO

--<< FOREIGNKEYS DEFINITION >>--
IF NOT EXISTS (SELECT 1 FROM sys.objects WHERE NAME = 'FK_PathPartyAddress_AreaAndPathRef')
ALTER TABLE [DST].[PathPartyAddress] ADD CONSTRAINT [FK_PathPartyAddress_AreaAndPathRef] FOREIGN KEY([AreaAndPathRef])
REFERENCES [DST].[AreaAndPath] ([AreaAndPathId])

GO

IF NOT EXISTS (SELECT 1 FROM sys.objects WHERE NAME = 'FK_PathPartyAddress_PartyAddressRef')
ALTER TABLE [DST].[PathPartyAddress] ADD CONSTRAINT [FK_PathPartyAddress_PartyAddressRef] FOREIGN KEY([PartyAddressRef])
REFERENCES [GNR].[PartyAddress] ([PartyAddressId])

GO
--<< DROP OBJECTS >>--
