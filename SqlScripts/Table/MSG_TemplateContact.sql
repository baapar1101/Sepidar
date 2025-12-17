--<<FileName:MSG_TemplateContact.sql>>--
--<< TABLE DEFINITION >>--

IF OBJECT_ID('MSG.TemplateContact') IS NULL
CREATE TABLE [MSG].[TemplateContact](
	[TemplateContactID] [int] NOT NULL,
	[TemplateRef] [int] NOT NULL,
	[Phone] [varchar](20) NULL,
	[ContactPhoneRef] [int] NULL,
	[ContactType] [int] NULL,
	[ParameterName] [varchar](100) null
) ON [PRIMARY]


--TEXTIMAGE_ON [SGBlob_Data]
--When a table has text, ntext, image, varchar(max), nvarchar(max), varbinary(max), xml or large user defined type columns uncomment above code
GO
--<< ADD CLOLUMNS >>--

--<< ALTER COLUMNS >>--
--<< PRIMARYKEY DEFINITION >>--
IF NOT EXISTS (SELECT 1 FROM sys.objects WHERE name = 'PK_TemplateContact')
ALTER TABLE [MSG].[TemplateContact] ADD  CONSTRAINT [PK_TemplateContact] PRIMARY KEY CLUSTERED 
(
	[TemplateContactID] ASC
) ON [PRIMARY]
GO

--<< DEFAULTS CHECKS DEFINITION >>--

--<< RULES DEFINITION >>--

--<< INDEXES DEFINITION >>--

IF NOT EXISTS(SELECT 1 FROM SYS.Indexes WHERE name = 'UQ_TemplateContact_TemplateRef_Phone_ParameterName')
BEGIN
	ALTER TABLE [MSG].[TemplateContact]
	ADD CONSTRAINT [UQ_TemplateContact_TemplateRef_Phone_ParameterName] UNIQUE NONCLUSTERED
		(
			[TemplateRef],
			[Phone],
			[ParameterName]
		)
END
GO

--<< FOREIGNKEYS DEFINITION >>--
IF NOT EXISTS (SELECT 1 FROM sys.objects WHERE name = 'FK_TemplateContact_TemplateRef')
ALTER TABLE [MSG].[TemplateContact]  ADD  CONSTRAINT [FK_TemplateContact_TemplateRef] FOREIGN KEY([TemplateRef])
REFERENCES [MSG].[Template] ([TemplateId])
ON UPDATE CASCADE
ON DELETE CASCADE
GO

--<< DROP OBJECTS >>--
