--<<FileName:PAY_Branch.sql>>--
--<< TABLE DEFINITION >>--

If Object_ID('PAY.Branch') Is Null
CREATE TABLE [PAY].[Branch](
	[BranchId] [int] NOT NULL,
	[Type] [int] NOT NULL,
	[BranchPartyRef] [int] NOT NULL,
	[Code] [nvarchar](40) NOT NULL,
	[WorkshopName] [nvarchar](200) NULL,
	[Company] [nvarchar](200) NULL,
	[WorkshopAddress] [nvarchar](500) NULL,
	[ContractNumber] [nvarchar](40) NULL,
	[NoInsurancePersonsCount] [int] NOT NULL,
	[AdjustmentType] [int] NOT NULL,
	[CostCenterRef] [int] NULL,
	[CostCenterDlRef] [int] NULL,
	[Version] [int] NOT NULL,
	[Creator] [int] NOT NULL,
	[CreationDate] [datetime] NOT NULL,
	[LastModifier] [int] NOT NULL,
	[LastModificationDate] [datetime] NOT NULL
) ON [PRIMARY]

--TEXTIMAGE_ON [SGBlob_Data]
--When a table has text, ntext, image, varchar(max), nvarchar(max), varbinary(max), xml or large user defined type columns uncomment above code
GO
--<< ADD CLOLUMNS >>--

--<<Sample>>--
IF NOT EXISTS (SELECT 1 FROM sys.columns WHERE object_id = object_id('PAY.Branch') AND
				[Name] = 'CostCenterRef')
BEGIN
    ALTER TABLE PAY.Branch ADD [CostCenterRef] [int] NULL
END
GO

IF NOT EXISTS (SELECT 1 FROM sys.columns WHERE object_id = object_id('PAY.Branch') AND
				[Name] = 'CostCenterDlRef')
BEGIN
    ALTER TABLE PAY.Branch ADD [CostCenterDlRef] [int] NULL
END
GO

IF NOT EXISTS (SELECT
			1
		FROM sys.columns
		WHERE object_id = OBJECT_ID('PAY.Branch')
		AND [Name] = 'WorkshopName')
	ALTER TABLE PAY.Branch ADD [WorkshopName] [NVARCHAR](200) NULL
	EXEC sp_executesql N'UPDATE PAY.Branch SET WorkshopName = (SELECT value FROM FMK.Configuration WHERE [key] = ''InsuranceWorkshopName'') WHERE Type=1'
GO
IF NOT EXISTS (SELECT
			1
		FROM sys.columns
		WHERE object_id = OBJECT_ID('PAY.Branch')
		AND [Name] = 'Company')
	ALTER TABLE PAY.Branch ADD [Company] [NVARCHAR](200) NULL
	EXEC sp_executesql N'UPDATE PAY.Branch SET Company = (SELECT value FROM FMK.Configuration WHERE [key] = ''InsuranceCompany'') WHERE Type=1'
GO
IF NOT EXISTS (SELECT
			1
		FROM sys.columns
		WHERE object_id = OBJECT_ID('PAY.Branch')
		AND [Name] = 'WorkshopAddress')
	ALTER TABLE PAY.Branch ADD [WorkshopAddress] [NVARCHAR](500) NULL
	EXEC sp_executesql N'UPDATE PAY.Branch SET WorkshopAddress = (SELECT value FROM FMK.Configuration WHERE [key] = ''InsuranceAddress'') WHERE Type=1'
GO

--<< ALTER COLUMNS >>--
ALTER TABLE [PAY].[Branch]
	ALTER COLUMN [Code] [nvarchar](40) NULL

--rename column
IF EXISTS (select 1 from sys.columns where object_id=object_id('PAY.Branch') and [name] = 'InsuranceCalcType')
	EXEC sp_rename 'PAY.Branch.InsuranceCalcType', 'AdjustmentType', 'COLUMN'  


--<< PRIMARYKEY DEFINITION >>--

If not Exists (select 1 from sys.objects where name = 'PK_Branch')
ALTER TABLE [PAY].[Branch] ADD  CONSTRAINT [PK_Branch] PRIMARY KEY CLUSTERED 
(
	[BranchId] ASC
) ON [PRIMARY]
GO

--<< DEFAULTS CHECKS DEFINITION >>--

--<< RULES DEFINITION >>--

--<< INDEXES DEFINITION >>--
If not Exists (select 1 from sys.indexes where name = 'UIX_Branch_BranchPartyRef')
CREATE UNIQUE NONCLUSTERED INDEX [UIX_Branch_BranchPartyRef] ON [PAY].[Branch] 
(
	[BranchPartyRef] ASC
) ON [PRIMARY]


--<< FOREIGNKEYS DEFINITION >>--

If not Exists (select 1 from sys.objects where name = 'FK_Branch_BranchPartyRef')
ALTER TABLE [PAY].[Branch]  ADD  CONSTRAINT [FK_Branch_BranchPartyRef] FOREIGN KEY([BranchPartyRef])
REFERENCES [GNR].[Party] ([PartyId])

GO

--<< DROP OBJECTS >>--
