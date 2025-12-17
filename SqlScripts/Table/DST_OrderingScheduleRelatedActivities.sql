--<<FileName:DST_OrderingScheduleRelatedActivities.sql>>--

--<< TABLE DEFINITION >>--
IF Object_ID('DST.OrderingScheduleRelatedActivities') IS NULL
CREATE TABLE [DST].[OrderingScheduleRelatedActivities](
	[OrderingScheduleRelatedActivitiesId]	[INT]		NOT NULL,
	[ScheduleId]							[BIGINT]	NOT	NULL,
	[OrderRef]								[INT]		NULL,
	[OrderingFailureItemRef]				[INT]		NULL,
	[Version]								[INT]		NOT NULL,
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
IF NOT EXISTS (SELECT 1 FROM sys.objects WHERE NAME = 'PK_OrderingScheduleRelatedActivities')
ALTER TABLE [DST].[OrderingScheduleRelatedActivities] ADD CONSTRAINT [PK_OrderingScheduleRelatedActivities] PRIMARY KEY CLUSTERED 
(
	[OrderingScheduleRelatedActivitiesId] ASC
) ON [PRIMARY]
GO

--<< DEFAULTS CHECKS DEFINITION >>--

--<< RULES DEFINITION >>--

--<< INDEXES DEFINITION >>--
IF NOT EXISTS (SELECT 1 FROM sys.indexes WHERE NAME = 'UIX_OrderingScheduleRelatedActivities_OrderRef')
CREATE UNIQUE NONCLUSTERED INDEX [UIX_OrderingScheduleRelatedActivities_OrderRef] ON [DST].[OrderingScheduleRelatedActivities] 
(
	[OrderRef] ASC 
) WHERE [OrderRef] IS NOT NULL ON [PRIMARY]

GO

IF NOT EXISTS (SELECT 1 FROM sys.indexes WHERE NAME = 'UIX_OrderingScheduleRelatedActivities_OrderingFailureItemRef')
CREATE UNIQUE NONCLUSTERED INDEX [UIX_OrderingScheduleRelatedActivities_OrderingFailureItemRef] ON [DST].[OrderingScheduleRelatedActivities] 
(
	[OrderingFailureItemRef] ASC 
) WHERE [OrderingFailureItemRef] IS NOT NULL ON [PRIMARY]

GO

--<< FOREIGNKEYS DEFINITION >>--
IF EXISTS (SELECT 1 FROM sys.objects WHERE NAME = 'FK_OrderingScheduleRelatedActivities_OrderRef') -- ToDo: Remove Before Release
ALTER TABLE [DST].[OrderingScheduleRelatedActivities] DROP CONSTRAINT [FK_OrderingScheduleRelatedActivities_OrderRef]

IF EXISTS (SELECT 1 FROM sys.objects WHERE NAME = 'FK_OrderingScheduleRelatedActivities_OrderingFailureItemRef') -- ToDo: Remove Before Release
ALTER TABLE [DST].[OrderingScheduleRelatedActivities] DROP CONSTRAINT [FK_OrderingScheduleRelatedActivities_OrderingFailureItemRef]

IF NOT EXISTS (SELECT 1 FROM sys.objects WHERE NAME = 'FK_OrderingScheduleRelatedActivities_OrderRef')
ALTER TABLE [DST].[OrderingScheduleRelatedActivities] ADD CONSTRAINT [FK_OrderingScheduleRelatedActivities_OrderRef] FOREIGN KEY([OrderRef])
REFERENCES [DST].[Order] ([OrderID])
ON DELETE CASCADE

GO

IF NOT EXISTS (SELECT 1 FROM sys.objects WHERE NAME = 'FK_OrderingScheduleRelatedActivities_OrderingFailureItemRef')
ALTER TABLE [DST].[OrderingScheduleRelatedActivities] ADD CONSTRAINT [FK_OrderingScheduleRelatedActivities_OrderingFailureItemRef] FOREIGN KEY([OrderingFailureItemRef])
REFERENCES [DST].[OrderingFailureItem] ([OrderingFailureItemId])
ON DELETE CASCADE

GO

--<< DROP OBJECTS >>--
