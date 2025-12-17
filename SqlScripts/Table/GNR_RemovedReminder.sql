--<<FileName:GNR_RemovedReminder.sql>>--
--<< TABLE DEFINITION >>--

If Object_ID('GNR.RemovedReminder') Is Null
CREATE TABLE [GNR].[RemovedReminder](
	-- [RemovedReminderId] [INT]           NOT NULL,
    [UserRef]           [INT]           NOT NULL,
    [ReminderRef]       [INT]           NOT NULL
) ON [PRIMARY]

--TEXTIMAGE_ON [SGBlob_Data]
--When a table has text, ntext, image, varchar(max), nvarchar(max), varbinary(max), xml or large user defined type columns uncomment above code
GO

--<< ADD CLOLUMNS >>--

--<< ALTER COLUMNS >>--

--<< PRIMARYKEY DEFINITION >>--

-- If not Exists (select 1 from sys.objects where name = 'PK_RemovedReminder')
-- ALTER TABLE [GNR].[RemovedReminder] ADD  CONSTRAINT [PK_RemovedReminder] PRIMARY KEY CLUSTERED 
-- (
-- 	[RemovedReminderId] ASC
-- ) ON [PRIMARY]
-- GO

--<< DEFAULTS CHECKS DEFINITION >>--

--<< RULES DEFINITION >>--

--<< INDEXES DEFINITION >>--

IF NOT EXISTS (SELECT 1 FROM sys.indexes WHERE name = 'UIX_RemovedReminder_ReminderRef_UserRef')
CREATE NONCLUSTERED INDEX [UIX_RemovedReminder_ReminderRef_UserRef] ON [GNR].[RemovedReminder]
(
	[ReminderRef], [UserRef] ASC
)

GO

--<< FOREIGNKEYS DEFINITION >>--

IF NOT EXISTS (SELECT 1 FROM sys.objects WHERE name = 'FK_RemovedReminder_ReminderRef')
ALTER TABLE [GNR].[RemovedReminder] ADD CONSTRAINT [FK_RemovedReminder_ReminderRef] FOREIGN KEY([ReminderRef])
REFERENCES [GNR].[Reminder] ([ReminderID])
ON DELETE CASCADE
GO

--<< DROP OBJECTS >>--
