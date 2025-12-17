--<<FileName:CNT_Guarantee.sql>>--
--<< TABLE DEFINITION >>--


IF OBJECT_ID('CNT.Guarantee') Is Null
CREATE TABLE [CNT].[Guarantee](
	[GuaranteeID] [int] NOT NULL,	
	[Date] [datetime] NOT NULL,
	[DocumentNumber] [int] NOT NULL,
	[TenderRef] [int] NULL,
	[ContractRef] [int] NULL,
	[WarrantyRef] [int] NOT NULL,
	[Regard] [int] NOT NULL,
	[DlRef] [int] NOT NULL,	
	[Price] [decimal](19, 4) NOT NULL,
	[DueDate] [datetime] NULL,
	[DeliveryDate] [datetime] NOT NULL,
	[FurtherInfo] [nvarchar](250) NULL,
	[Description] [nvarchar](250) NULL,
	[Description_En] [nvarchar](250) NULL,	
	[BankAccountRef] [int] NULL,	
	[Number] [nvarchar](50) NULL,--Cheque Number or NoteNumber	
	[BankBranchRef] [int] NULL,
	[State] [int] NOT NULL,	
	[VoucherRef] [int] NULL,
	[PaymentRef] [int] NULL,	
	[Nature] [int] NOT NULL,
	[ReceiptRef] [int] NULL,
	[BankRef] [int] NULL,
	[AccountNo] [nvarchar](50) NULL,
	[SLref] [int] NULL,
	[Version] [int] NOT NULL,
	[Creator] [int] NOT NULL,
	[CreationDate] [datetime] NOT NULL,
	[LastModifier] [int] NOT NULL,
	[LastModificationDate] [datetime] NOT NULL,
	[FiscalYearRef] [int] NOT NULL,
	[OldContractWarrantyItemId] [int] NULL,	
) ON [PRIMARY]

--TEXTIMAGE_ON [SGBlob_Data]
--When a table has text, ntext, image, varchar(max), nvarchar(max), varbinary(max), xml or large user defined type columns uncomment above code
GO
--<< ADD CLOLUMNS >>--

--<<Sample>>--
/*if not exists (select 1 from sys.columns where object_id=object_id('CNT.Guarantee') and
				[name] = 'ColumnName')
begin
    Alter table CNT.Guarantee Add ColumnName DataType Nullable
end
GO*/
IF NOT EXISTS (SELECT 1 FROM sys.columns WHERE OBJECT_ID=OBJECT_ID('CNT.Guarantee') AND
				[name] = 'VoucherRef')
BEGIN
    ALTER TABLE CNT.Guarantee ADD [VoucherRef] [int] NULL
END
GO
IF NOT EXISTS (SELECT 1 FROM sys.columns WHERE OBJECT_ID=OBJECT_ID('CNT.Guarantee') AND
				[name] = 'PaymentRef')
BEGIN
    ALTER TABLE CNT.Guarantee ADD [PaymentRef] [int] NULL
END
GO

IF NOT EXISTS (SELECT 1 FROM sys.columns WHERE OBJECT_ID=OBJECT_ID('CNT.Guarantee') AND
				[name] = 'BankBranchRef')
BEGIN
    ALTER TABLE CNT.Guarantee ADD [BankBranchRef] [int] NULL
END
GO

IF NOT EXISTS (SELECT 1 FROM sys.columns WHERE OBJECT_ID=OBJECT_ID('CNT.Guarantee') AND
				[name] = 'Nature')
BEGIN
    ALTER TABLE CNT.Guarantee ADD [Nature] [int] NULL
END
GO
if exists (select 1 from sys.columns where object_id=object_id('CNT.Guarantee') and
				[name] = 'Nature')
begin
	update CNT.Guarantee set Nature = 1 where Nature is null
    Alter table CNT.Guarantee ALTER COLUMN Nature [int] not NULL
end
GO
IF NOT EXISTS (SELECT 1 FROM sys.columns WHERE OBJECT_ID=OBJECT_ID('CNT.Guarantee') AND
				[name] = 'ReceiptRef')
BEGIN
    ALTER TABLE CNT.Guarantee ADD [ReceiptRef] [int] NULL
END
GO

IF NOT EXISTS (SELECT 1 FROM sys.columns WHERE OBJECT_ID=OBJECT_ID('CNT.Guarantee') AND
				[name] = 'BankRef')
BEGIN
    ALTER TABLE CNT.Guarantee ADD [BankRef] [int] NULL
END
GO

IF NOT EXISTS (SELECT 1 FROM sys.columns WHERE OBJECT_ID=OBJECT_ID('CNT.Guarantee') AND
				[name] = 'AccountNo')
BEGIN
    ALTER TABLE CNT.Guarantee ADD [AccountNo] [nvarchar](50) NULL
END
GO
IF NOT EXISTS (SELECT 1 FROM sys.columns WHERE OBJECT_ID=OBJECT_ID('CNT.Guarantee') AND
				[name] = 'SLRef')
BEGIN
    ALTER TABLE CNT.Guarantee ADD [SLref] [int] NULL
END
GO

--<< ALTER COLUMNS >>--

--<< PRIMARYKEY DEFINITION >>--

If not Exists (select 1 from sys.objects where name = 'PK_Guarantee_ID')
ALTER TABLE [CNT].[Guarantee] ADD  CONSTRAINT [PK_Guarantee_ID] PRIMARY KEY CLUSTERED 
(
	[GuaranteeID] ASC
) ON [PRIMARY]
GO

--<< DEFAULTS CHECKS DEFINITION >>--

--<< RULES DEFINITION >>--

--<< INDEXES DEFINITION >>--

--<< FOREIGNKEYS DEFINITION >>--



If not Exists (select 1 from sys.objects where name = 'FK_Guarantee_DlRef')
ALTER TABLE [CNT].[Guarantee]  ADD  CONSTRAINT [FK_Guarantee_DlRef] FOREIGN KEY([DlRef])
REFERENCES [ACC].[DL] ([DLId])
GO

If not Exists (select 1 from sys.objects where name = 'FK_Guarantee_TenderRef')
ALTER TABLE [CNT].[Guarantee]  ADD  CONSTRAINT [FK_Guarantee_TenderRef] FOREIGN KEY([TenderRef])
REFERENCES [CNT].[Tender] ([TenderId])
GO

If not Exists (select 1 from sys.objects where name = 'FK_Guarantee_WarrantyRef')
ALTER TABLE [CNT].[Guarantee]  ADD  CONSTRAINT [FK_Guarantee_WarrantyRef] FOREIGN KEY([WarrantyRef])
REFERENCES [CNT].[Warranty] ([WarrantyId])
GO

If Exists (select 1 from sys.objects where name = 'FK_Guarantee_ContractRef')
ALTER TABLE [CNT].[Guarantee]  DROP  CONSTRAINT [FK_Guarantee_ContractRef]

GO

If not Exists (select 1 from sys.objects where name = 'FK_Guarantee_ContractRef')
ALTER TABLE [CNT].[Guarantee]  ADD  CONSTRAINT [FK_Guarantee_ContractRef] FOREIGN KEY([ContractRef])
REFERENCES [CNT].[Contract] ([ContractId])
ON DELETE CASCADE
GO


If not Exists (select 1 from sys.objects where name = 'FK_Guarantee_BankAccountRef')
ALTER TABLE [CNT].[Guarantee]  ADD  CONSTRAINT [FK_Guarantee_BankAccountRef] FOREIGN KEY([BankAccountRef])
REFERENCES [RPA].[BankAccount] ([BankAccountId])
GO

If not Exists (select 1 from sys.objects where name = 'FK_Guarantee_FiscalYearRef')
ALTER TABLE [CNT].[Guarantee]  ADD  CONSTRAINT [FK_Guarantee_FiscalYearRef] FOREIGN KEY([FiscalYearRef])
REFERENCES [FMK].[FiscalYear] ([FiscalYearId])
GO

IF NOT EXISTS (select 1 from sys.objects where name = 'FK_Guarantee_VoucherRef')
ALTER TABLE [CNT].[Guarantee]  ADD  CONSTRAINT [FK_Guarantee_VoucherRef] FOREIGN KEY([VoucherRef])
REFERENCES [ACC].[Voucher](VoucherID)
GO

IF NOT EXISTS (select 1 from sys.objects where name = 'FK_Guarantee_PaymentRef')
ALTER TABLE [CNT].[Guarantee]  ADD  CONSTRAINT [FK_Guarantee_PaymentRef] FOREIGN KEY([PaymentRef])
REFERENCES [RPA].[PaymentHeader](PaymentHeaderID)
GO

IF NOT EXISTS (select 1 from sys.objects where name = 'FK_Guarantee_BankBranchRef')
ALTER TABLE [CNT].[Guarantee]  ADD  CONSTRAINT FK_Guarantee_BankBranchRef FOREIGN KEY([BankBranchRef])
REFERENCES [RPA].[BankBranch](BankBranchID)
GO

IF NOT EXISTS (select 1 from sys.objects where name = 'FK_Guarantee_ReceiptRef')
ALTER TABLE [CNT].[Guarantee]  ADD  CONSTRAINT [FK_Guarantee_ReceiptRef] FOREIGN KEY([ReceiptRef])
REFERENCES [RPA].[ReceiptHeader](ReceiptHeaderID)
GO

IF NOT EXISTS (select 1 from sys.objects where name = 'FK_Guarantee_BankRef')
ALTER TABLE [CNT].[Guarantee]  ADD  CONSTRAINT FK_Guarantee_BankRef FOREIGN KEY([BankRef])
REFERENCES [RPA].[Bank](BankID)
GO

IF NOT EXISTS (select 1 from sys.objects where name = 'FK_Guarantee_SLRef')
ALTER TABLE [CNT].[Guarantee]  ADD  CONSTRAINT FK_Guarantee_SLRef FOREIGN KEY([SLRef])
REFERENCES [ACC].[Account] ([AccountId])
GO