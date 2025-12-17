/****** Object:  Table GNR.Carriage    Script Date: 17/01/1398 09:09:44 Þ.Ù ******/
IF Object_ID('GNR.Truck') IS NULL
CREATE TABLE GNR.Truck (
	[TruckID] [int] NOT NULL,
	[BrokerPartyRef] [int] NULL,
	[Title] [nvarchar](255) NOT NULL,
	[Title_En] [nvarchar](255) NOT NULL,
    [VehicleNumber] [nvarchar](127) NOT NULL,
	[DrivingLicenseNumber] [nvarchar](127) NULL,
	[MinimumWeight] [Decimal] (19,4) NULL,
	[MaximumWeight] [Decimal] (19,4) NULL,
	[MinimumVolumeCapacity] [Decimal] (19,4) NULL,
	[MaximumVolumeCapacity] [Decimal] (19,4) NULL,
	[Creator] [int] NOT NULL,
	[CreationDate] [datetime] NOT NULL,
	[LastModifier] [int] NOT NULL,
	[LastModificationDate] [datetime] NOT NULL,
	[Version] [int] NOT NULL,
) ON [PRIMARY]
GO

IF NOT EXISTS (select 1 from sys.objects where name = 'PK_Truck')
ALTER TABLE [GNR].[Truck] ADD  CONSTRAINT [PK_Truck] PRIMARY KEY CLUSTERED 
(
	[TruckID] ASC
) ON [PRIMARY]
GO
--<<Dropping incorrct columns>>--
IF EXISTS (Select 1 From sys.objects Where Name = 'FK_GNR_WeightUnit')
ALTER TABLE GNR.Truck Drop Constraint  [FK_GNR_WeightUnit]

IF EXISTS (Select 1 From sys.columns where name = 'WeightUnitRef')
ALTER TABLE GNR.Truck Drop Column [WeightUnitRef]

IF EXISTS (Select 1 From sys.objects Where Name = 'FK_GNR_VolumeUnit')
ALTER TABLE GNR.Truck Drop Constraint  [FK_GNR_VolumeUnit]

IF EXISTS (Select 1 From sys.columns where name = 'VolumeUnitRef')
ALTER TABLE GNR.Truck Drop Column [VolumeUnitRef]

--<< INDEXES DEFINITION >>--

IF NOT EXISTS (SELECT 1 FROM sys.columns WHERE object_id=object_id('GNR.Truck') AND
				[Name]='BrokerPartyCode')
	ALTER TABLE GNR.Truck ADD [BrokerPartyCode] [int] NULL 

IF NOT EXISTS (SELECT 1 FROM sys.indexes WHERE name = 'UIX_Truck_VehicleNumber')
CREATE UNIQUE NONCLUSTERED INDEX [UIX_Truck_VehicleNumber] ON [GNR].[Truck]
(
	[VehicleNumber] ASC
) ON [PRIMARY]
GO
--<< ADD CLOLUMNS >>--
    IF NOT EXISTS (SELECT 1 FROM SYS.COLUMNS WHERE OBJECT_ID = OBJECT_ID('GNR.Truck') AND
				[NAME] = 'IsActive')
BEGIN
    ALTER TABLE GNR.[Truck] ADD [IsActive] [BIT] NOT NULL DEFAULT 1
END
GO
--<< FOREIGNKEYS DEFINITION >>--
IF NOT EXISTS (SELECT 1 FROM sys.objects WHERE Name='FK_GNR_PARTY')
ALTER TABLE [GNR].[Truck]  WITH CHECK ADD  CONSTRAINT [FK_GNR_PARTY] FOREIGN KEY([BrokerPartyRef])
REFERENCES [GNR].[Party] ([PartyId])
GO