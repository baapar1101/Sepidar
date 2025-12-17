--<< TABLE DEFINITION >>--

IF Object_ID('RPA.PartySettlementItem') IS NULL
CREATE TABLE [RPA].[PartySettlementItem](
	[PartySettlementItemID] [int] NOT NULL,
	[PartySettlementRef] [int] NOT NULL,
	[InvoiceRef] [int] NULL,
	[CommissionCalculationRef] [int] NULL,
	[CurrencyRef] [int] NOT NULL,
	[Rate] [decimal](26, 16) NOT NULL,
	[Amount] [decimal](30, 4) NOT NULL,
	[AmountInBaseCurrency] [decimal](30, 4) NOT NULL,
	[RemainingAmount] [decimal](30, 4) NOT NULL,
) ON [PRIMARY]

--TEXTIMAGE_ON [SGBlob_Data]
--When a table has text, ntext, image, varchar(max), nvarchar(max), varbinary(max), xml or large user defined type columns uncomment above code

--<< ADD CLOLUMNS >>--
--<<Sample>>--
IF NOT EXISTS (SELECT 1 FROM sys.columns WHERE object_id = object_id('RPA.PartySettlementItem') AND
				[name] = 'CommissionCalculationRef')
BEGIN
    ALTER TABLE RPA.PartySettlementItem ADD CommissionCalculationRef [int] NULL
END
GO

--<< ALTER COLUMNS >>--

IF EXISTS (SELECT 1 FROM sys.columns WHERE object_id = object_id('RPA.PartySettlementItem') AND
				[name] = 'Amount')
BEGIN
    ALTER TABLE RPA.PartySettlementItem ALTER COLUMN Amount [decimal](30, 4) NOT NULL
END
GO

IF EXISTS (SELECT 1 FROM sys.columns WHERE object_id = object_id('RPA.PartySettlementItem') AND
				[name] = 'AmountInBaseCurrency')
BEGIN
    ALTER TABLE RPA.PartySettlementItem ALTER COLUMN AmountInBaseCurrency [decimal](30, 4) NOT NULL
END
GO

IF EXISTS (SELECT 1 FROM sys.columns WHERE object_id = object_id('RPA.PartySettlementItem') AND
				[name] = 'RemainingAmount')
BEGIN
    ALTER TABLE RPA.PartySettlementItem ALTER COLUMN RemainingAmount [decimal](30, 4) NOT NULL
END
GO

--<< PRIMARYKEY DEFINITION >>--

IF NOT EXISTS (SELECT 1 FROM sys.objects WHERE name = 'PK_PartySettlementItem')
BEGIN
	ALTER TABLE [RPA].[PartySettlementItem] ADD CONSTRAINT [PK_PartySettlementItem] PRIMARY KEY CLUSTERED 
	(
		[PartySettlementItemID] ASC
	) ON [PRIMARY]
END
GO

--<< DEFAULTS CHECKS DEFINITION >>--

--<< RULES DEFINITION >>--

--<< INDEXES DEFINITION >>--

--<< FOREIGNKEYS DEFINITION >>--

IF NOT EXISTS (SELECT 1 FROM sys.objects WHERE name = 'FK_PartySettlementItem_PartySettlement')
BEGIN
	ALTER TABLE [RPA].[PartySettlementItem]
	ADD CONSTRAINT [FK_PartySettlementItem_PartySettlement] FOREIGN KEY([PartySettlementRef])
	REFERENCES [RPA].[PartySettlement] ([PartySettlementID])
	ON DELETE CASCADE
END
GO

--<< DROP OBJECTS >>--


IF EXISTS (select 1 from sys.objects where name = 'FK_PartySettlementItem_CommissionCalculationRef')
	ALTER TABLE [RPA].[PartySettlementItem]  DROP CONSTRAINT [FK_PartySettlementItem_CommissionCalculationRef] 

GO


IF EXISTS (select 1 from sys.objects where name = 'FK_PartySettlementItem_Invoice')
	ALTER TABLE [RPA].[PartySettlementItem]  DROP CONSTRAINT [FK_PartySettlementItem_Invoice] 

GO

IF EXISTS (select 1 from sys.objects where name = 'FK_PartySettlementItem_CurrencyRef')
	ALTER TABLE [RPA].[PartySettlementItem]  DROP CONSTRAINT [FK_PartySettlementItem_CurrencyRef] 

GO



