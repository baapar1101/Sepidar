--<<FileName:GNR_TaxPayerAssetSaleItemMapper.sql>>--
--<< TABLE DEFINITION >>--

If Object_ID('GNR.TaxPayerAssetSaleItemMapper') Is Null
CREATE TABLE [GNR].[TaxPayerAssetSaleItemMapper](
    [TaxPayerAssetSaleItemMapperID] [INT]          NOT NULL,
    [Serial]                                [nvarchar](13) NOT NULL,
    [SerialTitle]                           NVARCHAR(400)  NOT NULL,
    [TaxRate]                               DECIMAL(19, 4) NULL,
    [Version]                               [INT]          NOT NULL
) ON [PRIMARY]


GO
--<< ADD CLOLUMNS >>--

--<< ALTER COLUMNS >>--

--<< PRIMARYKEY DEFINITION >>--

IF NOT EXISTS (SELECT 1 FROM sys.objects WHERE name = 'PK_TaxPayerAssetSaleItemMapper')
ALTER TABLE [GNR].[TaxPayerAssetSaleItemMapper] ADD CONSTRAINT [PK_TaxPayerAssetSaleItemMapper] PRIMARY KEY CLUSTERED
(
    [TaxPayerAssetSaleItemMapperID] ASC
) ON [PRIMARY]
GO

--<< DEFAULTS CHECKS DEFINITION >>--

--<< RULES DEFINITION >>--

--<< INDEXES DEFINITION >>--

IF NOT EXISTS (SELECT 1 FROM sys.objects WHERE name = 'U_TaxPayerAssetSaleItemMapper_Serial')
    ALTER TABLE [GNR].[TaxPayerAssetSaleItemMapper] ADD CONSTRAINT [U_TaxPayerAssetSaleItemMapper_Serial] UNIQUE ([Serial])
GO

--<< FOREIGNKEYS DEFINITION >>--

--<< DROP OBJECTS >>--
