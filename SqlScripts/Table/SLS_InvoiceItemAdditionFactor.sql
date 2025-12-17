--<<FileName:SLS_InvoiceItemAdditionFactor.sql>>--
--<< TABLE DEFINITION >>--

If Object_ID('SLS.InvoiceItemAdditionFactor') Is Null
CREATE TABLE [SLS].[InvoiceItemAdditionFactor](
	[InvoiceItemAdditionFactorID] [int] NOT NULL,
	[InvoiceItemRef] [int] NOT NULL,
	[AdditionFactorRef] [int] NOT NULL,
	[Value] [decimal](19, 4) NOT NULL,
	[ValueInBaseCurrency] [decimal](19, 4) NOT NULL,
) ON [PRIMARY]

--TEXTIMAGE_ON [SGBlob_Data]
--When a table has text, ntext, image, varchar(max), nvarchar(max), varbinary(max), xml or large user defined type columns uncomment above code
GO
--<< ADD CLOLUMNS >>--

--<<Sample>>--
--if not exists (select 1 from sys.columns where object_id=object_id('SLS.InvoiceItemAdditionFactor') and
--				[name] = 'Description')
--begin
--    Alter table SLS.InvoiceItem Add Description NVARCHAR(255) NULL
--end
--GO

--<< ALTER COLUMNS >>--

--IF EXISTS (SELECT 1 FROM SYS.Columns WHERE object_id=object_id('SLS.InvoiceItemAdditionFactor') AND
--				[name] = 'DiscountInBaseCurrency' AND is_nullable = 1)
--BEGIN
--	UPDATE SLS.InvoiceItemAdditionFactor
--	SET DiscountInBaseCurrency = 0
--	WHERE DiscountInBaseCurrency IS NULL

--	ALTER TABLE SLS.InvoiceItemAdditionFactor ALTER COLUMN [DiscountInBaseCurrency]  [decimal](19, 4) NOT NULL
--END

--<< PRIMARYKEY DEFINITION >>--

If not Exists (select 1 from sys.objects where name = 'PK_InvoiceItemAdditionFactor')
ALTER TABLE [SLS].[InvoiceItemAdditionFactor] ADD CONSTRAINT [PK_InvoiceItemAdditionFactor] PRIMARY KEY CLUSTERED 
(
	[InvoiceItemAdditionFactorID] ASC
) ON [PRIMARY]
GO

--<< DEFAULTS CHECKS DEFINITION >>--

--<< RULES DEFINITION >>--

--<< INDEXES DEFINITION >>--

IF NOT EXISTS (SELECT 1 FROM sys.indexes WHERE name = 'IX_InvoiceItemAdditionFactor_InvoiceItemRef')
	CREATE NONCLUSTERED INDEX IX_InvoiceItemAdditionFactor_InvoiceItemRef
		ON [SLS].[InvoiceItemAdditionFactor] ([InvoiceItemRef], [AdditionFactorRef])
GO

IF NOT EXISTS (SELECT 1 FROM sys.indexes WHERE name = 'IX_InvoiceItemAdditionFactor_AdditionFactorRef')
	CREATE NONCLUSTERED INDEX [IX_InvoiceItemAdditionFactor_AdditionFactorRef]
		ON [SLS].[InvoiceItemAdditionFactor] ([AdditionFactorRef], [InvoiceItemRef])
GO

--<< FOREIGNKEYS DEFINITION >>--

If not Exists (select 1 from sys.objects where name = 'FK_InvoiceItemAdditionFactor_InvoiceItemRef')
ALTER TABLE [SLS].[InvoiceItemAdditionFactor] ADD CONSTRAINT [FK_InvoiceItemAdditionFactor_InvoiceItemRef] 
FOREIGN KEY([InvoiceItemRef])
REFERENCES [SLS].[InvoiceItem] ([InvoiceItemID])
ON UPDATE CASCADE
ON DELETE CASCADE
GO

If not Exists (select 1 from sys.objects where name = 'FK_InvoiceItemAdditionFactor_AdditionFactorRef')
ALTER TABLE [SLS].[InvoiceItemAdditionFactor] ADD CONSTRAINT [FK_InvoiceItemAdditionFactor_AdditionFactorRef] 
FOREIGN KEY([AdditionFactorRef])
REFERENCES [SLS].[AdditionFactor] ([AdditionFactorID])
GO

--<< DROP OBJECTS >>--
