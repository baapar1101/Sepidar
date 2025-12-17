--<<FileName:RPA_ReceiptPettyCash.sql>>--
--<< TABLE DEFINITION >>--

IF OBJECT_ID('RPA.ReceiptPettyCash') IS NULL
CREATE TABLE [RPA].[ReceiptPettyCash](
	[ReceiptPettyCashId] [int] NOT NULL,
	[PettyCashRef] [int] NOT NULL,
	[Description] [nvarchar](1000) NULL,
	[Description_En] [nvarchar](1000) NULL,
	[Amount] [decimal](19, 4) NOT NULL,
	[AmountInBaseCurrency] [decimal](19, 4) NOT NULL,
	[ReceiptHeaderRef] [int] NOT NULL,
	[CurrencyRef] [int] NOT NULL,
	[Rate] [decimal](26, 16) NOT NULL,
) ON [PRIMARY]

--TEXTIMAGE_ON [SGBlob_Data]
--When a table has text, ntext, image, varchar(max), nvarchar(max), varbinary(max), xml or large user defined type columns uncomment above code
GO
--<< ADD CLOLUMNS >>--

--<< ALTER COLUMNS >>--

--<< PRIMARYKEY DEFINITION >>--

IF NOT EXISTS (SELECT 1 FROM SYS.OBJECTS WHERE NAME = 'PK_ReceivePettyCash')
ALTER TABLE [RPA].[ReceiptPettyCash] ADD  CONSTRAINT [PK_ReceivePettyCash] PRIMARY KEY CLUSTERED 
(
	[ReceiptPettyCashId] ASC
) ON [PRIMARY]
GO

--<< DEFAULTS CHECKS DEFINITION >>--

--<< RULES DEFINITION >>--

--<< INDEXES DEFINITION >>--

--<< FOREIGNKEYS DEFINITION >>--

IF NOT EXISTS (SELECT 1 FROM SYS.OBJECTS WHERE NAME = 'FK_ReceiptPettyCash_PettyCashRef')
ALTER TABLE [RPA].[ReceiptPettyCash]  ADD  CONSTRAINT [FK_ReceiptPettyCash_PettyCashRef] FOREIGN KEY([PettyCashRef])
REFERENCES [RPA].[PettyCash] ([PettyCashId])
GO

IF NOT EXISTS (SELECT 1 FROM SYS.OBJECTS WHERE NAME = 'FK_ReceiptPettyCash_ReceiveHeaderRef')
ALTER TABLE [RPA].[ReceiptPettyCash]  ADD  CONSTRAINT [FK_ReceiptPettyCash_ReceiveHeaderRef] FOREIGN KEY([ReceiptHeaderRef])
REFERENCES [RPA].[ReceiptHeader] ([ReceiptHeaderId])
ON DELETE CASCADE
GO

IF NOT EXISTS (SELECT 1 FROM SYS.OBJECTS WHERE NAME = 'FK_ReceiptPettyCash_CurrencyRef')
ALTER TABLE [RPA].[ReceiptPettyCash]  ADD  CONSTRAINT [FK_ReceiptPettyCash_CurrencyRef] FOREIGN KEY([CurrencyRef])
REFERENCES [GNR].[Currency] ([CurrencyId])
GO

--<< DROP OBJECTS >>--
