--<<FileName:GNR_UserReport.sql>>--
--<< TABLE DEFINITION >>--

If Object_ID('FMK.UserReports') Is Null
CREATE TABLE FMK.UserReports(
	[UserReportsID] [int] NOT NULL,
	[Name] [nvarchar](255) NULL,
	[PersianTitle] [nvarchar](255) NULL,
	[EnglishTitle] [nvarchar](255) NULL,
	[ReportData] varbinary(MAX) NULL,
	[XMLData] varbinary(MAX) NULL,
	[ParentName] [nvarchar](255) NULL,
	[ReportMetaDataType] [int] NULL
) ON [PRIMARY]

--TEXTIMAGE_ON [SGBlob_Data]
--When a table has text, ntext, image, varchar(max), nvarchar(max), varbinary(max), xml or large user defined type columns uncomment above code
GO
--<< ADD CLOLUMNS >>--

--<<Sample>>--
--if not exists (select 1 from sys.columns where object_id=object_id('GNR.UserReport') and
--				[name] = 'PersianTitle')
--begin
--    Alter table GNR.UserReport Add PersianTitle [nvarchar](255) NULL
--end
--GO
--if not exists (select 1 from sys.columns where object_id=object_id('GNR.UserReport') and
--				[name] = 'EnglishTitle')
--begin
--    Alter table GNR.UserReport Add EnglishTitle [nvarchar](255) NULL
--end

IF NOT EXISTS (SELECT 1 FROM sys.columns WHERE object_id = OBJECT_ID(N'FMK.UserReports') AND [name] = 'ReportMetaDataType')
BEGIN
	ALTER TABLE FMK.UserReports add ReportMetaDataType int null
END

GO
--<< ALTER COLUMNS >>--
	IF EXISTS (SELECT
			1
		FROM sys.columns
		WHERE object_id = OBJECT_ID('FMK.UserReports')
		AND [Name] = 'DatasetName')
BEGIN
	ALTER TABLE FMK.UserReports
	DROP COLUMN DatasetName
END

IF EXISTS (SELECT
			1
		FROM sys.columns
		WHERE object_id = OBJECT_ID('FMK.UserReports')
		AND [Name] = 'SubSystemsKind')
BEGIN
	ALTER TABLE FMK.UserReports
	DROP COLUMN SubSystemsKind
END
--<< PRIMARYKEY DEFINITION >>--

If not Exists (select 1 from sys.objects where name = 'PK_UserReports')
ALTER TABLE FMK.UserReports ADD  CONSTRAINT [PK_UserReports] PRIMARY KEY CLUSTERED 
(
	[UserReportsID] ASC
) ON [PRIMARY]
GO

--<< DEFAULTS CHECKS DEFINITION >>--

--<< RULES DEFINITION >>--

--<< INDEXES DEFINITION >>--

--<< FOREIGNKEYS DEFINITION >>--


--<< DROP OBJECTS >>--
