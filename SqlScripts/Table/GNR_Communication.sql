--<<FileName:GNR_Communication.sql>>--
--<< TABLE DEFINITION >>--

If Object_ID('GNR.Communication') Is Null
CREATE TABLE [GNR].[Communication](
	[CommunicationId] INT NOT NULL,
	[System] INT NOT NULL,
	[Method] VARCHAR (100) NOT NULL,
	[RequestHttpMethod] NVARCHAR (10) NOT NULL,
	[RequestUrl] NVARCHAR (120) NOT NULL,
	[RequestBody] NVARCHAR (MAX) NULL,
	[SendingState] INT NOT NULL,
	[NumberOfAttempts] INT NOT NULL,
	[LastAttemptTime] DATETIME NULL,
	[UniqueId] NVARCHAR(250) NULL,
	[ResponseStatusCode] NVARCHAR (4) NULL,
	[ResponseRawText] NVARCHAR (MAX) NULL,
	[ErrorMessage] NVARCHAR (250) NULL,
	[Version] INT NOT NULL,
	[Creator] INT NOT NULL,
	[CreationDate] DATETIME NOT NULL,
	[LastModifier] INT NOT NULL,
	[LastModificationDate] DATETIME NOT NULL,
) ON [PRIMARY]

--TEXTIMAGE_ON [SGBlob_Data]
--When a table has text, ntext, image, varchar(max), nvarchar(max), varbinary(max), xml or large user defined type columns uncomment above code
GO
--<< ADD CLOLUMNS >>--
IF NOT EXISTS (SELECT 1 FROM sys.columns WHERE [object_id] = OBJECT_ID('GNR.Communication') AND [name] = 'RequestHttpMethod')
BEGIN
	ALTER TABLE [GNR].[Communication] ADD [RequestHttpMethod] NVARCHAR (10) NULL;
	EXEC [sys].[sp_executesql] N'UPDATE [GNR].[Communication] SET [RequestHttpMethod] = ''OldData'' WHERE [RequestHttpMethod] IS NULL';
	ALTER TABLE [GNR].[Communication] ALTER COLUMN [RequestHttpMethod] NVARCHAR (10) NOT NULL;
END
GO

IF NOT EXISTS (SELECT 1 FROM sys.columns WHERE [object_id] = OBJECT_ID('GNR.Communication') AND [name] = 'Method')
BEGIN
	ALTER TABLE [GNR].[Communication] ADD [Method] VARCHAR (100) NULL;
	EXEC [sys].[sp_executesql] N'UPDATE [GNR].[Communication] SET [Method] = ''OldData'' WHERE [Method] IS NULL';
	ALTER TABLE [GNR].[Communication] ALTER COLUMN [Method] VARCHAR (100) NOT NULL;
END
GO

IF NOT EXISTS (SELECT 1 FROM sys.columns WHERE [object_id] = OBJECT_ID('GNR.Communication') AND [name] = 'System')
BEGIN
	ALTER TABLE [GNR].[Communication] ADD [System] INT NULL;
	EXEC [sys].[sp_executesql] N'UPDATE [GNR].[Communication] SET [System] = 1 WHERE [System] IS NULL';
	ALTER TABLE [GNR].[Communication] ALTER COLUMN [System] INT NOT NULL;
END
GO

IF NOT EXISTS (SELECT 1 FROM sys.columns WHERE [object_id] = OBJECT_ID('GNR.Communication') AND [name] = 'ResponseStatusCode')
BEGIN
	ALTER TABLE [GNR].[Communication] ADD [ResponseStatusCode] NVARCHAR (4) NULL
END
GO

IF NOT EXISTS (SELECT 1 FROM sys.columns WHERE [object_id] = OBJECT_ID('GNR.Communication') AND [name] = 'NumberOfAttempts')
BEGIN
	ALTER TABLE [GNR].[Communication] ADD [NumberOfAttempts] INT NOT NULL DEFAULT(1)
END
GO

IF NOT EXISTS (SELECT 1 FROM sys.columns WHERE [object_id] = OBJECT_ID('GNR.Communication') AND [name] = 'ErrorMessage')
BEGIN
	ALTER TABLE [GNR].[Communication] ADD [ErrorMessage] NVARCHAR (250) NULL
END
GO
--<<Sample>>--
/*if not exists (select 1 from sys.columns where object_id=object_id('SLS.Invoice') and
				[name] = 'ColumnName')
begin
    Alter table SLS.Invoice Add ColumnName DataType Nullable
end
GO*/


--<< ALTER COLUMNS >>--
IF EXISTS (SELECT 1 FROM sys.columns WHERE [object_id] = OBJECT_ID('GNR.Communication') AND [name] = 'Content')
BEGIN
	EXEC sp_rename 'GNR.Communication.Content', 'RequestBody', 'COLUMN';
END
GO

IF EXISTS (SELECT 1 FROM sys.columns WHERE [object_id] = OBJECT_ID('GNR.Communication') AND [name] = 'RequestBody')
BEGIN
	ALTER TABLE [GNR].[Communication] ALTER COLUMN [RequestBody] NVARCHAR (MAX) NULL
END
GO

IF EXISTS (SELECT 1 FROM sys.columns WHERE [object_id] = OBJECT_ID('GNR.Communication') AND [name] = 'EndPoint')
BEGIN
	EXEC sp_rename 'GNR.Communication.EndPoint', 'RequestUrl', 'COLUMN';
END
GO

IF EXISTS (SELECT 1 FROM sys.columns WHERE [object_id] = OBJECT_ID('GNR.Communication') AND [name] = 'ObjectRef')
BEGIN
	EXEC sp_rename 'GNR.Communication.ObjectRef', 'UniqueId', 'COLUMN';
	ALTER TABLE [GNR].[Communication] ALTER COLUMN [UniqueId] NVARCHAR(250) NULL;
END
GO

IF EXISTS (SELECT 1 FROM sys.columns WHERE [object_id] = OBJECT_ID('GNR.Communication') AND [name] = 'Respond')
BEGIN
	EXEC sp_rename 'GNR.Communication.Respond', 'ResponseRawText', 'COLUMN';
END
GO
--<< PRIMARYKEY DEFINITION >>--

If not Exists (select 1 from sys.objects where name = 'PK_Communication')
ALTER TABLE [GNR].[Communication] ADD  CONSTRAINT [PK_Communication] PRIMARY KEY CLUSTERED 
(
	[CommunicationId] ASC
) ON [PRIMARY]
GO

--<< DEFAULTS CHECKS DEFINITION >>--

--<< RULES DEFINITION >>--

--<< INDEXES DEFINITION >>--

--<< FOREIGNKEYS DEFINITION >>--

--<< DROP OBJECTS >>--
IF EXISTS (SELECT 1 FROM sys.columns WHERE [object_id] = OBJECT_ID('GNR.Communication') AND [name] = 'TrackingCode')
BEGIN
	ALTER TABLE [GNR].[Communication] DROP COLUMN [TrackingCode]
END
GO

IF EXISTS (SELECT 1 FROM sys.columns WHERE [object_id] = OBJECT_ID('GNR.Communication') AND [name] = 'CommandType')
BEGIN
	ALTER TABLE [GNR].[Communication] DROP COLUMN [CommandType]
END
GO

IF EXISTS (SELECT 1 FROM sys.columns WHERE [object_id] = OBJECT_ID('GNR.Communication') AND [name] = 'EntityCode')
BEGIN
	ALTER TABLE [GNR].[Communication] DROP COLUMN [EntityCode]
END
GO

IF EXISTS (SELECT 1 FROM sys.columns WHERE [object_id] = OBJECT_ID('GNR.Communication') AND [name] = 'EntityName')
BEGIN
	ALTER TABLE [GNR].[Communication] DROP COLUMN [EntityName]
END
GO

IF EXISTS (SELECT 1 FROM sys.columns WHERE [object_id] = OBJECT_ID('GNR.Communication') AND [name] = 'IsAutomatic')
BEGIN
	ALTER TABLE [GNR].[Communication] DROP COLUMN [IsAutomatic]
END
GO
