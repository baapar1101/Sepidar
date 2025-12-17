--<<FileName:MSG_TemplateEvent.sql>>--
--<< TABLE DEFINITION >>--

IF OBJECT_ID('MSG.TemplateEvent') IS NULL
CREATE TABLE [MSG].[TemplateEvent](
	[TemplateEventID] [int] NOT NULL,	
	[TemplateRef] [int] NOT NULL,
	[EventKey] [nvarchar](200) NOT NULL
) ON [PRIMARY]

--TEXTIMAGE_ON [SGBlob_Data]
--When a table has text, ntext, image, varchar(max), nvarchar(max), varbinary(max), xml or large user defined type columns uncomment above code
GO
--<< ADD CLOLUMNS >>--

--<< ALTER COLUMNS >>--
--<< PRIMARYKEY DEFINITION >>--
IF NOT EXISTS (SELECT 1 FROM sys.objects WHERE name = 'PK_TemplateEvent')
ALTER TABLE [MSG].[TemplateEvent] ADD  CONSTRAINT [PK_TemplateEvent] PRIMARY KEY CLUSTERED 
(
	[TemplateEventID] ASC
) ON [PRIMARY]
GO

--<< DEFAULTS CHECKS DEFINITION >>--

--<< RULES DEFINITION >>--

--<< INDEXES DEFINITION >>--

IF NOT EXISTS(SELECT 1 FROM SYS.Indexes WHERE name = 'UQ_TemplateEvent_TemplateRef_EventKey')
BEGIN
	ALTER TABLE [MSG].[TemplateEvent]
	ADD CONSTRAINT [UQ_TemplateEvent_TemplateRef_EventKey] UNIQUE NONCLUSTERED
		(
			[TemplateRef],			
			[EventKey]
		)
END
GO

--<< FOREIGNKEYS DEFINITION >>--

IF NOT EXISTS (SELECT 1 FROM sys.objects WHERE name = 'FK_TemplateEvent_TemplateRef')
ALTER TABLE [MSG].[TemplateEvent]  ADD  CONSTRAINT [FK_TemplateEvent_TemplateRef] FOREIGN KEY([TemplateRef])
REFERENCES [MSG].[Template] ([TemplateId])
ON UPDATE CASCADE
ON DELETE CASCADE
GO

--<< DROP OBJECTS >>--