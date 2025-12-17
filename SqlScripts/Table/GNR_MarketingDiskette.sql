--<<FileName:GNR_MarketingDiskette.sql>>--
--<< TABLE DEFINITION >>--

If Object_ID('GNR.MarketingDiskette') Is Null
CREATE TABLE [GNR].[MarketingDiskette](
	[MarketingDisketteID] [int] NOT NULL,
	[year] int NOT NULL,
	[Season] int NOT NULL, 
	[Type] int NOT NULL,
	[Version] [int] NOT NULL,
	[Creator] [int] NOT NULL,
	[CreationDate] [datetime] NOT NULL,
	[LastModifier] [int] NOT NULL,
	[LastModificationDate] [datetime] NOT NULL,
	[Month] [int] NOT NULL,
	[PeriodType] [int] NOT NULL
) ON [PRIMARY]


--TEXTIMAGE_ON [SGBlob_Data]
--When a table has text, ntext, image, varchar(max), nvarchar(max), varbinary(max), xml or large user defined type columns uncomment above code
GO
--<< ADD CLOLUMNS >>--

--<<Sample>>--
if not exists (select 1 from sys.columns where object_id=object_id('GNR.MarketingDiskette') and
				[name] = 'FillItemNameByCategory')
begin
    ALTER TABLE GNR.MarketingDiskette ADD FillItemNameByCategory BIT NOT NULL DEFAULT(1)
end
GO

if not exists (select 1 from sys.columns where object_id=object_id('GNR.MarketingDiskette') and
				[name] = 'Month')
begin
    ALTER TABLE GNR.MarketingDiskette ADD [Month] INT NOT NULL DEFAULT(0)
end
GO
if not exists (select 1 from sys.columns where object_id=object_id('GNR.MarketingDiskette') and
				[name] = 'PeriodType')
begin
    ALTER TABLE GNR.MarketingDiskette ADD [PeriodType] INT NOT NULL DEFAULT(1)
end
GO
--<< ALTER COLUMNS >>--
--<< PRIMARYKEY DEFINITION >>--

If not Exists (select 1 from sys.objects where name = 'PK_MarketingDiskette')
ALTER TABLE [GNR].[MarketingDiskette] ADD  CONSTRAINT [PK_MarketingDiskette] PRIMARY KEY CLUSTERED 
(
	[MarketingDisketteID] ASC
) ON [PRIMARY]
GO

--<< DEFAULTS CHECKS DEFINITION >>--

--<< RULES DEFINITION >>--

--<< INDEXES DEFINITION >>--
IF  EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[GNR].[MarketingDiskette]') AND name = N'UIX_MarketingDiskette_Year_Season')
ALTER TABLE [GNR].[MarketingDiskette] DROP CONSTRAINT [UIX_MarketingDiskette_Year_Season]
GO

If not Exists (select 1 from sys.indexes where name = 'UIX_MarketingDiskette_Year_Season')
ALTER TABLE [GNR].[MarketingDiskette] ADD  CONSTRAINT [UIX_MarketingDiskette_Year_Season] UNIQUE NONCLUSTERED 
(
	[Year]  ASC,
	[Season] ASC,
	[Month] ASC,
	[Type] ASC,
	[PeriodType] ASC
) ON [PRIMARY]

IF  EXISTS (SELECT * FROM sys.check_constraints WHERE object_id = OBJECT_ID(N'[GNR].[CK_MarketingDiskette_SeasonGE1LE15]') AND parent_object_id = OBJECT_ID(N'[GNR].[MarketingDiskette]'))
ALTER TABLE [GNR].[MarketingDiskette] DROP CONSTRAINT [CK_MarketingDiskette_SeasonGE1LE15]

IF  NOT EXISTS (SELECT * FROM sys.check_constraints WHERE object_id = OBJECT_ID(N'[GNR].[CK_MarketingDiskette_SeasonGE0LE15]') AND parent_object_id = OBJECT_ID(N'[GNR].[MarketingDiskette]'))
ALTER TABLE GNR.MarketingDiskette ADD CONSTRAINT
	CK_MarketingDiskette_SeasonGE0LE15 CHECK (Season >= 0 and Season <= 15)
GO	
--<< FOREIGNKEYS DEFINITION >>--
--<< DROP OBJECTS >>--
