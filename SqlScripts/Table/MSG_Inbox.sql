--<<FileName:MSG_Inbox.sql>>--
--<< TABLE DEFINITION >>--

IF OBJECT_ID('MSG.Inbox') IS NULL
CREATE TABLE [MSG].[Inbox](
	[InboxID] [int] NOT NULL,	
	[Text] [nvarchar](3000) NULL,
	[Date] [datetime] NOT NULL,
	[SenderNumber] [varchar](20) NULL,
	[ReceiverNumber] [varchar](20) NULL,	
	[ContactPhoneRef] [int] NULL,
	[ContactType] [int] NULL,
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
IF NOT EXISTS (SELECT 1 FROM sys.objects WHERE name = 'PK_Inbox')
ALTER TABLE [MSG].[Inbox] ADD  CONSTRAINT [PK_Inbox] PRIMARY KEY CLUSTERED 
(
	[InboxID] ASC
) ON [PRIMARY]
GO

--<< DEFAULTS CHECKS DEFINITION >>--

--<< RULES DEFINITION >>--

--<< INDEXES DEFINITION >>--

--<< FOREIGNKEYS DEFINITION >>--

--<< DROP OBJECTS >>--