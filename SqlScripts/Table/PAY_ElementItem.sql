--<<FileName:PAY_ElementItem.sql>>--
--<< TABLE DEFINITION >>--

If Object_ID('PAY.ElementItem') Is Null
CREATE TABLE [PAY].[ElementItem](
	[ElementItemId] [int] NOT NULL,
	[ElementRef] [int] NOT NULL,
	[RelatedElementRef] [int] NOT NULL,
	[Coefficient] [decimal](19, 4) NULL,
	[Type] [int] NOT NULL
) ON [PRIMARY]

--TEXTIMAGE_ON [SGBlob_Data]
--When a table has text, ntext, image, varchar(max), nvarchar(max), varbinary(max), xml or large user defined type columns uncomment above code
GO
--<< ADD CLOLUMNS >>--

--<<Sample>>--
/*if not exists (select 1 from sys.columns where object_id=object_id('PAY.ElementItem') and
				[name] = 'ColumnName')
begin
    Alter table PAY.ElementItem Add ColumnName DataType Nullable
end
GO*/

--<< ALTER COLUMNS >>--

--<< PRIMARYKEY DEFINITION >>--

If not Exists (select 1 from sys.objects where name = 'PK_ElementItem')
ALTER TABLE [PAY].[ElementItem] ADD  CONSTRAINT [PK_ElementItem] PRIMARY KEY CLUSTERED 
(
	[ElementItemId] ASC
) ON [PRIMARY]
GO

--<< DEFAULTS CHECKS DEFINITION >>--

--<< RULES DEFINITION >>--

--<< INDEXES DEFINITION >>--

--<< FOREIGNKEYS DEFINITION >>--

If not Exists (select 1 from sys.objects where name = 'FK_ElementItem_ElementRef')
ALTER TABLE [PAY].[ElementItem]  ADD  CONSTRAINT [FK_ElementItem_ElementRef] FOREIGN KEY([ElementRef])
REFERENCES [PAY].[Element] ([ElementId])
ON DELETE CASCADE

GO
If not Exists (select 1 from sys.objects where name = 'FK_ElementItem_RelatedElementRef')
ALTER TABLE [PAY].[ElementItem]  ADD  CONSTRAINT [FK_ElementItem_RelatedElementRef] FOREIGN KEY([RelatedElementRef])
REFERENCES [PAY].[Element] ([ElementId])

GO

--<< DROP OBJECTS >>--
