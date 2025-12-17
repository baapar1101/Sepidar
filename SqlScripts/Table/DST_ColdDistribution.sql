--<<FileName:DST_ColdDistribution.sql>>--

--<< TABLE DEFINITION >>--
IF Object_ID('DST.ColdDistribution') IS NULL
CREATE TABLE [DST].[ColdDistribution](
	[ColdDistributionId]			[INT]		NOT NULL,
	[Date]							[DATETIME]	NOT NULL,
	[Number]						[INT]		NOT NULL,
	[DistributorPartyRef]			[INT]		NULL,
	[TruckRef]						[INT]		NULL,
	[DriverPartyRef]				[INT]		NULL,
	[State]							[INT]		NOT NULL,
	[IsModifiedByDevice]			[BIT]		NOT NULL DEFAULT(0),

	[FiscalYearRef]					[INT]		NOT NULL,

	[Version]						[INT]		NOT NULL,
	[Creator]						[INT]		NOT NULL,
	[CreationDate]					[DATETIME]	NOT NULL,
	[LastModifier]					[INT]		NOT NULL,
	[LastModificationDate]			[DATETIME]	NOT NULL
) ON [PRIMARY]

--TEXTIMAGE_ON [SGBlob_Data]
--When a table has text, ntext, image, varchar(max), nvarchar(max), varbinary(max), xml or large user defined type columns uncomment above code
GO
--<< ADD CLOLUMNS >>--
IF NOT EXISTS (SELECT 1 FROM sys.columns WHERE [object_id]=OBJECT_ID('DST.ColdDistribution') AND [name] = 'IsModifiedByDevice')
BEGIN
	ALTER TABLE [DST].[ColdDistribution] ADD [IsModifiedByDevice] [BIT] NOT NULL DEFAULT(0)
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
IF NOT EXISTS (SELECT 1 FROM sys.objects WHERE NAME = 'PK_ColdDistribution')
ALTER TABLE [DST].[ColdDistribution] ADD CONSTRAINT [PK_ColdDistribution] PRIMARY KEY CLUSTERED 
(
	[ColdDistributionId] ASC
) ON [PRIMARY]
GO

--<< DEFAULTS CHECKS DEFINITION >>--

--<< RULES DEFINITION >>--

--<< INDEXES DEFINITION >>--
IF NOT EXISTS (SELECT 1 FROM sys.indexes WHERE NAME = 'UIX_ColdDistribution_Number_FiscalYearRef')
CREATE UNIQUE NONCLUSTERED INDEX [UIX_ColdDistribution_Number_FiscalYearRef] ON [DST].[ColdDistribution] 
(
	[Number] ASC,
	[FiscalYearRef] ASC
) ON [PRIMARY]

GO

--<< FOREIGNKEYS DEFINITION >>--
IF NOT EXISTS (SELECT 1 FROM sys.objects WHERE NAME = 'FK_ColdDistribution_DistributorPartyRef')
ALTER TABLE [DST].[ColdDistribution]  ADD CONSTRAINT [FK_ColdDistribution_DistributorPartyRef] FOREIGN KEY([DistributorPartyRef])
REFERENCES [GNR].[Party] ([PartyId])

GO

IF NOT EXISTS (SELECT 1 FROM sys.objects WHERE NAME = 'FK_ColdDistribution_TruckRef')
ALTER TABLE [DST].[ColdDistribution]  ADD CONSTRAINT [FK_ColdDistribution_TruckRef] FOREIGN KEY([TruckRef])
REFERENCES [GNR].[Truck] ([TruckId])

GO

IF NOT EXISTS (SELECT 1 FROM sys.objects WHERE NAME = 'FK_ColdDistribution_DriverPartyRef')
ALTER TABLE [DST].[ColdDistribution]  ADD CONSTRAINT [FK_ColdDistribution_DriverPartyRef] FOREIGN KEY([DriverPartyRef])
REFERENCES [GNR].[Party] ([PartyId])

GO

--<< DROP OBJECTS >>--
