--<<FileName:AST_SALEITEM.sql>>--
--<< TABLE DEFINITION >>--

IF (Object_ID('AST.SaleItem') Is Null)
BEGIN
CREATE TABLE [AST].[SaleItem](
	[SaleItemID] [int] NOT NULL,
	[AssetRef] [int] NOT NULL,
	[SaleRef] [int] NOT NULL,
	[SalePrice] [decimal](19, 4) NOT NULL,
	[SalePriceInBaseCurrency] [decimal](19, 4) NOT NULL,
	[Tax]				 [decimal] (19, 4)  NULL,
	[TaxInBaseCurrency]  [decimal] (19, 4)  NULL,
	[Duty]				 [decimal] (19, 4)  NULL,
	[DutyInBaseCurrency] [decimal] (19, 4)  NULL,
	[TaxPayerAssetSaleItemMapperRef] [int] NULL,
	[Description] [nvarchar](255) NULL,
	[Description_En] [nvarchar](255) NULL,
	[AssetTransactionRef] [int] NOT NULL,
 ) ON [PRIMARY]
END

--TEXTIMAGE_ON [SGBlob_Data]
--When a table has text, ntext, image, varchar(max), nvarchar(max), varbinary(max), xml or large user defined type columns uncomment above code
GO
--<< ADD CLOLUMNS >>--

--<<Sample>>--
/*IF NOT EXISTS (SELECT 1 FROM sys.columns WHERE OBJECT_ID = OBJECT_ID('SLS.Commission') AND
				[name] = 'ColumnName')
BEGIN
    ALTER TABLE SLS.Commission ADD ColumnName DataType Nullable
END
GO*/

IF NOT EXISTS (SELECT 1 FROM sys.columns WHERE OBJECT_ID = OBJECT_ID('AST.SaleItem')
												AND [name] = 'Tax')
	ALTER TABLE [AST].[SaleItem] ADD  [Tax] [decimal] (19, 4)  NULL
GO

IF NOT EXISTS (SELECT 1 FROM sys.columns WHERE OBJECT_ID = OBJECT_ID('AST.SaleItem')
												AND [name] = 'TaxInBaseCurrency')
	ALTER TABLE [AST].[SaleItem] ADD  [TaxInBaseCurrency] [decimal] (19, 4)  NULL
GO

IF NOT EXISTS (SELECT 1 FROM sys.columns WHERE OBJECT_ID = OBJECT_ID('AST.SaleItem')
												AND [name] = 'Duty')
	ALTER TABLE [AST].[SaleItem] ADD  [Duty] [decimal] (19, 4)  NULL
GO

IF NOT EXISTS (SELECT 1 FROM sys.columns WHERE OBJECT_ID = OBJECT_ID('AST.SaleItem')
												AND [name] = 'DutyInBaseCurrency')
	ALTER TABLE [AST].[SaleItem] ADD  [DutyInBaseCurrency] [decimal] (19, 4)  NULL
GO

IF NOT EXISTS (select 1 from sys.columns where OBJECT_ID=OBJECT_ID('AST.SaleItem') and
                [name] = 'TaxPayerAssetSaleItemMapperRef')
    ALTER TABLE [AST].[SaleItem] ADD [TaxPayerAssetSaleItemMapperRef] [int] NULL
GO

--<< ALTER COLUMNS >>--


--<< PRIMARYKEY DEFINITION >>--
If not Exists (select 1 from sys.objects where name = 'PK_SaleItem')
ALTER TABLE [AST].[SaleItem] ADD  CONSTRAINT [PK_SaleItem] PRIMARY KEY CLUSTERED 
(
	[SaleItemID] ASC
) ON [PRIMARY]
GO

--<< DEFAULTS CHECKS DEFINITION >>--

--<< RULES DEFINITION >>--

--<< INDEXES DEFINITION >>--

--<< FOREIGNKEYS DEFINITION >>--
if NOT exists (select 1 from sys.objects where name =N'FK_AST_SaleItem_SaleRef')
BEGIN
    ALTER TABLE [AST].[SaleItem]
    ADD CONSTRAINT [FK_AST_SaleItem_SaleRef]     
    FOREIGN KEY (SaleRef) 
	REFERENCES [AST].[Sale](SaleID)
	ON UPDATE CASCADE
    ON DELETE CASCADE
END
GO

If not Exists (select 1 from sys.objects where name = 'FK_AST_SaleItem_AssetRef')
ALTER TABLE [AST].[SaleItem]  ADD  CONSTRAINT [FK_AST_SaleItem_AssetRef] FOREIGN KEY(AssetRef)
REFERENCES [AST].[Asset](AssetId)

IF NOT EXISTS (SELECT 1 FROM sys.objects WHERE name = 'FK_SaleItem_TaxPayerAssetSaleItemMapperRef')
ALTER TABLE [AST].[SaleItem]  ADD  CONSTRAINT [FK_SaleItem_TaxPayerAssetSaleItemMapperRef] FOREIGN KEY([TaxPayerAssetSaleItemMapperRef])
REFERENCES [GNR].[TaxPayerAssetSaleItemMapper] ([TaxPayerAssetSaleItemMapperID])
ON DELETE SET NULL
GO