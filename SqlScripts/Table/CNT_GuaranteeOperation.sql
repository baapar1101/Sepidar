--<<FileName:CNT_GuaranteeOperation.sql>>--
--<< TABLE DEFINITION >>--

--IF OBJECT_ID('CNT.GuaranteeOperation') Is not Null
--drop table CNT.GuaranteeOperation


IF OBJECT_ID('CNT.GuaranteeOperation') Is Null
CREATE TABLE [CNT].[GuaranteeOperation](
	[GuaranteeOperationID] [int] NOT NULL,
	[GuaranteeRef] [int] NOT NULL,
	[Date] [datetime] NOT NULL,
	[Type] [int] NOT NULL,		
	[Price] [decimal](19, 4) NULL,
	[ExtensionDate] [datetime] NULL,	
	[State] [int] NOT NULL,		
	[VoucherRef] [int] NULL,
	[PaymentRef] [int] NULL,
	[ReceiptRef] [int] NULL,
	[RefundChequeRef] [int] NULL,
	[Description] [nvarchar](250) NULL,
	[Description_En] [nvarchar](250) NULL,	
	[Version] [int] NOT NULL,
	[Creator] [int] NOT NULL,
	[CreationDate] [datetime] NOT NULL,
	[LastModifier] [int] NOT NULL,
	[LastModificationDate] [datetime] NOT NULL,	
	[FiscalYearRef] [int] NOT NULL,	
) ON [PRIMARY]

--TEXTIMAGE_ON [SGBlob_Data]
--When a table has text, ntext, image, varchar(max), nvarchar(max), varbinary(max), xml or large user defined type columns uncomment above code
GO

IF EXISTS (SELECT 1 FROM sys.columns where object_id=object_id('CNT.GuaranteeOperation') AND [Name] = 'DueDate')
		ALTER TABLE CNT.GuaranteeOperation DROP COLUMN DueDate
GO

IF EXISTS (SELECT 1 FROM sys.columns where object_id=object_id('CNT.GuaranteeOperation') AND [Name] = 'DeliveryDate')
		ALTER TABLE CNT.GuaranteeOperation DROP COLUMN DeliveryDate
GO

IF EXISTS (SELECT 1 FROM sys.columns where object_id=object_id('CNT.GuaranteeOperation') AND [Name] = 'DocumentNumber')
		ALTER TABLE CNT.GuaranteeOperation DROP COLUMN DocumentNumber
GO






--<< ADD CLOLUMNS >>--

--<<Sample>>--
/*if not exists (select 1 from sys.columns where object_id=object_id('CNT.GuaranteeOperation') and
				[name] = 'ColumnName')
begin
    Alter table CNT.GuaranteeOperation Add ColumnName DataType Nullable
end
GO*/


IF NOT EXISTS (SELECT 1 FROM sys.columns WHERE OBJECT_ID=OBJECT_ID('CNT.GuaranteeOperation') AND
				[name] = 'Description')
BEGIN
    ALTER TABLE CNT.GuaranteeOperation ADD [Description] [nvarchar](250) NULL
END
GO

IF NOT EXISTS (SELECT 1 FROM sys.columns WHERE OBJECT_ID=OBJECT_ID('CNT.GuaranteeOperation') AND
				[name] = 'Description_En')
BEGIN
    ALTER TABLE CNT.GuaranteeOperation ADD [Description_En] [nvarchar](250) NULL
END
GO

IF NOT EXISTS (SELECT 1 FROM sys.columns WHERE OBJECT_ID=OBJECT_ID('CNT.GuaranteeOperation') AND
				[name] = 'ExtensionDate')
BEGIN
    ALTER TABLE CNT.GuaranteeOperation ADD [ExtensionDate] [datetime] NULL
END
GO


if not exists (select 1 from sys.columns where object_id=object_id('CNT.GuaranteeOperation') and
				[name] = 'RefundChequeRef')
begin
    Alter table CNT.GuaranteeOperation Add RefundChequeRef int Null
end





--<< ALTER COLUMNS >>--

--<< PRIMARYKEY DEFINITION >>--

If not Exists (select 1 from sys.objects where name = 'PK_GuaranteeOperation_ID')
ALTER TABLE [CNT].[GuaranteeOperation] ADD  CONSTRAINT [PK_GuaranteeOperation_ID] PRIMARY KEY CLUSTERED 
(
	[GuaranteeOperationID] ASC
) ON [PRIMARY]
GO

--<< DEFAULTS CHECKS DEFINITION >>--

--<< RULES DEFINITION >>--

--<< INDEXES DEFINITION >>--

--<< FOREIGNKEYS DEFINITION >>--


If not Exists (select 1 from sys.objects where name = 'FK_GuaranteeOperation_FiscalYearRef')
ALTER TABLE [CNT].[GuaranteeOperation]  ADD  CONSTRAINT [FK_GuaranteeOperation_FiscalYearRef] FOREIGN KEY([FiscalYearRef])
REFERENCES [FMK].[FiscalYear] ([FiscalYearId])
GO

IF NOT EXISTS (select 1 from sys.objects where name = 'FK_GuaranteeOperation_GuaranteeRef')
ALTER TABLE [CNT].[GuaranteeOperation]  ADD  CONSTRAINT [FK_GuaranteeOperation_GuaranteeRef] FOREIGN KEY([GuaranteeRef])
REFERENCES [CNT].[Guarantee] ([GuaranteeId])
GO

IF NOT EXISTS (select 1 from sys.objects where name = 'FK_GuaranteeOperation_VoucherRef')
ALTER TABLE [CNT].[GuaranteeOperation]  ADD  CONSTRAINT [FK_GuaranteeOperation_VoucherRef] FOREIGN KEY([VoucherRef])
REFERENCES [ACC].[Voucher](VoucherID)
GO

IF NOT EXISTS (select 1 from sys.objects where name = 'FK_GuaranteeOperation_PaymentRef')
ALTER TABLE [CNT].[GuaranteeOperation]  ADD  CONSTRAINT [FK_GuaranteeOperation_PaymentRef] FOREIGN KEY([PaymentRef])
REFERENCES [RPA].[PaymentHeader](PaymentHeaderID)
GO

IF NOT EXISTS (select 1 from sys.objects where name = 'FK_GuaranteeOperation_ReceiptRef')
ALTER TABLE [CNT].[GuaranteeOperation]  ADD  CONSTRAINT [FK_GuaranteeOperation_ReceiptRef] FOREIGN KEY([ReceiptRef])
REFERENCES [RPA].[ReceiptHeader](ReceiptHeaderID)
GO

If not Exists (select 1 from sys.objects where name = 'FK_GuaranteeOperation_RefundChequeRef')
ALTER TABLE [CNT].[GuaranteeOperation]  ADD  CONSTRAINT [FK_GuaranteeOperation_RefundChequeRef] FOREIGN KEY([RefundChequeRef])
REFERENCES [RPA].[RefundCheque](RefundChequeID)
GO

