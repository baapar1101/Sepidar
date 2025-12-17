--<<FileName:SLS_PriceNote.sql>>--
--<< TABLE DEFINITION >>--

If Object_ID('SLS.PriceNote') Is Null
CREATE TABLE [SLS].[PriceNote](
	[PriceNoteID] [int] NOT NULL,
	[Date] [datetime] NOT NULL,
	[Title] [nvarchar](50) NOT NULL,
	[Title_En] [nvarchar](50) NOT NULL,
	[Version] [int] NOT NULL,
	[Creator] [int] NULL,
	[CreationDate] [datetime] NULL,
	[LastModifier] [int] NULL,
	[LastModificationDate] [datetime] NULL
) ON [PRIMARY]

--TEXTIMAGE_ON [SGBlob_Data]
--When a table has text, ntext, image, varchar(max), nvarchar(max), varbinary(max), xml or large user defined type columns uncomment above code
GO
--<< ADD CLOLUMNS >>--

--<<Sample>>--
/*if not exists (select 1 from sys.columns where object_id=object_id('SLS.PriceNote') and
				[name] = 'ColumnName')
begin
    Alter table SLS.PriceNote Add ColumnName DataType Nullable
end
GO*/

--<< ALTER COLUMNS >>--

--<< PRIMARYKEY DEFINITION >>--

If not Exists (select 1 from sys.objects where name = 'PK_PriceNote')
ALTER TABLE [SLS].[PriceNote] ADD  CONSTRAINT [PK_PriceNote] PRIMARY KEY CLUSTERED 
(
	[PriceNoteID] ASC
) ON [PRIMARY]
GO

--<< DEFAULTS CHECKS DEFINITION >>--

--<< RULES DEFINITION >>--

--<< INDEXES DEFINITION >>--

--<< FOREIGNKEYS DEFINITION >>--


--<< DROP OBJECTS >>--
