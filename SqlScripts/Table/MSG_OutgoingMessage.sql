--<<FileName:MSG_OutgoingMessage.sql>>--
--<< TABLE DEFINITION >>--

IF OBJECT_ID('MSG.OutgoingMessage') IS NULL
CREATE TABLE [MSG].[OutgoingMessage](
	[OutgoingMessageID] [int] NOT NULL,	
	[Text] [nvarchar](3000) NULL,
	[Date] [datetime] NOT NULL,
	[SenderNumber] [varchar](20) NULL,
	[ReceiverNumber] [varchar](20) NULL,
	[State] [int] NOT NULL,	
	[TrackingID] [bigint] NULL,
	[MessageContactRef] [int] NULL,
	[Description] [nvarchar](1000) NULL,
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
IF NOT EXISTS (SELECT 1 FROM sys.objects WHERE name = 'PK_OutgoingMessage')
ALTER TABLE [MSG].[OutgoingMessage] ADD  CONSTRAINT [PK_OutgoingMessage] PRIMARY KEY CLUSTERED 
(
	[OutgoingMessageID] ASC
) ON [PRIMARY]
GO

--<< DEFAULTS CHECKS DEFINITION >>--

--<< RULES DEFINITION >>--

--<< INDEXES DEFINITION >>--

--<< FOREIGNKEYS DEFINITION >>--

IF NOT EXISTS (SELECT 1 FROM sys.objects WHERE name = 'FK_OutgoingMessage_MessageContactRef')
ALTER TABLE [MSG].[OutgoingMessage]  ADD  CONSTRAINT [FK_OutgoingMessage_MessageContactRef] FOREIGN KEY([MessageContactRef])
REFERENCES [MSG].[MessageContact] (MessageContactId)
ON UPDATE CASCADE
ON DELETE CASCADE
GO

--<< DROP OBJECTS >>--