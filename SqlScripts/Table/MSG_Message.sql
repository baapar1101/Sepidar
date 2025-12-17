--<<FileName:MSG_Message.sql>>--
--<< TABLE DEFINITION >>--

IF OBJECT_ID('MSG.Message') IS NULL
CREATE TABLE [MSG].[Message](
	[MessageID] [int] NOT NULL,	
	[Body] [nvarchar](3000) NULL,
	[Date] [datetime] NOT NULL,	
	[IsDraft] [bit] NOT NULL,
	[TemplateRef] [int] NULL,	
	[Version] [int] NOT NULL,
	[Creator] [int] NOT NULL,
	[CreationDate] [datetime] NOT NULL,
	[LastModifier] [int] NOT NULL,
	[LastModificationDate] [datetime] NOT NULL
) ON [PRIMARY]

--TEXTIMAGE_ON [SGBlob_Data]
--When a table has text, ntext, image, varchar(max), nvarchar(max), varbinary(max), xml or large user defined type columns uncomment above code
GO
--<< ADD CLOLUMNS >>--

--<< ALTER COLUMNS >>--
--<< PRIMARYKEY DEFINITION >>--
IF NOT EXISTS (SELECT 1 FROM sys.objects WHERE name = 'PK_Message')
ALTER TABLE [MSG].[Message] ADD  CONSTRAINT [PK_Message] PRIMARY KEY CLUSTERED 
(
	[MessageID] ASC
) ON [PRIMARY]
GO

--<< DEFAULTS CHECKS DEFINITION >>--

--<< RULES DEFINITION >>--

--<< INDEXES DEFINITION >>--

--<< FOREIGNKEYS DEFINITION >>--

IF NOT EXISTS (SELECT 1 FROM sys.objects WHERE name = 'FK_Message_TemplateRef')
ALTER TABLE [MSG].[Message]  ADD  CONSTRAINT [FK_Message_TemplateRef] FOREIGN KEY([TemplateRef])
REFERENCES [MSG].[Template] ([TemplateId])
GO

--<< DROP OBJECTS >>--