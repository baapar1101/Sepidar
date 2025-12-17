--<<FileName:GNR_AutomaticAutomaticBackupConfigConfig.sql>>--
--<< TABLE DEFINITION >>--

If Object_ID('GNR.AutomaticBackupConfig') Is Null
CREATE TABLE [GNR].[AutomaticBackupConfig](
	[AutomaticBackupConfigID] [int] NOT NULL,
	[IsActive] [bit] NOT NULL,
	[BackupPath] [nvarchar](1500) NULL,
	[Filename] [nvarchar](200) NULL,
	[BackupPeriod] [int] NULL,
	[BackupFrequency] [int] NULL,	
	[BackupStartDateTime] [DateTime] NULL,	
	[LastBackupDate] [datetime]  NULL,		
	[IsPasswordProtected] [bit] NOT NULL,
	[Password] [nvarchar](50) NULL,
	[UploadToAbramad] [bit] NOT NULL default(0),
	[DeleteOldFiles] [bit] NOT NULL,
	[NumberOfFiles] int NOT NULL,
	[Version] [int] NOT NULL,
	[Creator] [int] NOT NULL,
	[CreationDate] [datetime] NOT NULL,
	[LastModifier] [int] NOT NULL,
	[LastModificationDate] [datetime] NOT NULL,
) ON [PRIMARY]

GO
--<< ADD CLOLUMNS >>--


--<< ALTER COLUMNS >>--

IF NOT EXISTS (SELECT 1 FROM sys.columns WHERE object_id=object_id('GNR.AutomaticBackupConfig') and
	[name]='UploadToAbramad')
BEGIN
	ALTER TABLE [GNR].[AutomaticBackupConfig] ADD [UploadToAbramad] [bit] not NULL default(0)
END
Go

--<< PRIMARYKEY DEFINITION >>--

If not Exists (select 1 from sys.objects where name = 'PK_AutomaticBackupConfig')
ALTER TABLE [GNR].[AutomaticBackupConfig] ADD  CONSTRAINT [PK_AutomaticBackupConfig] PRIMARY KEY CLUSTERED 
(
	[AutomaticBackupConfigID] ASC
) ON [PRIMARY]
GO

--<< DEFAULTS CHECKS DEFINITION >>--

--<< RULES DEFINITION >>--

--<< INDEXES DEFINITION >>--

--<< FOREIGNKEYS DEFINITION >>--


--<< DROP OBJECTS >>--
