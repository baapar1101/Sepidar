--<<FileName:SLS_PriceNoteItem.sql>>--
--<< TABLE DEFINITION >>--

If Object_ID('SLS.PriceNoteItem') Is Null
CREATE TABLE [SLS].[PriceNoteItem](
	[PriceNoteItemID] [int] NOT NULL,
	[PriceNoteRef] [int] NOT NULL,
	[SaleTypeRef] [int] NOT NULL,
	[ItemRef] [int] NOT NULL,
	[UnitRef] [int] NOT NULL,
	[Fee] [decimal](19, 4) NOT NULL,
	[CurrencyRef] [int] NULL,
	[Discount] [decimal](5, 2) NULL,
	[CanChangeInvoiceFee] bit  NOT NULL,
	[CanChangeInvoiceDiscount] bit NOT NULL,
	[AdditionRate] [decimal](5, 2) NOT NULL,
	[TracingRef] [int] NULL,
	[CustomerGroupingRef] [int] NULL,
	[LowerMargin] [decimal](19,4) NULL,
	[UpperMargin] [decimal](19,4) NULL
) ON [PRIMARY]

--TEXTIMAGE_ON [SGBlob_Data]
--When a table has text, ntext, image, varchar(max), nvarchar(max), varbinary(max), xml or large user defined type columns uncomment above code
GO
--<< ADD CLOLUMNS >>--

--<<Sample>>--
/*if not exists (select 1 from sys.columns where object_id=object_id('SLS.PriceNoteItem') and
				[name] = 'ColumnName')
begin
    Alter table SLS.PriceNoteItem Add ColumnName DataType Nullable
end
GO*/
if not exists (select 1 from sys.columns where object_id=object_id('SLS.PriceNoteItem') and
				[name] = 'CanChangeInvoiceFee')
begin
	Alter table SLS.PriceNoteItem Add CanChangeInvoiceFee bit
end
GO
if exists (select 1 from sys.columns where object_id=object_id('SLS.PriceNoteItem') and
                        [name] = 'CanChangeInvoiceFee' and Is_Nullable = 1)
begin
	Update SLS.PriceNoteItem  set CanChangeInvoiceFee  = 1
    Alter table SLS.PriceNoteItem Alter Column CanChangeInvoiceFee bit not null
end
GO
if not exists (select 1 from sys.columns where object_id=object_id('SLS.PriceNoteItem') and
				[name] = 'CanChangeInvoiceDiscount')
begin
    Alter table SLS.PriceNoteItem Add CanChangeInvoiceDiscount bit
end
GO
if exists (select 1 from sys.columns where object_id=object_id('SLS.PriceNoteItem') and
                        [name] = 'CanChangeInvoiceDiscount' and Is_Nullable = 1)
begin
	Update SLS.PriceNoteItem  set CanChangeInvoiceDiscount = 1
    Alter table SLS.PriceNoteItem Alter Column CanChangeInvoiceDiscount bit not null
end
GO
if not exists (select 1 from sys.columns where object_id=object_id('SLS.PriceNoteItem') and
				[name] = 'AdditionRate')
begin
    Alter table SLS.PriceNoteItem Add AdditionRate [decimal](5, 2) null
end
GO
if exists (select 1 from sys.columns where object_id=object_id('SLS.PriceNoteItem') and
                        [name] = 'AdditionRate' and Is_Nullable = 1)
begin
	Update SLS.PriceNoteItem  set AdditionRate  = 0
    Alter table SLS.PriceNoteItem Alter Column AdditionRate [decimal](5, 2) not null
end
if not exists (select 1 from sys.columns where object_id=object_id('SLS.PriceNoteItem') and
				[name] = 'TracingRef')
begin
    Alter table SLS.PriceNoteItem Add TracingRef int null
end
GO
if not exists (select 1 from sys.columns where object_id=object_id('SLS.PriceNoteItem') and
				[name] = 'CustomerGroupingRef')
begin
    Alter table SLS.PriceNoteItem Add CustomerGroupingRef int null
end
GO
if not exists (select 1 from sys.columns where object_id=object_id('SLS.PriceNoteItem') and
				[name] = 'LowerMargin')
begin
    Alter table SLS.PriceNoteItem Add LowerMargin decimal(19,4) null
end
else if exists (
				SELECT *
				FROM Sys.columns C
					JOIN sys.tables T ON c.object_id = T.object_id 
				WHERE c.name = 'LowerMargin' AND T.name = 'PriceNoteItem' AND C.is_nullable = 0
				)
begin
	Alter table SLS.PriceNoteItem Alter column LowerMargin decimal(19,4) null
end

GO
if not exists (select 1 from sys.columns where object_id=object_id('SLS.PriceNoteItem') and
				[name] = 'UpperMargin')
begin
    Alter table SLS.PriceNoteItem Add UpperMargin decimal(19,4) null
end
else if exists (
				select *
				from Sys.columns C
					JOIN sys.tables T ON c.object_id = T.object_id 
				where c.name = 'UpperMargin' AND T.name = 'PriceNoteItem' AND C.is_nullable = 0
				)
begin
	Alter table SLS.PriceNoteItem Alter column UpperMargin decimal(19,4) null
end

GO
--<< ALTER COLUMNS >>--
    
--<< PRIMARYKEY DEFINITION >>--

If not Exists (select 1 from sys.objects where name = 'PK_PriceNoteItem')
ALTER TABLE [SLS].[PriceNoteItem] ADD  CONSTRAINT [PK_PriceNoteItem] PRIMARY KEY CLUSTERED 
(
	[PriceNoteItemID] ASC
) ON [PRIMARY]
GO

--<< DEFAULTS CHECKS DEFINITION >>--

--<< RULES DEFINITION >>--

--<< INDEXES DEFINITION >>--

If Exists (select 1 from sys.indexes where name = 'UIX_SLS_SaleTypeItem_ItemRef_CurrencyRef_UnitRef_SaleTypeRef')
DROP INDEX UIX_SLS_SaleTypeItem_ItemRef_CurrencyRef_UnitRef_SaleTypeRef ON SLS.PriceNoteItem

If not Exists (select 1 from sys.indexes where name = 'UIX_SLS_SaleTypeItem_ItemRef_CurrencyRef_UnitRef_SaleTypeRef_TracingRef_CustomerGroupingRef')
CREATE UNIQUE NONCLUSTERED INDEX [UIX_SLS_SaleTypeItem_ItemRef_CurrencyRef_UnitRef_SaleTypeRef_TracingRef_CustomerGroupingRef] ON [SLS].[PriceNoteItem] 
(
	[ItemRef] ASC,
	[CurrencyRef] ASC,
	[UnitRef] ASC,
	[SaleTypeRef] ASC,
	[TracingRef] ASC,
	[CustomerGroupingRef] ASC
) ON [PRIMARY]

GO
--<< FOREIGNKEYS DEFINITION >>--

If not Exists (select 1 from sys.objects where name = 'FK_PriceNoteItem_CurrencyRef')
ALTER TABLE [SLS].[PriceNoteItem]  ADD  CONSTRAINT [FK_PriceNoteItem_CurrencyRef] FOREIGN KEY([CurrencyRef])
REFERENCES [GNR].[Currency] ([CurrencyID])

GO
if Exists 
	(select * from sys.Foreign_Keys
		where name = 'FK_PriceNoteItem_ItemRef'
		and delete_Referential_action = 0)
alter table sls.PriceNoteItem drop constraint  FK_PriceNoteItem_ItemRef
GO 
If not Exists (select 1 from sys.objects where name = 'FK_PriceNoteItem_ItemRef')
ALTER TABLE [SLS].[PriceNoteItem]  ADD  CONSTRAINT [FK_PriceNoteItem_ItemRef] FOREIGN KEY([ItemRef])
REFERENCES [INV].[Item] ([ItemID])
ON DELETE CASCADE

GO
If not Exists (select 1 from sys.objects where name = 'FK_PriceNoteItem_PriceNoteRef')
ALTER TABLE [SLS].[PriceNoteItem]  ADD  CONSTRAINT [FK_PriceNoteItem_PriceNoteRef] FOREIGN KEY([PriceNoteRef])
REFERENCES [SLS].[PriceNote] ([PriceNoteID])
ON UPDATE CASCADE
ON DELETE CASCADE

GO
If not Exists (select 1 from sys.objects where name = 'FK_PriceNoteItem_SaleTypeRef')
ALTER TABLE [SLS].[PriceNoteItem]  ADD  CONSTRAINT [FK_PriceNoteItem_SaleTypeRef] FOREIGN KEY([SaleTypeRef])
REFERENCES [SLS].[SaleType] ([SaleTypeId])

GO
If not Exists (select 1 from sys.objects where name = 'FK_PriceNoteItem_UnitRef')
ALTER TABLE [SLS].[PriceNoteItem]  ADD  CONSTRAINT [FK_PriceNoteItem_UnitRef] FOREIGN KEY([UnitRef])
REFERENCES [INV].[Unit] ([UnitID])

GO
If not Exists (select 1 from sys.objects where name = 'FK_PriceNoteItem_TracingRef')
ALTER TABLE [SLS].[PriceNoteItem]  ADD  CONSTRAINT [FK_PriceNoteItem_TracingRef] FOREIGN KEY([TracingRef])
REFERENCES [INV].[Tracing] ([TracingID])

GO

If not Exists (select 1 from sys.objects where name = 'FK_PriceNoteItem_CustomerGroupingRef')
ALTER TABLE [SLS].[PriceNoteItem]  ADD  CONSTRAINT [FK_PriceNoteItem_CustomerGroupingRef] FOREIGN KEY([CustomerGroupingRef])
REFERENCES [GNR].[Grouping] ([GroupingID])

GO

--<< DROP OBJECTS >>--
