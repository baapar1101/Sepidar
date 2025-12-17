--<<FileName:SLS_PriceNoteItemDiscountItemDiscount.sql>>--
--<< TABLE DEFINITION >>--

If Object_ID('SLS.PriceNoteItemDiscount') Is Null
CREATE TABLE [SLS].[PriceNoteItemDiscount](
	[PriceNoteItemDiscountID] [int] NOT NULL,
	[PriceNoteItemRef] [int] NOT NULL,
	[StartDate] [DateTime] NOT NULL,
	[EndDate] [DateTime] NULL,
	[DiscountRef] [int] NOT NULL,
	[Converted] [int] NULL
) ON [PRIMARY]

--TEXTIMAGE_ON [SGBlob_Data]
--When a table has text, ntext, image, varchar(max), nvarchar(max), varbinary(max), xml or large user defined type columns uncomment above code
GO
--<< ADD CLOLUMNS >>--

--<<Sample>>--
/*if not exists (select 1 from sys.columns where object_id=object_id('SLS.PriceNoteItemDiscount') and
				[name] = 'ColumnName')
begin
    Alter table SLS.PriceNoteItemDiscount Add ColumnName DataType Nullable
end
GO*/
if not exists (select 1 from sys.columns where object_id=object_id('SLS.PriceNoteItemDiscount') and
				[name] = 'Converted')
begin
    Alter table SLS.PriceNoteItemDiscount Add Converted INT NULL
end
GO
--<< ALTER COLUMNS >>--

--<< PRIMARYKEY DEFINITION >>--

If not Exists (select 1 from sys.objects where name = 'PK_PriceNoteItemDiscount')
ALTER TABLE [SLS].[PriceNoteItemDiscount] ADD  CONSTRAINT [PK_PriceNoteItemDiscount] PRIMARY KEY CLUSTERED 
(
	[PriceNoteItemDiscountID] ASC
) ON [PRIMARY]
GO

--<< DEFAULTS CHECKS DEFINITION >>--

--<< RULES DEFINITION >>--

--<< INDEXES DEFINITION >>--

--<< FOREIGNKEYS DEFINITION >>--
If not Exists (select 1 from sys.objects where name = 'FK_PriceNoteItemDiscount_PriceNoteItem')
ALTER TABLE [SLS].[PriceNoteItemDiscount]  ADD  CONSTRAINT [FK_PriceNoteItemDiscount_PriceNoteItem] FOREIGN KEY([PriceNoteItemRef])
REFERENCES [SLS].[PriceNoteItem] ([PriceNoteItemID])
ON UPDATE CASCADE
ON DELETE CASCADE
GO

If  Exists (select 1 from sys.objects where name = 'FK_PriceNoteItemDiscount_Discount')
ALTER TABLE [SLS].[PriceNoteItemDiscount]  DROP CONSTRAINT [FK_PriceNoteItemDiscount_Discount]
GO

--<< DROP OBJECTS >>--
