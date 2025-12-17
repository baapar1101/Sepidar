--<<FileName:DST_ColdDistributionReturnedInvoice.sql>>--

--<< TABLE DEFINITION >>--
IF Object_ID('DST.ColdDistributionReturnedInvoice') IS NULL
CREATE TABLE [DST].[ColdDistributionReturnedInvoice](
	[ColdDistributionReturnedInvoiceId]	[INT]	NOT NULL,
	[ColdDistributionRef]				[INT]	NOT NULL,
	[RowNumber]							[INT]	NOT NULL,
	[ReturnedInvoiceRef]				[INT]	NOT NULL,
	[UnexecutedActReasonRef]			[INT]	NULL,
	[DebtCollectionListAmount]					decimal(19, 4)	NULL,
	[DebtCollectionListDiscount]				decimal(19, 4)	NULL,
	[DebtCollectionListUnexecutedActReasonRef]	[INT]			NULL,
) ON [PRIMARY]

--TEXTIMAGE_ON [SGBlob_Data]
--When a table has text, ntext, image, varchar(max), nvarchar(max), varbinary(max), xml or large user defined type columns uncomment above code
GO
--<< ADD CLOLUMNS >>--

--<<Sample>>--
if not exists (select 1 from sys.columns where object_id=object_id('DST.ColdDistributionReturnedInvoice') and
				[name] = 'DebtCollectionListAmount')
begin
    Alter table DST.ColdDistributionReturnedInvoice Add DebtCollectionListAmount decimal(19, 4) NUll
end
GO
if not exists (select 1 from sys.columns where object_id=object_id('DST.ColdDistributionReturnedInvoice') and
				[name] = 'DebtCollectionListDiscount')
begin
    Alter table DST.ColdDistributionReturnedInvoice Add DebtCollectionListDiscount decimal(19, 4) NUll
end
GO
if not exists (select 1 from sys.columns where object_id=object_id('DST.ColdDistributionReturnedInvoice') and
				[name] = 'DebtCollectionListUnexecutedActReasonRef')
begin
    Alter table DST.ColdDistributionReturnedInvoice Add DebtCollectionListUnexecutedActReasonRef [INT] NUll
end
GO

--<< ALTER COLUMNS >>--

--<< PRIMARYKEY DEFINITION >>--
IF NOT EXISTS (SELECT 1 FROM sys.objects WHERE NAME = 'PK_ColdDistributionReturnedInvoice')
ALTER TABLE [DST].[ColdDistributionReturnedInvoice] ADD CONSTRAINT [PK_ColdDistributionReturnedInvoice] PRIMARY KEY CLUSTERED 
(
	[ColdDistributionReturnedInvoiceId] ASC
) ON [PRIMARY]
GO

--<< DEFAULTS CHECKS DEFINITION >>--

--<< RULES DEFINITION >>--

--<< INDEXES DEFINITION >>--
IF NOT EXISTS (SELECT 1 FROM sys.indexes WHERE NAME = 'UIX_ColdDistributionReturnedInvoice_ColdDistributionRef_ReturnedInvoiceRef')
CREATE UNIQUE NONCLUSTERED INDEX [UIX_ColdDistributionReturnedInvoice_ColdDistributionRef_ReturnedInvoiceRef] ON [DST].[ColdDistributionReturnedInvoice] 
(
	[ColdDistributionRef] ASC,
	[ReturnedInvoiceRef] ASC
) ON [PRIMARY]

GO

--<< FOREIGNKEYS DEFINITION >>--
IF NOT EXISTS (SELECT 1 FROM sys.objects WHERE NAME = 'FK_ColdDistributionReturnedInvoice_ColdDistributionRef')
ALTER TABLE [DST].[ColdDistributionReturnedInvoice]  ADD CONSTRAINT [FK_ColdDistributionReturnedInvoice_ColdDistributionRef] FOREIGN KEY([ColdDistributionRef])
REFERENCES [DST].[ColdDistribution] ([ColdDistributionId])
ON DELETE CASCADE

GO

IF NOT EXISTS (SELECT 1 FROM sys.objects WHERE NAME = 'FK_ColdDistributionReturnedInvoice_ReturnedInvoiceRef')
ALTER TABLE [DST].[ColdDistributionReturnedInvoice]  ADD CONSTRAINT [FK_ColdDistributionReturnedInvoice_ReturnedInvoiceRef] FOREIGN KEY([ReturnedInvoiceRef])
REFERENCES [SLS].[ReturnedInvoice] ([ReturnedInvoiceId])

GO

IF NOT EXISTS (SELECT 1 FROM sys.objects WHERE NAME = 'FK_ColdDistributionReturnedInvoice_UnexecutedActReasonRef')
ALTER TABLE [DST].[ColdDistributionReturnedInvoice]  ADD CONSTRAINT [FK_ColdDistributionReturnedInvoice_UnexecutedActReasonRef] FOREIGN KEY([UnexecutedActReasonRef])
REFERENCES [DST].[UnexecutedActReason] ([UnexecutedActReasonId])

GO

--<< DROP OBJECTS >>--
IF EXISTS (SELECT 1 FROM sys.indexes WHERE NAME = 'UIX_ColdDistributionReturnedInvoice_ColdDistributionRef_RowNumber')
DROP INDEX [UIX_ColdDistributionReturnedInvoice_ColdDistributionRef_RowNumber] ON [DST].[ColdDistributionReturnedInvoice] 

GO
