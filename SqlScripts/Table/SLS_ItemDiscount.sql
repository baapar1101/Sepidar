--<<FileName:SLS_ItemDiscount.sql>>--
--<< TABLE DEFINITION >>--

If Object_ID('SLS.ItemDiscount') Is Null
CREATE TABLE [SLS].[ItemDiscount](
	[ItemDiscountID] [int] NOT NULL,
	[DiscountRef] [int] NOT NULL,
	[ItemRef] [int] NOT NULL,
	[TracingRef] [INT] NULL
) ON [PRIMARY]

--TEXTIMAGE_ON [SGBlob_Data]
--When a table has text, ntext, image, varchar(max), nvarchar(max), varbinary(max), xml or large user defined type columns uncomment above code
GO
--<< ADD CLOLUMNS >>--

--<<Sample>>--
/*if not exists (select 1 from sys.columns where object_id=object_id('SLS.ItemDiscount') and
				[name] = 'ColumnName')
begin
    Alter table SLS.ItemDiscount Add ColumnName DataType Nullable
end
GO*/
--<< ALTER COLUMNS >>--
    
--<< PRIMARYKEY DEFINITION >>--

If not Exists (select 1 from sys.objects where name = 'PK_ItemDiscount')
ALTER TABLE [SLS].[ItemDiscount] ADD  CONSTRAINT [PK_ItemDiscount] PRIMARY KEY CLUSTERED 
(
	[ItemDiscountID] ASC
) ON [PRIMARY]
GO

--<< DEFAULTS CHECKS DEFINITION >>--

--<< RULES DEFINITION >>--

--<< INDEXES DEFINITION >>--
If not Exists (select 1 from sys.indexes where name = 'UIX_SLS_ItemDiscount_Item')
CREATE UNIQUE NONCLUSTERED INDEX [UIX_SLS_ItemDiscount_Item] ON [SLS].[ItemDiscount]
(
	DiscountRef,ItemRef, TracingRef
) ON [PRIMARY]
go
--<< FOREIGNKEYS DEFINITION >>--

If not Exists (select 1 from sys.objects where name = 'FK_ItemDiscount_Discount')
ALTER TABLE [SLS].[ItemDiscount]  ADD  CONSTRAINT [FK_ItemDiscount_Discount] FOREIGN KEY([DiscountRef])
REFERENCES [SLS].[Discount] ([DiscountId])
ON UPDATE CASCADE
ON DELETE CASCADE

GO
If not Exists (select 1 from sys.objects where name = 'FK_ItemDiscount_Item')
ALTER TABLE [SLS].[ItemDiscount]  ADD  CONSTRAINT [FK_ItemDiscount_Item] FOREIGN KEY([ItemRef])
REFERENCES [INV].[Item] ([ItemID])

GO

If not Exists (select 1 from sys.objects where name = 'FK_ItemDiscount_Tracing')
ALTER TABLE [SLS].[ItemDiscount]  ADD  CONSTRAINT [FK_ItemDiscount_Tracing] FOREIGN KEY([TracingRef])
REFERENCES [INV].[Tracing] ([TracingID])
GO

--<< DROP OBJECTS >>--
