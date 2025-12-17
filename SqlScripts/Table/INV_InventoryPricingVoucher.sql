--<<FileName:INV_InventoryPricingVoucher.sql>>--
--<< TABLE DEFINITION >>--

If Object_ID('INV.InventoryPricingVoucher') Is Null
CREATE TABLE [INV].[InventoryPricingVoucher](
	[InventoryPricingVoucherID] [int] NOT NULL,
	[InventoryPricingRef] [int] NOT NULL,
	[RowNumber] [int] NOT NULL,
	[InventoryVoucherType] [int] NOT NULL,
	[InventoryVoucherRef] [int] NOT NULL,
	[Number] [int] NOT NULL,
	[Date] [datetime] NOT NULL,
	[Version] [int] NOT NULL
) ON [PRIMARY]

--TEXTIMAGE_ON [SGBlob_Data]
--When a table has text, ntext, image, varchar(max), nvarchar(max), varbinary(max), xml or large user defined type columns uncomment above code
GO
--<< ADD CLOLUMNS >>--

--<<Sample>>--
/*if not exists (select 1 from sys.columns where object_id=object_id('INV.InventoryPricingVoucher') and
				[name] = 'ColumnName')
begin
    Alter table INV.InventoryPricingVoucher Add ColumnName DataType Nullable
end
GO*/

--<< ALTER COLUMNS >>--

--<< PRIMARYKEY DEFINITION >>--

If not Exists (select 1 from sys.objects where name = 'PK_InventoryPricingVoucher')
ALTER TABLE [INV].[InventoryPricingVoucher] ADD  CONSTRAINT [PK_InventoryPricingVoucher] PRIMARY KEY CLUSTERED 
(
	[InventoryPricingVoucherID] ASC
) ON [PRIMARY]
GO

--<< DEFAULTS CHECKS DEFINITION >>--

--<< RULES DEFINITION >>--

--<< INDEXES DEFINITION >>--
If not Exists (select 1 from sys.indexes where name = 'IX_InventoryPricingVoucher_VoucherType')
CREATE NONCLUSTERED INDEX [IX_InventoryPricingVoucher_VoucherType] ON [INV].[InventoryPricingVoucher] 
(
	[InventoryVoucherType] ASC,
	[InventoryVoucherRef] ASC
) ON [PRIMARY]

GO

--<< FOREIGNKEYS DEFINITION >>--

If not Exists (select 1 from sys.objects where name = 'FK_InventoryPricingVoucher_InventoryPricing')
ALTER TABLE [INV].[InventoryPricingVoucher]  ADD  CONSTRAINT [FK_InventoryPricingVoucher_InventoryPricing] FOREIGN KEY([InventoryPricingRef])
REFERENCES [INV].[InventoryPricing] ([InventoryPricingID])
ON DELETE CASCADE

GO

--<< DROP OBJECTS >>--
