--<<FileName:MSG_TemplateScheduling.sql>>--
--<< TABLE DEFINITION >>--

IF OBJECT_ID('MSG.TemplateScheduling') IS NULL
CREATE TABLE [MSG].[TemplateScheduling](
	[TemplateSchedulingID] [int] NOT NULL,	
	[TemplateRef] [int] NOT NULL,
	[SchedulingRef] [int] NOT NULL
) ON [PRIMARY]

--TEXTIMAGE_ON [SGBlob_Data]
--When a table has text, ntext, image, varchar(max), nvarchar(max), varbinary(max), xml or large user defined type columns uncomment above code
GO
--<< ADD CLOLUMNS >>--

--<< ALTER COLUMNS >>--
--<< PRIMARYKEY DEFINITION >>--
IF NOT EXISTS (SELECT 1 FROM sys.objects WHERE name = 'PK_TemplateScheduling')
ALTER TABLE [MSG].[TemplateScheduling] ADD  CONSTRAINT [PK_TemplateScheduling] PRIMARY KEY CLUSTERED 
(
	[TemplateSchedulingID] ASC
) ON [PRIMARY]
GO

--<< DEFAULTS CHECKS DEFINITION >>--

--<< RULES DEFINITION >>--

--<< INDEXES DEFINITION >>--

IF NOT EXISTS(SELECT 1 FROM SYS.Indexes WHERE name = 'UQ_TemplateScheduling_TemplateRef_SchedulingRef')
BEGIN
	ALTER TABLE [MSG].[TemplateScheduling]
	ADD CONSTRAINT [UQ_TemplateScheduling_TemplateRef_SchedulingRef] UNIQUE NONCLUSTERED
		(
			[TemplateRef],			
			[SchedulingRef]
		)
END
GO

--<< FOREIGNKEYS DEFINITION >>--

IF NOT EXISTS (SELECT 1 FROM SYS.OBJECTS WHERE name = 'FK_TemplateScheduling_TemplateRef')
ALTER TABLE [MSG].[TemplateScheduling]  ADD  CONSTRAINT [FK_TemplateScheduling_TemplateRef] FOREIGN KEY([TemplateRef])
REFERENCES [MSG].[Template] ([TemplateId])
ON UPDATE CASCADE
ON DELETE CASCADE
GO

IF NOT EXISTS (SELECT 1 FROM SYS.OBJECTS WHERE name = 'FK_TemplateScheduling_SchedulingRef')
ALTER TABLE [MSG].[TemplateScheduling]  ADD  CONSTRAINT [FK_TemplateScheduling_SchedulingRef] FOREIGN KEY([SchedulingRef])
REFERENCES [SCD].[Scheduling] ([SchedulingId])
GO

--<< DROP OBJECTS >>--