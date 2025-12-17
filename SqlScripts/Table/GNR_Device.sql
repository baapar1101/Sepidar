--<<FileName:GNR_Device.sql>>--

--<< TABLE DEFINITION >>--
IF Object_ID('GNR.Device') IS NULL
CREATE TABLE [GNR].[Device](
	[DeviceId]				[INT]					NOT NULL,
	[DeviceType]			[INT]					NOT NULL,
	[Title]					[NVARCHAR](250)			NOT NULL,
	[Title_En]				[NVARCHAR](250)			NOT NULL,
	[Code]					[INT]					NOT NULL,
	[Key]					[NVARCHAR](1000)		NULL,
	[TempKey]	 			[INT]					NULL,
	[IntegrationId]			[INT]IDENTITY(1000, 1)	NOT NULL,
	[IsRegistered]			[BIT]					NOT NULL,
	[IsActive]				[BIT]					NOT NULL,
	[Version]				[INT]					NOT NULL,
	[Creator]				[INT]					NOT NULL,
	[CreationDate]			[DATETIME]				NOT NULL,
	[LastModifier]			[INT]					NOT NULL,
	[LastModificationDate]	[DATETIME]				NOT NULL,
) ON [PRIMARY]

--TEXTIMAGE_ON [SGBlob_Data]
--When a table has text, ntext, image, varchar(max), nvarchar(max), varbinary(max), xml or large user defined type columns uncomment above code
GO
--<< ADD CLOLUMNS >>--

if not exists (select 1 from sys.columns where object_id=object_id('GNR.Device') and
				[name] = 'DeviceType')
BEGIN
    ALTER TABLE GNR.Device ADD DeviceType [INT] NOT NULL DEFAULT 0 -- 0: Distribution Mobile
END
GO

IF NOT EXISTS (SELECT 1 FROM SYS.COLUMNS WHERE OBJECT_ID = OBJECT_ID('GNR.Device') AND
				[NAME] = 'IsRegistered')
BEGIN
    ALTER TABLE GNR.[Device] ADD [IsRegistered] [BIT] NOT NULL DEFAULT 0
END
GO

IF NOT EXISTS (SELECT 1 FROM sys.columns WHERE [object_id] = OBJECT_ID('GNR.Device') AND
				[name] = 'IntegrationId')
BEGIN
	ALTER TABLE GNR.[Device] ADD [IntegrationId] [INT]IDENTITY(1000, 1)	NOT NULL
END
GO

--<< ALTER COLUMNS >>--
IF  EXISTS(SELECT 1 FROM SYS.COLUMNS WHERE OBJECT_ID = OBJECT_ID('GNR.Device') AND [NAME] = 'OneTimeKey')
BEGIN
    EXEC sp_rename 'GNR.Device.OneTimeKey', 'TempKey', 'COLUMN';
END
GO

IF EXISTS (SELECT 1 FROM sys.columns WHERE [object_id] = OBJECT_ID('GNR.Device') AND [name] = 'TempKey')
BEGIN
	ALTER TABLE GNR.[Device] ALTER COLUMN [TempKey] [INT] NULL
END
GO

IF EXISTS (SELECT 1 FROM sys.columns WHERE [object_id] = OBJECT_ID('GNR.Device') AND [name] = 'Key')
BEGIN
	ALTER TABLE GNR.[Device] ALTER COLUMN [Key] [NVARCHAR](1000) NULL
END
GO

--<< PRIMARYKEY DEFINITION >>--
IF NOT EXISTS (SELECT 1 FROM sys.objects WHERE NAME = 'PK_Device')
ALTER TABLE [GNR].[Device] ADD  CONSTRAINT [PK_Device] PRIMARY KEY CLUSTERED 
(
	[DeviceId] ASC
) ON [PRIMARY]
GO

--<< DEFAULTS CHECKS DEFINITION >>--

--<< RULES DEFINITION >>--

--<< INDEXES DEFINITION >>--
IF NOT EXISTS (SELECT 1 FROM sys.indexes WHERE name = 'UIX_Device_Code')
CREATE UNIQUE NONCLUSTERED INDEX [UIX_Device_Code] ON [GNR].[Device]
(
	[Code] ASC
) ON [PRIMARY]
GO

IF NOT EXISTS (SELECT 1 FROM sys.indexes WHERE name = 'UIX_Device_IntegrationId')
CREATE UNIQUE NONCLUSTERED INDEX [UIX_Device_IntegrationId] ON [GNR].[Device]
(
	[IntegrationId] ASC
) ON [PRIMARY]
GO

--<< FOREIGNKEYS DEFINITION >>--

--<< DROP OBJECTS >>--
