--<<FileName:INV_PerformaItem.sql >>--
--<< TABLE DEFINITION >>--
-- drop TABLE [POM].[PerformaItem]
If Object_ID('POM.PerformaItem') Is Null
CREATE TABLE [POM].[PerformaItem](
	[PerformaItemID] [int] NOT NULL,
	[PerformaRef] [int] NOT NULL,
	[PurchaseRequestItemRef] [int] NULL,
	[RowNumber] [int] NOT NULL,
	[ItemRef] [int] NOT NULL,
	[TracingRef] [int] NULL,
	[Quantity] [decimal](19, 4) NOT NULL,
	[SecondaryQuantity] [decimal](19, 4) NULL,
	[Fee] [decimal](19,4) NOT NULL,
	[FeeInBaseCurrency] [decimal](19, 4) NULL,
	[Price] [decimal](19, 4) NOT NULL,
	[PriceInBaseCurrency] [decimal](19,4) NULL,
	[Discount] [decimal](19, 4) NULL,
	[DiscountInBaseCurrency] [decimal](19,4) NULL,
	[Addition] [decimal](19, 4) NULL,
	[AdditionInBaseCurrency] [decimal](19,4)NULL,
	[DeliveryDate] [DateTime] null,

	[Tax] [decimal](19, 4) NULL,
	[TaxInBaseCurrency] [decimal](19,4) NULL,

	[Duty] [decimal](19, 4) NULL,
	[DutyInBaseCurrency] [decimal](19,4) NULL,

	[InsuranceAmount] [decimal](19, 4) NULL,
	[InsuranceAmountInBaseCurrency] [decimal](19,4)NULL,

	[NetPrice]   [decimal](19,4) null ,
	[NetPriceInBaseCurrency] [decimal](19, 4) NULL,
	[Description] [nvarchar](500) NULL	
) ON [PRIMARY]

GO
--<< ADD CLOLUMNS >>--
if not exists (select 1 from sys.columns where object_id=object_id('POM.PerformaItem') and
				[name] = 'PurchaseRequestItemRef')
begin
    Alter table POM.PerformaItem Add [PurchaseRequestItemRef] INT NULL
end
GO

if not exists (select 1 from sys.columns where object_id=object_id('POM.PerformaItem') and
				[name] = 'Tax')
begin
    Alter table POM.PerformaItem Add [Tax] [decimal](19, 4) NULL DEFAULT(0)
end
GO

if not exists (select 1 from sys.columns where object_id=object_id('POM.PerformaItem') and
				[name] = 'TaxInBaseCurrency')
begin
    Alter table POM.PerformaItem Add [TaxInBaseCurrency] [decimal](19, 4) NULL DEFAULT(0)
end
GO
if not exists (select 1 from sys.columns where object_id=object_id('POM.PerformaItem') and
				[name] = 'Duty')
begin
    Alter table POM.PerformaItem Add [Duty] [decimal](19, 4) NULL DEFAULT(0)
end
GO

if not exists (select 1 from sys.columns where object_id=object_id('POM.PerformaItem') and
				[name] = 'DutyInBaseCurrency')
begin
    Alter table POM.PerformaItem Add [DutyInBaseCurrency] [decimal](19, 4) NULL DEFAULT(0)
end
GO

if not exists (select 1 from sys.columns where object_id=object_id('POM.PerformaItem') and
				[name] = 'InsuranceAmount')
begin
    Alter table POM.PerformaItem Add [InsuranceAmount] [decimal](19, 4) NULL DEFAULT(0)
end
GO

if not exists (select 1 from sys.columns where object_id=object_id('POM.PerformaItem') and
				[name] = 'InsuranceAmountInBaseCurrency')
begin
    Alter table POM.PerformaItem Add [InsuranceAmountInBaseCurrency] [decimal](19, 4) NULL DEFAULT(0)
end
GO

if not exists (select 1 from sys.columns where object_id=object_id('POM.PerformaItem') and
				[name] = 'DeliveryDate')
begin
    Alter table POM.PerformaItem Add [DeliveryDate] [datetime] NULL
end
GO


--<< ALTER COLUMNS >>--


--<< PRIMARYKEY DEFINITION >>--

IF NOT EXISTS (SELECT 1 FROM sys.objects WHERE NAME = 'PK_PerformaItem')
ALTER TABLE [POM].[PerformaItem] ADD CONSTRAINT [PK_PerformaItem] PRIMARY KEY CLUSTERED 
(
	[PerformaItemID] ASC
) ON [PRIMARY]

GO

--<< DEFAULTS CHECKS DEFINITION >>--
--<< RULES DEFINITION >>--

--<< INDEXES DEFINITION >>--
IF NOT EXISTS (SELECT 1 FROM sys.indexes WHERE name = 'IX_PerformaItem_ItemRef')
CREATE NONCLUSTERED INDEX [IX_PerformaItem_ItemRef]
ON [POM].[PerformaItem] ([ItemRef])
GO
IF NOT EXISTS (SELECT 1 FROM sys.indexes WHERE name = 'IX_PerformaItem_PurchaseRequestItemRef')
CREATE NONCLUSTERED INDEX [IX_PerformaItem_PurchaseRequestItemRef]
ON [POM].[PerformaItem] ([PurchaseRequestItemRef])
GO
--<< FOREIGNKEYS DEFINITION >>--

If not Exists (select 1 from sys.objects where name = 'FK_PerformaItem_Performa')
ALTER TABLE POM.PerformaItem ADD CONSTRAINT FK_PerformaItem_Performa FOREIGN KEY
	( PerformaRef ) REFERENCES POM.Performa ( PerformaID )
	 ON UPDATE  NO ACTION 
	 ON DELETE  CASCADE 
GO

If not Exists (select 1 from sys.objects where name = 'FK_PerformaItem_Item')
ALTER TABLE [POM].[PerformaItem]  WITH CHECK ADD  CONSTRAINT [FK_PerformaItem_Item] FOREIGN KEY([ItemRef])
REFERENCES [INV].[Item] ([ItemID])
GO

IF NOT EXISTS (SELECT 1 FROM sys.objects where name = 'FK_PerformaItem_TracingRef')
ALTER TABLE [POM].[PerformaItem]  ADD  CONSTRAINT [FK_PerformaItem_TracingRef] FOREIGN KEY([TracingRef])
REFERENCES [INV].[Tracing] ([TracingID])
GO

If not Exists (select 1 from sys.objects where name = 'FK_PerformaItem_PurchaseRequestItemRef')
ALTER TABLE [POM].[PerformaItem]  WITH CHECK ADD  CONSTRAINT [FK_PerformaItem_PurchaseRequestItemRef] FOREIGN KEY([PurchaseRequestItemRef])
REFERENCES [POM].[PurchaseRequestItem] ([PurchaseRequestItemID])
GO