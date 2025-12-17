--drop table RPA.PartyAccountSettlementItem
--<< TABLE DEFINITION >>--
IF Object_ID('RPA.PartyAccountSettlementItem') IS NULL
CREATE TABLE [RPA].[PartyAccountSettlementItem](
	[PartyAccountSettlementItemID] [int] NOT NULL,	
	[PartyAccountSettlementRef] [int] NOT NULL,
	[CurrencyRef] [int] NOT NULL,
	[Amount] [decimal](30, 4) NOT NULL,
	[DebitEntityType][int] NULL,
	[DebitEntityRef][int] NULL,
	[CreditEntityType][int] NULL,	
	[CreditEntityRef][int] NULL,
	[IsSettled] [bit] NOT NULL CONSTRAINT [DF_PartyAccountSettlementItem_IsSettled]  DEFAULT ((0)),
	[OldPartySettlementItemID] [int] NULL,	
	[OldPartySettlementID] [int] NULL	
) ON [PRIMARY]

--TEXTIMAGE_ON [SGBlob_Data]
--When a table has text, ntext, image, varchar(max), nvarchar(max), varbinary(max), xml or large user defined type columns uncomment above code
GO
--<< PRIMARYKEY DEFINITION >>--

IF NOT EXISTS (SELECT 1 FROM sys.objects WHERE name = 'PK_PartyAccountSettlementItemID')
ALTER TABLE [RPA].[PartyAccountSettlementItem] ADD CONSTRAINT [PK_PartyAccountSettlementItemID] PRIMARY KEY CLUSTERED 
(
	[PartyAccountSettlementItemID] ASC
) ON [PRIMARY]
GO
--<< DEFAULTS CHECKS DEFINITION >>--

IF NOT EXISTS (SELECT 1 FROM sys.objects WHERE NAME = 'DF_PartyAccountSettlementItem_IsSettled')
	ALTER TABLE RPA.PartyAccountSettlementItem
	ADD CONSTRAINT [DF_PartyAccountSettlementItem_IsSettled]  DEFAULT ((0)) FOR IsSettled
GO

--<< INDEXES DEFINITION >>--
IF NOT EXISTS (SELECT 1 FROM sys.indexes WHERE name = 'IX_PartyAccountSettlementItem_PartyAccountSettlementRef')
CREATE NONCLUSTERED INDEX [IX_PartyAccountSettlementItem_PartyAccountSettlementRef]
ON [RPA].[PartyAccountSettlementItem] ([PartyAccountSettlementRef])
INCLUDE ([Amount])
GO

IF NOT EXISTS (SELECT 1 FROM sys.indexes WHERE name = 'IX_PartyAccountSettlementItem_DebitEntityType_DebitEntityRef')
CREATE NONCLUSTERED INDEX [IX_PartyAccountSettlementItem_DebitEntityType_DebitEntityRef]
ON [RPA].[PartyAccountSettlementItem] ([DebitEntityType], [DebitEntityRef])
GO

--<< FOREIGNKEYS DEFINITION >>--

IF NOT EXISTS (SELECT 1 FROM sys.objects WHERE name = 'FK_PartyAccountSettlementItem_PartyAccountSettlement')
BEGIN
	ALTER TABLE [RPA].[PartyAccountSettlementItem]
	ADD CONSTRAINT [FK_PartyAccountSettlementItem_PartyAccountSettlement] FOREIGN KEY([PartyAccountSettlementRef])
	REFERENCES [RPA].[PartyAccountSettlement] ([PartyAccountSettlementID])
	ON DELETE CASCADE
END
GO

IF EXISTS (SELECT 1 FROM sys.columns WHERE object_id=object_id('Rpa.PartyAccountSettlementItem') AND
				[name] = 'Rate')
BEGIN

   ALTER TABLE Rpa.PartyAccountSettlementItem DROP COLUMN [Rate]
END
go

IF EXISTS (SELECT 1 FROM sys.columns WHERE object_id=object_id('Rpa.PartyAccountSettlementItem') AND
				[name] = 'AmountInBaseCurrency')
BEGIN

   ALTER TABLE Rpa.PartyAccountSettlementItem DROP COLUMN [AmountInBaseCurrency]
END
go
