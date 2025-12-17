--<<FileName:SLS_InvoiceReceiptChequeInfo.sql>>--
--<< TABLE DEFINITION >>--
IF OBJECT_ID('SLS.InvoiceReceiptChequeInfo') IS NULL
	CREATE TABLE [SLS].[InvoiceReceiptChequeInfo] (
		[InvoiceReceiptChequeInfoId] [INT] NOT NULL
	   ,[InvoiceRef] [INT] NOT NULL
	   ,[Number] [NVARCHAR](50) NOT NULL
	   ,[Amount] [DECIMAL](19, 4) NOT NULL
	   ,[Date] [DATETIME] NOT NULL
	   ,[AccountNo] [NVARCHAR](50) NOT NULL
	   ,[BankRef] [INT] NOT NULL
	   ,[PartyAccountSettlementItemRef] [INT] NULL
	   ,[SayadCode]	NVARCHAR(20) NULL
	) ON [PRIMARY]

--TEXTIMAGE_ON [SGBlob_Data]
--When a table has text, ntext, image, varchar(max), nvarchar(max), varbinary(max), xml or large user defined type columns uncomment above code
GO
--<< ADD CLOLUMNS >>--
IF NOT EXISTS (SELECT 1 FROM sys.columns WHERE [object_id] = OBJECT_ID('SLS.InvoiceReceiptChequeInfo')
				AND [name] = 'PartyAccountSettlementItemRef')
BEGIN
	ALTER TABLE [SLS].[InvoiceReceiptChequeInfo] ADD [PartyAccountSettlementItemRef] [INT] NULL
END
GO

IF NOT EXISTS (SELECT 1 FROM sys.columns WHERE [object_id] = OBJECT_ID('SLS.InvoiceReceiptChequeInfo') AND
				[name] = 'SayadCode')
BEGIN
    ALTER TABLE [SLS].[InvoiceReceiptChequeInfo] ADD [SayadCode] NVARCHAR(20) NULL
END
GO

--<<Sample>>--

--<< ALTER COLUMNS >>--

--<< PRIMARYKEY DEFINITION >>--
IF NOT EXISTS (SELECT 1 FROM sys.objects WHERE name = 'PK_InvoiceReceiptChequeInfo')
	ALTER TABLE [SLS].[InvoiceReceiptChequeInfo] ADD CONSTRAINT [PK_InvoiceReceiptChequeInfo] PRIMARY KEY CLUSTERED
	(
	[InvoiceReceiptChequeInfoId] ASC
	) ON [PRIMARY]
GO

--<< DEFAULTS CHECKS DEFINITION >>--

--<< RULES DEFINITION >>--

--<< INDEXES DEFINITION >>--

--<< FOREIGNKEYS DEFINITION >>--
IF NOT EXISTS (SELECT 1 FROM sys.objects WHERE name = 'FK_InvoiceReceiptChequeInfo_InvoiceRef')
	ALTER TABLE [SLS].[InvoiceReceiptChequeInfo] ADD CONSTRAINT [FK_InvoiceReceiptChequeInfo_InvoiceRef] FOREIGN KEY ([InvoiceRef])
	REFERENCES [SLS].[Invoice] ([InvoiceId])
	ON UPDATE CASCADE
	ON DELETE CASCADE
GO

IF NOT EXISTS (SELECT 1 FROM sys.objects WHERE name = 'FK_InvoiceReceiptChequeInfo_PartyAccountSettlementItemRef')
	ALTER TABLE [SLS].[InvoiceReceiptChequeInfo] ADD CONSTRAINT [FK_InvoiceReceiptChequeInfo_PartyAccountSettlementItemRef] FOREIGN KEY ([PartyAccountSettlementItemRef])
	REFERENCES [RPA].[PartyAccountSettlementItem] ([PartyAccountSettlementItemID])
	ON UPDATE CASCADE
	ON DELETE SET NULL
GO

IF NOT EXISTS (SELECT 1 FROM sys.objects WHERE name = 'FK_InvoiceReceiptChequeInfo_BankRef')
	ALTER TABLE [SLS].[InvoiceReceiptChequeInfo] ADD CONSTRAINT [FK_InvoiceReceiptChequeInfo_BankRef] FOREIGN KEY ([BankRef])
	REFERENCES [RPA].[Bank] ([BankId])
GO

--<< DROP OBJECTS >>--
