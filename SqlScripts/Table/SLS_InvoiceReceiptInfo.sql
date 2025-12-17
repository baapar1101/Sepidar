--<<FileName:SLS_InvoiceReceiptInfo.sql>>--
--<< TABLE DEFINITION >>--
IF OBJECT_ID('SLS.InvoiceReceiptInfo') IS NULL
	CREATE TABLE [SLS].[InvoiceReceiptInfo] (
		[InvoiceReceiptInfoID] [INT] NOT NULL
	   ,[InvoiceRef] [INT] NOT NULL
	   ,[Discount] [DECIMAL](19, 4) NOT NULL
	   ,[Amount] [DECIMAL](19, 4) NOT NULL
	   ,[DraftAmount] [DECIMAL](19, 4) NOT NULL
	   ,[PartyAccountSettlementItemRef] [INT] NULL
	) ON [PRIMARY]

--TEXTIMAGE_ON [SGBlob_Data]
--When a table has text, ntext, image, varchar(max), nvarchar(max), varbinary(max), xml or large user defined type columns uncomment above code
GO
--<< ADD CLOLUMNS >>--
IF NOT EXISTS (SELECT 1 FROM sys.columns WHERE [object_id] = OBJECT_ID('SLS.InvoiceReceiptInfo')
				AND [name] = 'PartyAccountSettlementItemRef')
BEGIN
	ALTER TABLE [SLS].[InvoiceReceiptInfo] ADD [PartyAccountSettlementItemRef] [INT] NULL
END
GO

--<<Sample>>--
/*if not exists (select 1 from sys.columns where object_id=object_id('RPA.ReceiptHeader') and
				[name] = 'ColumnName')
begin
    Alter table RPA.ReceiptHeader Add ColumnName DataType Nullable
end
GO*/

--<< ALTER COLUMNS >>--

--<< PRIMARYKEY DEFINITION >>--
IF NOT EXISTS (SELECT 1 FROM sys.objects WHERE name = 'PK_InvoiceReceiptInfo')
	ALTER TABLE [SLS].[InvoiceReceiptInfo] ADD CONSTRAINT [PK_InvoiceReceiptInfo] PRIMARY KEY CLUSTERED
	(
	[InvoiceReceiptInfoID] ASC
	) ON [PRIMARY]
GO

--<< DEFAULTS CHECKS DEFINITION >>--

--<< RULES DEFINITION >>--

--<< INDEXES DEFINITION >>--
IF NOT EXISTS (SELECT 1 FROM sys.indexes WHERE name = 'UIX_InvoiceReceiptInfo_InvoiceRef')
	CREATE UNIQUE NONCLUSTERED INDEX [UIX_InvoiceReceiptInfo_InvoiceRef]
	ON [SLS].[InvoiceReceiptInfo] ([InvoiceRef])
GO

--<< FOREIGNKEYS DEFINITION >>--
IF NOT EXISTS (SELECT 1 FROM sys.objects WHERE name = 'FK_InvoiceReceiptInfo_InvoiceRef')
	ALTER TABLE [SLS].[InvoiceReceiptInfo] ADD CONSTRAINT [FK_InvoiceReceiptInfo_InvoiceRef] FOREIGN KEY ([InvoiceRef])
	REFERENCES [SLS].[Invoice] ([InvoiceId])
	ON UPDATE CASCADE
	ON DELETE CASCADE
GO

IF NOT EXISTS (SELECT 1 FROM sys.objects WHERE name = 'FK_InvoiceReceiptInfo_PartyAccountSettlementItemRef')
	ALTER TABLE [SLS].[InvoiceReceiptInfo] ADD CONSTRAINT [FK_InvoiceReceiptInfo_PartyAccountSettlementItemRef] FOREIGN KEY ([PartyAccountSettlementItemRef])
	REFERENCES [RPA].[PartyAccountSettlementItem] ([PartyAccountSettlementItemID])
	ON UPDATE CASCADE
	ON DELETE SET NULL
GO

--<< DROP OBJECTS >>--
