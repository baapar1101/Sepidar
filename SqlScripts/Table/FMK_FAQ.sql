--<<FileName:FMK_FAQ.sql>>--
--<< TABLE DEFINITION >>--

If Object_ID('FMK.FAQ') Is Null
CREATE TABLE [FMK].[FAQ](
	[FAQID] [int] NOT NULL,
	[ClubFAQRef] [int] NOT NULL,
	[ClubVersion] [int] NOT NULL,
	[Question] [nvarchar](max) NOT NULL,
	[Answer] [nvarchar](max) NOT NULL,
	[Location] [nvarchar](250) NOT NULL,
	[Key] [nvarchar](250) NOT NULL,
	[Version] [int] NOT NULL
) ON [PRIMARY]

--TEXTIMAGE_ON [SGBlob_Data]
--When a table has text, ntext, image, varchar(max), nvarchar(max), varbinary(max), xml or large user defined type columns uncomment above code
GO
--<< ADD CLOLUMNS >>--

--<<Sample>>--
/*if not exists (select 1 from sys.columns where object_id=object_id('FMK.FAQ') and
				[name] = 'ColumnName')
begin
    Alter table FMK.FAQ Add ColumnName DataType Nullable
end
GO*/

--<< ALTER COLUMNS >>--

--<< PRIMARYKEY DEFINITION >>--

If not Exists (select 1 from sys.objects where name = 'PK_FAQ')
ALTER TABLE [FMK].[FAQ] ADD  CONSTRAINT [PK_FAQ] PRIMARY KEY CLUSTERED 
(
	[FAQID] ASC
) ON [PRIMARY]
GO

--<< DEFAULTS CHECKS DEFINITION >>--

--<< RULES DEFINITION >>--

--<< INDEXES DEFINITION >>--

--<< FOREIGNKEYS DEFINITION >>--


--<< DROP OBJECTS >>--
