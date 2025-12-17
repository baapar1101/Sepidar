--<<FileName:FMK_ApiLog.sql>>--

--<< TABLE DEFINITION >>--
IF Object_ID('FMK.ApiLog') IS NULL
CREATE TABLE [FMK].[ApiLog](
	[ApiLogID]				[INT]				NOT NULL,

	[RequestTime]			[DATETIME]			NOT NULL,
	[RequestUrl]			[nvarchar](250)		NOT NULL,
	[RequestUserHostAddress][nvarchar](250)		NOT NULL,
	[RequestHeaders]		[nvarchar](max)		NOT NULL,
	[RequestMethod]			[nvarchar](10)		NOT NULL,
	
	[RequestBody]	 		[nvarchar](max)		NULL,
	[Guid]					[nvarchar](36)		NULL,
	[UserRef]				[INT]				NULL,
	[UserName] 				[nvarchar](200) 	NULL,
	[UserName_En] 			[nvarchar](200) 	NULL,
	[UserUserName] 			[nvarchar](200) 	NULL,
	[DeviceRef]				[INT]				NULL,
	[DeviceTitle]			[NVARCHAR](250)		NULL,
	[DeviceTitle_En]		[NVARCHAR](250)		NULL,
	[DeviceCode]			[INT]				NULL,
	
	[OriginalResource]		[nvarchar](max)		NULL,

	[ResponseTime]			[DATETIME]			NULL,
	[ResponseRawText]		[nvarchar](max)		NULL,
	[ResponseStatusCode]	[INT]				NULL,

) ON [PRIMARY]

--TEXTIMAGE_ON [SGBlob_Data]
--When a table has text, ntext, image, varchar(max), nvarchar(max), varbinary(max), xml or large user defined type columns uncomment above code
GO
--<< ADD CLOLUMNS >>--
IF NOT EXISTS (SELECT 1 FROM [sys].[columns] WHERE [object_id]=OBJECT_ID('FMK.ApiLog') AND [name] = 'UserName')
ALTER TABLE [FMK].[ApiLog] ADD [UserName] [NVARCHAR](200) NULL
GO

IF NOT EXISTS (SELECT 1 FROM [sys].[columns] WHERE [object_id]=OBJECT_ID('FMK.ApiLog') AND [name] = 'UserName_En')
ALTER TABLE [FMK].[ApiLog] ADD [UserName_En] [NVARCHAR](200) NULL
GO

IF NOT EXISTS (SELECT 1 FROM [sys].[columns] WHERE [object_id]=OBJECT_ID('FMK.ApiLog') AND [name] = 'UserUserName')
ALTER TABLE [FMK].[ApiLog] ADD [UserUserName] [NVARCHAR](200) NULL
GO

IF NOT EXISTS (SELECT 1 FROM [sys].[columns] WHERE [object_id]=OBJECT_ID('FMK.ApiLog') AND [name] = 'DeviceTitle')
ALTER TABLE [FMK].[ApiLog] ADD [DeviceTitle] [NVARCHAR](250) NULL
GO

IF NOT EXISTS (SELECT 1 FROM [sys].[columns] WHERE [object_id]=OBJECT_ID('FMK.ApiLog') AND [name] = 'DeviceTitle_En')
ALTER TABLE [FMK].[ApiLog] ADD [DeviceTitle_En] [NVARCHAR](250) NULL
GO

IF NOT EXISTS (SELECT 1 FROM [sys].[columns] WHERE [object_id]=OBJECT_ID('FMK.ApiLog') AND [name] = 'DeviceCode')
ALTER TABLE [FMK].[ApiLog] ADD [DeviceCode] [INT] NULL
GO

--<<Sample>>--
/*if not exists (select 1 from sys.columns where object_id=object_id('DST.AreaAndPath') and
				[name] = 'ColumnName')
begin
    Alter table DST.AreaAndPath Add ColumnName DataType Nullable
end
GO*/

--<< ALTER COLUMNS >>--

--<< PRIMARYKEY DEFINITION >>--
IF NOT EXISTS (SELECT 1 FROM sys.objects WHERE NAME = 'PK_ApiLog')
ALTER TABLE [FMK].[ApiLog] ADD CONSTRAINT [PK_ApiLog] PRIMARY KEY CLUSTERED 
(
	[ApiLogID] ASC
) ON [PRIMARY]
GO

--<< DEFAULTS CHECKS DEFINITION >>--

--<< RULES DEFINITION >>--

--<< INDEXES DEFINITION >>--
IF EXISTS (SELECT 1 FROM sys.indexes WHERE name = 'UIX_ApiLog_Guid')
DROP INDEX [UIX_ApiLog_Guid] ON [FMK].[ApiLog]

GO

--<< FOREIGNKEYS DEFINITION >>--
IF EXISTS (SELECT 1 FROM sys.objects WHERE NAME = 'FK_ApiLog_UserRef')
ALTER TABLE [FMK].[ApiLog] DROP CONSTRAINT [FK_ApiLog_UserRef]

GO

IF EXISTS (SELECT 1 FROM sys.objects WHERE NAME = 'FK_ApiLog_DeviceRef')
ALTER TABLE [FMK].[ApiLog] DROP CONSTRAINT [FK_ApiLog_DeviceRef]

GO


--<< DROP OBJECTS >>--
