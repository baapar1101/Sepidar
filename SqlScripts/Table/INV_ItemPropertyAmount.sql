--<<FileName:INV_ItemPropertyAmount.sql>>--
--<< TABLE DEFINITION >>--

If Object_ID('INV.ItemPropertyAmount') Is Null
CREATE TABLE [INV].[ItemPropertyAmount](
	[ItemPropertyAmountID]  [int]             NOT NULL,
	[ItemRef]               [int]             NOT NULL,
	[PropertyAmount1]       [nvarchar](120)       NULL,
	[PropertyAmount2]       [nvarchar](120)       NULL,
	[PropertyAmount3]       [nvarchar](120)       NULL,
	[PropertyAmount4]       [nvarchar](120)       NULL,
	[PropertyAmount5]       [nvarchar](120)       NULL,
	[PropertyAmount6]       [nvarchar](120)       NULL,
	[PropertyAmount7]       [nvarchar](120)       NULL,
	[PropertyAmount8]       [nvarchar](120)       NULL,
	[PropertyAmount9]       [nvarchar](120)       NULL,
	[PropertyAmount10]      [nvarchar](120)       NULL,
) ON [PRIMARY]
GO
--TEXTIMAGE_ON [SGBlob_Data]
--When a table has text, ntext, image, varchar(max), nvarchar(max), varbinary(max), xml or large user defined type columns uncomment above code

--<< ADD CLOLUMNS >>--


--<<Sample>>--
/*if not exists (select 1 from sys.columns where object_id=object_id('INV.ItemPropertyAmount') and
				[name] = 'ColumnName')
begin
    Alter table INV.ItemPropertyAmount Add ColumnName DataType Nullable
end
GO*/

--<< ALTER COLUMNS >>--

--<< PRIMARYKEY DEFINITION >>--

IF NOT EXISTS (SELECT 1 FROM sys.objects WHERE name = 'PK_ItemPropertyAmount')
ALTER TABLE [INV].[ItemPropertyAmount] ADD  CONSTRAINT [PK_ItemPropertyAmount] PRIMARY KEY CLUSTERED 
(
	[ItemPropertyAmountID] ASC
) ON [PRIMARY]
GO

--<< DEFAULTS CHECKS DEFINITION >>--

--<< RULES DEFINITION >>--

--<< INDEXES DEFINITION >>--

--If not Exists (select 1 from sys.indexes where name = 'IX_ColumnName')
--CREATE NONCLUSTERED INDEX [IX_ColumnName] ON [INV].[ItemPropertyAmount] 
--(
--	[ColumnName] ASC
--) ON [PRIMARY]

--GO

IF NOT EXISTS (SELECT 1 FROM sys.indexes WHERE name = 'IX_ItemPropertyAmount_ItemRef')
CREATE NONCLUSTERED INDEX [IX_ItemPropertyAmount_ItemRef] ON [INV].[ItemPropertyAmount]
(
  [ItemRef] ASC
) ON [PRIMARY]

--<< FOREIGNKEYS DEFINITION >>--
IF NOT EXISTS (SELECT 1 FROM sys.objects WHERE NAME = 'FK_ItemPropertyAmount_ItemRef')
	ALTER TABLE [INV].[ItemPropertyAmount]  ADD  CONSTRAINT [FK_ItemPropertyAmount_ItemRef] FOREIGN KEY([ItemRef])
	REFERENCES [INV].[Item] ([ItemID])
	ON DELETE CASCADE
GO

--<< DROP OBJECTS >>--
