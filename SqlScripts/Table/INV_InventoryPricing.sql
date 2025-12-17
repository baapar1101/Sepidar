--<<FileName:INV_InventoryPricing.sql>>--
--<< TABLE DEFINITION >>--

If Object_ID('INV.InventoryPricing') Is Null
CREATE TABLE [INV].[InventoryPricing](
	[InventoryPricingID] [int] NOT NULL,
	[StockRef] [int] NOT NULL,
	[StartDate] [datetime] NOT NULL,
	[EndDate] [datetime] NOT NULL,
	[Inputs] [int] NOT NULL,
	[Outputs] [int] NOT NULL,
	[FiscalYearRef] [int] NOT NULL,
	[Creator] [int] NULL,
	[CreationDate] [datetime] NULL,
	[LastModifier] [int] NULL,
	[LastModificationDate] [datetime] NULL,
	[Version] [int] NOT NULL
) ON [PRIMARY]

--TEXTIMAGE_ON [SGBlob_Data]
--When a table has text, ntext, image, varchar(max), nvarchar(max), varbinary(max), xml or large user defined type columns uncomment above code
GO
--<< ADD CLOLUMNS >>--
IF NOT EXISTS (SELECT 1 FROM sys.columns WHERE object_id=object_id('INV.InventoryPricing') AND
				[Name]='FiscalYearRef')
	ALTER TABLE INV.InventoryPricing
		ADD FiscalYearRef INT NULL

GO

IF EXISTS (SELECT 1 FROM sys.columns WHERE object_id=object_id('INV.InventoryPricing') AND
				[Name]='FiscalYearRef' and is_nullable=1)
BEGIN
	DECLARE @fy INT
	SELECT TOP 1 @fy =FiscalYearId FROM FMK.FiscalYear
	UPDATE INV.InventoryPricing SET FiscalYearRef=@fy
	ALTER TABLE INV.InventoryPricing
		ALTER COLUMN FiscalYearRef INT NOT NULL
END
--<<Sample>>--
/*if not exists (select 1 from sys.columns where object_id=object_id('INV.InventoryPricing') and
				[name] = 'ColumnName')
begin
    Alter table INV.InventoryPricing Add ColumnName DataType Nullable
end
GO*/

--<< ALTER COLUMNS >>--

--<< PRIMARYKEY DEFINITION >>--

If not Exists (select 1 from sys.objects where name = 'PK_InventoryPricing')
ALTER TABLE [INV].[InventoryPricing] ADD  CONSTRAINT [PK_InventoryPricing] PRIMARY KEY CLUSTERED 
(
	[InventoryPricingID] ASC
) ON [PRIMARY]
GO

--<< DEFAULTS CHECKS DEFINITION >>--

--<< RULES DEFINITION >>--

--<< INDEXES DEFINITION >>--

--<< FOREIGNKEYS DEFINITION >>--

If not Exists (select 1 from sys.objects where name = 'FK_InventoryPricing_Stock')
ALTER TABLE [INV].[InventoryPricing]  ADD  CONSTRAINT [FK_InventoryPricing_Stock] FOREIGN KEY([StockRef])
REFERENCES [INV].[Stock] ([StockID])

IF NOT EXISTS (SELECT 1 FROM sys.objects WHERE NAME='FK_InventoryPricing_FiscalYear')
	ALTER TABLE INV.InventoryPricing ADD CONSTRAINT FK_InventoryPricing_FiscalYear
	FOREIGN KEY(FiscalYearRef) REFERENCES [FMK].[FiscalYear] ([FiscalYearId])

GO

--<< DROP OBJECTS >>--
