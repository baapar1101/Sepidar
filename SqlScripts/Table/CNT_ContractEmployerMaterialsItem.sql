--<<FileName:CNT_ContractEmployerMaterialsItem.sql>>--
--<< TABLE DEFINITION >>--

If Object_ID('CNT.ContractEmployerMaterialsItem') Is Null
CREATE TABLE [CNT].[ContractEmployerMaterialsItem](
	[EmployerMaterialsID] [int] NOT NULL,
	[ContractRef] [int] NOT NULL,
	[RowNumber] [int] NOT NULL,
	[Date] [datetime] NOT NULL,
	[StockRef] [int] NULL,
	[ItemRef] [int] NOT NULL,
	[Quantity] [decimal](19,4) NOT NULL,
	[SecondaryQuantity] [decimal](19, 4) NULL,
	[Fee] [decimal](19,4) NOT NULL,
	[ReceiptRef] [int] NULL,
	[ReceiptNumber] [int] NULL,	
	[InventoryDeliveryRef] [int] NULL,
	[Description] [nvarchar](250) NULL,
	[Description_En] [nvarchar](250) NULL,
	[TracingRef] [int] NULL
) ON [PRIMARY]

--TEXTIMAGE_ON [SGBlob_Data]
--When a table has text, ntext, image, varchar(max), nvarchar(max), varbinary(max), xml or large user defined type columns uncomment above code
GO
--<< ADD CLOLUMNS >>--

--<<Sample>>--
/*if not exists (select 1 from sys.columns where object_id=object_id('CNT.ContractEmployerMaterialsItem') and
				[name] = 'ColumnName')
begin
    Alter table CNT.ContractEmployerMaterialsItem Add ColumnName DataType Nullable
end
GO*/
if not exists (select 1 from sys.columns where object_id=object_id('CNT.ContractEmployerMaterialsItem') and
				[name] = 'ReceiptNumber')
begin
    Alter table CNT.ContractEmployerMaterialsItem Add [ReceiptNumber] [int] NULL
end
GO

if not exists (select 1 from sys.columns where object_id=object_id('CNT.ContractEmployerMaterialsItem') and
				[name] = 'Date')
begin
    Alter table CNT.ContractEmployerMaterialsItem Add Date datetime Null
end
GO

if not exists (select 1 from sys.columns where object_id=object_id('CNT.ContractEmployerMaterialsItem') and
				[name] = 'SecondaryQuantity')
begin
    Alter table CNT.ContractEmployerMaterialsItem Add [SecondaryQuantity] [decimal](19, 4) NULL
    
end
GO

if not exists (select 1 from sys.columns where object_id=object_id('CNT.ContractEmployerMaterialsItem') and
				[name] = 'Description')
begin
    Alter table CNT.ContractEmployerMaterialsItem Add [Description] [nvarchar](250) NULL
end
GO

if not exists (select 1 from sys.columns where object_id=object_id('CNT.ContractEmployerMaterialsItem') and
				[name] = 'Description_En')
begin
    Alter table CNT.ContractEmployerMaterialsItem Add [Description_En] [nvarchar](250) NULL
end
GO
if not exists (select 1 from sys.columns where object_id=object_id('CNT.ContractEmployerMaterialsItem') and
				[name] = 'TracingRef')
begin
    Alter table CNT.ContractEmployerMaterialsItem Add TracingRef [INT] NULL
end

GO
if not exists (select 1 from sys.columns where object_id=object_id('CNT.ContractEmployerMaterialsItem') and
				[name] = 'InventoryDeliveryRef')
begin
    Alter table CNT.ContractEmployerMaterialsItem Add InventoryDeliveryRef [INT] NULL
end
GO

if not exists (select 1 from sys.columns where object_id=object_id('CNT.ContractEmployerMaterialsItem') and
				[name] = 'TotalPrice')
begin
    Alter table CNT.ContractEmployerMaterialsItem Add TotalPrice [decimal](19,4) NULL
end

GO
if exists (select 1 from sys.columns where object_id=object_id('CNT.ContractEmployerMaterialsItem') and
				[name] = 'TotalPrice')
	update CNT.ContractEmployerMaterialsItem set TotalPrice = Fee* Quantity where TotalPrice is null

Go






--<< ALTER COLUMNS >>--

--<< PRIMARYKEY DEFINITION >>--

If not Exists (select 1 from sys.objects where name = 'PK_ContractEmployerMaterialsItem')
ALTER TABLE [CNT].[ContractEmployerMaterialsItem] ADD  CONSTRAINT [PK_ContractEmployerMaterialsItem] PRIMARY KEY CLUSTERED 
(
	[EmployerMaterialsID] ASC
) ON [PRIMARY]
GO

--<< DEFAULTS CHECKS DEFINITION >>--

--<< RULES DEFINITION >>--

--<< INDEXES DEFINITION >>--

--<< FOREIGNKEYS DEFINITION >>--

If not Exists (select 1 from sys.objects where name = 'FK_ContractEmployerMaterialsItem_Contract')
ALTER TABLE [CNT].[ContractEmployerMaterialsItem]  ADD  CONSTRAINT [FK_ContractEmployerMaterialsItem_Contract] FOREIGN KEY([ContractRef])
REFERENCES [CNT].[Contract] ([ContractID])
ON DELETE CASCADE

GO
If not Exists (select 1 from sys.objects where name = 'FK_ContractEmployerMaterialsItem_InventoryReceipt')
ALTER TABLE [CNT].[ContractEmployerMaterialsItem]  ADD  CONSTRAINT [FK_ContractEmployerMaterialsItem_InventoryReceipt] FOREIGN KEY([ReceiptRef])
REFERENCES [INV].[InventoryReceipt] ([InventoryReceiptID])

GO
If not Exists (select 1 from sys.objects where name = 'FK_ContractEmployerMaterialsItem_Item')
ALTER TABLE [CNT].[ContractEmployerMaterialsItem]  ADD  CONSTRAINT [FK_ContractEmployerMaterialsItem_Item] FOREIGN KEY([ItemRef])
REFERENCES [INV].[Item] ([ItemID])

GO
If not Exists (select 1 from sys.objects where name = 'FK_ContractEmployerMaterialsItem_Stock')
ALTER TABLE [CNT].[ContractEmployerMaterialsItem]  ADD  CONSTRAINT [FK_ContractEmployerMaterialsItem_Stock] FOREIGN KEY([StockRef])
REFERENCES [INV].[Stock] ([StockID])

GO
If not Exists (select 1 from sys.objects where name = 'FK_ContractEmployerMaterialsItem_Tracing')
ALTER TABLE [CNT].[ContractEmployerMaterialsItem]   ADD  CONSTRAINT [FK_ContractEmployerMaterialsItem_Tracing] FOREIGN KEY([TracingRef])
REFERENCES [INV].[Tracing] ([TracingID])
GO

If not Exists (select 1 from sys.objects where name = 'FK_ContractEmployerMaterialsItem_InventoryDelivery')
ALTER TABLE [CNT].[ContractEmployerMaterialsItem]  ADD  CONSTRAINT [FK_ContractEmployerMaterialsItem_InventoryDelivery] FOREIGN KEY([InventoryDeliveryRef])
REFERENCES [INV].[InventoryDelivery] ([InventoryDeliveryID])

GO


--<< DROP OBJECTS >>--
