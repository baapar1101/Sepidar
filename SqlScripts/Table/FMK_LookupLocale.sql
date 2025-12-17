--<<FileName:FMK_LookupLocale.sql>>--
--<< TABLE DEFINITION >>--

If Object_ID('FMK.LookupLocale') Is Null
CREATE TABLE [FMK].[LookupLocale](
	[LookupRef] [int] NOT NULL,
	[LocaleName] [nvarchar] (150) NOT NULL,
	[Title] [nvarchar](100) NOT NULL
) ON [PRIMARY]

--TEXTIMAGE_ON [SGBlob_Data]
--When a table has text, ntext, image, varchar(max), nvarchar(max), varbinary(max), xml or large user defined type columns uncomment above code
GO
--<< ADD CLOLUMNS >>--

--<<Sample>>--
/*if not exists (select 1 from sys.columns where object_id=object_id('FMK.LookupLocale') and
				[name] = 'ColumnName')
begin
    Alter table FMK.LookupLocale Add ColumnName DataType Nullable
end
GO*/

--<< ALTER COLUMNS >>--

--<< PRIMARYKEY DEFINITION >>--

If not Exists (select 1 from sys.objects where name = 'PK_SG_LookupLocale')
ALTER TABLE [FMK].[LookupLocale] ADD  CONSTRAINT [PK_SG_LookupLocale] PRIMARY KEY CLUSTERED 
(
	[LookupRef] ASC,
	[LocaleName] ASC
) ON [PRIMARY]
GO

--<< DEFAULTS CHECKS DEFINITION >>--

--<< RULES DEFINITION >>--

--<< INDEXES DEFINITION >>--

--<< FOREIGNKEYS DEFINITION >>--

IF NOT EXISTS (SELECT 1 FROM sys.objects WHERE Name='FK_LookupLocale_Lookup')
ALTER TABLE FMK.LookupLocale ADD CONSTRAINT
	FK_LookupLocale_Lookup FOREIGN KEY ( LookupRef )
	REFERENCES [FMK].[Lookup] ( [LookupID] )
ON DELETE CASCADE
GO

--<< DROP OBJECTS >>--
