--<<FileName:AST_AcquisitionReceipt.sql>>--
--<< TABLE DEFINITION >>--

If Object_ID('AST.AcquisitionReceipt') Is Null
CREATE TABLE [AST].[AcquisitionReceipt](
	[AcquisitionReceiptID]	[INT]				NOT NULL,
	[Number]				[INT]				NOT NULL,
	[Date]					[DATETIME]			NOT NULL,
	[CurrencyRef]			[INT]				NOT NULL,
	[CurrencyRate]			[DECIMAL](26,16)	NOT NULL,
	[Type]					[INT]				NOT NULL,
	[Description]			[NVARCHAR](4000)		NULL,
	[Description_En]		[NVARCHAR](4000)		NULL,
	[AccountingDLRef]		[INT] 					NULL,
	[AccountingSLRef]		[INT] 					NULL,
	[FiscalYearRef]			[INT] 				NOT NULL,
	[VoucherRef]			[INT] 					NULL,
	[Version]				[INT] 				NOT NULL,
	[Creator]				[INT] 				NOT NULL,
	[CreationDate]			[DATETIME]			NOT NULL,
	[LastModifier]			[INT]				NOT NULL,
	[LastModificationDate]	[DATETIME]			NOT NULL
) ON [PRIMARY]

--TEXTIMAGE_ON [SGBlob_Data]
--When a table has text, ntext, image, varchar(max), nvarchar(max), varbinary(max), xml or large user defined type columns uncomment above code
GO
--<< ADD CLOLUMNS >>--

--<< ALTER COLUMNS >>--

IF COLUMNPROPERTY(object_id('AST.AcquisitionReceipt'), 'AccountingDLRef' , 'AllowsNull') = 0
begin
	ALTER TABLE AST.AcquisitionReceipt ALTER COLUMN [AccountingDLRef] [INT] NULL
end
GO

--<< PRIMARYKEY DEFINITION >>--

If not Exists (select 1 from sys.objects where name = 'PK_AcquisitionReceipt')
ALTER TABLE [AST].[AcquisitionReceipt] ADD  CONSTRAINT [PK_AcquisitionReceipt] PRIMARY KEY CLUSTERED 
(
	[AcquisitionReceiptID] ASC
) ON [PRIMARY]
GO

--<< DEFAULTS CHECKS DEFINITION >>--

--<< RULES DEFINITION >>--

--<< INDEXES DEFINITION >>--

--<< FOREIGNKEYS DEFINITION >>--

If not Exists (select 1 from sys.objects where name = 'FK_AST_AcquisitionReceipt_CurrencyRef')
	ALTER TABLE [AST].[AcquisitionReceipt]  ADD  CONSTRAINT [FK_AST_AcquisitionReceipt_CurrencyRef] 
		FOREIGN KEY([CurrencyRef])
		REFERENCES [GNR].[Currency] ([CurrencyID])
GO

If not Exists (select 1 from sys.objects where name = 'FK_AST_AcquisitionReceipt_FiscalYearRef')
	ALTER TABLE [AST].[AcquisitionReceipt]  ADD  CONSTRAINT [FK_AST_AcquisitionReceipt_FiscalYearRef]
		FOREIGN KEY([FiscalYearRef])
		REFERENCES [FMK].[FiscalYear] ([FiscalYearId])
GO

If not Exists (select 1 from sys.objects where name = 'FK_AST_AcquisitionReceipt_AccountingSLRef')
	ALTER TABLE [AST].[AcquisitionReceipt]  ADD  CONSTRAINT [FK_AST_AcquisitionReceipt_AccountingSLRef] 
		FOREIGN KEY([AccountingSLRef])
		REFERENCES [ACC].[Account] ([AccountId])
GO

If not Exists (select 1 from sys.objects where name = 'FK_AST_AcquisitionReceipt_AccountingDLRef')
	ALTER TABLE [AST].[AcquisitionReceipt]  ADD  CONSTRAINT [FK_AST_AcquisitionReceipt_AccountingDLRef] 
		FOREIGN KEY([AccountingDLRef])
		REFERENCES [ACC].[DL] ([DLId])
GO

If not Exists (select 1 from sys.objects where name = 'FK_AST_AcquisitionReceipt_VoucherRef')
	ALTER TABLE [AST].[AcquisitionReceipt]  ADD  CONSTRAINT [FK_AST_AcquisitionReceipt_VoucherRef] 
		FOREIGN KEY([VoucherRef])
		REFERENCES [ACC].[Voucher] ([VoucherId])
Go

--<< DROP OBJECTS >>--
