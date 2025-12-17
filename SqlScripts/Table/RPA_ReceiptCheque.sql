--<<FileName:RPA_ReceiptCheque.sql>>--
--<< TABLE DEFINITION >>--

If Object_ID('RPA.ReceiptCheque') Is Null
CREATE TABLE [RPA].[ReceiptCheque](
	[ReceiptChequeId] [int] NOT NULL,
	[Number] [nvarchar](50) NOT NULL,
	[SecondNumber] [nvarchar](50) NULL,
	[SayadCode] CHAR(20) NULL,
	[IsGuarantee] [bit] NOT NULL,
	[AccountNo] [nvarchar](50) NOT NULL,
	[Amount] [decimal](19, 4) NOT NULL,
	[Date] [datetime] NULL,
	[Description] [nvarchar](4000) NULL,
	[Description_En] [nvarchar](4000) NULL,
	[Version] [int] NOT NULL,
	[State] [int] NOT NULL,
	[CashRef] [int] NULL,
	[ReceiptHeaderRef] [int] NOT NULL,
	[BankRef] [int] NULL,
	[BranchCode] [int] NULL,
	[BranchTitle] [nvarchar](250) NULL,
	[LocationRef] [int] NULL,
	[HeaderNumber] [int] NOT NULL,
	[HeaderDate] [datetime] NOT NULL,
	[CurrencyRef] [int] NOT NULL,
	[Rate] [decimal](26, 16) NOT NULL,
	[AmountInBaseCurrency] [decimal](19, 4) NOT NULL,
	[BankBranchRef] [int] NOT NULL,
	[DlRef] [int] NOT NULL,
	[Type] [int] NOT NULL,
	[ChequeOwner] [NVARCHAR](250) NULL
) ON [PRIMARY]

--TEXTIMAGE_ON [SGBlob_Data]
--When a table has text, ntext, image, varchar(max), nvarchar(max), varbinary(max), xml or large user defined type columns uncomment above code
GO
--<< ADD CLOLUMNS >>--

--<<Sample>>--

Alter table RPA.ReceiptCheque Alter column [BranchCode] [nvarchar](250) NULL
GO

if not exists (select 1 from sys.columns where object_id=object_id('RPA.ReceiptCheque') and
				[name] = 'Type')
begin
    Alter table RPA.ReceiptCheque Add [Type] int NULL

end
GO

if not exists (select 1 from sys.columns where object_id=object_id('RPA.ReceiptCheque') and
				[name] = 'InitState')
begin
    Alter table RPA.ReceiptCheque Add [InitState] int NULL

end
GO

IF NOT EXISTS (SELECT 1 FROM sys.columns WHERE object_id=object_id('RPA.ReceiptCheque') AND
				[name] = 'SayadCode')
BEGIN
    ALTER TABLE RPA.ReceiptCheque ADD [SayadCode] CHAR(20) NULL
END
GO

IF NOT EXISTS (SELECT 1 FROM sys.columns WHERE object_id=object_id('RPA.ReceiptCheque') AND
				[name] = 'ChequeOwner')
BEGIN
    ALTER TABLE RPA.ReceiptCheque ADD [ChequeOwner] NVARCHAR(250) NULL
END
GO

UPDATE Cheque
SET [Type] = Header.Type
FROM RPA.ReceiptCheque Cheque INNER JOIN 
	Rpa.ReceiptHeader Header ON Cheque.ReceiptHeaderRef = Header.ReceiptHeaderId
WHERE Cheque.Type is null
GO
	
--<< ALTER COLUMNS >>--
Alter table RPA.ReceiptCheque Alter Column [Type] int Not NULL
go

Alter table RPA.ReceiptCheque Alter Column [Rate] [decimal](26, 16) NOT NULL
Go

Alter table RPA.ReceiptCheque Alter Column [BankBranchRef] [int] NULL
Go

Alter table RPA.ReceiptCheque Alter Column [CashRef] [int] NULL
Go

--<< PRIMARYKEY DEFINITION >>--

If not Exists (select 1 from sys.objects where name = 'PK_ReceiveChq')
ALTER TABLE [RPA].[ReceiptCheque] ADD  CONSTRAINT [PK_ReceiveChq] PRIMARY KEY CLUSTERED 
(
	[ReceiptChequeId] ASC
) ON [PRIMARY]
GO

--<< DEFAULTS CHECKS DEFINITION >>--

--<< RULES DEFINITION >>--

--<< INDEXES DEFINITION >>--
IF NOT EXISTS (SELECT 1 FROM sys.indexes WHERE name = 'IX_ReceiptCheque_ReceiptHeaderRef')
CREATE NONCLUSTERED INDEX [IX_ReceiptCheque_ReceiptHeaderRef]
ON [RPA].[ReceiptCheque] ([ReceiptHeaderRef])
INCLUDE ([Amount])

GO

--<< FOREIGNKEYS DEFINITION >>--

If not Exists (select 1 from sys.objects where name = 'FK_ReceiptCheque_BankBranchRef')
ALTER TABLE [RPA].[ReceiptCheque]  ADD  CONSTRAINT [FK_ReceiptCheque_BankBranchRef] FOREIGN KEY([BankBranchRef])
REFERENCES [RPA].[BankBranch] ([BankBranchId])

GO
If not Exists (select 1 from sys.objects where name = 'FK_ReceiptCheque_BankRef')
ALTER TABLE [RPA].[ReceiptCheque]  ADD  CONSTRAINT [FK_ReceiptCheque_BankRef] FOREIGN KEY([BankRef])
REFERENCES [RPA].[Bank] ([BankId])

GO
If not Exists (select 1 from sys.objects where name = 'FK_ReceiptCheque_CurrencyRef')
ALTER TABLE [RPA].[ReceiptCheque]  ADD  CONSTRAINT [FK_ReceiptCheque_CurrencyRef] FOREIGN KEY([CurrencyRef])
REFERENCES [GNR].[Currency] ([CurrencyID])

GO
If not Exists (select 1 from sys.objects where name = 'FK_ReceiptCheque_DL')
ALTER TABLE [RPA].[ReceiptCheque]  ADD  CONSTRAINT [FK_ReceiptCheque_DL] FOREIGN KEY([DlRef])
REFERENCES [ACC].[DL] ([DLId])

GO
If not Exists (select 1 from sys.objects where name = 'FK_ReceiptCheque_LocationRef')
ALTER TABLE [RPA].[ReceiptCheque]  ADD  CONSTRAINT [FK_ReceiptCheque_LocationRef] FOREIGN KEY([LocationRef])
REFERENCES [GNR].[Location] ([LocationId])

GO
If not Exists (select 1 from sys.objects where name = 'FK_ReceiveCheque_CashRef')
ALTER TABLE [RPA].[ReceiptCheque]  ADD  CONSTRAINT [FK_ReceiveCheque_CashRef] FOREIGN KEY([CashRef])
REFERENCES [RPA].[Cash] ([CashId])

GO
If not Exists (select 1 from sys.objects where name = 'FK_ReceiveCheque_ReceiveHeaderRef')
ALTER TABLE [RPA].[ReceiptCheque]  ADD  CONSTRAINT [FK_ReceiveCheque_ReceiveHeaderRef] FOREIGN KEY([ReceiptHeaderRef])
REFERENCES [RPA].[ReceiptHeader] ([ReceiptHeaderId])
ON DELETE CASCADE

GO

--<< DROP OBJECTS >>--
