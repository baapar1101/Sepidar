--<<FileName:GNR_MarketingDiskette1396.sql>>--
--<< TABLE DEFINITION >>--

If Object_ID('GNR.MarketingDiskette1396') Is Null
CREATE TABLE [GNR].[MarketingDiskette1396](
	[MarketingDisketteID] [int] NOT NULL,
	[year] int NOT NULL,
	[Season] int NOT NULL, 
	[Type] int NOT NULL,  /*Buy = 1, Sales = 2, BuyAndSales = Buy | Sales, Status = 4, BuyAndStatus = Buy | Status, SalesAndStatus = Sales | Status, All = Buy | Sales | Status*/ /*Import Export*/
	--[Month] [int] NOT NULL,
	--[PeriodType] [int] NOT NULL, /* Season  , Month */
	--FillItemNameByCategory BIT NOT NULL,

	[Version] [int] NOT NULL,
	[Creator] [int] NOT NULL,
	[CreationDate] [datetime] NOT NULL,
	[LastModifier] [int] NOT NULL,
	[LastModificationDate] [datetime] NOT NULL
) ON [PRIMARY]
GO

--TEXTIMAGE_ON [SGBlob_Data]
--When a table has text, ntext, image, varchar(max), nvarchar(max), varbinary(max), xml or large user defined type columns uncomment above code
GO
--<< ADD CLOLUMNS >>--
--<< ALTER COLUMNS >>--
--<< PRIMARYKEY DEFINITION >>--

If not Exists (select 1 from sys.objects where name = 'PK_MarketingDiskette1396')
ALTER TABLE [GNR].[MarketingDiskette1396] ADD  CONSTRAINT [PK_MarketingDiskette1396] PRIMARY KEY CLUSTERED 
(
	[MarketingDisketteID] ASC
) ON [PRIMARY]
GO

--<< DEFAULTS CHECKS DEFINITION >>--

--<< RULES DEFINITION >>--

--<< INDEXES DEFINITION >>--
IF  EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[GNR].[MarketingDiskette1396]') AND name = N'UIX_MarketingDiskette1396_Year_Season')
ALTER TABLE [GNR].[MarketingDiskette1396] DROP CONSTRAINT [UIX_MarketingDiskette1396_Year_Season]
GO

If not Exists (select 1 from sys.indexes where name = 'UIX_MarketingDiskette1396_Year_Season')
ALTER TABLE [GNR].[MarketingDiskette1396] ADD  CONSTRAINT [UIX_MarketingDiskette1396_Year_Season] UNIQUE NONCLUSTERED 
(
	[Year]  ASC,
	[Season] ASC,
	[Type] ASC
	--[Month] ASC,
	--[PeriodType] ASC,
) ON [PRIMARY]

--IF  EXISTS (SELECT * FROM sys.check_constraints WHERE object_id = OBJECT_ID(N'[GNR].[CK_MarketingDiskette1396_SeasonGE1LE15]') AND parent_object_id = OBJECT_ID(N'[GNR].[MarketingDiskette1396]'))
--ALTER TABLE [GNR].[MarketingDiskette1396] DROP CONSTRAINT [CK_MarketingDiskette1396_SeasonGE1LE15]

--IF  NOT EXISTS (SELECT * FROM sys.check_constraints WHERE object_id = OBJECT_ID(N'[GNR].[CK_MarketingDiskette1396_SeasonGE0LE15]') AND parent_object_id = OBJECT_ID(N'[GNR].[MarketingDiskette1396]'))
--ALTER TABLE GNR.MarketingDiskette1396 ADD CONSTRAINT
--	CK_MarketingDiskette1396_SeasonGE0LE15 CHECK (Season >= 0 and Season <= 15)
--GO	

--<< FOREIGNKEYS DEFINITION >>--
--<< DROP OBJECTS >>--
