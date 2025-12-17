--<<FileName:INV_InventoryPricingVoucherItem.sql>>--
--<< TABLE DEFINITION >>--

If Object_ID('INV.InventoryPricingVoucherItem') Is Null
CREATE TABLE [INV].[InventoryPricingVoucherItem](
	[InventoryPricingVoucherItemID] [int] NOT NULL,
	[InventoryPricingVoucherRef] [int] NOT NULL,
	[InventoryVoucherItemRef] [int] NOT NULL,
	[Version] [int] NOT NULL
) ON [PRIMARY]

--TEXTIMAGE_ON [SGBlob_Data]
--When a table has text, ntext, image, varchar(max), nvarchar(max), varbinary(max), xml or large user defined type columns uncomment above code
GO
--<< ADD CLOLUMNS >>--

--<<Sample>>--
/*if not exists (select 1 from sys.columns where object_id=object_id('INV.InventoryPricingVoucherItem') and
				[name] = 'ColumnName')
begin
    Alter table INV.InventoryPricingVoucherItem Add ColumnName DataType Nullable
end
GO*/

--<< ALTER COLUMNS >>--

--<< PRIMARYKEY DEFINITION >>--

If not Exists (select 1 from sys.objects where name = 'PK_InventoryPricingVoucherItem')
ALTER TABLE [INV].[InventoryPricingVoucherItem] ADD  CONSTRAINT [PK_InventoryPricingVoucherItem] PRIMARY KEY CLUSTERED 
(
	[InventoryPricingVoucherItemID] ASC
) ON [PRIMARY]
GO

--<< DEFAULTS CHECKS DEFINITION >>--

--<< RULES DEFINITION >>--

--<< INDEXES DEFINITION >>--

--<< FOREIGNKEYS DEFINITION >>--

If not Exists (select 1 from sys.objects where name = 'FK_InventoryPricingVoucherItem_InventoryPricingVoucher')
ALTER TABLE [INV].[InventoryPricingVoucherItem]  ADD  CONSTRAINT [FK_InventoryPricingVoucherItem_InventoryPricingVoucher] FOREIGN KEY([InventoryPricingVoucherRef])
REFERENCES [INV].[InventoryPricingVoucher] ([InventoryPricingVoucherID])
ON DELETE CASCADE

GO

--<< DROP OBJECTS >>--
