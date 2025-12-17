--<<FileName:DST_OrderItemAdditionFactor.sql>>--
--<< TABLE DEFINITION >>--

If Object_ID('DST.OrderItemAdditionFactor') Is Null
CREATE TABLE [DST].[OrderItemAdditionFactor](
	[OrderItemAdditionFactorID] [int] NOT NULL,
	[OrderItemRef] [int] NOT NULL,
	[AdditionFactorRef] [int] NOT NULL,
	[Value] [decimal](19, 4) NOT NULL,
	[ValueInBaseCurrency] [decimal](19, 4) NOT NULL,
) ON [PRIMARY]

--TEXTIMAGE_ON [SGBlob_Data]
--When a table has text, ntext, image, varchar(max), nvarchar(max), varbinary(max), xml or large user defined type columns uncomment above code
GO
--<< ADD CLOLUMNS >>--

--<<Sample>>--
--if not exists (select 1 from sys.columns where object_id=object_id('DST.OrderItemAdditionFactor') and
--				[name] = 'Description')
--begin
--    Alter table DST.OrderItem Add Description NVARCHAR(255) NULL
--end
--GO

--<< ALTER COLUMNS >>--

--IF EXISTS (SELECT 1 FROM SYS.Columns WHERE object_id=object_id('DST.OrderItemAdditionFactor') AND
--				[name] = 'DiscountInBaseCurrency' AND is_nullable = 1)
--BEGIN
--	UPDATE DST.OrderItemAdditionFactor
--	SET DiscountInBaseCurrency = 0
--	WHERE DiscountInBaseCurrency IS NULL

--	ALTER TABLE DST.OrderItemAdditionFactor ALTER COLUMN [DiscountInBaseCurrency]  [decimal](19, 4) NOT NULL
--END

--<< PRIMARYKEY DEFINITION >>--

If not Exists (select 1 from sys.objects where name = 'PK_OrderItemAdditionFactor')
ALTER TABLE [DST].[OrderItemAdditionFactor] ADD CONSTRAINT [PK_OrderItemAdditionFactor] PRIMARY KEY CLUSTERED 
(
	[OrderItemAdditionFactorID] ASC
) ON [PRIMARY]
GO

--<< DEFAULTS CHECKS DEFINITION >>--

--<< RULES DEFINITION >>--

--<< INDEXES DEFINITION >>--

IF NOT EXISTS (SELECT 1 FROM sys.indexes WHERE name = 'IX_OrderItemAdditionFactor_OrderItemRef')
	CREATE NONCLUSTERED INDEX IX_OrderItemAdditionFactor_OrderItemRef
		ON [DST].[OrderItemAdditionFactor] ([OrderItemRef], [AdditionFactorRef])
GO

IF NOT EXISTS (SELECT 1 FROM sys.indexes WHERE name = 'IX_OrderItemAdditionFactor_AdditionFactorRef')
	CREATE NONCLUSTERED INDEX [IX_OrderItemAdditionFactor_AdditionFactorRef]
		ON [DST].[OrderItemAdditionFactor] ([AdditionFactorRef], [OrderItemRef])
GO

--<< FOREIGNKEYS DEFINITION >>--

If not Exists (select 1 from sys.objects where name = 'FK_OrderItemAdditionFactor_OrderItemRef')
ALTER TABLE [DST].[OrderItemAdditionFactor] ADD CONSTRAINT [FK_OrderItemAdditionFactor_OrderItemRef] 
FOREIGN KEY([OrderItemRef])
REFERENCES [DST].[OrderItem] ([OrderItemID])
ON UPDATE CASCADE
ON DELETE CASCADE
GO

If not Exists (select 1 from sys.objects where name = 'FK_OrderItemAdditionFactor_AdditionFactorRef')
ALTER TABLE [DST].[OrderItemAdditionFactor] ADD CONSTRAINT [FK_OrderItemAdditionFactor_AdditionFactorRef] 
FOREIGN KEY([AdditionFactorRef])
REFERENCES [SLS].[AdditionFactor] ([AdditionFactorID])
GO

--<< DROP OBJECTS >>--
