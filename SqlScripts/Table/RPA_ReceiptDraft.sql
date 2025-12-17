--<<FileName:RPA_ReceiptDraft.sql>>--
--<< TABLE DEFINITION >>--

If Object_ID('RPA.ReceiptDraft') Is Null
CREATE TABLE [RPA].[ReceiptDraft](
	[ReceiptDraftId] [int] NOT NULL,
	[Number] [int] NULL,
	[Date] [datetime] NULL,
	[Amount] [decimal](19, 4) NULL,
	[BankAccountRef] [int] NULL,
	[Description] [nvarchar](4000) NULL,
	[Description_En] [nvarchar](4000) NULL,
	[Version] [int] NOT NULL,
	[ReceiptHeaderRef] [int] NOT NULL,
	[HeaderNumber] [int] NOT NULL,
	[HeaderDate] [datetime] NOT NULL,
	[CurrencyRef] [int] NOT NULL,
	[Rate] [decimal](26, 16) NOT NULL,
	[AmountInBaseCurrency] [decimal](19, 4) NOT NULL
) ON [PRIMARY]

--TEXTIMAGE_ON [SGBlob_Data]
--When a table has text, ntext, image, varchar(max), nvarchar(max), varbinary(max), xml or large user defined type columns uncomment above code
GO
--<< ADD CLOLUMNS >>--

--<<Sample>>--
/*if not exists (select 1 from sys.columns where object_id=object_id('RPA.ReceiptDraft') and
				[name] = 'ColumnName')
begin
    Alter table RPA.ReceiptDraft Add ColumnName DataType Nullable
end
GO*/

--<< ALTER COLUMNS >>--

Alter table RPA.ReceiptDraft Alter Column [Rate] [decimal](26, 16) NOT NULL
Go

Alter table RPA.ReceiptDraft Alter Column [Number] [nvarchar](100) NULL
Go
--<< PRIMARYKEY DEFINITION >>--

If not Exists (select 1 from sys.objects where name = 'PK_ReceiveDraft')
ALTER TABLE [RPA].[ReceiptDraft] ADD  CONSTRAINT [PK_ReceiveDraft] PRIMARY KEY CLUSTERED 
(
	[ReceiptDraftId] ASC
) ON [PRIMARY]
GO

--<< DEFAULTS CHECKS DEFINITION >>--

--<< RULES DEFINITION >>--

--<< INDEXES DEFINITION >>--
IF NOT EXISTS (SELECT 1 FROM sys.indexes WHERE name = 'IX_ReceiptDraft_ReceiptHeaderRef')
CREATE NONCLUSTERED INDEX [IX_ReceiptDraft_ReceiptHeaderRef]
ON [RPA].[ReceiptDraft] ([ReceiptHeaderRef])
INCLUDE ([Amount])

GO

--<< FOREIGNKEYS DEFINITION >>--

If not Exists (select 1 from sys.objects where name = 'FK_ReceiptDraft_CurrencyRef')
ALTER TABLE [RPA].[ReceiptDraft]  ADD  CONSTRAINT [FK_ReceiptDraft_CurrencyRef] FOREIGN KEY([CurrencyRef])
REFERENCES [GNR].[Currency] ([CurrencyID])

GO
If not Exists (select 1 from sys.objects where name = 'FK_ReceiveDraft_BankAccountRef')
ALTER TABLE [RPA].[ReceiptDraft]  ADD  CONSTRAINT [FK_ReceiveDraft_BankAccountRef] FOREIGN KEY([BankAccountRef])
REFERENCES [RPA].[BankAccount] ([BankAccountId])

GO
If not Exists (select 1 from sys.objects where name = 'FK_ReceiveDraft_ReceiveHeader')
ALTER TABLE [RPA].[ReceiptDraft]  ADD  CONSTRAINT [FK_ReceiveDraft_ReceiveHeader] FOREIGN KEY([ReceiptHeaderRef])
REFERENCES [RPA].[ReceiptHeader] ([ReceiptHeaderId])
ON DELETE CASCADE

GO

--<< DROP OBJECTS >>--
