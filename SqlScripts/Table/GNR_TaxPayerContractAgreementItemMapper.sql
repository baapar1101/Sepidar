--<<FileName:GNR_TaxPayerContractAgreementItemMapper.sql>>--
--<< TABLE DEFINITION >>--

If Object_ID('GNR.TaxPayerContractAgreementItemMapper') Is Null
CREATE TABLE [GNR].[TaxPayerContractAgreementItemMapper](
    [TaxPayerContractAgreementItemMapperID] [INT]          NOT NULL,
    [Serial]                                [nvarchar](13) NOT NULL,
    [SerialTitle]                           NVARCHAR(400)  NOT NULL,
    [TaxRate]                               DECIMAL(19, 4) NULL,
    [Version]                               [INT]          NOT NULL
) ON [PRIMARY]

--TEXTIMAGE_ON [SGBlob_Data]
--When a table has text, ntext, image, varchar(max), nvarchar(max), varbinary(max), xml or large user defined type columns uncomment above code
GO
--<< ADD CLOLUMNS >>--

IF NOT EXISTS (SELECT 1 FROM sys.columns WHERE object_id=object_id('GNR.TaxPayerContractAgreementItemMapper')
    AND name = 'SerialTitle')
BEGIN
    ALTER TABLE GNR.TaxPayerContractAgreementItemMapper ADD [SerialTitle] NVARCHAR(400) NOT NULL DEFAULT('')
END
GO

IF NOT EXISTS (SELECT 1 FROM sys.columns WHERE object_id=object_id('GNR.TaxPayerContractAgreementItemMapper')
    AND name = 'TaxRate')
BEGIN
    ALTER TABLE GNR.TaxPayerContractAgreementItemMapper ADD [TaxRate] DECIMAL(19, 4) NULL
END
GO
--<< ALTER COLUMNS >>--

--<< PRIMARYKEY DEFINITION >>--

IF NOT EXISTS (SELECT 1 FROM sys.objects WHERE name = 'PK_TaxPayerContractAgreementItemMapper')
ALTER TABLE [GNR].[TaxPayerContractAgreementItemMapper] ADD CONSTRAINT [PK_TaxPayerContractAgreementItemMapper] PRIMARY KEY CLUSTERED
(
    [TaxPayerContractAgreementItemMapperID] ASC
) ON [PRIMARY]
GO

--<< DEFAULTS CHECKS DEFINITION >>--

--<< RULES DEFINITION >>--

--<< INDEXES DEFINITION >>--

IF NOT EXISTS (SELECT 1 FROM sys.objects WHERE name = 'U_TaxPayerContractAgreementItemMapper_Serial')
    ALTER TABLE [GNR].[TaxPayerContractAgreementItemMapper] ADD CONSTRAINT [U_TaxPayerContractAgreementItemMapper_Serial] UNIQUE ([Serial])
GO

--<< FOREIGNKEYS DEFINITION >>--

--<< DROP OBJECTS >>--

IF EXISTS (SELECT 1 FROM sys.objects WHERE name = 'FK_TaxPayerContractAgreementItemMapper_ContractAgreementItemRef')
    ALTER TABLE [GNR].[TaxPayerContractAgreementItemMapper] DROP CONSTRAINT [FK_TaxPayerContractAgreementItemMapper_ContractAgreementItemRef]
GO

IF EXISTS (SELECT 1 FROM sys.columns WHERE object_id=object_id('GNR.TaxPayerContractAgreementItemMapper') and [name] = 'ContractAgreementItemRef')
BEGIN
    ALTER TABLE [GNR].[TaxPayerContractAgreementItemMapper] DROP COLUMN [ContractAgreementItemRef]
END
GO