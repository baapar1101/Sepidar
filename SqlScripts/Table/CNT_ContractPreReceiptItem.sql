--<<FileName:CNT_ContractPreReceiptItem.sql>>--
--<< TABLE DEFINITION >>--

If Object_ID('CNT.ContractPreReceiptItem') Is Null
CREATE TABLE [CNT].[ContractPreReceiptItem](
	[PreReceiptID] [int] NOT NULL,
	[ReceiptRef] [int] NULL,
	[ReceiptNumber] [int] NULL,	
	[PaymentRef] [int] NULL,
	[ContractRef] [int] NOT NULL,
	[RowNumber] [int] NOT NULL,
	[Date] [datetime] NOT NULL,
	[Price] [decimal](19, 4) NOT NULL,
	[Type] [int] NOT NULL,
	[Description] [nvarchar](250) NULL,
	[Description_En] [nvarchar](250) NULL
) ON [PRIMARY]

--TEXTIMAGE_ON [SGBlob_Data]
--When a table has text, ntext, image, varchar(max), nvarchar(max), varbinary(max), xml or large user defined type columns uncomment above code
GO
--<< ADD CLOLUMNS >>--

--<<Sample>>--
/*if not exists (select 1 from sys.columns where object_id=object_id('CNT.ContractPreReceiptItem') and
				[name] = 'ColumnName')
begin
    Alter table CNT.ContractPreReceiptItem Add ColumnName DataType Nullable
end
GO*/
if not exists (select 1 from sys.columns where object_id=object_id('CNT.ContractPreReceiptItem') and
				[name] = 'ReceiptNumber')
begin
    Alter table CNT.ContractPreReceiptItem Add [ReceiptNumber] [int] NULL
end
GO

if not exists (select 1 from sys.columns where object_id=object_id('CNT.ContractPreReceiptItem') and
				[name] = 'PaymentRef')
begin
    Alter table CNT.ContractPreReceiptItem Add [PaymentRef] [int] NULL
end
GO

--<< ALTER COLUMNS >>--

--<< PRIMARYKEY DEFINITION >>--

If not Exists (select 1 from sys.objects where name = 'PK_ContractPreReceiptItem')
ALTER TABLE [CNT].[ContractPreReceiptItem] ADD  CONSTRAINT [PK_ContractPreReceiptItem] PRIMARY KEY CLUSTERED 
(
	[PreReceiptID] ASC
) ON [PRIMARY]
GO

--<< DEFAULTS CHECKS DEFINITION >>--

--<< RULES DEFINITION >>--

--<< INDEXES DEFINITION >>--

--<< FOREIGNKEYS DEFINITION >>--

If not Exists (select 1 from sys.objects where name = 'FK_ContractPreReceiptItem_Contract')
ALTER TABLE [CNT].[ContractPreReceiptItem]  ADD  CONSTRAINT [FK_ContractPreReceiptItem_Contract] FOREIGN KEY([ContractRef])
REFERENCES [CNT].[Contract] ([ContractID])
ON DELETE CASCADE

GO
If not Exists (select 1 from sys.objects where name = 'FK_PreReceipt_ReceiptHeader')
ALTER TABLE [CNT].[ContractPreReceiptItem]  ADD  CONSTRAINT [FK_PreReceipt_ReceiptHeader] FOREIGN KEY([ReceiptRef])
REFERENCES [RPA].[ReceiptHeader] ([ReceiptHeaderId])

GO

If not Exists (select 1 from sys.objects where name = 'FK_PreReceipt_PaymentRef')
ALTER TABLE [CNT].[ContractPreReceiptItem]  ADD  CONSTRAINT [FK_PreReceipt_PaymentRef] FOREIGN KEY([PaymentRef])
REFERENCES [RPA].[PaymentHeader] ([PaymentHeaderId])

GO

--<< DROP OBJECTS >>--
