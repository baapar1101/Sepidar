--<<FileName:DST_OrderingSchedule.sql>>--

--<< TABLE DEFINITION >>--
IF Object_ID('DST.OrderingSchedule') IS NULL
CREATE TABLE [DST].[OrderingSchedule](
	[OrderingScheduleId]			[INT]		NOT NULL,
	[OrderingScheduleRecurrenceRef]	[INT]		NULL,
	[Date]							[DATETIME]	NOT NULL,
	[PartyRef]						[INT]		NOT NULL,
	[AreaAndPathRef]				[INT]		    NULL,
	[CustomerAddressRef]			[INT]		    NULL,
	[IsLockedByDevice]				[BIT]		NOT NULL,
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
IF NOT EXISTS (SELECT 1 FROM [sys].[columns] WHERE [object_id] = OBJECT_ID('DST.OrderingSchedule') AND [name] = 'IsLockedByDevice')
	ALTER TABLE [DST].[OrderingSchedule] ADD [IsLockedByDevice] [BIT] NOT NULL DEFAULT 0
GO

IF NOT EXISTS (SELECT 1 FROM [sys].[columns] WHERE [object_id] = OBJECT_ID('DST.OrderingSchedule') AND [name] = 'CustomerAddressRef')
	ALTER TABLE [DST].[OrderingSchedule] ADD [CustomerAddressRef] [INT] NULL
GO

--<<Sample>>--
/*if not exists (select 1 from sys.columns where object_id=object_id('DST.AreaAndPath') and
				[name] = 'ColumnName')
begin
    Alter table DST.AreaAndPath Add ColumnName DataType Nullable
end
GO*/

--<< ALTER COLUMNS >>--

IF EXISTS (SELECT 1 FROM [sys].[columns] WHERE [object_id] = OBJECT_ID('DST.OrderingSchedule') AND [name] = 'AreaAndPathRef' AND [is_nullable] = 0)
BEGIN
	BEGIN TRANSACTION
		IF EXISTS (SELECT 1 FROM sys.indexes WHERE name = 'UIX_PartyRef_Date_AreaAndPathRef')
			DROP INDEX UIX_PartyRef_Date_AreaAndPathRef ON [DST].[OrderingSchedule]

		ALTER TABLE [DST].[OrderingSchedule] ALTER COLUMN [AreaAndPathRef] [INT] NULL

		CREATE UNIQUE NONCLUSTERED INDEX [UIX_PartyRef_Date_AreaAndPathRef] ON [DST].[OrderingSchedule] 
		(
			[PartyRef] ASC,
			[Date] ASC,
			[AreaAndPathRef] ASC
		) WHERE AreaAndPathRef IS NOT NULL
		ON [PRIMARY]

	COMMIT TRANSACTION
END
GO

--<< PRIMARYKEY DEFINITION >>--
IF NOT EXISTS (SELECT 1 FROM sys.objects WHERE NAME = 'PK_OrderingSchedule')
ALTER TABLE [DST].[OrderingSchedule] ADD CONSTRAINT [PK_OrderingSchedule] PRIMARY KEY CLUSTERED 
(
	[OrderingScheduleId] ASC
) ON [PRIMARY]
GO

--<< DEFAULTS CHECKS DEFINITION >>--

--<< RULES DEFINITION >>--

--<< INDEXES DEFINITION >>--

IF NOT EXISTS (SELECT 1 FROM sys.indexes WHERE NAME = 'UIX_PartyRef_Date_AreaAndPathRef')
CREATE UNIQUE NONCLUSTERED INDEX [UIX_PartyRef_Date_AreaAndPathRef] ON [DST].[OrderingSchedule] 
(
	[PartyRef] ASC,
	[Date] ASC,
	[AreaAndPathRef] ASC
) WHERE AreaAndPathRef IS NOT NULL
ON [PRIMARY]

GO

IF NOT EXISTS (SELECT 1 FROM sys.indexes WHERE NAME = 'UIX_PartyRef_Date_CustomerAddressRef')
CREATE UNIQUE NONCLUSTERED INDEX [UIX_PartyRef_Date_CustomerAddressRef] ON [DST].[OrderingSchedule] 
(
	[PartyRef] ASC,
	[Date] ASC,
	[CustomerAddressRef] ASC
	
) WHERE CustomerAddressRef IS NOT NULL
ON [PRIMARY]


GO


--<< FOREIGNKEYS DEFINITION >>--
IF NOT EXISTS (SELECT 1 FROM sys.objects WHERE NAME = 'FK_OrderingSchedule_OrderingScheduleRecurrenceRef')
ALTER TABLE [DST].[OrderingSchedule]  ADD CONSTRAINT [FK_OrderingSchedule_OrderingScheduleRecurrenceRef] FOREIGN KEY([OrderingScheduleRecurrenceRef])
REFERENCES [DST].[OrderingScheduleRecurrence] ([OrderingScheduleRecurrenceId])

GO

IF NOT EXISTS (SELECT 1 FROM sys.objects WHERE NAME = 'FK_OrderingSchedule_PartyRef')
ALTER TABLE [DST].[OrderingSchedule]  ADD CONSTRAINT [FK_OrderingSchedule_PartyRef] FOREIGN KEY([PartyRef])
REFERENCES [GNR].[Party] ([PartyId])

GO

IF NOT EXISTS (SELECT 1 FROM sys.objects WHERE NAME = 'FK_OrderingSchedule_AreaAndPathRef')
ALTER TABLE [DST].[OrderingSchedule]  ADD CONSTRAINT [FK_OrderingSchedule_AreaAndPathRef] FOREIGN KEY([AreaAndPathRef])
REFERENCES [DST].[AreaAndPath] ([AreaAndPathId])

GO

IF NOT EXISTS (SELECT 1 FROM sys.objects WHERE NAME = 'FK_OrderingSchedule_CustomerAddressRef')
ALTER TABLE [DST].[OrderingSchedule]  ADD CONSTRAINT FK_OrderingSchedule_CustomerAddressRef FOREIGN KEY([CustomerAddressRef])
REFERENCES [GNR].[PartyAddress] ([PartyAddressId])

GO

IF NOT EXISTS (SELECT 1	FROM sys.objects WHERE name = 'FK_OrderingSchedule_FiscalYearRef')
ALTER TABLE [DST].[OrderingSchedule] ADD CONSTRAINT [FK_OrderingSchedule_FiscalYearRef] FOREIGN KEY ([FiscalYearRef])
REFERENCES [FMK].[FiscalYear] ([FiscalYearId])

GO

--<< DROP OBJECTS >>--
