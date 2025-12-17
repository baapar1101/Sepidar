--<<FileName:RPA_PaymentCheque.sql>>--
--<< TABLE DEFINITION >>--

If Object_ID('RPA.PaymentCheque') Is Null
CREATE TABLE [RPA].[PaymentCheque](
	[PaymentChequeId] [int] NOT NULL,
	[Number] [nvarchar](50) NOT NULL,
	[SecondNumber] [nvarchar](50) NULL,
	[SayadCode] CHAR(20) NULL,
	[IsGuarantee] [bit] NOT NULL,
	[Amount] [decimal](19, 4) NOT NULL,
	[Date] [datetime] NULL,
	[Description] [nvarchar](4000) NULL,
	[Description_En] [nvarchar](4000) NULL,
	[Version] [int] NOT NULL,
	[State] [int] NOT NULL,
	[PaymentHeaderRef] [int] NOT NULL,
	[BankAccountRef] [int] NOT NULL,
	[HeaderNumber] [int] NOT NULL,
	[HeaderDate] [datetime] NOT NULL,
	[CurrencyRef] [int] NOT NULL,
	[Rate] [decimal](26, 16) NOT NULL,
	[AmountInBaseCurrency] [decimal](19, 4) NOT NULL,
	[DurationType] [int] NOT NULL,
	[DlRef] [int] NOT NULL,
	[Type] [int] NOT NULL
) ON [PRIMARY]

--TEXTIMAGE_ON [SGBlob_Data]
--When a table has text, ntext, image, varchar(max), nvarchar(max), varbinary(max), xml or large user defined type columns uncomment above code
GO
--<< ADD CLOLUMNS >>--

--<<Sample>>--
if not exists (select 1 from sys.columns where object_id=object_id('RPA.PaymentCheque') and
				[name] = 'Type')
begin
    Alter table RPA.PaymentCheque Add [Type] int NULL
end
GO

IF NOT EXISTS (SELECT 1 FROM sys.columns WHERE object_id=object_id('RPA.PaymentCheque') AND
				[name] = 'SayadCode')
BEGIN
    ALTER TABLE RPA.PaymentCheque ADD [SayadCode] CHAR(20) NULL
END
GO


UPDATE Cheque
SET [Type] = Header.Type
FROM RPA.PaymentCheque Cheque INNER JOIN 
	Rpa.PaymentHeader Header ON Cheque.PaymentHeaderRef = Header.PaymentHeaderId
WHERE Cheque.Type is null
GO
--<< ALTER COLUMNS >>--
Alter table RPA.ReceiptCheque Alter Column [Type] int Not NULL
go

Alter table RPA.PaymentCheque Alter Column Rate [decimal](26, 16) NOT NULL

Go
--<< PRIMARYKEY DEFINITION >>--

If not Exists (select 1 from sys.objects where name = 'PK_PaymentCheque')
ALTER TABLE [RPA].[PaymentCheque] ADD  CONSTRAINT [PK_PaymentCheque] PRIMARY KEY CLUSTERED 
(
	[PaymentChequeId] ASC
) ON [PRIMARY]
GO

--<< DEFAULTS CHECKS DEFINITION >>--

--<< RULES DEFINITION >>--

--<< INDEXES DEFINITION >>--

--<< FOREIGNKEYS DEFINITION >>--

If not Exists (select 1 from sys.objects where name = 'FK_PaymentCheque_BankAccount')
ALTER TABLE [RPA].[PaymentCheque]  ADD  CONSTRAINT [FK_PaymentCheque_BankAccount] FOREIGN KEY([BankAccountRef])
REFERENCES [RPA].[BankAccount] ([BankAccountId])

GO
If not Exists (select 1 from sys.objects where name = 'FK_PaymentCheque_CurrencyRef')
ALTER TABLE [RPA].[PaymentCheque]  ADD  CONSTRAINT [FK_PaymentCheque_CurrencyRef] FOREIGN KEY([CurrencyRef])
REFERENCES [GNR].[Currency] ([CurrencyID])

GO
If not Exists (select 1 from sys.objects where name = 'FK_PaymentCheque_DLRef')
ALTER TABLE [RPA].[PaymentCheque]  ADD  CONSTRAINT [FK_PaymentCheque_DLRef] FOREIGN KEY([DlRef])
REFERENCES [ACC].[DL] ([DLId])

GO
If not Exists (select 1 from sys.objects where name = 'FK_PaymentCheque_PaymentHeaderRef')
ALTER TABLE [RPA].[PaymentCheque]  ADD  CONSTRAINT [FK_PaymentCheque_PaymentHeaderRef] FOREIGN KEY([PaymentHeaderRef])
REFERENCES [RPA].[PaymentHeader] ([PaymentHeaderId])
ON UPDATE CASCADE
ON DELETE CASCADE

GO

--<< DROP OBJECTS >>--
