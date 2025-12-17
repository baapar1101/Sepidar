--<<FileName:FMK_Note.sql>>--
--<< TABLE DEFINITION >>--

If Object_ID('FMK.Note') Is Null
CREATE TABLE [FMK].[Note](
	[NoteID] [int] NOT NULL,
	[EntityType] [varchar](1000) NOT NULL,
	[EntityRef] [int] NOT NULL,
	[Note] [nvarchar](max) NOT NULL,
	[Version] [int] NOT NULL,
	[Creator] [int] NOT NULL,
	[CreationDate] [datetime] NOT NULL,
	[LastModifier] [int] NOT NULL,
	[LastModificationDate] [datetime] NOT NULL
) ON [PRIMARY]

--TEXTIMAGE_ON [SGBlob_Data]
--When a table has text, ntext, image, varchar(max), nvarchar(max), varbinary(max), xml or large user defined type columns uncomment above code
GO
--<< ADD CLOLUMNS >>--

--<<Sample>>--
/*if not exists (select 1 from sys.columns where object_id=object_id('FMK.Note') and
				[name] = 'ColumnName')
begin
    Alter table FMK.Note Add ColumnName DataType Nullable
end
GO*/

--<< ALTER COLUMNS >>--

--<< PRIMARYKEY DEFINITION >>--

If not Exists (select 1 from sys.objects where name = 'PK_Note')
ALTER TABLE [FMK].[Note] ADD  CONSTRAINT [PK_Note] PRIMARY KEY CLUSTERED 
(
	[NoteID] ASC
) ON [PRIMARY]
GO

--<< DEFAULTS CHECKS DEFINITION >>--

--<< RULES DEFINITION >>--

--<< INDEXES DEFINITION >>--

--<< FOREIGNKEYS DEFINITION >>--


--<< DROP OBJECTS >>--
