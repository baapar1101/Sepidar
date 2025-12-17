--<<FileName:GNR_Party.sql>>--
--<< TABLE DEFINITION >>--

If Object_ID('GNR.Party') Is Null
CREATE TABLE [GNR].[Party](
	[PartyId] [int] NOT NULL,
	[Type] [int] NOT NULL,
	[SubType] [int] NOT NULL,
	[Name] [nvarchar](250) NOT NULL,
	[LastName] [nvarchar](250) NULL,
	[Name_En] [nvarchar](250) NOT NULL,
	[LastName_En] [nvarchar](250) NULL,
	[EconomicCode] [nvarchar](40) NULL,
	[IdentificationCode] [nvarchar](40) NULL,
	[RegistrationCode] [nvarchar] (40) NULL,
	[Website] [nvarchar](250) NULL,
	[Email] [nvarchar](250) NULL,
	[DLRef] [int] NOT NULL,
	[IsActive] [bit] NOT NULL,
	[IsInBlacklist] [bit] NOT NULL,
	[IsVendor] [bit] NOT NULL,
	[VendorGroupingRef] [int] NULL,
	[IsBroker] [bit] NOT NULL,
    [BrokerGroupingRef] [INT] NULL,
	[CommissionRate] [decimal](5, 2) NULL,
	[BrokerOpeningBalance] [decimal](19, 4) NULL,
	[BrokerOpeningBalanceType] [int] NULL,
    [IsPurchasingAgent] [bit] NOT NULL,
	[IsEmployee] [bit] NOT NULL,
	[IsCustomer] [bit] NOT NULL,
	[SalespersonPartyRef] [int] NULL,
	[DiscountRate] [decimal](13, 10) NULL,
	[MaximumCredit] [decimal](19, 4) NULL,
	[CustomerGroupingRef] [int] NULL,
	[CustomerCategoryForTax] [int] NOT NULL,
	[BirthDate] [datetime] NULL,
	[MarriageDate] [datetime] NULL,
	[HasCredit] [bit] NOT NULL DEFAULT 0,
	[CreditCheckingType] [int] NOT NULL DEFAULT 3,
	[Version] [int] NOT NULL,
	[Creator] [int] NOT NULL,
	[CreationDate] [datetime] NOT NULL,
	[LastModifier] [int] NOT NULL,
	[LastModificationDate] [datetime] NOT NULL,
	[Guid] [nvarchar](36) NULL,
	[PassportNumber] [nvarchar](9) NULL,
	[MaximumQuantityCredit] [int] NULL,
	[HasQuantityCredit] [bit] NOT NULL DEFAULT 0,
	[QuantityCreditCheckingType] [int] NOT NULL DEFAULT 3,
) ON [PRIMARY]

--TEXTIMAGE_ON [SGBlob_Data]
--When a table has text, ntext, image, varchar(max), nvarchar(max), varbinary(max), xml or large user defined type columns uncomment above code
GO
--<< ADD CLOLUMNS >>--
IF NOT EXISTS (SELECT 1 FROM SYS.COLUMNS WHERE object_id=object_id('GNR.Party') AND
				[name] = 'PassportNumber')
BEGIN
    Alter TABLE [GNR].[Party] ADD [PassportNumber] [nvarchar](9) NULL
END
GO

IF NOT EXISTS (SELECT 1 FROM SYS.COLUMNS WHERE object_id=object_id('GNR.Party') AND
				[name] = 'MaximumQuantityCredit')
BEGIN
    Alter TABLE [GNR].[Party] ADD [MaximumQuantityCredit] [int] NULL 
END
GO

IF NOT EXISTS (SELECT 1 FROM SYS.COLUMNS WHERE object_id=object_id('GNR.Party') AND
				[name] = 'HasQuantityCredit')
BEGIN
    Alter TABLE [GNR].[Party] ADD [HasQuantityCredit] [bit] NOT NULL DEFAULT 0
END
GO

IF NOT EXISTS (SELECT 1 FROM SYS.COLUMNS WHERE object_id=object_id('GNR.Party') AND
				[name] = 'QuantityCreditCheckingType')
BEGIN
    Alter TABLE [GNR].[Party] ADD [QuantityCreditCheckingType] [int] NOT NULL DEFAULT 3
END
GO

if not exists (select 1 from sys.columns where object_id=object_id('GNR.Party') and
				[name] = 'HasCredit')
begin
    Alter table GNR.Party ADD [HasCredit] [bit] NOT NULL DEFAULT 0
end
GO

if not exists (select 1 from sys.columns where object_id=object_id('GNR.Party') and
				[name] = 'CreditCheckingType')
begin
    Alter table GNR.Party Add [CreditCheckingType] [int] NOT NULL DEFAULT 3
end
GO

if not exists (select 1 from sys.columns where object_id=object_id('GNR.Party') and
				[name] = 'CustomerRemaining')
begin
    Alter table GNR.Party Add [CustomerRemaining] [decimal](19, 4) NULL
end
GO

if not exists (select 1 from sys.columns where object_id=object_id('GNR.Party') and
				[name] = 'BrokerGroupingRef')
begin
    Alter table GNR.Party Add [BrokerGroupingRef] [int]  NULL
end
GO

if not exists (select 1 from sys.columns where object_id=object_id('GNR.Party') and
				[name] = 'SubType')
begin
    Alter table GNR.Party Add [SubType] INT NULL
end
GO
--remove IsActive
if exists (select 1 from sys.columns where object_id=object_id('GNR.Party') and
				[name] = 'IsActive')
begin
    Alter table GNR.Party Drop column [IsActive]
end
GO

IF NOT EXISTS (SELECT 1 FROM sys.columns WHERE object_id=object_id('GNR.Party') and
	[name]='CustomerCategoryForTax')
BEGIN
	ALTER TABLE GNR.Party ADD [CustomerCategoryForTax] [int] NOT NULL DEFAULT(1)
END

IF NOT EXISTS (SELECT 1 FROM sys.columns WHERE object_id=object_id('GNR.Party') and
	[name]='RegistrationCode')
BEGIN
	ALTER TABLE GNR.Party ADD [RegistrationCode] [nvarchar] (40) NULL
	exec('UPDATE GNR.Party SET RegistrationCode = IdentificationCode WHERE [Type] =  2')
	UPDATE GNR.Party SET IdentificationCode = '' WHERE [Type] = 2
END
Go

IF NOT EXISTS (SELECT 1 FROM sys.columns WHERE object_id=object_id('GNR.Party') and
	[name]='BirthDate')
BEGIN
	ALTER TABLE GNR.Party ADD [BirthDate] [datetime] NULL
END
Go

IF NOT EXISTS (SELECT 1 FROM sys.columns WHERE object_id=object_id('GNR.Party') and
	[name]='MarriageDate')
BEGIN
	ALTER TABLE GNR.Party ADD [MarriageDate] [datetime] NULL
END
Go

IF NOT EXISTS (SELECT 1 FROM sys.columns WHERE object_id=object_id('GNR.Party') and
	[name]='Guid')
BEGIN
	ALTER TABLE GNR.Party ADD [Guid] [nvarchar](36) NULL
END
Go

IF NOT EXISTS (SELECT 1 FROM sys.columns WHERE object_id=object_id('GNR.Party') and
	[name]='IsPurchasingAgent')
BEGIN
	ALTER TABLE GNR.Party ADD [IsPurchasingAgent] [bit] Not NULL DEFAULT 0
END
Go

--<< ALTER COLUMNS >>--
if exists (select 1 from sys.columns where object_id=object_id('GNR.Party') and
				[name] = 'DiscountRate' AND precision = 5)
begin
    Alter table GNR.Party Alter Column DiscountRate [decimal](13, 10) NULL
end
GO	
if exists (select 1 from sys.columns where object_id=object_id('GNR.Party') and
				[name] = 'SubType' and IS_Nullable = 1)
begin
    Update Gnr.Party Set SubType = 7 where SubType is null
    Alter table GNR.Party Alter Column [SubType] INT NOT NULL
end
GO

--<< PRIMARYKEY DEFINITION >>--

If not Exists (select 1 from sys.objects where name = 'PK_Party')
ALTER TABLE [GNR].[Party] ADD  CONSTRAINT [PK_Party] PRIMARY KEY CLUSTERED 
(
	[PartyId] ASC
) ON [PRIMARY]
GO

--<< DEFAULTS CHECKS DEFINITION >>--

--<< RULES DEFINITION >>--

--<< INDEXES DEFINITION >>--
IF(NOT EXISTS (SELECT TOP 1 1 FROM sys.indexes WHERE object_id = OBJECT_ID(N'[GNR].[Party]') AND name LIKE 'IX_PartyDL'))
BEGIN
	CREATE NONCLUSTERED INDEX [IX_PartyDL] ON [GNR].[Party] 
	(
		[DLRef] ASC
	)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
END

IF NOT EXISTS (SELECT 1 FROM sys.indexes WHERE name = 'UIX_Party_Guid')
CREATE UNIQUE NONCLUSTERED INDEX [UIX_Party_Guid] ON [GNR].[Party]
(
	[Guid] ASC
) WHERE [Guid] IS NOT NULL ON [PRIMARY]
GO

--<< FOREIGNKEYS DEFINITION >>--

If not Exists (select 1 from sys.objects where name = 'FK_Party_CustomerGroupingRef')
ALTER TABLE [GNR].[Party]  ADD  CONSTRAINT [FK_Party_CustomerGroupingRef] FOREIGN KEY([CustomerGroupingRef])
REFERENCES [GNR].[Grouping] ([GroupingID])

GO
If not Exists (select 1 from sys.objects where name = 'FK_Party_DLRef_2_DL_DLId')
ALTER TABLE [GNR].[Party]  ADD  CONSTRAINT [FK_Party_DLRef_2_DL_DLId] FOREIGN KEY([DLRef])
REFERENCES [ACC].[DL] ([DLId])

GO
If not Exists (select 1 from sys.objects where name = 'FK_Party_SalespersonPartyRef')
ALTER TABLE [GNR].[Party]  ADD  CONSTRAINT [FK_Party_SalespersonPartyRef] FOREIGN KEY([SalespersonPartyRef])
REFERENCES [GNR].[Party] ([PartyId])

GO
If not Exists (select 1 from sys.objects where name = 'FK_Party_VendorGroupingRef')
ALTER TABLE [GNR].[Party]  ADD  CONSTRAINT [FK_Party_VendorGroupingRef] FOREIGN KEY([VendorGroupingRef])
REFERENCES [GNR].[Grouping] ([GroupingID])

GO

--<< DROP OBJECTS >>--
