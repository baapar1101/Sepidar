--<<FileName:GNR_Backup.sql>>--
--<< TABLE DEFINITION >>--

If Object_ID('GNR.Backup') Is Null
CREATE TABLE [GNR].[Backup](
	[BackupID] [int] NOT NULL,
	[Label] [nvarchar](500) NOT NULL,
	[Date] [datetime] NOT NULL,
	[Path] [nvarchar](1500) NULL,
	[RestoreDate] [datetime] NULL,
	[Version] [int] NOT NULL,
	[Creator] [int] NOT NULL,
	[CreationDate] [datetime] NOT NULL,
	[LastModifier] [int] NOT NULL,
	[LastModificationDate] [datetime] NOT NULL,
	[Filename] [nvarchar](200) NOT NULL,
	[ServerName] [nvarchar](50) NULL,
	[IsOk] [bit] NOT NULL,
	[IsAutomatic] [bit]  NULL,
	[IsPasswordProtected] [bit] NOT NULL,
	[Password] [nvarchar](50) NULL
) ON [PRIMARY]

--TEXTIMAGE_ON [SGBlob_Data]
--When a table has text, ntext, image, varchar(max), nvarchar(max), varbinary(max), xml or large user defined type columns uncomment above code
GO
--<< ADD CLOLUMNS >>--

if not exists (select 1 from sys.columns where object_id=object_id('GNR.Backup') and
				[name] = 'IsAutomatic')
begin
    Alter table [GNR].[Backup] Add [IsAutomatic] [bit]  NULL
end
GO

if not exists (select 1 from sys.columns where object_id=object_id('GNR.Backup') and
				[name] = 'ServerName')
begin
    Alter table GNR.[Backup] Add [ServerName] [nvarchar](50) NULL
end
GO

if not exists (select 1 from sys.columns where object_id=object_id('GNR.Backup') and
				[name] = 'IsPasswordProtected')
begin
    Alter table GNR.[Backup] Add [IsPasswordProtected] [bit] NOT NULL default(0)
end
GO

if not exists (select 1 from sys.columns where object_id=object_id('GNR.Backup') and
				[name] = 'Password')
begin
    Alter table GNR.[Backup] Add Password [nvarchar](50) NULL
end
GO

if not exists (select 1 from sys.columns where object_id=object_id('GNR.Backup') and
				[name] = 'IsCompressed')
begin
    Alter table [GNR].[Backup] Add [IsCompressed] [bit]  NULL
end
GO

--<< ALTER COLUMNS >>--

--<< PRIMARYKEY DEFINITION >>--

If not Exists (select 1 from sys.objects where name = 'PK_Backup')
ALTER TABLE [GNR].[Backup] ADD  CONSTRAINT [PK_Backup] PRIMARY KEY CLUSTERED 
(
	[BackupID] ASC
) ON [PRIMARY]
GO

--<< DEFAULTS CHECKS DEFINITION >>--

--<< RULES DEFINITION >>--

--<< INDEXES DEFINITION >>--

--<< FOREIGNKEYS DEFINITION >>--


--<< DROP OBJECTS >>--
