--<<FileName:RPA_PaymentDraft.sql>>--
--<< TABLE DEFINITION >>--

If Object_ID('RPA.PaymentDraft') Is Null
CREATE TABLE [RPA].[PaymentDraft](
	[PaymentDraftId] [int] NOT NULL,
	[Number] [NVARCHAR](50) NULL,
	[Date] [datetime] NULL,
	[Amount] [decimal](19, 4) NULL,
	[BankAccountRef] [int] NULL,
	[Description] [nvarchar](4000) NULL,
	[Description_En] [nvarchar](4000) NULL,
	[Version] [int] NOT NULL,
	[PaymentHeaderRef] [int] NOT NULL,
	[HeaderNumber] [int] NOT NULL,
	[HeaderDate] [datetime] NOT NULL,
	[CurrencyRef] [int] NOT NULL,
	[Rate] [decimal](26, 16) NOT NULL,
	[AmountInBaseCurrency] [decimal](19, 4) NOT NULL,
	[BankFeeAmount] [decimal](19, 4) NULL,
	[BankFeeAmountInBaseCurrency] [decimal](19, 4) NULL,
    [BankFeeAmountRate] [decimal](26, 16) NULL,
) ON [PRIMARY]

--TEXTIMAGE_ON [SGBlob_Data]
--When a table has text, ntext, image, varchar(max), nvarchar(max), varbinary(max), xml or large user defined type columns uncomment above code
GO
--<< ADD CLOLUMNS >>--

--<<Sample>>--
/*if not exists (select 1 from sys.columns where object_id=object_id('RPA.PaymentDraft') and
				[name] = 'ColumnName')
begin
    Alter table RPA.PaymentDraft Add ColumnName DataType Nullable
end
GO*/

--<< ALTER COLUMNS >>--

Alter table RPA.PaymentDraft Alter Column Rate [decimal](26, 16) NOT NULL
Go

Alter table RPA.PaymentDraft Alter Column [Amount] [decimal](19, 4) NOT NULL
GO

ALTER TABLE RPA.PaymentDraft ALTER COLUMN [Number] NVARCHAR(50) NULL;
GO

IF NOT EXISTS (SELECT 1 FROM sys.columns where object_id=object_id('RPA.PaymentDraft') AND
				[name] = 'BankFeeAmount')
BEGIN
    ALTER TABLE RPA.PaymentDraft Add [BankFeeAmount] [decimal](19, 4) NULL
END
GO

IF NOT EXISTS (SELECT 1 FROM sys.columns where object_id=object_id('RPA.PaymentDraft') AND
				[name] = 'BankFeeAmountInBaseCurrency')
BEGIN
    ALTER TABLE RPA.PaymentDraft Add [BankFeeAmountInBaseCurrency] [decimal](19, 4) NULL
END

GO

IF NOT EXISTS (SELECT 1 FROM sys.columns where object_id=object_id('RPA.PaymentDraft') AND
				[name] = 'BankFeeAmountRate')
BEGIN
    ALTER TABLE RPA.PaymentDraft Add [BankFeeAmountRate] [decimal](26, 16) NULL
END

GO
--<< PRIMARYKEY DEFINITION >>--

If not Exists (select 1 from sys.objects where name = 'PK_PaymentDraft')
ALTER TABLE [RPA].[PaymentDraft] ADD  CONSTRAINT [PK_PaymentDraft] PRIMARY KEY CLUSTERED 
(
	[PaymentDraftId] ASC
) ON [PRIMARY]
GO

--<< DEFAULTS CHECKS DEFINITION >>--

--<< RULES DEFINITION >>--

--<< INDEXES DEFINITION >>--

--<< FOREIGNKEYS DEFINITION >>--

If not Exists (select 1 from sys.objects where name = 'FK_PaymentDraft_BankAccount')
ALTER TABLE [RPA].[PaymentDraft]  ADD  CONSTRAINT [FK_PaymentDraft_BankAccount] FOREIGN KEY([BankAccountRef])
REFERENCES [RPA].[BankAccount] ([BankAccountId])

GO
If not Exists (select 1 from sys.objects where name = 'FK_PaymentDraft_CurrencyRef')
ALTER TABLE [RPA].[PaymentDraft]  ADD  CONSTRAINT [FK_PaymentDraft_CurrencyRef] FOREIGN KEY([CurrencyRef])
REFERENCES [GNR].[Currency] ([CurrencyID])

GO
If not Exists (select 1 from sys.objects where name = 'FK_PaymentDraft_PaymentHeaderRef')
ALTER TABLE [RPA].[PaymentDraft]  ADD  CONSTRAINT [FK_PaymentDraft_PaymentHeaderRef] FOREIGN KEY([PaymentHeaderRef])
REFERENCES [RPA].[PaymentHeader] ([PaymentHeaderId])
ON UPDATE CASCADE
ON DELETE CASCADE

GO

--<< DROP OBJECTS >>--
