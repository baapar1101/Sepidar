--<<FileName:SLS_ReturnedInvoiceItemAdditionFactor.sql>>--
--<< TABLE DEFINITION >>--

If Object_ID('SLS.ReturnedInvoiceItemAdditionFactor') Is Null
CREATE TABLE [SLS].[ReturnedInvoiceItemAdditionFactor](
	[ReturnedInvoiceItemAdditionFactorID] [int] NOT NULL,
	[ReturnedInvoiceItemRef] [int] NOT NULL,
	[AdditionFactorRef] [int] NOT NULL,
	[Value] [decimal](19, 4) NOT NULL,
	[ValueInBaseCurrency] [decimal](19, 4) NOT NULL,
) ON [PRIMARY]

--TEXTIMAGE_ON [SGBlob_Data]
--When a table has text, ntext, image, varchar(max), nvarchar(max), varbinary(max), xml or large user defined type columns uncomment above code
GO
--<< ADD CLOLUMNS >>--

--<<Sample>>--
--if not exists (select 1 from sys.columns where object_id=object_id('SLS.ReturnedInvoiceItemAdditionFactor') and
--				[name] = 'Description')
--begin
--    Alter table SLS.ReturnedInvoiceItem Add Description NVARCHAR(255) NULL
--end
--GO

--<< ALTER COLUMNS >>--

--IF EXISTS (SELECT 1 FROM SYS.Columns WHERE object_id=object_id('SLS.ReturnedInvoiceItemAdditionFactor') AND
--				[name] = 'DiscountInBaseCurrency' AND is_nullable = 1)
--BEGIN
--	UPDATE SLS.ReturnedInvoiceItemAdditionFactor
--	SET DiscountInBaseCurrency = 0
--	WHERE DiscountInBaseCurrency IS NULL

--	ALTER TABLE SLS.ReturnedInvoiceItemAdditionFactor ALTER COLUMN [DiscountInBaseCurrency]  [decimal](19, 4) NOT NULL
--END

--<< PRIMARYKEY DEFINITION >>--

If not Exists (select 1 from sys.objects where name = 'PK_ReturnedInvoiceItemAdditionFactor')
ALTER TABLE [SLS].[ReturnedInvoiceItemAdditionFactor] ADD CONSTRAINT [PK_ReturnedInvoiceItemAdditionFactor] PRIMARY KEY CLUSTERED 
(
	[ReturnedInvoiceItemAdditionFactorID] ASC
) ON [PRIMARY]
GO

--<< DEFAULTS CHECKS DEFINITION >>--

--<< RULES DEFINITION >>--

--<< INDEXES DEFINITION >>--

IF NOT EXISTS (SELECT 1 FROM sys.indexes WHERE name = 'IX_ReturnedInvoiceItemAdditionFactor_ReturnedInvoiceItemRef')
	CREATE NONCLUSTERED INDEX IX_ReturnedInvoiceItemAdditionFactor_ReturnedInvoiceItemRef
		ON [SLS].[ReturnedInvoiceItemAdditionFactor] ([ReturnedInvoiceItemRef], [AdditionFactorRef])
GO

IF NOT EXISTS (SELECT 1 FROM sys.indexes WHERE name = 'IX_ReturnedInvoiceItemAdditionFactor_AdditionFactorRef')
	CREATE NONCLUSTERED INDEX [IX_ReturnedInvoiceItemAdditionFactor_AdditionFactorRef]
		ON [SLS].[ReturnedInvoiceItemAdditionFactor] ([AdditionFactorRef], [ReturnedInvoiceItemRef])
GO

--<< FOREIGNKEYS DEFINITION >>--

If not Exists (select 1 from sys.objects where name = 'FK_ReturnedInvoiceItemAdditionFactor_ReturnedInvoiceItemRef')
ALTER TABLE [SLS].[ReturnedInvoiceItemAdditionFactor] ADD CONSTRAINT [FK_ReturnedInvoiceItemAdditionFactor_ReturnedInvoiceItemRef] 
FOREIGN KEY([ReturnedInvoiceItemRef])
REFERENCES [SLS].[ReturnedInvoiceItem] ([ReturnedInvoiceItemID])
ON UPDATE CASCADE
ON DELETE CASCADE
GO

If not Exists (select 1 from sys.objects where name = 'FK_ReturnedInvoiceItemAdditionFactor_AdditionFactorRef')
ALTER TABLE [SLS].[ReturnedInvoiceItemAdditionFactor] ADD CONSTRAINT [FK_ReturnedInvoiceItemAdditionFactor_AdditionFactorRef] 
FOREIGN KEY([AdditionFactorRef])
REFERENCES [SLS].[AdditionFactor] ([AdditionFactorID])
GO

--<< DROP OBJECTS >>--
