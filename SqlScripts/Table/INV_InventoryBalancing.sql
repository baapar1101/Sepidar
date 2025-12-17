--<<FileName:INV_InventoryBalancing.sql>>--
--<< TABLE DEFINITION >>--


If Object_ID('INV.InventoryBalancing') Is Null
CREATE TABLE [INV].[InventoryBalancing](
	[InventoryBalancingId] [int] NOT NULL,
	[Number] [int] NOT NULL,
	[State] [int] NOT NULL,
	[StockRef] [int] NOT NULL,
	[OperatorDLRef] [int] NOT NULL,
	[RedundancySLRef] [int] NULL,
	[RedundancyDLRef] [int] NULL,
	[ShortageSLRef] [int] NULL,
	[ShortageDLRef] [int] NULL,
	[Date] [DateTime] NOT NULL,
	[FiscalYearRef] [int]  NOT NULL,
	[Description] NVARCHAR(255) NULL,
	[Description_En] NVARCHAR(255) NULL,
	[InventoryReceiptRef] [int] NULL,
	[InventoryDeliveryRef] [int] NULL,
	[ItemMinQuantity] [decimal](19, 4) NOT NULL,
	[Version] [int] NOT NULL,
	[Creator] [int] NOT NULL,
	[CreationDate] [datetime] NOT NULL,
	[LastModifier] [int] NOT NULL,
	[LastModificationDate] [datetime] NOT NULL,
) ON [PRIMARY]

--TEXTIMAGE_ON [SGBlob_Data]
--When a table has text, ntext, image, varchar(max), nvarchar(max), varbinary(max), xml or large user defined type columns uncomment above code
GO
--<< ADD CLOLUMNS >>--

--<<Sample>>--
/*if not exists (select 1 from sys.columns where object_id=object_id('INV.InventoryBalancing') and
				[name] = 'ColumnName')
begin
    Alter table INV.InventoryBalancing Add ColumnName DataType Nullable
end
GO*/


--<< ALTER COLUMNS >>--

--<< PRIMARYKEY DEFINITION >>--

If not Exists (select 1 from sys.objects where name = 'PK_InventoryBalancing')
ALTER TABLE [INV].[InventoryBalancing] ADD  CONSTRAINT [PK_InventoryBalancing] PRIMARY KEY CLUSTERED 
(
	[InventoryBalancingId] ASC
) ON [PRIMARY]
GO

--<< DEFAULTS CHECKS DEFINITION >>--

--<< RULES DEFINITION >>--

--<< INDEXES DEFINITION >>--

--<< FOREIGNKEYS DEFINITION >>--


If not Exists (select 1 from sys.objects where name = 'FK_InventoryBalancing_Stock')
ALTER TABLE [INV].[InventoryBalancing]  ADD  CONSTRAINT [FK_InventoryBalancing_Stock] FOREIGN KEY([StockRef])
REFERENCES [INV].[Stock] ([StockId])

GO

If not Exists (select 1 from sys.objects where name = 'FK_InventoryBalancing_OperatorDL')
ALTER TABLE [INV].[InventoryBalancing]  ADD  CONSTRAINT [FK_InventoryBalancing_OperatorDL] FOREIGN KEY([OperatorDLRef])
REFERENCES [ACC].[DL] ([DLId])

GO

If not Exists (select 1 from sys.objects where name = 'FK_InventoryBalancing_RedundancySL')
ALTER TABLE [INV].[InventoryBalancing]  ADD  CONSTRAINT [FK_InventoryBalancing_RedundancySL] FOREIGN KEY([RedundancySLRef])
REFERENCES [ACC].[Account] ([AccountId])

GO

If not Exists (select 1 from sys.objects where name = 'FK_InventoryBalancing_RedundancyDL')
ALTER TABLE [INV].[InventoryBalancing]  ADD  CONSTRAINT [FK_InventoryBalancing_RedundancyDL] FOREIGN KEY([RedundancyDLRef])
REFERENCES [ACC].[DL] ([DLId])

GO

If not Exists (select 1 from sys.objects where name = 'FK_InventoryBalancing_ShortageSL')
ALTER TABLE [INV].[InventoryBalancing]  ADD  CONSTRAINT [FK_InventoryBalancing_ShortageSL] FOREIGN KEY([ShortageSLRef])
REFERENCES [ACC].[Account] ([AccountId])

GO

If not Exists (select 1 from sys.objects where name = 'FK_InventoryBalancing_ShortageDL')
ALTER TABLE [INV].[InventoryBalancing]  ADD  CONSTRAINT [FK_InventoryBalancing_ShortageDL] FOREIGN KEY([ShortageDLRef])
REFERENCES [ACC].[DL] ([DLId])

GO

If not Exists (select 1 from sys.objects where name = 'FK_InventoryBalancing_FiscalYear')
ALTER TABLE [INV].[InventoryBalancing]  ADD  CONSTRAINT [FK_InventoryBalancing_FiscalYear] FOREIGN KEY([FiscalYearRef])
REFERENCES [FMK].[FiscalYear] ([FiscalYearId])

GO

If not Exists (select 1 from sys.objects where name = 'FK_InventoryBalancing_InventoryReceipt')
ALTER TABLE [INV].[InventoryBalancing]  ADD  CONSTRAINT [FK_InventoryBalancing_InventoryReceipt] FOREIGN KEY([InventoryReceiptRef])
REFERENCES [INV].[InventoryReceipt] ([InventoryReceiptId])

GO

If not Exists (select 1 from sys.objects where name = 'FK_InventoryBalancing_InventoryDelivery')
ALTER TABLE [INV].[InventoryBalancing]  ADD  CONSTRAINT [FK_InventoryBalancing_InventoryDelivery] FOREIGN KEY([InventoryDeliveryRef])
REFERENCES [INV].[InventoryDelivery] ([InventoryDeliveryId])

GO

--<< DROP OBJECTS >>--