--<<FileName:GNR_PartyAddress.sql>>--
--<< TABLE DEFINITION >>--

If Object_ID('GNR.PartyAddress') Is Null
CREATE TABLE [GNR].[PartyAddress](
	[PartyAddressId] [int] NOT NULL,
	[PartyRef] [int] NOT NULL,
	[IsMain] [int] NOT NULL,
	[Type] [int] NOT NULL,
	[Address] [nvarchar](400) NOT NULL,
	[LocationRef] [int] NULL,
	[ZipCode] [varchar](40) NULL,
	[BranchCode] [varchar](40) NULL,
	[Adress_En] [nvarchar](400) NOT NULL,
	[Title] [nvarchar](250) NULL,
	[Latitude] [DECIMAL](12,9) NULL,
	[Longitude] [DECIMAL](12,9) NULL,
	[Version] [int] NOT NULL,
	[Guid] [nvarchar](36) NULL,
) ON [PRIMARY]

--TEXTIMAGE_ON [SGBlob_Data]
--When a table has text, ntext, image, varchar(max), nvarchar(max), varbinary(max), xml or large user defined type columns uncomment above code
GO
--<< ADD CLOLUMNS >>--

--<<Sample>>--
/*if not exists (select 1 from sys.columns where object_id=object_id('GNR.PartyAddress') and
				[name] = 'ColumnName')
begin
    Alter table GNR.PartyAddress Add ColumnName DataType Nullable
end
GO*/

if not exists (select 1 from sys.columns where object_id=object_id('GNR.PartyAddress') and
				[name] = 'Latitude')
begin
    Alter table GNR.PartyAddress Add [Latitude] [DECIMAL](12,9) NULL
end
GO

if not exists (select 1 from sys.columns where object_id=object_id('GNR.PartyAddress') and
				[name] = 'Longitude')
begin
    Alter table GNR.PartyAddress Add [Longitude] [DECIMAL](12,9) NULL
end
GO

if not exists (select 1 from sys.columns where object_id=object_id('GNR.PartyAddress') and
				[name] = 'Title')
begin
    Alter table GNR.PartyAddress Add [Title] [nvarchar](250) NULL
end
GO

IF NOT EXISTS (SELECT 1 FROM sys.columns WHERE object_id=object_id('GNR.PartyAddress') and
	[name]='Guid')
BEGIN
	ALTER TABLE GNR.PartyAddress ADD [Guid] [nvarchar](36) NULL
END
GO

IF NOT EXISTS (SELECT 1 FROM sys.columns WHERE object_id=object_id('GNR.PartyAddress') and
	[name]='BranchCode')
BEGIN
	ALTER TABLE GNR.PartyAddress ADD [BranchCode] [varchar](40) NULL
END
Go

--<< ALTER COLUMNS >>--

--<< PRIMARYKEY DEFINITION >>--

If not Exists (select 1 from sys.objects where name = 'PK_PartyAddress')
ALTER TABLE [GNR].[PartyAddress] ADD  CONSTRAINT [PK_PartyAddress] PRIMARY KEY CLUSTERED 
(
	[PartyAddressId] ASC
) ON [PRIMARY]
GO

--<< DEFAULTS CHECKS DEFINITION >>--

--<< RULES DEFINITION >>--

--<< INDEXES DEFINITION >>--
IF NOT EXISTS (SELECT 1 FROM sys.indexes WHERE name = 'IX_PartyAddress_IsMain')
CREATE NONCLUSTERED INDEX [IX_PartyAddress_IsMain] ON [GNR].[PartyAddress] 
(
	[IsMain]
) 
ON [PRIMARY]

GO

IF NOT EXISTS (SELECT 1 FROM sys.indexes WHERE name = 'IX_PartyAddress_PartyRef_IsMain')
CREATE NONCLUSTERED INDEX [IX_PartyAddress_PartyRef_IsMain] ON [GNR].[PartyAddress] 
(
	[PartyRef],
	[IsMain]
) 
ON [PRIMARY]

GO

IF NOT EXISTS (SELECT 1 FROM sys.indexes WHERE name = 'UIX_PartyAddress_Guid')
CREATE UNIQUE NONCLUSTERED INDEX [UIX_PartyAddress_Guid] ON [GNR].[PartyAddress]
(
	[Guid] ASC
) WHERE [Guid] IS NOT NULL ON [PRIMARY]

GO

--<< FOREIGNKEYS DEFINITION >>--

If not Exists (select 1 from sys.objects where name = 'FK_PartyAddress_LocationRef_2_Location_LocationId')
ALTER TABLE [GNR].[PartyAddress]  ADD  CONSTRAINT [FK_PartyAddress_LocationRef_2_Location_LocationId] FOREIGN KEY([LocationRef])
REFERENCES [GNR].[Location] ([LocationId])

GO
If not Exists (select 1 from sys.objects where name = 'FK_PartyAddress_PartyRef_2_Party_PartyId')
ALTER TABLE [GNR].[PartyAddress]  ADD  CONSTRAINT [FK_PartyAddress_PartyRef_2_Party_PartyId] FOREIGN KEY([PartyRef])
REFERENCES [GNR].[Party] ([PartyId])
ON UPDATE CASCADE
ON DELETE CASCADE

GO

--<< DROP OBJECTS >>--
