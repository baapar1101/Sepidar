--<<FileName:INV_CustomsClearanceItem.sql>>--  
--<< TABLE DEFINITION >>--
If Object_ID('POM.CustomsClearanceItem') Is Null
CREATE  TABLE [POM].[CustomsClearanceItem](
	[CustomsClearanceItemID] [int] NOT NULL,		
	[CustomsClearanceRef] [int] NOT NULL,		
	[RowNumber] [int] NOT NULL,
	[PurchaseInvoiceItemRef] [int] NOT NULL,		

	[CurrencyRef] [int] not null,
	[Currencyrate] [Decimal](19,4) not null,

	[Quantity] [decimal](19, 4) NOT NULL,
	[SecondaryQuantity] [decimal](19, 4) NULL,

	[Amount]   [Decimal](19,4) not null,
	[AmountInBaseCurrency]   [Decimal](19,4) not null,
	[PurchaseInvoiceItemNetPrice] [Decimal](19,4) not null,
	[PurchaseInvoiceItemNetPriceInBaseCurrency] [Decimal](19,4) not null,

	[CustomsCost]  [Decimal](19,4) not null,
	[Tax]  [Decimal](19,4) not null,
	[Duty]  [Decimal](19,4) not null,

	
	
) ON [PRIMARY]


--<< ADD CLOLUMNS >>--
--<<Sample>>--
/*if not exists (select 1 from sys.columns where object_id=object_id('POM.CustomsClearanceItem') and
				[name] = 'ColumnName')
begin
    Alter table POM.CustomsClearanceItem Add ColumnName DataType Nullable
end
GO*/
if not exists (select 1 from sys.columns where object_id=object_id('POM.CustomsClearanceItem') and
				[name] = 'RowNumber')
begin
    Alter table POM.CustomsClearanceItem Add [RowNumber] [int]  NULL
end
Go

if not exists (select 1 from sys.columns where object_id=object_id('POM.CustomsClearanceItem') and
				[name] = 'PurchaseInvoiceItemNetPrice')
begin
    Alter table POM.CustomsClearanceItem Add [PurchaseInvoiceItemNetPrice] [Decimal](19,4) null
end
Go

if not exists (select 1 from sys.columns where object_id=object_id('POM.CustomsClearanceItem') and
				[name] = 'PurchaseInvoiceItemNetPriceInBaseCurrency')
begin
    Alter table POM.CustomsClearanceItem Add [PurchaseInvoiceItemNetPriceInBaseCurrency] [Decimal](19,4) null
end
Go

--<< ALTER COLUMNS >>--

--<< PRIMARYKEY DEFINITION >>--

IF NOT EXISTS (SELECT 1 FROM sys.objects WHERE NAME = 'PK_CustomsClearanceItem')
BEGIN
ALTER TABLE [POM].[CustomsClearanceItem] ADD CONSTRAINT [PK_CustomsClearanceItem] PRIMARY KEY CLUSTERED 
(
	[CustomsClearanceItemID] ASC
) ON [PRIMARY]
END
GO

--<< DEFAULTS CHECKS DEFINITION >>--


--<< RULES DEFINITION >>--

--<< INDEXES DEFINITION >>--
--<< FOREIGNKEYS DEFINITION >>--

If  Exists (select 1 from sys.objects where name = 'FK_CustomsClearanceItem_CustomsClearance')
ALTER TABLE [POM].[CustomsClearanceItem]  drop CONSTRAINT [FK_CustomsClearanceItem_CustomsClearance]

GO

If not Exists (select 1 from sys.objects where name = 'FK_CustomsClearanceItem_CustomsClearanceRef')
ALTER TABLE [POM].[CustomsClearanceItem]  WITH CHECK ADD  CONSTRAINT [FK_CustomsClearanceItem_CustomsClearanceRef] FOREIGN KEY([CustomsClearanceRef])
REFERENCES [POM].[CustomsClearance] ([CustomsClearanceID])
 ON UPDATE  NO ACTION 
	 ON DELETE  CASCADE 
GO



If not Exists (select 1 from sys.objects where name = 'FK_CustomsClearanceItem_PurchaseInvoiceItemRef')
ALTER TABLE [POM].[CustomsClearanceItem]  WITH CHECK ADD  CONSTRAINT [FK_CustomsClearanceItem_PurchaseInvoiceItemRef] FOREIGN KEY([PurchaseInvoiceItemRef])
REFERENCES [POM].[PurchaseInvoiceItem] ([PurchaseInvoiceItemID])
GO

