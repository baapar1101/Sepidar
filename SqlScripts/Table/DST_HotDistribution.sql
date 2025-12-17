--<<FileName:DST_HotDistribution.sql>>--

--<< TABLE DEFINITION >>--
IF OBJECT_ID('DST.HotDistribution') IS NULL
CREATE TABLE [DST].[HotDistribution](
	[HotDistributionId]		[INT]		NOT NULL,
	[Date]					[DATETIME]	NOT NULL,
	[Number]				[INT]		NOT NULL,
	[DistributorPartyRef]	[INT]		NOT NULL,
	[TruckRef]				[INT]		NOT NULL,
	[DriverPartyRef]		[INT]		NULL,
	[StockRef]				[INT]		NOT NULL,
	[InventoryDeliveryRef]	[INT]		NULL,
	[State]					[INT]		NOT NULL,
	[IsModifiedByDevice]	[BIT]		NOT NULL,
	[FiscalYearRef]			[INT]		NOT NULL,
	[TransferHotDistributionRef]  [INT]         ,
	[Version]				[INT]		NOT NULL,
	[Creator]				[INT]		NOT NULL,
	[CreationDate]			[DATETIME]	NOT NULL,
	[LastModifier]			[INT]		NOT NULL,
	[LastModificationDate]	[DATETIME]	NOT NULL
) ON [PRIMARY]

--TEXTIMAGE_ON [SGBlob_Data]
--When a table has text, ntext, image, varchar(max), nvarchar(max), varbinary(max), xml or large user defined type columns uncomment above code
GO
--<< ADD CLOLUMNS >>--
IF NOT EXISTS (SELECT 1 FROM sys.columns WHERE [object_id]=OBJECT_ID('DST.HotDistribution') AND [name] = 'IsModifiedByDevice')
BEGIN
	ALTER TABLE [DST].[HotDistribution] ADD [IsModifiedByDevice] [BIT] NOT NULL DEFAULT(0)
END
GO
IF NOT EXISTS (SELECT 1 FROM sys.columns WHERE [object_id]=OBJECT_ID('DST.HotDistribution') AND [name] = 'TransferHotDistributionRef')
BEGIN
	ALTER TABLE [DST].[HotDistribution] ADD [TransferHotDistributionRef] [INT] 
END
GO
--<<Sample>>--
/*if not exists (select 1 from sys.columns where object_id=object_id('DST.AreaAndPath') and
				[name] = 'ColumnName')
begin
    Alter table DST.AreaAndPath Add ColumnName DataType Nullable
end
GO*/

--<< ALTER COLUMNS >>--

--<< PRIMARYKEY DEFINITION >>--
IF NOT EXISTS (SELECT 1 FROM sys.objects WHERE NAME = 'PK_HotDistribution')
ALTER TABLE [DST].[HotDistribution] ADD CONSTRAINT [PK_HotDistribution] PRIMARY KEY CLUSTERED 
(
	[HotDistributionId] ASC
) ON [PRIMARY]
GO

--<< DEFAULTS CHECKS DEFINITION >>--

--<< RULES DEFINITION >>--

--<< INDEXES DEFINITION >>--
IF NOT EXISTS (SELECT 1 FROM sys.indexes WHERE NAME = 'UIX_HotDistribution_Number_FiscalYearRef')
CREATE UNIQUE NONCLUSTERED INDEX [UIX_HotDistribution_Number_FiscalYearRef] ON [DST].[HotDistribution] 
(
	[Number] ASC,
	[FiscalYearRef] ASC
) ON [PRIMARY]

GO

--<< FOREIGNKEYS DEFINITION >>--
IF NOT EXISTS (SELECT 1 FROM sys.objects WHERE NAME = 'FK_HotDistribution_DistributorPartyRef')
ALTER TABLE [DST].[HotDistribution]  ADD CONSTRAINT [FK_HotDistribution_DistributorPartyRef] FOREIGN KEY([DistributorPartyRef])
REFERENCES [GNR].[Party] ([PartyId])

GO

IF NOT EXISTS (SELECT 1 FROM sys.objects WHERE NAME = 'FK_HotDistribution_TruckRef')
ALTER TABLE [DST].[HotDistribution]  ADD CONSTRAINT [FK_HotDistribution_TruckRef] FOREIGN KEY([TruckRef])
REFERENCES [GNR].[Truck] ([TruckId])

GO

IF NOT EXISTS (SELECT 1 FROM sys.objects WHERE NAME = 'FK_HotDistribution_DriverPartyRef')
ALTER TABLE [DST].[HotDistribution]  ADD CONSTRAINT [FK_HotDistribution_DriverPartyRef] FOREIGN KEY([DriverPartyRef])
REFERENCES [GNR].[Party] ([PartyId])

GO

IF NOT EXISTS (SELECT 1 FROM sys.objects WHERE NAME = 'FK_HotDistribution_StockRef')
ALTER TABLE [DST].[HotDistribution]  ADD CONSTRAINT [FK_HotDistribution_StockRef] FOREIGN KEY([StockRef])
REFERENCES [INV].[Stock] ([StockId])

GO

IF NOT EXISTS (SELECT 1 FROM sys.objects WHERE NAME = 'FK_HotDistribution_FiscalYearRef')
ALTER TABLE [DST].[HotDistribution]  ADD CONSTRAINT [FK_HotDistribution_FiscalYearRef] FOREIGN KEY([FiscalYearRef])
REFERENCES [FMK].[FiscalYear] ([FiscalYearId])

GO

IF NOT EXISTS (SELECT 1 FROM sys.objects WHERE name = 'FK_HotDistribution_InventoryDeliveryRef')
	ALTER TABLE [DST].[HotDistribution] ADD CONSTRAINT [FK_HotDistribution_InventoryDeliveryRef] FOREIGN KEY([InventoryDeliveryRef])
	REFERENCES [INV].[InventoryDelivery] ([InventoryDeliveryID])

GO

--<< DROP OBJECTS >>--
IF EXISTS (SELECT 1 FROM sys.indexes WHERE NAME = 'UIX_InventoryDeliveryRef') -- ToDo: Delete before Release
DROP INDEX [UIX_InventoryDeliveryRef] ON [DST].[HotDistribution] 

GO

