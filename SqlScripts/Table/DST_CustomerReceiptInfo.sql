--<<FileName:DST_CustomerReceiptInfo.sql>>--

--<< TABLE DEFINITION >>--
IF Object_ID('DST.CustomerReceiptInfo') IS NULL
CREATE TABLE [DST].[CustomerReceiptInfo](
	[CustomerReceiptInfoId]	    [INT]		        NOT NULL,
	[CustomerPartyRef]          [INT]	            NOT NULL,
	[PartyAccountSettlementRef]	[INT]				NULL,
	[DebtCollectionListRef]     [INT]	            NULL,
	[ColdDistributionRef]       [INT]	            NULL,
	[CurrencyRef]               [INT]	            NOT NULL,
	[ReceiptAmount]				decimal(19, 4)		NOT NULL,
	[ReceiptDraftAmount] 		decimal(19, 4)	    NOT NULL
) ON [PRIMARY]

--TEXTIMAGE_ON [SGBlob_Data]
--When a table has text, ntext, image, varchar(max), nvarchar(max), varbinary(max), xml or large user defined type columns uncomment above code

GO
--<< ADD CLOLUMNS >>--
--<<Sample>>--
/*if not exists (select 1 from sys.columns where object_id=object_id('DST.AreaAndPath') and
				[name] = 'ColumnName')
begin
    Alter table DST.AreaAndPath Add ColumnName DataType Nullable
end
GO*/

--<< ALTER COLUMNS >>--

--<< PRIMARYKEY DEFINITION >>--
IF NOT EXISTS (SELECT 1 FROM sys.objects WHERE NAME = 'PK_CustomerReceiptInfo')
ALTER TABLE [DST].[CustomerReceiptInfo] ADD CONSTRAINT [PK_CustomerReceiptInfo] PRIMARY KEY CLUSTERED
(
	[CustomerReceiptInfoId] ASC
) ON [PRIMARY]
GO

--<< DEFAULTS CHECKS DEFINITION >>--

--<< RULES DEFINITION >>--

--<< INDEXES DEFINITION >>--

--<< FOREIGNKEYS DEFINITION >>--
IF NOT EXISTS (SELECT 1 FROM sys.objects WHERE NAME = 'FK_CustomerReceiptInfo_CustomerPartyRef')
ALTER TABLE [DST].[CustomerReceiptInfo] ADD CONSTRAINT [FK_CustomerReceiptInfo_CustomerPartyRef] FOREIGN KEY([CustomerPartyRef])
REFERENCES [GNR].[Party] ([PartyId])

GO
IF NOT EXISTS (SELECT 1 FROM sys.objects WHERE NAME = 'FK_CustomerReceiptInfo_DebtCollectionListRef')
ALTER TABLE [DST].[CustomerReceiptInfo] ADD CONSTRAINT [FK_CustomerReceiptInfo_DebtCollectionListRef] FOREIGN KEY([DebtCollectionListRef])
REFERENCES [DST].[DebtCollectionList] ([DebtCollectionListId])

GO
IF NOT EXISTS (SELECT 1 FROM sys.objects WHERE NAME = 'FK_CustomerReceiptInfo_ColdDistributionRef')
ALTER TABLE [DST].[CustomerReceiptInfo] ADD CONSTRAINT [FK_CustomerReceiptInfo_ColdDistributionRef] FOREIGN KEY([ColdDistributionRef])
REFERENCES [DST].[ColdDistribution] ([ColdDistributionId])

GO
IF NOT EXISTS (SELECT 1 FROM sys.objects WHERE NAME = 'FK_CustomerReceiptInfo_CurrencyRef')
ALTER TABLE [DST].[CustomerReceiptInfo] ADD CONSTRAINT [FK_CustomerReceiptInfo_CurrencyRef] FOREIGN KEY([CurrencyRef])
REFERENCES [GNR].[Currency] ([CurrencyId])

GO

IF NOT EXISTS (SELECT 1 FROM sys.objects WHERE NAME = 'FK_CustomerReceiptInfo_PartyAccountSettlementRef')
ALTER TABLE [DST].[CustomerReceiptInfo] ADD CONSTRAINT [FK_CustomerReceiptInfo_PartyAccountSettlementRef] FOREIGN KEY([PartyAccountSettlementRef])
REFERENCES [RPA].[PartyAccountSettlement] ([PartyAccountSettlementID])
ON DELETE SET NULL
GO
--<< DROP OBJECTS >>--
