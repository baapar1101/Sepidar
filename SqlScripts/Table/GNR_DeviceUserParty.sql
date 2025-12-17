--<<FileName:GNR_DeviceUserParty.sql>>--
--<< TABLE DEFINITION >>--

IF OBJECT_ID('GNR.DeviceUserParty') IS NULL
CREATE TABLE [GNR].[DeviceUserParty](
	[DeviceUserPartyId]	[INT] NOT NULL,
	[DeviceRef]			[INT] NOT NULL,
	[UserRef]			[INT] NOT NULL,
	[PartyRef]			[INT] NULL,
	[Version]			[INT] NOT NULL,
) ON [PRIMARY]

--TEXTIMAGE_ON [SGBlob_Data]
--When a table has text, ntext, image, varchar(max), nvarchar(max), varbinary(max), xml or large user defined type columns uncomment above code
GO
--<< ADD CLOLUMNS >>--

--<<Sample>>--
/*if not exists (select 1 from sys.columns where object_id=object_id('GNR.PartyRelated') and
				[name] = 'ColumnName')
begin
    Alter table GNR.PartyRelated Add ColumnName DataType Nullable
end
GO*/

--<< ALTER COLUMNS >>--
IF EXISTS (SELECT 1 FROM sys.[columns] AS [C] WHERE [C].[object_id] = OBJECT_ID('GNR.DeviceUserParty')
													AND [C].[name] = 'PartyRef'
													AND [C].[is_nullable] = 0)
BEGIN
	ALTER TABLE [GNR].[DeviceUserParty] ALTER COLUMN [PartyRef] [int] NULL
END
GO

--<< PRIMARYKEY DEFINITION >>--
IF NOT EXISTS (SELECT 1 FROM sys.objects WHERE name = 'PK_DeviceUserParty')
ALTER TABLE [GNR].[DeviceUserParty] ADD  CONSTRAINT PK_DeviceUserParty PRIMARY KEY CLUSTERED 
(
	[DeviceUserPartyId] ASC
) ON [PRIMARY]
GO

--<< DEFAULTS CHECKS DEFINITION >>--

--<< RULES DEFINITION >>--

--<< INDEXES DEFINITION >>--

IF EXISTS (SELECT 1 FROM sys.indexes WHERE name = 'UIX_DeviceUserParty_PartyRef' AND [has_filter] = 0)
BEGIN
	DROP INDEX [UIX_DeviceUserParty_PartyRef] ON [GNR].[DeviceUserParty]
END
GO

IF NOT EXISTS (SELECT 1 FROM sys.indexes WHERE name = 'UIX_DeviceUserParty_PartyRef')
CREATE UNIQUE NONCLUSTERED INDEX [UIX_DeviceUserParty_PartyRef] ON [GNR].[DeviceUserParty]
(
	[PartyRef] ASC
) WHERE [PartyRef] IS NOT NULL ON [PRIMARY]
GO

IF NOT EXISTS (SELECT 1 FROM sys.indexes WHERE name = 'UIX_DeviceUserParty_UserRef')
CREATE UNIQUE NONCLUSTERED INDEX [UIX_DeviceUserParty_UserRef] ON [GNR].[DeviceUserParty]
(
	[UserRef] ASC
) ON [PRIMARY]
GO

--<< FOREIGNKEYS DEFINITION >>--
IF NOT EXISTS (SELECT 1 FROM sys.objects WHERE name = 'FK_DeviceUserParty_DeviceRef')
ALTER TABLE [GNR].[DeviceUserParty] ADD CONSTRAINT [FK_DeviceUserParty_DeviceRef] FOREIGN KEY([DeviceRef])
REFERENCES [GNR].[Device]([DeviceId])
ON UPDATE CASCADE
ON DELETE CASCADE

GO

IF NOT EXISTS (SELECT 1 FROM sys.objects WHERE name = 'FK_DeviceUserParty_PartyRef')
ALTER TABLE [GNR].[DeviceUserParty] ADD CONSTRAINT [FK_DeviceUserParty_PartyRef] FOREIGN KEY([PartyRef])
REFERENCES [GNR].[Party] ([PartyId])

GO

IF NOT EXISTS (SELECT 1 FROM sys.objects WHERE name = 'FK_DeviceUserParty_UserRef')
ALTER TABLE [GNR].[DeviceUserParty] ADD CONSTRAINT [FK_DeviceUserParty_UserRef] FOREIGN KEY([UserRef])
REFERENCES [FMK].[User] ([UserId])

GO

--<< DROP OBJECTS >>--
