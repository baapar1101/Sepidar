--<<FileName:FMK_Configuration.sql>>--
--<< TABLE DEFINITION >>--

If Object_ID('FMK.Configuration') Is Null
CREATE TABLE [FMK].[Configuration](
	[ConfigurationID] [int] NOT NULL,
	[Key] [nchar](50) NOT NULL,
	[Value] [nvarchar](max) NULL,
	[Version] [int] NOT NULL
) ON [PRIMARY]

--TEXTIMAGE_ON [SGBlob_Data]
--When a table has text, ntext, image, varchar(max), nvarchar(max), varbinary(max), xml or large user defined type columns uncomment above code
GO
--<< ADD CLOLUMNS >>--

--<<Sample>>--
/*if not exists (select 1 from sys.columns where object_id=object_id('FMK.Configuration') and
				[name] = 'ColumnName')
begin
    Alter table FMK.Configuration Add ColumnName DataType Nullable
end
GO*/

--<< ALTER COLUMNS >>--

--<< PRIMARYKEY DEFINITION >>--

If not Exists (select 1 from sys.objects where name = 'PK_Configuration')
ALTER TABLE [FMK].[Configuration] ADD  CONSTRAINT [PK_Configuration] PRIMARY KEY CLUSTERED 
(
	[ConfigurationID] ASC
) ON [PRIMARY]
GO

--<< DEFAULTS CHECKS DEFINITION >>--

--<< RULES DEFINITION >>--

--<< INDEXES DEFINITION >>--

--<< FOREIGNKEYS DEFINITION >>--


--<< DROP OBJECTS >>--
