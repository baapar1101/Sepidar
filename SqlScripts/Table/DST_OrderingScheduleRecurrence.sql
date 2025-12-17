--<<FileName:DST_OrderingScheduleRecurrence.sql>>--

--<< TABLE DEFINITION >>--
IF Object_ID('DST.OrderingScheduleRecurrence') IS NULL
CREATE TABLE [DST].[OrderingScheduleRecurrence](
	[OrderingScheduleRecurrenceId]	[INT]			NOT NULL,
	[StartDate]						[DATETIME]		NOT NULL,
	[EndDate]						[DATETIME]		NOT NULL,
	[Type]							[INT]			NOT NULL,
	[DayInterval]					[INT]			NULL,
	[WeekInterval]					[INT]			NULL,
	[Weekdays]						[INT]			NULL,
	[Version]						[INT]			NOT NULL,
	[Creator]						[INT]			NOT NULL,
	[CreationDate]					[DATETIME]		NOT NULL,
	[LastModifier]					[INT]			NOT NULL,
	[LastModificationDate]			[DATETIME]		NOT NULL
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
IF NOT EXISTS (SELECT 1 FROM sys.objects WHERE NAME = 'PK_OrderingScheduleRecurrence')
ALTER TABLE [DST].[OrderingScheduleRecurrence] ADD CONSTRAINT [PK_OrderingScheduleRecurrence] PRIMARY KEY CLUSTERED 
(
	[OrderingScheduleRecurrenceId] ASC
) ON [PRIMARY]
GO

--<< DEFAULTS CHECKS DEFINITION >>--

--<< RULES DEFINITION >>--

--<< INDEXES DEFINITION >>--

--<< FOREIGNKEYS DEFINITION >>--

--<< DROP OBJECTS >>--
