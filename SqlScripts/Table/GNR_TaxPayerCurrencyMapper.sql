--<<FileName:GNR_TaxPayerCurrencyMapper.sql>>--

--<< TABLE DEFINITION >>--
IF Object_ID('GNR.TaxPayerCurrencyMapper') IS NULL
CREATE TABLE [GNR].[TaxPayerCurrencyMapper](
    [TaxPayerCurrencyMapperID] [int] NOT NULL,
    [CurrencyRef] INT NOT NULL,
    [TaxPayerCurrencyRef] INT NULL,
    [Version] [int] NOT NULL,
    [Creator] [int] NOT NULL,
    [CreationDate] [datetime] NOT NULL,
    [LastModifier] [int] NOT NULL,
    [LastModificationDate] [datetime] NOT NULL,
 CONSTRAINT [PK_TaxPayerCurrencyMapper] PRIMARY KEY CLUSTERED 
(
    [TaxPayerCurrencyMapperID] ASC

) ON [PRIMARY]
) ON [PRIMARY]

GO
--<< PRIMARYKEY DEFINITION >>--
If NOT EXISTS (select 1 from sys.objects where name = 'FK_TaxPayerCurrencyMapper_CurrencyRef')
ALTER TABLE [GNR].[TaxPayerCurrencyMapper] ADD CONSTRAINT [FK_TaxPayerCurrencyMapper_CurrencyRef] FOREIGN KEY(CurrencyRef)
REFERENCES GNR.Currency(CurrencyID) ON DELETE CASCADE
GO
--<< INDEXES DEFINITION >>--
IF NOT EXISTS (SELECT 1 FROM sys.indexes WHERE name = 'UIX_CurrencyRef_TaxPayerCurrencyRef')
CREATE UNIQUE NONCLUSTERED INDEX [UIX_CurrencyRef_TaxPayerCurrencyRef] ON GNR.TaxPayerCurrencyMapper 
(
    [CurrencyRef] ASC,
    [TaxPayerCurrencyRef] ASC
) ON [PRIMARY]
GO

IF NOT EXISTS (SELECT 1 FROM sys.objects WHERE name = 'U_TaxPayerCurrencyMapping_CurrencyRef')
    ALTER TABLE [GNR].[TaxPayerCurrencyMapper] ADD CONSTRAINT [U_TaxPayerCurrencyMapping_CurrencyRef] UNIQUE ([CurrencyRef])
GO
