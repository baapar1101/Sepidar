--<<FileName:GNR_TaxPayerItemMapping.sql>>--
--<< TABLE DEFINITION >>--

If Object_ID('GNR.TaxPayerItemMapping') Is Null
CREATE TABLE [GNR].[TaxPayerItemMapping](
	[TaxPayerItemMappingID] [int]			NOT NULL,
	[ItemRef]				[int]			NOT NULL,
	[Serial]				[nvarchar](13)	NULL,
    [TaxPayerCurrencyRef]   [INT]           NULL,
	[Version]				[INT]			NOT NULL
) ON [PRIMARY]

--TEXTIMAGE_ON [SGBlob_Data]
--When a table has text, ntext, image, varchar(max), nvarchar(max), varbinary(max), xml or large user defined type columns uncomment above code
GO
--<< ADD CLOLUMNS >>--

IF NOT EXISTS (SELECT 1 FROM sys.columns WHERE object_id=object_id('GNR.TaxPayerItemMapping') AND
	[name] = 'TaxPayerCurrencyRef')
BEGIN
	ALTER TABLE GNR.TaxPayerItemMapping ADD TaxPayerCurrencyRef int NULL
END
GO

--<< ALTER COLUMNS >>--

--<< PRIMARYKEY DEFINITION >>--

IF NOT EXISTS (SELECT 1 FROM sys.objects WHERE name = 'PK_TaxPayerItemMapping')
ALTER TABLE [GNR].[TaxPayerItemMapping] ADD CONSTRAINT [PK_TaxPayerItemMapping] PRIMARY KEY CLUSTERED
(
    [TaxPayerItemMappingID] ASC
) ON [PRIMARY]
GO

--<< DEFAULTS CHECKS DEFINITION >>--

--<< RULES DEFINITION >>--

--<< INDEXES DEFINITION >>--

IF NOT EXISTS (SELECT 1 FROM sys.indexes WHERE name = 'UIX_TaxPayerItemMapping_ItemRefSerial')
CREATE UNIQUE NONCLUSTERED INDEX [UIX_TaxPayerItemMapping_ItemRefSerial] ON [GNR].[TaxPayerItemMapping]
(
    [ItemRef],
    [Serial]
) ON [PRIMARY]
GO

IF NOT EXISTS (SELECT 1 FROM sys.objects WHERE name = 'U_TaxPayerItemMapping_ItemRef')
    ALTER TABLE [GNR].[TaxPayerItemMapping] ADD CONSTRAINT [U_TaxPayerItemMapping_ItemRef] UNIQUE ([ItemRef])
GO

--<< FOREIGNKEYS DEFINITION >>--

IF NOT EXISTS (SELECT 1 FROM sys.objects WHERE name = 'FK_TaxPayerItemMapping_ItemRef')
ALTER TABLE [GNR].[TaxPayerItemMapping] ADD CONSTRAINT [FK_TaxPayerItemMapping_ItemRef] FOREIGN KEY([ItemRef])
REFERENCES [INV].[Item] ([ItemID])
ON DELETE CASCADE
GO

IF NOT EXISTS (SELECT 1 FROM sys.objects WHERE name = 'FK_TaxPayerItemMapping_TaxPayerCurrencyRef')
ALTER TABLE [GNR].[TaxPayerItemMapping] ADD CONSTRAINT [FK_TaxPayerItemMapping_TaxPayerCurrencyRef] FOREIGN KEY([TaxPayerCurrencyRef])
REFERENCES [GNR].[TaxPayerCurrency] ([TaxPayerCurrencyID])
ON DELETE SET NULL
GO

--<< DROP OBJECTS >>--
