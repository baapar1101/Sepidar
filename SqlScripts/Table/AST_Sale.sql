--<<FileName:AST_SALE.sql>>--
--<< TABLE DEFINITION >>--

IF (Object_ID('AST.Sale') Is Null)
BEGIN

CREATE TABLE [AST].[Sale](
	[SaleID] [int] NOT NULL,
	[Number] [int] NOT NULL,
	[Date] [datetime] NOT NULL,
	[PartyRef] [int] NOT NULL,
	[PartyAddressRef] [int] NULL,
	[VoucherRef] [int] NULL,
	[CurrencyRef] [int] NULL,
	[FiscalYearRef] [int] NOT NULL,
	[CurrencyRate] [decimal](26, 16) NULL,
	[SLAccountRef] [int] NULL,
	[Description] [nvarchar](255) NULL,
	[Description_En] [nvarchar](255) NULL,
	[Version] [int] NOT NULL,
	[Creator] [int] NOT NULL,
	[CreationDate] [DateTime] NOT NULL,
	[LastModifier] [int] NOT NULL,
	[LastModificationDate] [DateTime] NOT NULL,
	[IsRevoked] [BIT] NOT NULL DEFAULT 0,
	[TaxPayerBillIssueDateTime] [DateTime] NULL,
	[SettlementType] [int] NOT NULL
) ON [PRIMARY]
END

--TEXTIMAGE_ON [SGBlob_Data]
--When a table has text, ntext, image, varchar(max), nvarchar(max), varbinary(max), xml or large user defined type columns uncomment above code
GO
--<< ADD CLOLUMNS >>--

--<<Sample>>--

--<< PRIMARYKEY DEFINITION >>--

If not Exists (select 1 from sys.objects where name = 'PK_Sale')
ALTER TABLE [AST].[Sale] ADD  CONSTRAINT [PK_Sale] PRIMARY KEY CLUSTERED 
(
	[SaleId] ASC
) ON [PRIMARY]
GO

--<< ALTER COLUMNS >>--

IF NOT EXISTS (SELECT 1 FROM sys.columns WHERE object_id=object_id('AST.Sale') AND
				[name] = 'PartyAddressRef')
BEGIN
    ALTER TABLE [AST].[Sale] ADD [PartyAddressRef] INT NULL
END	
Go

IF NOT EXISTS (SELECT 1 FROM sys.columns WHERE object_id=object_id('AST.Sale') AND
				[name] = 'IsRevoked')
BEGIN
    ALTER TABLE [AST].[Sale] ADD [IsRevoked] BIT NOT NULL DEFAULT 0
END	
Go

IF NOT EXISTS (SELECT 1 FROM sys.columns WHERE object_id=object_id('AST.Sale') AND 
				[name] = 'TaxPayerBillIssueDateTime')
BEGIN
    ALTER TABLE [AST].[Sale] ADD [TaxPayerBillIssueDateTime] [DateTime] NULL;
    EXEC sp_executesql N'UPDATE [AST].[Sale] SET [TaxPayerBillIssueDateTime] = [Date]';
END
GO

IF NOT EXISTS (SELECT 1 FROM sys.columns WHERE OBJECT_ID = OBJECT_ID('AST.Sale') AND
				[name] = 'SettlementType')
BEGIN
    ALTER TABLE AST.[Sale] ADD [SettlementType] [int] NULL
	EXEC('UPDATE AST.[Sale] SET SettlementType = 1')
    ALTER TABLE AST.[Sale] ALTER COLUMN [SettlementType] [int] NOT NULL
END
GO

--<< DEFAULTS CHECKS DEFINITION >>--

--<< RULES DEFINITION >>--

--<< INDEXES DEFINITION >>--

--<< FOREIGNKEYS DEFINITION >>--
if NOT exists (select 1 from sys.objects where  name = N'FK_AST_Sale_SLAccountRef')
BEGIN
    ALTER TABLE [AST].[Sale]
    ADD CONSTRAINT [FK_AST_Sale_SLAccountRef] 
    FOREIGN KEY (SLAccountRef) REFERENCES [ACC].[Account](AccountId);
END    

Go
if NOT exists (select 1 from sys.objects where name =N'FK_AST_Sale_CurrencyRef') 
BEGIN    
    ALTER TABLE [AST].[Sale]
    ADD CONSTRAINT [FK_AST_Sale_CurrencyRef] 
    FOREIGN KEY (CurrencyRef) REFERENCES [GNR].[Currency](CurrencyID);
END
Go
if NOT exists (select 1 from sys.objects where name =N'FK_AST_Sale_PartyRef') 
BEGIN        
    ALTER TABLE [AST].[Sale]
    ADD CONSTRAINT [FK_AST_Sale_PartyRef] 
    FOREIGN KEY (PartyRef) REFERENCES [GNR].[Party](PartyID);
END    
Go

if NOT exists (select 1 from sys.objects where name =N'FK_AST_Sale_FiscalYearRef')
BEGIN        
    ALTER TABLE [AST].[Sale]
    ADD CONSTRAINT [FK_AST_Sale_FiscalYearRef] 
    FOREIGN KEY (FiscalYearRef) REFERENCES [FMK].[FiscalYear](FiscalYearId);
    
END	
Go
if NOT exists (select 1 from sys.objects where name =N'FK_AST_Sale_VoucherRef') 
BEGIN    
    ALTER TABLE [AST].[Sale]
    ADD CONSTRAINT [FK_AST_Sale_VoucherRef] 
    FOREIGN KEY (VoucherRef) REFERENCES [ACC].[Voucher](VoucherID);
END


--<< DROP OBJECTS >>--
