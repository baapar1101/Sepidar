--<<FileName:POS_Settlement.sql>>--
--<< TABLE DEFINITION >>--

If Object_ID('POS.Settlement') Is Null
CREATE TABLE [POS].[Settlement](
	[SettlementID] [int] NOT NULL,
	[CashierRef] [int] NOT NULL,
	[Number] [int] NOT NULL,
	[FromDate] [datetime] NOT NULL,
	[ToDate] [datetime] NOT NULL,
	[ReceiptHeaderRef] int NULL,
	[PaymentHeaderRef] int NULL,
	[FiscalYearRef] int NOT NULL,
	[Version] [int] NOT NULL,
	[Creator] [int] NOT NULL,
	[CreationDate] [datetime] NOT NULL,
	[LastModifier] [int] NOT NULL,
	[LastModificationDate] [datetime] NOT NULL
) ON [PRIMARY]

--TEXTIMAGE_ON [SGBlob_Data]
--When a table has text, ntext, image, varchar(max), nvarchar(max), varbinary(max), xml or large user defined type columns uncomment above code
GO
--<< ADD CLOLUMNS >>--
--<< ADD CLOLUMNS >>--

if not exists (select 1 from sys.columns where object_id=object_id('POS.Settlement') and
				[name] = 'CashierRef')
begin
    Alter table POS.Settlement Add [CashierRef] [int] NULL
end
GO

--<< ALTER COLUMNS >>--
if exists (select 1 from sys.columns where object_id=object_id('POS.Settlement') and
				[name] = 'CashierRef' and is_Nullable = 1)
begin
    Update POS.Settlement Set [CashierRef] = IsNull((Select top 1 C.CashierID From POS.Cashier C WHERE C.PartyRef = PartyRef), (Select Top 1 CashierID From POS.Cashier) )
    Alter table POS.Settlement Alter Column [CashierRef] [int] NOT NULL
	ALTER TABLE [POS].[Settlement]  DROP CONSTRAINT [FK_POS_Settlement_PartyRef] 
    Alter table POS.Settlement DROP Column [PartyRef]
end
GO

--<< PRIMARYKEY DEFINITION >>--

If not Exists (select 1 from sys.objects where name = 'PK_POS_Settlement')
ALTER TABLE [POS].[Settlement] ADD  CONSTRAINT [PK_POS_Settlement] PRIMARY KEY CLUSTERED 
(
	[SettlementID] ASC
) ON [PRIMARY]
GO

--<< DEFAULTS CHECKS DEFINITION >>--

--<< RULES DEFINITION >>--

--<< INDEXES DEFINITION >>--

--<< FOREIGNKEYS DEFINITION >>--

If not Exists (select 1 from sys.objects where name = 'FK_POS_Settlement_CashierRef')
ALTER TABLE [POS].[Settlement]  ADD  CONSTRAINT [FK_POS_Settlement_CashierRef] FOREIGN KEY([CashierRef])
REFERENCES [POS].[Cashier] ([CashierId])
GO
If not Exists (select 1 from sys.objects where name = 'FK_POS_ReceiptHeader_ReceiptHeaderRef')
ALTER TABLE [POS].[Settlement]  ADD  CONSTRAINT [FK_POS_ReceiptHeader_ReceiptHeaderRef] FOREIGN KEY([ReceiptHeaderRef])
REFERENCES [RPA].[ReceiptHeader]  ([ReceiptHeaderId])
GO
If not Exists (select 1 from sys.objects where name = 'FK_POS_PaymentHeader_PaymentHeaderRef')
ALTER TABLE [POS].[Settlement]  ADD  CONSTRAINT [FK_POS_PaymentHeader_PaymentHeaderRef] FOREIGN KEY([PaymentHeaderRef])
REFERENCES [RPA].[PaymentHeader]  ([PaymentHeaderId])
GO

--<< DROP OBJECTS >>--
