--<<FileName:DST_ColdDistributionInvoice.sql>>--

--<< TABLE DEFINITION >>--
IF Object_ID('DST.ColdDistributionInvoice') IS NULL
CREATE TABLE [DST].[ColdDistributionInvoice](
	[ColdDistributionInvoiceId]					[INT]			NOT NULL,
	[ColdDistributionRef]						[INT]			NOT NULL,
	[RowNumber]									[INT]			NOT NULL,
	[InvoiceRef]								[INT]			NOT NULL,
	[UnexecutedActReasonRef]					[INT]			NULL,
	[DebtCollectionListAmount]					decimal(19, 4)	NULL,
	[DebtCollectionListDiscount]				decimal(19, 4)	NULL,
	[DebtCollectionListUnexecutedActReasonRef]	[INT]			NULL,

) ON [PRIMARY]

--TEXTIMAGE_ON [SGBlob_Data]
--When a table has text, ntext, image, varchar(max), nvarchar(max), varbinary(max), xml or large user defined type columns uncomment above code
GO
--<< ADD CLOLUMNS >>--

--<<Sample>>--
if not exists (select 1 from sys.columns where object_id=object_id('DST.ColdDistributionInvoice') and
				[name] = 'DebtCollectionListAmount')
begin
    Alter table DST.ColdDistributionInvoice Add DebtCollectionListAmount decimal(19, 4) NUll
end
GO
if not exists (select 1 from sys.columns where object_id=object_id('DST.ColdDistributionInvoice') and
				[name] = 'DebtCollectionListDiscount')
begin
    Alter table DST.ColdDistributionInvoice Add DebtCollectionListDiscount decimal(19, 4) NUll
end
GO
if not exists (select 1 from sys.columns where object_id=object_id('DST.ColdDistributionInvoice') and
				[name] = 'DebtCollectionListUnexecutedActReasonRef')
begin
    Alter table DST.ColdDistributionInvoice Add DebtCollectionListUnexecutedActReasonRef [INT] NUll
end
GO

--<< ALTER COLUMNS >>--

--<< PRIMARYKEY DEFINITION >>--
IF NOT EXISTS (SELECT 1 FROM sys.objects WHERE NAME = 'PK_ColdDistributionInvoice')
ALTER TABLE [DST].[ColdDistributionInvoice] ADD CONSTRAINT [PK_ColdDistributionInvoice] PRIMARY KEY CLUSTERED 
(
	[ColdDistributionInvoiceId] ASC
) ON [PRIMARY]
GO

--<< DEFAULTS CHECKS DEFINITION >>--

--<< RULES DEFINITION >>--

--<< INDEXES DEFINITION >>--
IF NOT EXISTS (SELECT 1 FROM sys.indexes WHERE NAME = 'UIX_ColdDistributionInvoice_ColdDistributionRef_InvoiceRef')
CREATE UNIQUE NONCLUSTERED INDEX [UIX_ColdDistributionInvoice_ColdDistributionRef_InvoiceRef] ON [DST].[ColdDistributionInvoice] 
(
	[ColdDistributionRef] ASC,
	[InvoiceRef] ASC
) ON [PRIMARY]

GO

--<< FOREIGNKEYS DEFINITION >>--
IF NOT EXISTS (SELECT 1 FROM sys.objects WHERE NAME = 'FK_ColdDistributionInvoice_ColdDistributionRef')
ALTER TABLE [DST].[ColdDistributionInvoice]  ADD CONSTRAINT [FK_ColdDistributionInvoice_ColdDistributionRef] FOREIGN KEY([ColdDistributionRef])
REFERENCES [DST].[ColdDistribution] ([ColdDistributionId])
ON DELETE CASCADE

GO

IF NOT EXISTS (SELECT 1 FROM sys.objects WHERE NAME = 'FK_ColdDistributionInvoice_InvoiceRef')
ALTER TABLE [DST].[ColdDistributionInvoice]  ADD CONSTRAINT [FK_ColdDistributionInvoice_InvoiceRef] FOREIGN KEY([InvoiceRef])
REFERENCES [SLS].[Invoice] ([InvoiceId])

GO

IF NOT EXISTS (SELECT 1 FROM sys.objects WHERE NAME = 'FK_ColdDistributionInvoice_UnexecutedActReasonRef')
ALTER TABLE [DST].[ColdDistributionInvoice]  ADD CONSTRAINT [FK_ColdDistributionInvoice_UnexecutedActReasonRef] FOREIGN KEY([UnexecutedActReasonRef])
REFERENCES [DST].[UnexecutedActReason] ([UnexecutedActReasonId])

GO

--<< DROP OBJECTS >>--
IF EXISTS (SELECT 1 FROM sys.indexes WHERE NAME = 'UIX_ColdDistributionInvoice_ColdDistributionRef_RowNumber')
DROP INDEX [UIX_ColdDistributionInvoice_ColdDistributionRef_RowNumber] ON [DST].[ColdDistributionInvoice] 

GO
