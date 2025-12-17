--<<FileName:GNR_ShredItem.sql>>--
--<< TABLE DEFINITION >>--

If Object_ID('GNR.ShredItem') Is Null
CREATE TABLE [GNR].[ShredItem](
	[ShredItemID] [int] NOT NULL,
	[ShredRef] [int] NOT NULL,
	[RowNumber] [int] NOT NULL,
	[UsanceDate] [datetime] NOT NULL,
	[Amount] [decimal](18, 4) NOT NULL,
	[InterestAmount] [decimal](19, 4) NULL,
	[PenaltyAmount] [decimal](19, 4) NULL,
	[PenaltyRate] [decimal](19, 4) NULL,
	[Status] [int] NOT NULL,
	[PaymentRef] [int] NULL,
	[ReceiptRef] [int] NULL,
	[PartySettlementRef] [INT] NULL,
	[PaymentDate] [datetime] NULL,
	[IsPaid] [bit] NOT NULL
) ON [PRIMARY]

--TEXTIMAGE_ON [SGBlob_Data]
--When a table has text, ntext, image, varchar(max), nvarchar(max), varbinary(max), xml or large user defined type columns uncomment above code
GO
--<< ADD CLOLUMNS >>--

--<<Sample>>--
/*if not exists (select 1 from sys.columns where object_id=object_id('GNR.ShredItem') and
				[name] = 'ColumnName')
begin
    Alter table GNR.ShredItem Add ColumnName DataType Nullable
end
GO*/

--<< ALTER COLUMNS >>--
if not exists (select 1 from sys.columns where object_id=object_id('GNR.ShredItem') 
	and [name] = 'PaidDate')
		Alter table GNR.ShredItem Add [PaidDate] datetime NULL
Go

if not exists (select 1 from sys.columns where object_id=object_id('GNR.ShredItem') 
	and [name] = 'PaidDesc')
		Alter table GNR.ShredItem Add [PaidDesc] nvarchar(2000) NULL
Go

IF NOT EXISTS (SELECT 1 FROM sys.columns WHERE object_id=object_id('GNR.ShredItem') 
	AND [name] = 'PartySettlementRef')
		ALTER TABLE GNR.ShredItem ADD [PartySettlementRef] [INT] NULL
GO


--<< PRIMARYKEY DEFINITION >>--

If not Exists (select 1 from sys.objects where name = 'PK_ShredableItem')
ALTER TABLE [GNR].[ShredItem] ADD  CONSTRAINT [PK_ShredableItem] PRIMARY KEY CLUSTERED 
(
	[ShredItemID] ASC
) ON [PRIMARY]
GO

--<< DEFAULTS CHECKS DEFINITION >>--

--<< RULES DEFINITION >>--

--<< INDEXES DEFINITION >>--

--<< FOREIGNKEYS DEFINITION >>--

If Exists (select 1 from sys.objects where name = 'FK_ShredItem_Shred')
ALTER TABLE [GNR].[ShredItem]  DROP CONSTRAINT [FK_ShredItem_Shred]

If not Exists (select 1 from sys.objects where name = 'FK_ShredItem_Shred')
ALTER TABLE [GNR].[ShredItem]  WITH CHECK ADD  CONSTRAINT [FK_ShredItem_Shred] FOREIGN KEY([ShredRef])
REFERENCES [GNR].[Shred] ([ShredID])
ON DELETE CASCADE
GO


If not Exists (select 1 from sys.objects where name = 'FK_ShredItem_PaymentHeader')
ALTER TABLE [GNR].[ShredItem]  WITH CHECK ADD  CONSTRAINT [FK_ShredItem_PaymentHeader] FOREIGN KEY([PaymentRef])
REFERENCES [RPA].[PaymentHeader] ([PaymentHeaderID])
GO

If not Exists (select 1 from sys.objects where name = 'FK_ShredItem_ReceiptHeader')
ALTER TABLE [GNR].[ShredItem]  WITH CHECK ADD  CONSTRAINT [FK_ShredItem_ReceiptHeader] FOREIGN KEY([ReceiptRef])
REFERENCES [RPA].[ReceiptHeader] ([ReceiptHeaderID])
GO

If not Exists (select 1 from sys.objects where name = 'FK_ShredItem_PartySettlement')
ALTER TABLE [GNR].[ShredItem]  WITH CHECK ADD  CONSTRAINT [FK_ShredItem_PartySettlement] FOREIGN KEY([PartySettlementRef])
REFERENCES [RPA].[PartyAccountSettlement] ([PartyAccountSettlementID])
GO

--<< DROP OBJECTS >>--
