--<<FileName:GNR_TaxPayerUnitMapper.sql>>--

--<< TABLE DEFINITION >>--
IF Object_ID('GNR.TaxPayerUnitMapper') IS NULL
CREATE TABLE [GNR].[TaxPayerUnitMapper](
    [TaxPayerMapperUnitID] [int] NOT NULL,
    [UnitRef] INT NOT NULL,
    [TaxPayerUnitRef] INT NULL,
    [Version] [int] NOT NULL,
    [Creator] [int] NOT NULL,
    [CreationDate] [datetime] NOT NULL,
    [LastModifier] [int] NOT NULL,
    [LastModificationDate] [datetime] NOT NULL,
 CONSTRAINT [PK_TaxPayerUnitMapper] PRIMARY KEY CLUSTERED 
(
    [TaxPayerMapperUnitID] ASC

) ON [PRIMARY]
) ON [PRIMARY]

GO
--<< PRIMARYKEY DEFINITION >>--
If NOT EXISTS (select 1 from sys.objects where name = 'FK_GNR_TaxPayerUnitMapper_UnitRef')
ALTER TABLE [GNR].[TaxPayerUnitMapper] ADD CONSTRAINT [FK_GNR_TaxPayerUnitMapper_UnitRef] FOREIGN KEY(UnitRef)
REFERENCES INV.Unit(UnitID) ON DELETE CASCADE
GO
--<< INDEXES DEFINITION >>--
IF NOT EXISTS (SELECT 1 FROM sys.indexes WHERE name = 'UIX_UnitRef_TaxPayerUnitRef')
CREATE UNIQUE NONCLUSTERED INDEX [UIX_UnitRef_TaxPayerUnitRef] ON GNR.TaxPayerUnitMapper 
(
    [UnitRef] ASC,
    [TaxPayerUnitRef] ASC
) ON [PRIMARY]
GO

IF NOT EXISTS (SELECT 1 FROM sys.objects WHERE name = 'U_TaxPayerUnitMapper_UnitRef')
    ALTER TABLE [GNR].[TaxPayerUnitMapper] ADD CONSTRAINT [U_TaxPayerUnitMapper_UnitRef] UNIQUE ([UnitRef])
GO