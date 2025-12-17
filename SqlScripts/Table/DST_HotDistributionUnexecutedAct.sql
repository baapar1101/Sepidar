--<<FileName:DST_HotDistributionUnexecutedAct.sql>>--

--<< TABLE DEFINITION >>--
IF OBJECT_ID('DST.HotDistributionUnexecutedAct') IS NULL
CREATE TABLE [DST].[HotDistributionUnexecutedAct](
	[HotDistributionUnexecutedActId]	[INT]			NOT NULL,
	[HotDistributionRef]				[INT]			NOT NULL,
	[AreaAndPathRef]					[INT]			NOT NULL,
	[PartyAddressRef]					[INT]			NULL,
	[UnexecutedActReasonRef]			[INT]			NULL,
	[Description]						[NVARCHAR](250) NULL,
	[Description_En]					[NVARCHAR](250)	NULL,
	[Guid] 								[NVARCHAR](36)	NULL,
	[Creator]							[INT]			NOT NULL,
	[CreationDate]						[DATETIME]		NOT NULL,
	[LastModifier]						[INT]			NOT NULL,
	[LastModificationDate]				[DATETIME]		NOT NULL,
) ON [PRIMARY]

--TEXTIMAGE_ON [SGBlob_Data]
--When a table has text, ntext, image, varchar(max), nvarchar(max), varbinary(max), xml or large user defined type columns uncomment above code
GO
--<< ADD CLOLUMNS >>--

--<<Sample>>--
/*if not exists (select 1 from sys.columns where object_id=object_id('DST.AreaAndPath') and
				[name] = 'ColumnName')
begin
    Alter table DST.AreaAndPath Add ColumnName DataType Nullable
end
GO*/

--<< ALTER COLUMNS >>--

--<< PRIMARYKEY DEFINITION >>--
IF NOT EXISTS (SELECT 1 FROM sys.objects WHERE NAME = 'PK_HotDistributionUnexecutedAct')
ALTER TABLE [DST].[HotDistributionUnexecutedAct] ADD CONSTRAINT [PK_HotDistributionUnexecutedAct] PRIMARY KEY CLUSTERED 
(
	[HotDistributionUnexecutedActId] ASC
) ON [PRIMARY]
GO

--<< DEFAULTS CHECKS DEFINITION >>--

--<< RULES DEFINITION >>--

--<< INDEXES DEFINITION >>--
IF NOT EXISTS (SELECT 1 FROM sys.indexes WHERE NAME = 'UIX_HotDistributionUnexecutedAct_HotDistributionRef_AreaAndPathRef_PartyAddressRef')
CREATE UNIQUE NONCLUSTERED INDEX [UIX_HotDistributionUnexecutedAct_HotDistributionRef_AreaAndPathRef_PartyAddressRef] ON [DST].[HotDistributionUnexecutedAct] 
(
	[HotDistributionRef] ASC,
	[AreaAndPathRef] ASC,
	[PartyAddressRef] ASC
) ON [PRIMARY]

GO

--<< FOREIGNKEYS DEFINITION >>--
IF NOT EXISTS (SELECT 1 FROM sys.objects WHERE NAME = 'FK_HotDistributionUnexecutedAct_HotDistributionRef')
ALTER TABLE [DST].[HotDistributionUnexecutedAct] ADD CONSTRAINT [FK_HotDistributionUnexecutedAct_HotDistributionRef] FOREIGN KEY([HotDistributionRef])
REFERENCES [DST].[HotDistribution] ([HotDistributionId])
ON DELETE CASCADE

GO

IF NOT EXISTS (SELECT 1 FROM sys.objects WHERE NAME = 'FK_HotDistributionUnexecutedAct_AreaAndPathRef')
ALTER TABLE [DST].[HotDistributionUnexecutedAct] ADD CONSTRAINT [FK_HotDistributionUnexecutedAct_AreaAndPathRef] FOREIGN KEY([AreaAndPathRef])
REFERENCES [DST].[AreaAndPath] ([AreaAndPathId])

GO

IF NOT EXISTS (SELECT 1 FROM sys.objects WHERE NAME = 'FK_HotDistributionUnexecutedAct_PartyAddressRef')
ALTER TABLE [DST].[HotDistributionUnexecutedAct] ADD CONSTRAINT [FK_HotDistributionUnexecutedAct_PartyAddressRef] FOREIGN KEY([PartyAddressRef])
REFERENCES [GNR].[PartyAddress] ([PartyAddressId])
ON DELETE SET NULL

GO

IF EXISTS (SELECT 1 FROM sys.objects WHERE NAME = 'FK_HotDistributionUnexecutedAct_UnexecutedActReasonRef' 
										   AND [parent_object_id] = OBJECT_ID('DST.OrderingFailureItem'))
ALTER TABLE [DST].[OrderingFailureItem] DROP CONSTRAINT [FK_HotDistributionUnexecutedAct_UnexecutedActReasonRef]

GO

IF NOT EXISTS (SELECT 1 FROM sys.objects WHERE NAME = 'FK_HotDistributionUnexecutedAct_UnexecutedActReasonRef')
ALTER TABLE [DST].[HotDistributionUnexecutedAct] ADD CONSTRAINT [FK_HotDistributionUnexecutedAct_UnexecutedActReasonRef] FOREIGN KEY([UnexecutedActReasonRef])
REFERENCES [DST].[UnexecutedActReason] ([UnexecutedActReasonId])

GO

--<< DROP OBJECTS >>--
