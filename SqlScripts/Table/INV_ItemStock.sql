--<<FileName:INV_ItemStock.sql>>--
--<< TABLE DEFINITION >>--

If Object_ID('INV.ItemStock') Is Null
CREATE TABLE [INV].[ItemStock](
	[ItemStockID] [int] NOT NULL,
	[ItemRef] [int] NOT NULL,
	[StockRef] [int] NOT NULL,
	[Version] [int] NOT NULL
) ON [PRIMARY]

--TEXTIMAGE_ON [SGBlob_Data]
--When a table has text, ntext, image, varchar(max), nvarchar(max), varbinary(max), xml or large user defined type columns uncomment above code
GO
--<< ADD CLOLUMNS >>--

--<<Sample>>--
/*if not exists (select 1 from sys.columns where object_id=object_id('INV.ItemStock') and
				[name] = 'ColumnName')
begin
    Alter table INV.ItemStock Add ColumnName DataType Nullable
end
GO*/

--<< ALTER COLUMNS >>--

--<< PRIMARYKEY DEFINITION >>--

If not Exists (select 1 from sys.objects where name = 'PK_ItemStock')
ALTER TABLE [INV].[ItemStock] ADD  CONSTRAINT [PK_ItemStock] PRIMARY KEY CLUSTERED 
(
	[ItemStockID] ASC
) ON [PRIMARY]
GO

--<< DEFAULTS CHECKS DEFINITION >>--

--<< RULES DEFINITION >>--

--<< INDEXES DEFINITION >>--
If not Exists (select 1 from sys.indexes where name = 'IX_ItemStock_ItemRef')
CREATE  NONCLUSTERED INDEX [IX_ItemStock_ItemRef] ON [INV].[ItemStock]
(
	 [ItemRef] ASC
) ON [PRIMARY]

If not Exists (select 1 from sys.indexes where name = 'IX_ItemStock_StockRef')
CREATE  NONCLUSTERED INDEX [IX_ItemStock_StockRef] ON [INV].[ItemStock]
(
	 [StockRef] ASC
) ON [PRIMARY]

--<< FOREIGNKEYS DEFINITION >>--


If not Exists (select 1 from sys.objects where name = 'FK_ItemStock_Item')
ALTER TABLE [INV].[ItemStock]  ADD  CONSTRAINT [FK_ItemStock_Item] FOREIGN KEY([ItemRef])
REFERENCES [INV].[Item] ([ItemID])
ON DELETE CASCADE

GO

-- Delete the old relation, because it is "ON DELETE CASCADE"
IF EXISTS (select 1 from sys.objects where name = 'FK_ItemStock_Stock')
BEGIN
	ALTER TABLE [INV].[ItemStock] DROP CONSTRAINT [FK_ItemStock_Stock] 
END

GO
If not Exists (select 1 from sys.objects where name = 'FK_ItemStock_Stock')
ALTER TABLE [INV].[ItemStock]  ADD  CONSTRAINT [FK_ItemStock_Stock] FOREIGN KEY([StockRef])
REFERENCES [INV].[Stock] ([StockID])


GO

--<< DROP OBJECTS >>--
