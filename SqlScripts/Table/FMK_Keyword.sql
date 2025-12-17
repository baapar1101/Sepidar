--<<FileName:FMK_Keyword.sql>>--
--<< TABLE DEFINITION >>--

If Object_ID('FMK.Keyword') Is Null
CREATE TABLE [FMK].[Keyword](
	[KeywordID] [int] NOT NULL IDENTITY(1,1),
	[ActionKey] [nvarchar](250) NOT NULL,
) ON [PRIMARY]

--TEXTIMAGE_ON [SGBlob_Data]
--When a table has text, ntext, image, varchar(max), nvarchar(max), varbinary(max), xml or large user defined type columns uncomment above code
GO
--<< ADD CLOLUMNS >>--

--<<Sample>>--
/*if not exists (select 1 from sys.columns where object_id=object_id('FMK.Keyword') and
				[name] = 'ColumnName')
begin
    Alter table FMK.Keyword Add ColumnName DataType Nullable
end
GO*/

--<< ALTER COLUMNS >>--
/*if exists (select 1 from sys.columns where object_id=object_id('FMK.Keyword') and
				[name] = 'Title_En' and is_nullable = 0)
begin
    Alter table FMK.Keyword alter column [Title_En] [nvarchar](100) NULL -- compatibility issue!
end
GO*/

--<< PRIMARYKEY DEFINITION >>--

If not Exists (select 1 from sys.objects where name = 'PK_SG_Keyword')
ALTER TABLE [FMK].[Keyword] ADD  CONSTRAINT [PK_SG_Keyword] PRIMARY KEY CLUSTERED 
(
	[KeywordID] ASC
) ON [PRIMARY]
GO

--<< DEFAULTS CHECKS DEFINITION >>--

--<< RULES DEFINITION >>--

--<< INDEXES DEFINITION >>--

If not Exists (select 1 from sys.indexes where name = 'UIX_SG_Keyword')
CREATE UNIQUE NONCLUSTERED INDEX [UIX_SG_Keyword] ON [FMK].[Keyword] 
(
	[ActionKey] ASC
) ON [PRIMARY]

GO

--<< FOREIGNKEYS DEFINITION >>--


--<< DROP OBJECTS >>--
