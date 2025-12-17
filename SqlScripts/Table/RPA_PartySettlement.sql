--<< TABLE DEFINITION >>--
IF Object_ID('RPA.PartySettlement') IS NULL
CREATE TABLE [RPA].[PartySettlement](
	[PartySettlementID] [int] NOT NULL,
	[Number] [int] NOT NULL,
	[Date] [datetime] NOT NULL,
	[State] [int] NOT NULL,
	[PartyRef] [int] NOT NULL,
	[CurrencyRef] [int] NOT NULL,
	[Rate] [decimal](26, 16) NOT NULL,
	[SettlementByRemainingAmount] [decimal](19,4) NOT NULL,
	[SettlementByRemainingAmountInBaseCurrency] [decimal](19,4) NOT NULL,
	[SettlementByRemainingRate] [decimal](26, 16) NOT NULL,
	[ReceiptHeaderRef] [int] NULL,
	[PaymentHeaderRef] [int] NULL,
	[SettlementType] [int] NOT NULL,
	[Description] [nvarchar](4000) NULL,
	[FiscalYearRef] [int] NOT NULL,
	[VoucherRef] [int] NULL,
	[CreatorForm] [nvarchar](50) NOT NULL,
	[Creator] [int] NOT NULL,
	[CreationDate] [datetime] NOT NULL,
	[LastModifier] [int] NOT NULL,
	[LastModificationDate] [datetime] NOT NULL,
	[Version] [int] NOT NULL
) ON [PRIMARY]

--TEXTIMAGE_ON [SGBlob_Data]
--When a table has text, ntext, image, varchar(max), nvarchar(max), varbinary(max), xml or large user defined type columns uncomment above code
GO

--<< ADD CLOLUMNS >>--

IF NOT EXISTS (SELECT 1 FROM sys.columns WHERE object_id = object_id('RPA.PartySettlement') AND
				[name] = 'VoucherRef')
BEGIN
    ALTER TABLE RPA.PartySettlement ADD VoucherRef [int] NULL
END
GO

IF NOT EXISTS (SELECT 1 FROM sys.columns WHERE object_id = object_id('RPA.PartySettlement') AND
				[name] = 'PaymentHeaderRef')
BEGIN
    ALTER TABLE RPA.PartySettlement ADD PaymentHeaderRef [int] NULL
END
GO

IF NOT EXISTS (SELECT 1 FROM sys.columns WHERE object_id = object_id('RPA.PartySettlement') AND
				[name] = 'SettlementType')
BEGIN
    ALTER TABLE RPA.PartySettlement ADD SettlementType [int] NULL
	EXEC ('UPDATE RPA.PartySettlement SET SettlementType = 1')
	ALTER TABLE RPA.PartySettlement ALTER COLUMN SettlementType [int] NOT NULL
END
GO

--<< ALTER COLUMNS >>--

--<< PRIMARYKEY DEFINITION >>--

IF NOT EXISTS (SELECT 1 FROM sys.objects WHERE name = 'PK_PartySettlement')
ALTER TABLE [RPA].[PartySettlement] ADD CONSTRAINT [PK_PartySettlement] PRIMARY KEY CLUSTERED 
(
	[PartySettlementID] ASC
) ON [PRIMARY]
GO

--<< DEFAULTS CHECKS DEFINITION >>--

--<< RULES DEFINITION >>--

--<< INDEXES DEFINITION >>--

--<< FOREIGNKEYS DEFINITION >>--

IF NOT EXISTS (SELECT 1 FROM sys.objects WHERE name = 'FK_PartySettlement_FiscalYear')
BEGIN
	ALTER TABLE [RPA].[PartySettlement] 
	ADD CONSTRAINT [FK_PartySettlement_FiscalYear] FOREIGN KEY([FiscalYearRef])
		REFERENCES [FMK].[FiscalYear] ([FiscalYearID])
END
GO

IF EXISTS (select 1 from sys.objects where name = 'FK_PartySettlement_VoucherRef')
	ALTER TABLE [RPA].[PartySettlement]  DROP CONSTRAINT [FK_PartySettlement_VoucherRef] 
GO

IF EXISTS (select 1 from sys.objects where name = 'FK_PartySettlement_CurrencyRef')
	ALTER TABLE [RPA].[PartySettlement]  DROP CONSTRAINT [FK_PartySettlement_CurrencyRef] 
GO

IF EXISTS (select 1 from sys.objects where name = 'FK_PartySettlement_PaymentHeaderRef')
	ALTER TABLE [RPA].[PartySettlement]  DROP CONSTRAINT [FK_PartySettlement_PaymentHeaderRef] 
GO

IF EXISTS (select 1 from sys.objects where name = 'FK_PartySettlement_ReceiptHeader')
	ALTER TABLE [RPA].[PartySettlement]  DROP CONSTRAINT [FK_PartySettlement_ReceiptHeader] 
GO

IF EXISTS (select 1 from sys.objects where name = 'FK_PartySettlement_Party')
	ALTER TABLE [RPA].[PartySettlement]  DROP CONSTRAINT [FK_PartySettlement_Party] 
GO
--<< DROP OBJECTS >>--
