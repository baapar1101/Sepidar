--drop  TABLE [RPA].[PartyAccountSettlement]
--<< TABLE DEFINITION >>--
IF Object_ID('RPA.PartyAccountSettlement') IS NULL
CREATE TABLE [RPA].[PartyAccountSettlement](
	[PartyAccountSettlementID] [int] NOT NULL,
	[Number] [int] NOT NULL,
	[Date] [datetime] NOT NULL,
	[State] [int] NOT NULL,
	[PartyRef] [int] NOT NULL,
	[PartyAccountSettlementType] [int] NOT NULL,
	[CurrencyRef] [int] NOT NULL,
	[Rate] [decimal](26, 16) NOT NULL,	
	[Description] [nvarchar](4000) NULL,
	[Description_En] [nvarchar](4000) NULL,
	[FiscalYearRef] [int] NOT NULL,
	[VoucherRef] [int] NULL,
	[CreatorForm] [nvarchar](50) NOT NULL,
	[Creator] [int] NOT NULL,
	[CreationDate] [datetime] NOT NULL,
	[LastModifier] [int] NOT NULL,
	[LastModificationDate] [datetime] NOT NULL,
	[Version] [int] NOT NULL,
	[OldPartySettlementID] [int] NULL,
) ON [PRIMARY]

--TEXTIMAGE_ON [SGBlob_Data]
--When a table has text, ntext, image, varchar(max), nvarchar(max), varbinary(max), xml or large user defined type columns uncomment above code
GO



--<< ALTER COLUMNS >>--

--<< PRIMARYKEY DEFINITION >>--

IF NOT EXISTS (SELECT 1 FROM sys.objects WHERE name = 'PK_PartyAccountSettlementID')
ALTER TABLE [RPA].[PartyAccountSettlement] ADD CONSTRAINT [PK_PartyAccountSettlementID] PRIMARY KEY CLUSTERED 
(
	[PartyAccountSettlementID] ASC
) ON [PRIMARY]
GO

--<< DEFAULTS CHECKS DEFINITION >>--

--<< RULES DEFINITION >>--

--<< INDEXES DEFINITION >>--

--<< FOREIGNKEYS DEFINITION >>--

IF NOT EXISTS (SELECT 1 FROM sys.objects WHERE name = 'FK_PartyAccountSettlement_FiscalYear')
BEGIN
	ALTER TABLE [RPA].[PartyAccountSettlement] 
	ADD CONSTRAINT [FK_PartyAccountSettlement_FiscalYear] FOREIGN KEY([FiscalYearRef])
		REFERENCES [FMK].[FiscalYear] ([FiscalYearID])
END
GO

IF NOT EXISTS (SELECT 1 FROM sys.objects WHERE name = 'FK_PartyAccountSettlement_Party')
BEGIN
	ALTER TABLE [RPA].[PartyAccountSettlement]
	ADD CONSTRAINT [FK_PartyAccountSettlement_Party] FOREIGN KEY([PartyRef])
		REFERENCES [GNR].[Party] ([PartyId])
END
GO



IF NOT EXISTS (SELECT 1 FROM sys.objects WHERE name = 'FK_PartyAccountSettlement_CurrencyRef')
BEGIN
	ALTER TABLE [RPA].[PartyAccountSettlement] 
	ADD CONSTRAINT [FK_PartyAccountSettlement_CurrencyRef] FOREIGN KEY([CurrencyRef])
	REFERENCES [GNR].[Currency] ([CurrencyID])
END

IF NOT EXISTS (SELECT 1 FROM sys.objects WHERE name = 'FK_PartyAccountSettlement_VoucherRef')
ALTER TABLE [RPA].[PartyAccountSettlement] ADD CONSTRAINT [FK_PartyAccountSettlement_VoucherRef] FOREIGN KEY([VoucherRef])
REFERENCES [ACC].[Voucher] ([VoucherId])

--<< DROP OBJECTS >>--
