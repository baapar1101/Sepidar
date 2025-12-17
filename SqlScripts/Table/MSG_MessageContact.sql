--<<FileName:MSG_MessageContact.sql>>--
--<< TABLE DEFINITION >>--

IF OBJECT_ID('MSG.MessageContact') IS NULL
CREATE TABLE [MSG].[MessageContact](
	[MessageContactID] [int] NOT NULL,
	[MessageRef] [int] NOT NULL,	
	[Phone] [varchar](20) NOT NULL,
	[ContactPhoneRef] [int] NULL,
	[ContactType] [int] NULL
) ON [PRIMARY]


--TEXTIMAGE_ON [SGBlob_Data]
--When a table has text, ntext, image, varchar(max), nvarchar(max), varbinary(max), xml or large user defined type columns uncomment above code
GO
--<< ADD CLOLUMNS >>--

--<< ALTER COLUMNS >>--
--<< PRIMARYKEY DEFINITION >>--
IF NOT EXISTS (SELECT 1 FROM sys.objects WHERE name = 'PK_MessageContact')
ALTER TABLE [MSG].[MessageContact] ADD  CONSTRAINT [PK_MessageContact] PRIMARY KEY CLUSTERED 
(
	[MessageContactID] ASC
) ON [PRIMARY]
GO

--<< DEFAULTS CHECKS DEFINITION >>--

--<< RULES DEFINITION >>--

--<< INDEXES DEFINITION >>--
IF NOT EXISTS(SELECT 1 FROM SYS.Indexes WHERE name = 'UQ_MessageContact_MessageRef_Phone')
BEGIN
	ALTER TABLE [MSG].[MessageContact] 
	ADD CONSTRAINT [UQ_MessageContact_MessageRef_Phone] UNIQUE NONCLUSTERED
		(
			[MessageRef],
			[Phone]
		)
END
GO

--<< FOREIGNKEYS DEFINITION >>--
IF NOT EXISTS (SELECT 1 FROM sys.objects WHERE name = 'FK_MessageContact_MessageRef')
ALTER TABLE [MSG].[MessageContact]  ADD  CONSTRAINT [FK_MessageContact_MessageRef] FOREIGN KEY([MessageRef])
REFERENCES [MSG].[Message] ([MessageId])
ON UPDATE CASCADE
ON DELETE CASCADE
GO

--<< DROP OBJECTS >>--
