--<<FileName:INV_ItemImage.sql>>--
--<< TABLE DEFINITION >>--

If Object_ID('INV.ItemImage') Is Null
CREATE TABLE [INV].[ItemImage](
	[ItemImageID] [int] NOT NULL,
	[ItemRef] [int] NOT NULL,
	[Image] [varbinary](max) NULL,
	[Thumbnail] [varbinary](max) NULL,
	[Version] [int] NOT NULL
) ON [PRIMARY]

--TEXTIMAGE_ON [SGBlob_Data]
--When a table has text, ntext, image, varchar(max), nvarchar(max), varbinary(max), xml or large user defined type columns uncomment above code
GO
--<< ADD CLOLUMNS >>--

--<<Sample>>--
/*if not exists (select 1 from sys.columns where object_id=object_id('INV.ItemImage') and
				[name] = 'ColumnName')
begin
    Alter table INV.ItemImage Add ColumnName DataType Nullable
end
GO*/

if not exists (select 1 from sys.columns where object_id=object_id('INV.ItemImage') and
				[name] = 'Thumbnail')
begin
    Alter table INV.ItemImage Add [Thumbnail] [varbinary](max) NULL
end
GO

--<< ALTER COLUMNS >>--

--<< PRIMARYKEY DEFINITION >>--

If not Exists (select 1 from sys.objects where name = 'PK_ItemImage')
ALTER TABLE [INV].[ItemImage] ADD  CONSTRAINT [PK_ItemImage] PRIMARY KEY CLUSTERED 
(
	[ItemImageID] ASC
) ON [PRIMARY]
GO

--<< DEFAULTS CHECKS DEFINITION >>--

--<< RULES DEFINITION >>--

--<< INDEXES DEFINITION >>--

--<< FOREIGNKEYS DEFINITION >>--

If not Exists (select 1 from sys.objects where name = 'FK_ItemImage_Item')
ALTER TABLE [INV].[ItemImage]  ADD  CONSTRAINT [FK_ItemImage_Item] FOREIGN KEY([ItemRef])
REFERENCES [INV].[Item] ([ItemID])
ON DELETE CASCADE

GO

--<< DROP OBJECTS >>--
