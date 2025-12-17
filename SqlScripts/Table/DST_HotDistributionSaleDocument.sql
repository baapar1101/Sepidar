--<<FileName:DST_HotDistributionSaleDocument.sql>>--

--<< TABLE DEFINITION >>--
IF OBJECT_ID('DST.HotDistributionSaleDocument') IS NULL
CREATE TABLE [DST].[HotDistributionSaleDocument](
	[HotDistributionSaleDocumentId]	[INT]	NOT NULL,
	[HotDistributionRef]			[INT]	NOT NULL,
	[InvoiceRef]					[INT]	NULL,
	[ReturnedInvoiceRef]			[INT]	NULL,
	[IsDocCreatedByHotDistribution] [BIT]   NOT NULL,
) ON [PRIMARY]

--TEXTIMAGE_ON [SGBlob_Data]
--When a table has text, ntext, image, varchar(max), nvarchar(max), varbinary(max), xml or large user defined type columns uncomment above code
GO

--<< ADD CLOLUMNS >>--
IF NOT EXISTS (SELECT 1 FROM [sys].[columns] WHERE [object_id]=OBJECT_ID('DST.HotDistributionSaleDocument') AND [name] = 'IsDocCreatedByHotDistribution')
BEGIN
	ALTER TABLE [DST].[HotDistributionSaleDocument] ADD [IsDocCreatedByHotDistribution] [BIT] NOT NULL DEFAULT 0
END
--<<Sample>>--
/*IF NOT EXISTS (SELECT 1 FROM sys.columns WHERE OBJECT_ID=OBJECT_ID('SLS.HotDistributionSaleDocument') AND
				[name] = 'ColumnName')
BEGIN
    ALTER TABLE SLS.HotDistributionSaleDocument ADD ColumnName DataType Nullable
END
GO*/

--<< ALTER COLUMNS >>--

--<< PRIMARYKEY DEFINITION >>--
IF NOT EXISTS (SELECT 1 FROM sys.objects WHERE name = 'PK_HotDistributionSaleDocument')
ALTER TABLE [DST].[HotDistributionSaleDocument] ADD CONSTRAINT [PK_HotDistributionSaleDocument] PRIMARY KEY CLUSTERED 
(
	[HotDistributionSaleDocumentId] ASC
) ON [PRIMARY]

GO

--<< DEFAULTS CHECKS DEFINITION >>--

--<< RULES DEFINITION >>--

--<< INDEXES DEFINITION >>--
IF NOT EXISTS (SELECT 1 FROM sys.indexes WHERE name = 'UIX_HotDistributionSaleDocument_HotDistributionRef_InvoiceRef_ReturnedInvoiceRef')
CREATE UNIQUE NONCLUSTERED INDEX [UIX_HotDistributionSaleDocument_HotDistributionRef_InvoiceRef_ReturnedInvoiceRef] ON [DST].[HotDistributionSaleDocument] 
(
	[HotDistributionRef] ASC,
	[InvoiceRef] ASC,
	[ReturnedInvoiceRef] ASC
) ON [PRIMARY]

GO

IF NOT EXISTS (SELECT 1 FROM sys.indexes WHERE name = 'IX_HotDistributionSaleDocument_InvoiceRef')
CREATE NONCLUSTERED INDEX [IX_HotDistributionSaleDocument_InvoiceRef] ON [DST].[HotDistributionSaleDocument] 
(
	[InvoiceRef] ASC
) ON [PRIMARY]

GO

--<< FOREIGNKEYS DEFINITION >>--
IF NOT EXISTS (SELECT 1	FROM sys.objects WHERE name = 'FK_HotDistributionSaleDocument_HotDistributionRef')
	ALTER TABLE [DST].[HotDistributionSaleDocument] ADD CONSTRAINT [FK_HotDistributionSaleDocument_HotDistributionRef] FOREIGN KEY ([HotDistributionRef])
	REFERENCES [DST].[HotDistribution] ([HotDistributionId])
	ON DELETE CASCADE

GO

IF NOT EXISTS (SELECT 1 FROM sys.objects WHERE name = 'FK_HotDistributionSaleDocument_InvoiceRef')
	ALTER TABLE [DST].[HotDistributionSaleDocument] ADD CONSTRAINT [FK_HotDistributionSaleDocument_InvoiceRef] FOREIGN KEY([InvoiceRef])
	REFERENCES [SLS].[Invoice] ([InvoiceId])

GO

IF NOT EXISTS (SELECT 1 FROM sys.objects WHERE name = 'FK_HotDistributionSaleDocument_ReturnedInvoiceRef')
	ALTER TABLE [DST].[HotDistributionSaleDocument] ADD CONSTRAINT [FK_HotDistributionSaleDocument_ReturnedInvoiceRef] FOREIGN KEY([ReturnedInvoiceRef])
	REFERENCES [SLS].[ReturnedInvoice] ([ReturnedInvoiceId])

GO

--<< DROP OBJECTS >>--
IF EXISTS (SELECT 1 FROM sys.indexes WHERE name = 'UIX_HotDistributionSaleDocument_HotDistributionRef_InvoiceRef')	-- ToDo: Remove before Release
DROP INDEX [UIX_HotDistributionSaleDocument_HotDistributionRef_InvoiceRef] ON [DST].[HotDistributionSaleDocument] 

GO
