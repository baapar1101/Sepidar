--<<FileName:FMK_KeywordLocale.sql>>--
--<< TABLE DEFINITION >>--

If Object_ID('FMK.KeywordLocale') Is Null
CREATE TABLE [FMK].[KeywordLocale](
	[KeywordRef] [int] NOT NULL,
	[LocaleName] [nvarchar] (150) NOT NULL,
	[Value] [nvarchar](500) NOT NULL
) ON [PRIMARY]

--TEXTIMAGE_ON [SGBlob_Data]
--When a table has text, ntext, image, varchar(max), nvarchar(max), varbinary(max), xml or large user defined type columns uncomment above code
GO
--<< ADD CLOLUMNS >>--

--<<Sample>>--
/*if not exists (select 1 from sys.columns where object_id=object_id('FMK.KeywordLocale') and
				[name] = 'ColumnName')
begin
    Alter table FMK.KeywordLocale Add ColumnName DataType Nullable
end
GO*/

--<< ALTER COLUMNS >>--

--<< PRIMARYKEY DEFINITION >>--

If not Exists (select 1 from sys.objects where name = 'PK_SG_KeywordLocale')
ALTER TABLE [FMK].[KeywordLocale] ADD  CONSTRAINT [PK_SG_KeywordLocale] PRIMARY KEY CLUSTERED 
(
	[KeywordRef] ASC,
	[LocaleName] ASC
) ON [PRIMARY]
GO

--<< DEFAULTS CHECKS DEFINITION >>--

--<< RULES DEFINITION >>--

--<< INDEXES DEFINITION >>--

--<< FOREIGNKEYS DEFINITION >>--

IF NOT EXISTS (SELECT 1 FROM sys.objects WHERE Name='FK_KeywordLocale_Keyword')
ALTER TABLE FMK.KeywordLocale ADD CONSTRAINT
	FK_KeywordLocale_Keyword FOREIGN KEY ( KeywordRef )
	REFERENCES [FMK].[Keyword] ( [KeywordID] )
ON DELETE CASCADE
GO

--<< DROP OBJECTS >>--
