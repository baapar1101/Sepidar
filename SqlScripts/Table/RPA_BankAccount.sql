--<<FileName:RPA_BankAccount.sql>>--
--<< TABLE DEFINITION >>--

If Object_ID('RPA.BankAccount') Is Null
CREATE TABLE [RPA].[BankAccount](
	[BankAccountId] [int] NOT NULL,
	[BankBranchRef] [int] NOT NULL,
	[AccountNo] [nvarchar](250) NOT NULL,
	[AccountTypeRef] [int] NOT NULL,
	[DlRef] [int] NOT NULL,
	[IsActive] [bit] NOT NULL,
	[CurrencyRef] [int] NOT NULL,
	[Rate] [decimal](26, 16) NOT NULL,
	[FirstAmount] [decimal](19, 4) NOT NULL,
	[FirstDate] [datetime] NOT NULL,
	[Version] [int] NOT NULL,
	[Creator] [int] NULL,
	[CreationDate] [datetime] NULL,
	[LastModifier] [int] NULL,
	[LastModificationDate] [datetime] NULL,
	[Balance] [decimal](19, 4) NOT NULL,
	[BillFirstAmount] [decimal](19, 4) NULL,
	[BlockedAmount] [decimal](19, 4) NULL,
	[ShowBankFeeSeparately] [BIT] NOT NULL,
	[CreditCardNumber] [NVarchar](16) NULL,
	[ShebaNumber] [NVarchar](30) NULL,
) ON [PRIMARY]

--TEXTIMAGE_ON [SGBlob_Data]
--When a table has text, ntext, image, varchar(max), nvarchar(max), varbinary(max), xml or large user defined type columns uncomment above code
GO
--<< ADD CLOLUMNS >>--

--remove IsActive
if exists (select 1 from sys.columns where object_id=object_id('RPA.BankAccount') and
				[name] = 'IsActive')
begin
    Alter table RPA.BankAccount Drop column [IsActive]
end
GO

if not exists (select 1 from sys.columns where object_id=object_id('RPA.BankAccount') and
				[name] = 'CreditCardNumber')
begin
    Alter table RPA.BankAccount Add [CreditCardNumber] nvarchar(16) NULL
end
GO

if not exists (select 1 from sys.columns where object_id=object_id('RPA.BankAccount') and
				[name] = 'ShebaNumber')
begin
    Alter table RPA.BankAccount Add [ShebaNumber] nvarchar(30) NULL
end
GO

if not exists (select 1 from sys.columns where object_id=object_id('RPA.BankAccount') and
				[name] = 'ClearFormatName')
begin
    Alter table RPA.BankAccount Add [ClearFormatName] nvarchar(250)  NULL
end
GO

if not exists (select 1 from sys.columns where object_id=object_id('RPA.BankAccount') and
				[name] = 'Owner')
begin
    Alter table RPA.BankAccount Add [Owner] nvarchar(4000)  NULL
end
GO

if not exists (select 1 from sys.columns where object_id=object_id('RPA.BankAccount') and
				[name] = 'Owner_En')
begin
    Alter table RPA.BankAccount Add [Owner_En] nvarchar(4000)  NULL
end
GO

if not exists (select 1 from sys.columns where object_id=object_id('RPA.BankAccount') and
				[name] = 'BlockedAmount')
begin
    Alter table RPA.BankAccount Add [BlockedAmount] [decimal](19, 4)  NULL
end
GO

if not exists (select 1 from sys.columns where object_id=object_id('RPA.BankAccount') and
				[name] = 'ShowBankFeeSeparately')
begin
    Alter table RPA.BankAccount Add [ShowBankFeeSeparately] [BIT] NOT NULL DEFAULT(1)
end
GO



--<< ALTER COLUMNS >>--


Alter table RPA.BankAccount Alter Column Rate decimal(26, 16) not null

GO

--<< PRIMARYKEY DEFINITION >>--

If not Exists (select 1 from sys.objects where name = 'PK_BankAccount')
ALTER TABLE [RPA].[BankAccount] ADD  CONSTRAINT [PK_BankAccount] PRIMARY KEY CLUSTERED 
(
	[BankAccountId] ASC
) ON [PRIMARY]
GO

--<< DEFAULTS CHECKS DEFINITION >>--

--<< RULES DEFINITION >>--

--<< INDEXES DEFINITION >>--

If not Exists (select 1 from sys.indexes where name = 'UIX_BankAccount_BankBranchRef_AccountNo')
CREATE UNIQUE NONCLUSTERED INDEX [UIX_BankAccount_BankBranchRef_AccountNo] ON [RPA].[BankAccount] 
(
	[BankBranchRef] ASC,
	[AccountNo] ASC
) ON [PRIMARY]

GO
--<< FOREIGNKEYS DEFINITION >>--

If not Exists (select 1 from sys.objects where name = 'FK_BankAccount_AccountTypeRef')
ALTER TABLE [RPA].[BankAccount]  ADD  CONSTRAINT [FK_BankAccount_AccountTypeRef] FOREIGN KEY([AccountTypeRef])
REFERENCES [RPA].[AccountType] ([AccountTypeId])

GO
If not Exists (select 1 from sys.objects where name = 'FK_BankAccount_BankBranchRef')
ALTER TABLE [RPA].[BankAccount]  ADD  CONSTRAINT [FK_BankAccount_BankBranchRef] FOREIGN KEY([BankBranchRef])
REFERENCES [RPA].[BankBranch] ([BankBranchId])

GO
If not Exists (select 1 from sys.objects where name = 'FK_BankAccount_CurrencyRef')
ALTER TABLE [RPA].[BankAccount]  ADD  CONSTRAINT [FK_BankAccount_CurrencyRef] FOREIGN KEY([CurrencyRef])
REFERENCES [GNR].[Currency] ([CurrencyID])

GO
If not Exists (select 1 from sys.objects where name = 'FK_BankAccount_DlRef')
ALTER TABLE [RPA].[BankAccount]  ADD  CONSTRAINT [FK_BankAccount_DlRef] FOREIGN KEY([DlRef])
REFERENCES [ACC].[DL] ([DLId])

GO

--<< DROP OBJECTS >>--
