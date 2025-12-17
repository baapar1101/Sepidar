--<<FileName:DST_HotDistributionPath.sql>>--

--<< TABLE DEFINITION >>--
IF OBJECT_ID('DST.HotDistributionPath') IS NULL
CREATE TABLE [DST].[HotDistributionPath](
	[HotDistributionPathId]	[INT]	NOT NULL,
	[HotDistributionRef]	[INT] 	NOT NULL,
	[PathRef]				[INT]	NOT NULL,
) ON [PRIMARY]

--TEXTIMAGE_ON [SGBlob_Data]
--When a table has text, ntext, image, varchar(max), nvarchar(max), varbinary(max), xml or large user defined type columns uncomment above code
GO

--<< ADD CLOLUMNS >>--

--<<Sample>>--
/*IF NOT EXISTS (SELECT 1 FROM sys.columns WHERE OBJECT_ID=OBJECT_ID('SLS.HotDistributionPath') AND
				[name] = 'ColumnName')
BEGIN
    ALTER TABLE SLS.HotDistributionPath ADD ColumnName DataType Nullable
END
GO*/

--<< ALTER COLUMNS >>--

--<< PRIMARYKEY DEFINITION >>--
IF NOT EXISTS (SELECT 1 FROM sys.objects WHERE name = 'PK_HotDistributionPath')
ALTER TABLE [DST].[HotDistributionPath] ADD CONSTRAINT [PK_HotDistributionPath] PRIMARY KEY CLUSTERED 
(
	[HotDistributionPathId] ASC
) ON [PRIMARY]

GO

--<< DEFAULTS CHECKS DEFINITION >>--

--<< RULES DEFINITION >>--

--<< INDEXES DEFINITION >>--
IF NOT EXISTS (SELECT 1 FROM sys.indexes WHERE name = 'UIX_HotDistributionPath_HotDistributionRef_PathRef')
CREATE UNIQUE NONCLUSTERED INDEX [UIX_HotDistributionPath_HotDistributionRef_PathRef] ON [DST].[HotDistributionPath] 
(
	[HotDistributionRef] ASC,
	[PathRef] ASC
) ON [PRIMARY]

GO

--<< FOREIGNKEYS DEFINITION >>--
IF NOT EXISTS (SELECT 1	FROM sys.objects WHERE name = 'FK_HotDistributionPath_HotDistributionRef')
	ALTER TABLE [DST].[HotDistributionPath] ADD CONSTRAINT [FK_HotDistributionPath_HotDistributionRef] FOREIGN KEY ([HotDistributionRef])
	REFERENCES [DST].[HotDistribution] ([HotDistributionId])
	ON DELETE CASCADE

GO

IF NOT EXISTS (SELECT 1 FROM sys.objects WHERE name = 'FK_HotDistributionPath_PathRef')
	ALTER TABLE [DST].[HotDistributionPath] ADD CONSTRAINT [FK_HotDistributionPath_PathRef] FOREIGN KEY([PathRef])
	REFERENCES [DST].[AreaAndPath] ([AreaAndPathId])

GO

--<< DROP OBJECTS >>--
