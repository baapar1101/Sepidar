--<<FileName:FMK_IDGeneration.sql>>--
--<< TABLE DEFINITION >>--

If Object_ID('FMK.IDGeneration') Is Null
CREATE TABLE [FMK].[IDGeneration](
	[TableName] [nvarchar](100) NOT NULL,
	[LastId] [int] NOT NULL
) ON [PRIMARY]

--TEXTIMAGE_ON [SGBlob_Data]
--When a table has text, ntext, image, varchar(max), nvarchar(max), varbinary(max), xml or large user defined type columns uncomment above code
GO
--<< ADD CLOLUMNS >>--

--<<Sample>>--
/*if not exists (select 1 from sys.columns where object_id=object_id('FMK.IDGeneration') and
				[name] = 'ColumnName')
begin
    Alter table FMK.IDGeneration Add ColumnName DataType Nullable
end
GO*/

--<< ALTER COLUMNS >>--

--<< PRIMARYKEY DEFINITION >>--

If not Exists (select 1 from sys.objects where name = 'PK_IDGenerator')
ALTER TABLE [FMK].[IDGeneration] ADD  CONSTRAINT [PK_IDGenerator] PRIMARY KEY CLUSTERED 
(
	[TableName] ASC
) ON [PRIMARY]
GO

--<< DEFAULTS CHECKS DEFINITION >>--

--<< RULES DEFINITION >>--

--<< INDEXES DEFINITION >>--

--<< FOREIGNKEYS DEFINITION >>--


--<< DROP OBJECTS >>--
