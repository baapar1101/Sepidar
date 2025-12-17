--<<FileName:RPA_PettyCash.sql>>--
--<< TABLE DEFINITION >>--

If Object_ID('RPA.PettyCash') Is Null
CREATE TABLE [RPA].[PettyCash](
	[PettyCashId] [int] NOT NULL,
	[PartyRef] [int] NOT NULL,
	[Title] [nvarchar](250) NOT NULL,
	[Title_En] [nvarchar](250) NOT NULL,
	[CurrencyRef] [int] NOT NULL,
	[Rate] [decimal](26, 16) NOT NULL,
	[FirstAmount] [decimal](19, 4) NOT NULL,
	[MaximumCredit] [decimal](19, 4) NOT NULL,
	[IsActive] [bit] NOT NULL,
	[Version] [int] NOT NULL,
	[Creator] [int] NOT NULL,
	[CreationDate] [datetime] NOT NULL,
	[LastModifier] [int] NOT NULL,
	[LastModificationDate] [datetime] NOT NULL ,
	[AccountSLRef] [int] NULL,
) ON [PRIMARY]

--TEXTIMAGE_ON [SGBlob_Data]
--When a table has text, ntext, image, varchar(max), nvarchar(max), varbinary(max), xml or large user defined type columns uncomment above code
GO
--<< ADD CLOLUMNS >>--

--<< ALTER COLUMNS >>--


GO
--<< PRIMARYKEY DEFINITION >>--

IF NOT EXISTS (SELECT 1 FROM SYS.OBJECTS WHERE NAME = 'PK_PettyCash')
ALTER TABLE [RPA].[PettyCash] ADD  CONSTRAINT [PK_PettyCash] PRIMARY KEY CLUSTERED 
(
	[PettyCashId] ASC
) ON [PRIMARY]
GO

--<< DEFAULTS CHECKS DEFINITION >>--

--<< RULES DEFINITION >>--

--<< INDEXES DEFINITION >>--

IF NOT EXISTS (SELECT 1 FROM sys.indexes WHERE NAME = 'IX_PettyCash_Title')
ALTER TABLE [RPA].[PettyCash] ADD CONSTRAINT
	IX_PettyCash_Title UNIQUE NONCLUSTERED 
	(
	Title
	) 

GO

IF NOT EXISTS (SELECT 1 FROM sys.indexes WHERE NAME = 'IX_PettyCash_Title_En')
ALTER TABLE [RPA].[PettyCash] ADD CONSTRAINT
	IX_PettyCash_Title_En UNIQUE NONCLUSTERED 
	(
	Title_En
	) 

GO
IF NOT EXISTS (SELECT 1 FROM sys.indexes WHERE NAME = 'IX_PettyCash_CurrencyRef_PartyRef')
	CREATE UNIQUE NONCLUSTERED INDEX [IX_PettyCash_CurrencyRef_PartyRef] ON [RPA].[PettyCash]
	(PartyRef ASC , CurrencyRef ASC)
GO
--<< FOREIGNKEYS DEFINITION >>--

IF NOT EXISTS (SELECT 1 FROM SYS.OBJECTS WHERE NAME = 'FK_PettyCash_CurrencyRef')
ALTER TABLE [RPA].[PettyCash]  ADD  CONSTRAINT [FK_PettyCash_CurrencyRef] FOREIGN KEY([CurrencyRef])
REFERENCES [GNR].[Currency] ([CurrencyID])

GO

IF NOT EXISTS (SELECT 1 FROM SYS.OBJECTS WHERE NAME = 'FK_PettyCash_PartyRef')
ALTER TABLE [RPA].[PettyCash]  ADD  CONSTRAINT [FK_PettyCash_PartyRef] FOREIGN KEY([PartyRef])
REFERENCES [GNR].[Party] ([PartyId])

GO

If not Exists (select 1 from sys.objects where name = 'FK_PettyCash_Account')
ALTER TABLE [RPA].[PettyCash]  ADD  CONSTRAINT [FK_PettyCash_Account] FOREIGN KEY([AccountSLRef])
REFERENCES [ACC].[Account] ([AccountId])

GO

--<< DROP OBJECTS >>--
