--<<FileName:GNR_TaxPayerContractMapper.sql>>--

--<< TABLE DEFINITION >>--
IF Object_ID('GNR.TaxPayerContractMapper') IS NULL
CREATE TABLE [GNR].[TaxPayerContractMapper](
	[TaxPayerContractMapperID] [int] NOT NULL,
	[ContractRef] INT NOT NULL,
	[TaxPayerContractSerial] [nvarchar](12)	NULL,
	[Version] [int] NOT NULL,
 CONSTRAINT [PK_TaxPayerContractMapper] PRIMARY KEY CLUSTERED 
(
	[TaxPayerContractMapperID] ASC

) ON [PRIMARY]
) ON [PRIMARY]

GO
--<< PRIMARYKEY DEFINITION >>--
If NOT EXISTS (select 1 from sys.objects where name = 'FK_TaxPayerContractMapper_ContractRef')
ALTER TABLE [GNR].[TaxPayerContractMapper] ADD CONSTRAINT [FK_TaxPayerContractMapper_ContractRef] FOREIGN KEY(ContractRef)
REFERENCES CNT.Contract(ContractID) ON DELETE CASCADE
GO
--<< INDEXES DEFINITION >>--
IF NOT EXISTS (SELECT 1 FROM sys.indexes WHERE name = 'UIX_TaxPayerContractMapping_TaxPayerContractSerial')
CREATE UNIQUE NONCLUSTERED INDEX [UIX_TaxPayerContractMapping_TaxPayerContractSerial] ON GNR.TaxPayerContractMapper 
(
	[ContractRef],
	[TaxPayerContractSerial]
) ON [PRIMARY]
GO
