--<<FileName:FMK_Version.sql>>--
--<< TABLE DEFINITION >>--

If Object_ID('FMK.Version') Is Null
CREATE TABLE [FMK].[Version](
	[VersionID] [int] NOT NULL,
	[Major] [int] NOT NULL,
	[Minor] [int] NOT NULL,
	[Build] [int] NOT NULL,
	[Revision] [int] NOT NULL,
	[CreationDate] [datetime] NOT NULL,
	[LastModificationDate] [datetime] NOT NULL,
	[Version] [int] NOT NULL
) ON [PRIMARY]

--TEXTIMAGE_ON [SGBlob_Data]
--When a table has text, ntext, image, varchar(max), nvarchar(max), varbinary(max), xml or large user defined type columns uncomment above code
GO
--<< ADD CLOLUMNS >>--

--<<Sample>>--
/*if not exists (select 1 from sys.columns where object_id=object_id('FMK.Version') and
				[name] = 'ColumnName')
begin
    Alter table FMK.Version Add ColumnName DataType Nullable
end
GO*/

--<< ALTER COLUMNS >>--

--<< PRIMARYKEY DEFINITION >>--

If not Exists (select 1 from sys.objects where name = 'PK_Version')
ALTER TABLE [FMK].[Version] ADD  CONSTRAINT [PK_Version] PRIMARY KEY CLUSTERED 
(
	[VersionID] ASC
) ON [PRIMARY]
GO

--<< DEFAULTS CHECKS DEFINITION >>--

--<< RULES DEFINITION >>--

--<< INDEXES DEFINITION >>--

--<< FOREIGNKEYS DEFINITION >>--


--<< DROP OBJECTS >>--
