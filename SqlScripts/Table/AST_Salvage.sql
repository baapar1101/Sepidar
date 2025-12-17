--<<FileName:AST_Salvage.sql>>--
--<< TABLE DEFINITION >>--

IF (Object_ID('AST.Salvage') Is Null)
BEGIN

CREATE TABLE [AST].[Salvage](
	[SalvageID] [int] NOT NULL,
	[Number] [int] NOT NULL,
	[Date] [datetime] NOT NULL,
	[VoucherRef] [int] NULL,
	[FiscalYearRef] [int] NOT NULL,
	[LossSLRef] [int] NULL,
	[Description] [nvarchar](255) NULL,
	[Description_En] [nvarchar](255) NULL,
	[Version] [int] NOT NULL,
	[Creator] [int] NOT NULL,
	[CreationDate] [Date] NOT NULL,
	[LastModifier] [int] NOT NULL,
	[LastModificationDate] [DateTime] NOT NULL,
) ON [PRIMARY]
END

--TEXTIMAGE_ON [SGBlob_Data]
--When a table has text, ntext, image, varchar(max), nvarchar(max), varbinary(max), xml or large user defined type columns uncomment above code
GO
--<< ADD CLOLUMNS >>--

--<<Sample>>--

--<< PRIMARYKEY DEFINITION >>--
If not Exists (select 1 from sys.objects where name = 'PK_Salvage')
ALTER TABLE [AST].[Salvage] ADD  CONSTRAINT [PK_Salvage] PRIMARY KEY CLUSTERED 
(
	[SalvageId] ASC
) ON [PRIMARY]
GO


--<< ALTER COLUMNS >>--

IF (SELECT COLUMNPROPERTY(OBJECT_ID('AST.Salvage', 'U'), 'LossSLRef', 'AllowsNull')) = 0
BEGIN
	ALTER TABLE [AST].[Salvage] ALTER COLUMN [LossSLRef] INTEGER NULL
END

GO

IF EXISTS(SELECT 1 FROM sys.columns 
          WHERE Name = N'CurrencyRef'
          AND Object_ID = Object_ID(N'AST.Salvage'))
BEGIN
    ALTER TABLE [AST].[Salvage] DROP COLUMN [CurrencyRef]
END

--<< DEFAULTS CHECKS DEFINITION >>--

--<< RULES DEFINITION >>--

--<< INDEXES DEFINITION >>--

--<< FOREIGNKEYS DEFINITION >>--
if NOT exists (select 1 from sys.objects where  name = N'FK_AST_Salvage_LossSLRef')
BEGIN
    ALTER TABLE [AST].[Salvage]
    ADD CONSTRAINT [FK_AST_Salvage_LossSLRef] 
    FOREIGN KEY (LossSLRef) REFERENCES [ACC].[Account](AccountId);
END    

Go


if NOT exists (select 1 from sys.objects where name =N'FK_AST_Salvage_FiscalYearRef')
BEGIN        
    ALTER TABLE [AST].[Salvage]
    ADD CONSTRAINT [FK_AST_Salvage_FiscalYearRef] 
    FOREIGN KEY (FiscalYearRef) REFERENCES [FMK].[FiscalYear](FiscalYearId);
    
END	
Go
if NOT exists (select 1 from sys.objects where name =N'FK_AST_Salvage_VoucherRef') 
BEGIN    
    ALTER TABLE [AST].[Salvage]
    ADD CONSTRAINT [FK_AST_Salvage_VoucherRef] 
    FOREIGN KEY (VoucherRef) REFERENCES [ACC].[Voucher](VoucherID);
END


--<< DROP OBJECTS >>--
