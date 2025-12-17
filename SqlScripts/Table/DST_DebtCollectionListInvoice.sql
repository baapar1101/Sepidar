--<<FileName:DST_DebtCollectionListInvoice.sql>>--

--<< TABLE DEFINITION >>--
IF Object_ID('DST.DebtCollectionListInvoice') IS NULL
CREATE TABLE [DST].[DebtCollectionListInvoice](
	[DebtCollectionListInvoiceId]	[INT]				NOT NULL,
	[DebtCollectionListRef]			[INT]				NOT NULL,
	[RowNumber]						[INT]				NOT NULL,
	[InvoiceRef]					[INT]				NULL,
	[ReturnedInvoiceRef]			[INT]				NULL,
	[Amount]						[DECIMAL](19, 4)	NOT NULL,
	[Discount]						[DECIMAL](19, 4)	NOT NULL,
	[UnexecutedActReasonRef]		[INT]				NULL,
	[PartyAccountSettlementRef]		[INT]				NULL,
) ON [PRIMARY]

--TEXTIMAGE_ON [SGBlob_Data]
--When a table has text, ntext, image, varchar(max), nvarchar(max), varbinary(max), xml or large user defined type columns uncomment above code
GO
--<< ADD CLOLUMNS >>--
IF NOT EXISTS (SELECT 1 FROM sys.columns WHERE object_id = OBJECT_ID('DST.DebtCollectionListInvoice') AND name = 'Discount')
BEGIN
	ALTER TABLE [DST].[DebtCollectionListInvoice] ADD [Discount] [DECIMAL](19, 4) NOT NULL DEFAULT 0;
END

GO
--<<Sample>>--

/*if not exists (select 1 from sys.columns where object_id=object_id('DST.AreaAndPath') and
				[name] = 'ColumnName')
begin
    Alter table DST.AreaAndPath Add ColumnName DataType Nullable
end
GO*/

if not exists (select 1 from sys.columns where object_id=object_id('DST.DebtCollectionListInvoice') and
				[name] = 'ReturnedInvoiceRef')
begin
    Alter table DST.DebtCollectionListInvoice Add ReturnedInvoiceRef INT NULL
end
GO

if not exists (select 1 from sys.columns where object_id=object_id('DST.DebtCollectionListInvoice') and
				[name] = 'InvoiceRef' and [is_nullable] = 1 )
begin
    Alter table DST.DebtCollectionListInvoice ALTER COLUMN [InvoiceRef] INT NULL
end

GO

--<< ALTER COLUMNS >>--

--<< PRIMARYKEY DEFINITION >>--
IF NOT EXISTS (SELECT 1 FROM sys.objects WHERE NAME = 'PK_DebtCollectionListInvoice')
ALTER TABLE [DST].[DebtCollectionListInvoice] ADD CONSTRAINT [PK_DebtCollectionListInvoice] PRIMARY KEY CLUSTERED 
(
	[DebtCollectionListInvoiceId] ASC
) ON [PRIMARY]
GO

--<< DEFAULTS CHECKS DEFINITION >>--

--<< RULES DEFINITION >>--

--<< INDEXES DEFINITION >>--

IF EXISTS (SELECT 1 FROM sys.indexes WHERE NAME = 'UIX_DebtCollectionListInvoice_DebtCollectionListRef_InvoiceRef')
    DROP INDEX UIX_DebtCollectionListInvoice_DebtCollectionListRef_InvoiceRef ON DST.DebtCollectionListInvoice

GO
IF NOT EXISTS (SELECT 1 FROM sys.indexes WHERE NAME = 'UIX_DebtCollectionListInvoice_DebtCollectionListRef_InvoiceRef_ReturnedInvoiceRef')
CREATE UNIQUE NONCLUSTERED INDEX [UIX_DebtCollectionListInvoice_DebtCollectionListRef_InvoiceRef_ReturnedInvoiceRef] ON [DST].[DebtCollectionListInvoice]
(
	[DebtCollectionListRef] ASC,
	[InvoiceRef] ASC,
	[ReturnedInvoiceRef] ASC
) ON [PRIMARY]
GO


--<< FOREIGNKEYS DEFINITION >>--
IF NOT EXISTS (SELECT 1 FROM sys.objects WHERE NAME = 'FK_DebtCollectionListInvoice_DebtCollectionListRef')
ALTER TABLE [DST].[DebtCollectionListInvoice] ADD CONSTRAINT [FK_DebtCollectionListInvoice_DebtCollectionListRef] FOREIGN KEY([DebtCollectionListRef])
REFERENCES [DST].[DebtCollectionList] ([DebtCollectionListId])
ON DELETE CASCADE

GO

IF NOT EXISTS (SELECT 1 FROM sys.objects WHERE NAME = 'FK_DebtCollectionListInvoice_InvoiceRef')
ALTER TABLE [DST].[DebtCollectionListInvoice] ADD CONSTRAINT [FK_DebtCollectionListInvoice_InvoiceRef] FOREIGN KEY([InvoiceRef])
REFERENCES [SLS].[Invoice] ([InvoiceId])

GO

IF NOT EXISTS (SELECT 1 FROM sys.objects WHERE NAME = 'FK_DebtCollectionListInvoice_ReturnedInvoiceRef')
ALTER TABLE [DST].[DebtCollectionListInvoice] ADD CONSTRAINT [FK_DebtCollectionListInvoice_ReturnedInvoiceRef] FOREIGN KEY([ReturnedInvoiceRef])
REFERENCES [SLS].[ReturnedInvoice] ([ReturnedInvoiceId])

GO

IF NOT EXISTS (SELECT 1 FROM sys.objects WHERE NAME = 'FK_DebtCollectionListInvoice_UnexecutedActReasonRef')
ALTER TABLE [DST].[DebtCollectionListInvoice] ADD CONSTRAINT [FK_DebtCollectionListInvoice_UnexecutedActReasonRef] FOREIGN KEY([UnexecutedActReasonRef])
REFERENCES [DST].[UnexecutedActReason] ([UnexecutedActReasonId])

GO

IF NOT EXISTS (SELECT 1 FROM sys.objects WHERE NAME = 'FK_DebtCollectionListInvoice_PartyAccountSettlementRef')
ALTER TABLE [DST].[DebtCollectionListInvoice] ADD CONSTRAINT [FK_DebtCollectionListInvoice_PartyAccountSettlementRef] FOREIGN KEY([PartyAccountSettlementRef])
REFERENCES [RPA].[PartyAccountSettlement] ([PartyAccountSettlementID])

GO

--<< DROP OBJECTS >>--