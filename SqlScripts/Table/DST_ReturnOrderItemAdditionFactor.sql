--<<FileName:DST_ReturnOrderItemAdditionFactor.sql>>--
--<< TABLE DEFINITION >>--

If Object_ID('DST.ReturnOrderItemAdditionFactor') Is Null
CREATE TABLE [DST].[ReturnOrderItemAdditionFactor](
	[ReturnOrderItemAdditionFactorID] [int] NOT NULL,
	[ReturnOrderItemRef] [int] NOT NULL,
	[AdditionFactorRef] [int] NOT NULL,
	[Value] [decimal](19, 4) NOT NULL,
	[ValueInBaseCurrency] [decimal](19, 4) NOT NULL,
) ON [PRIMARY]

--TEXTIMAGE_ON [SGBlob_Data]
--When a table has text, ntext, image, varchar(max), nvarchar(max), varbinary(max), xml or large user defined type columns uncomment above code
GO
--<< ADD CLOLUMNS >>--

--<<Sample>>--
--if not exists (select 1 from sys.columns where object_id=object_id('DST.ReturnOrderItemAdditionFactor') and
--				[name] = 'Description')
--begin
--    Alter table DST.ReturnOrderItem Add Description NVARCHAR(255) NULL
--end
--GO

--<< ALTER COLUMNS >>--

--IF EXISTS (SELECT 1 FROM SYS.Columns WHERE object_id=object_id('DST.ReturnOrderItemAdditionFactor') AND
--				[name] = 'DiscountInBaseCurrency' AND is_nullable = 1)
--BEGIN
--	UPDATE DST.ReturnOrderItemAdditionFactor
--	SET DiscountInBaseCurrency = 0
--	WHERE DiscountInBaseCurrency IS NULL

--	ALTER TABLE DST.ReturnOrderItemAdditionFactor ALTER COLUMN [DiscountInBaseCurrency]  [decimal](19, 4) NOT NULL
--END

--<< PRIMARYKEY DEFINITION >>--

If not Exists (select 1 from sys.objects where name = 'PK_ReturnOrderItemAdditionFactor')
ALTER TABLE [DST].[ReturnOrderItemAdditionFactor] ADD CONSTRAINT [PK_ReturnOrderItemAdditionFactor] PRIMARY KEY CLUSTERED 
(
	[ReturnOrderItemAdditionFactorID] ASC
) ON [PRIMARY]
GO

--<< DEFAULTS CHECKS DEFINITION >>--

--<< RULES DEFINITION >>--

--<< INDEXES DEFINITION >>--

IF NOT EXISTS (SELECT 1 FROM sys.indexes WHERE name = 'IX_ReturnOrderItemAdditionFactor_ReturnOrderItemRef')
	CREATE NONCLUSTERED INDEX IX_ReturnOrderItemAdditionFactor_ReturnOrderItemRef
		ON [DST].[ReturnOrderItemAdditionFactor] ([ReturnOrderItemRef], [AdditionFactorRef])
GO

IF NOT EXISTS (SELECT 1 FROM sys.indexes WHERE name = 'IX_ReturnOrderItemAdditionFactor_AdditionFactorRef')
	CREATE NONCLUSTERED INDEX [IX_ReturnOrderItemAdditionFactor_AdditionFactorRef]
		ON [DST].[ReturnOrderItemAdditionFactor] ([AdditionFactorRef], [ReturnOrderItemRef])
GO

--<< FOREIGNKEYS DEFINITION >>--

If not Exists (select 1 from sys.objects where name = 'FK_ReturnOrderItemAdditionFactor_ReturnOrderItemRef')
ALTER TABLE [DST].[ReturnOrderItemAdditionFactor] ADD CONSTRAINT [FK_ReturnOrderItemAdditionFactor_ReturnOrderItemRef] 
FOREIGN KEY([ReturnOrderItemRef])
REFERENCES [DST].[ReturnOrderItem] ([ReturnOrderItemID])
ON UPDATE CASCADE
ON DELETE CASCADE
GO

If not Exists (select 1 from sys.objects where name = 'FK_ReturnOrderItemAdditionFactor_AdditionFactorRef')
ALTER TABLE [DST].[ReturnOrderItemAdditionFactor] ADD CONSTRAINT [FK_ReturnOrderItemAdditionFactor_AdditionFactorRef] 
FOREIGN KEY([AdditionFactorRef])
REFERENCES [SLS].[AdditionFactor] ([AdditionFactorID])
GO

--<< DROP OBJECTS >>--
