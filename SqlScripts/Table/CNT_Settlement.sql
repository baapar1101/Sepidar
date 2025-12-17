--<<FileName:CNT_Settlement.sql>>--
--<< TABLE DEFINITION >>--

If Object_ID('CNT.Settlement') Is Null
CREATE TABLE [CNT].[Settlement](
	[SettlementID] [int] NOT NULL,
	[ContractRef] [int] NOT NULL,
	[Number] [int] NOT NULL,
	[Date] [datetime] NOT NULL,
	[ReceiptRef] [int] NULL,
	[PaymentRef] [int] Null,
	[PartyRef] [int] Null,
	[Type][int] NOT NULL,
	[Version] [int] NOT NULL,
	[Creator] [int] NOT NULL,
	[CreationDate] [datetime] NOT NULL,
	[LastModifier] [int] NOT NULL,
	[LastModificationDate] [datetime] NOT NULL,
	[FiscalYearRef] [int] NOT NULL,
	[Description] [nvarchar](250) NULL,
	[Description_En] [nvarchar](250) NULL
) ON [PRIMARY]

--TEXTIMAGE_ON [SGBlob_Data]
--When a table has text, ntext, image, varchar(max), nvarchar(max), varbinary(max), xml or large user defined type columns uncomment above code
GO
--<< ADD CLOLUMNS >>--

--<<Sample>>--
/*if not exists (select 1 from sys.columns where object_id=object_id('CNT.Settlement') and
				[name] = 'ColumnName')
begin
    Alter table CNT.Settlement Add ColumnName DataType Nullable
end
GO*/
if not exists (select 1 from sys.columns where object_id=object_id('CNT.Settlement') and
				[name] = 'FiscalYearRef')
begin
    Alter table CNT.Settlement Add [FiscalYearRef] [int] NOT NULL DEFAULT 1
end
GO

if not exists (select 1 from sys.columns where object_id=object_id('CNT.Settlement') and
				[name] = 'Description_En')
begin
    Alter table CNT.Settlement Add [Description_En] [nvarchar](250) NULL
end
GO
if not exists (select 1 from sys.columns where object_id=object_id('CNT.Settlement') and
				[name] = 'Description')
begin
    Alter table CNT.Settlement Add [Description] [nvarchar](250) NULL
end
GO
--<< ALTER COLUMNS >>--

--<< PRIMARYKEY DEFINITION >>--

If not Exists (select 1 from sys.objects where name = 'PK_Settlement_1')
ALTER TABLE [CNT].[Settlement] ADD  CONSTRAINT [PK_Settlement_1] PRIMARY KEY CLUSTERED 
(
	[SettlementID] ASC
) ON [PRIMARY]
GO

--<< DEFAULTS CHECKS DEFINITION >>--

--<< RULES DEFINITION >>--

--<< INDEXES DEFINITION >>--

--<< FOREIGNKEYS DEFINITION >>--

If not Exists (select 1 from sys.objects where name = 'FK_Settlement_Contract')
ALTER TABLE [CNT].[Settlement]  ADD  CONSTRAINT [FK_Settlement_Contract] FOREIGN KEY([ContractRef])
REFERENCES [CNT].[Contract] ([ContractID])

GO
If not Exists (select 1 from sys.objects where name = 'FK_Settlement_ReceiptHeader')
ALTER TABLE [CNT].[Settlement]  ADD  CONSTRAINT [FK_Settlement_ReceiptHeader] FOREIGN KEY([ReceiptRef])
REFERENCES [RPA].[ReceiptHeader] ([ReceiptHeaderId])

GO

If not Exists (select 1 from sys.objects where name = 'FK_Settlement_PaymentHeader')
ALTER TABLE [CNT].[Settlement]  ADD  CONSTRAINT [FK_Settlement_PaymentHeader] FOREIGN KEY([PaymentRef])
REFERENCES [RPA].[PaymentHeader] ([PaymentHeaderId])

GO


If not Exists (select 1 from sys.objects where name = 'FK_Settlement_FiscalYear')
ALTER TABLE [CNT].[Settlement]  ADD  CONSTRAINT [FK_Settlement_FiscalYear] FOREIGN KEY([FiscalYearRef])
REFERENCES [FMK].[FiscalYear] ([FiscalYearId])

GO
--<< DROP OBJECTS >>--
