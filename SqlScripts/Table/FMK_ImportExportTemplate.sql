--<<FileName:GNR_UserReport.sql>>--
--<< TABLE DEFINITION >>--

If Object_ID('FMK.ImportExportTemplate') Is Null
CREATE TABLE FMK.ImportExportTemplate(
	[ImportExportTemplateID] [int] NOT NULL,
	[PersianTitle] [nvarchar](255) NULL,
	[EnglishTitle] [nvarchar](255) NULL,
	[Template] [varbinary](max) NULL,
	[GUID] [uniqueidentifier] NOT NULL,
	[Type] [nvarchar](max) NULL
) ON [PRIMARY]

--TEXTIMAGE_ON [SGBlob_Data]
--When a table has text, ntext, image, varchar(max), nvarchar(max), varbinary(max), xml or large user defined type columns uncomment above code
GO
--<< ADD CLOLUMNS >>--

if not exists (select 1 from sys.columns where object_id=object_id('FMK.ImportExportTemplate') and
				[name] = 'IsImport')
begin
	ALTER TABLE FMK.ImportExportTemplate ADD
		IsImport bit NULL
end
--GO
--if not exists (select 1 from sys.columns where object_id=object_id('GNR.UserReport') and
--				[name] = 'EnglishTitle')
--begin
--    Alter table GNR.UserReport Add EnglishTitle [nvarchar](255) NULL
--end
GO

--<< ALTER COLUMNS >>--

--<< PRIMARYKEY DEFINITION >>--

If not Exists (select 1 from sys.objects where name = 'PK_ImportExportTemplate')
ALTER TABLE FMK.ImportExportTemplate ADD  CONSTRAINT [PK_ImportExportTemplate] PRIMARY KEY CLUSTERED 
(
	[ImportExportTemplateID] ASC
) ON [PRIMARY]
GO

--<< DEFAULTS CHECKS DEFINITION >>--

--<< RULES DEFINITION >>--

--<< INDEXES DEFINITION >>--

--<< FOREIGNKEYS DEFINITION >>--


--<< DROP OBJECTS >>--