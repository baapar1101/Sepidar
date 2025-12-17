--<<FileName:MSG_SentScheduledTemplateSchedulingDate.sql>>--
--<< TABLE DEFINITION >>--

IF OBJECT_ID('MSG.SentScheduledTemplateSchedulingDate') IS NULL
CREATE TABLE [MSG].[SentScheduledTemplateSchedulingDate](
	[SentScheduledTemplateSchedulingDateID] [int] NOT NULL,	
	[TemplateSchedulingRef] [int] NOT NULL,
	[SchedulingItemRef] [int] NOT NULL
) ON [PRIMARY]

--TEXTIMAGE_ON [SGBlob_Data]
--When a table has text, ntext, image, varchar(max), nvarchar(max), varbinary(max), xml or large user defined type columns uncomment above code
GO
--<< ADD CLOLUMNS >>--

--<< ALTER COLUMNS >>--
--<< PRIMARYKEY DEFINITION >>--
IF NOT EXISTS (SELECT 1 FROM sys.objects WHERE name = 'PK_SentScheduledTemplateSchedulingDate')
ALTER TABLE [MSG].[SentScheduledTemplateSchedulingDate] ADD  CONSTRAINT [PK_SentScheduledTemplateSchedulingDate] PRIMARY KEY CLUSTERED 
(
	[SentScheduledTemplateSchedulingDateID] ASC
) ON [PRIMARY]
GO

--<< DEFAULTS CHECKS DEFINITION >>--

--<< RULES DEFINITION >>--

--<< INDEXES DEFINITION >>--

--<< FOREIGNKEYS DEFINITION >>--
IF NOT EXISTS (SELECT 1 FROM SYS.OBJECTS WHERE name = 'FK_SentScheduledTemplateSchedulingDate_TemplateSchedulingRef')
ALTER TABLE [MSG].[SentScheduledTemplateSchedulingDate]  ADD  CONSTRAINT [FK_SentScheduledTemplateSchedulingDate_TemplateSchedulingRef] FOREIGN KEY([TemplateSchedulingRef])
REFERENCES [MSG].[TemplateScheduling] ([TemplateSchedulingId])
ON DELETE CASCADE
GO

IF NOT EXISTS (SELECT 1 FROM SYS.OBJECTS WHERE name = 'FK_SentScheduledTemplateSchedulingDate_SchedulingItemRef')
ALTER TABLE [MSG].[SentScheduledTemplateSchedulingDate]  ADD  CONSTRAINT [FK_SentScheduledTemplateSchedulingDate_SchedulingItemRef] FOREIGN KEY([SchedulingItemRef])
REFERENCES [SCD].[SchedulingItem] ([SchedulingItemId])
ON UPDATE CASCADE
ON DELETE CASCADE
GO

--<< DROP OBJECTS >>--