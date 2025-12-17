--<<FileName:SLS_QuotationItemAdditionFactor.sql>>--
--<< TABLE DEFINITION >>--

If Object_ID('SLS.QuotationItemAdditionFactor') Is Null
CREATE TABLE [SLS].[QuotationItemAdditionFactor](
	[QuotationItemAdditionFactorID] [int] NOT NULL,
	[QuotationItemRef] [int] NOT NULL,
	[AdditionFactorRef] [int] NOT NULL,
	[Value] [decimal](19, 4) NOT NULL,
	[ValueInBaseCurrency] [decimal](19, 4) NOT NULL,
) ON [PRIMARY]

--TEXTIMAGE_ON [SGBlob_Data]
--When a table has text, ntext, image, varchar(max), nvarchar(max), varbinary(max), xml or large user defined type columns uncomment above code
GO
--<< ADD CLOLUMNS >>--

--<<Sample>>--
--if not exists (select 1 from sys.columns where object_id=object_id('SLS.QuotationItemAdditionFactor') and
--				[name] = 'Description')
--begin
--    Alter table SLS.QuotationItem Add Description NVARCHAR(255) NULL
--end
--GO

--<< ALTER COLUMNS >>--

--IF EXISTS (SELECT 1 FROM SYS.Columns WHERE object_id=object_id('SLS.QuotationItemAdditionFactor') AND
--				[name] = 'DiscountInBaseCurrency' AND is_nullable = 1)
--BEGIN
--	UPDATE SLS.QuotationItemAdditionFactor
--	SET DiscountInBaseCurrency = 0
--	WHERE DiscountInBaseCurrency IS NULL

--	ALTER TABLE SLS.QuotationItemAdditionFactor ALTER COLUMN [DiscountInBaseCurrency]  [decimal](19, 4) NOT NULL
--END

--<< PRIMARYKEY DEFINITION >>--

If not Exists (select 1 from sys.objects where name = 'PK_QuotationItemAdditionFactor')
ALTER TABLE [SLS].[QuotationItemAdditionFactor] ADD CONSTRAINT [PK_QuotationItemAdditionFactor] PRIMARY KEY CLUSTERED 
(
	[QuotationItemAdditionFactorID] ASC
) ON [PRIMARY]
GO

--<< DEFAULTS CHECKS DEFINITION >>--

--<< RULES DEFINITION >>--

--<< INDEXES DEFINITION >>--

IF NOT EXISTS (SELECT 1 FROM sys.indexes WHERE name = 'IX_QuotationItemAdditionFactor_QuotationItemRef')
	CREATE NONCLUSTERED INDEX IX_QuotationItemAdditionFactor_QuotationItemRef
		ON [SLS].[QuotationItemAdditionFactor] ([QuotationItemRef], [AdditionFactorRef])
GO

IF NOT EXISTS (SELECT 1 FROM sys.indexes WHERE name = 'IX_QuotationItemAdditionFactor_AdditionFactorRef')
	CREATE NONCLUSTERED INDEX [IX_QuotationItemAdditionFactor_AdditionFactorRef]
		ON [SLS].[QuotationItemAdditionFactor] ([AdditionFactorRef], [QuotationItemRef])
GO

--<< FOREIGNKEYS DEFINITION >>--

If not Exists (select 1 from sys.objects where name = 'FK_QuotationItemAdditionFactor_QuotationItemRef')
ALTER TABLE [SLS].[QuotationItemAdditionFactor] ADD CONSTRAINT [FK_QuotationItemAdditionFactor_QuotationItemRef] 
FOREIGN KEY([QuotationItemRef])
REFERENCES [SLS].[QuotationItem] ([QuotationItemID])
ON UPDATE CASCADE
ON DELETE CASCADE
GO

If not Exists (select 1 from sys.objects where name = 'FK_QuotationItemAdditionFactor_AdditionFactorRef')
ALTER TABLE [SLS].[QuotationItemAdditionFactor] ADD CONSTRAINT [FK_QuotationItemAdditionFactor_AdditionFactorRef] 
FOREIGN KEY([AdditionFactorRef])
REFERENCES [SLS].[AdditionFactor] ([AdditionFactorID])
GO

--<< DROP OBJECTS >>--
