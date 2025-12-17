--<<FileName:MSG_Template.sql>>--
--<< TABLE DEFINITION >>--

IF OBJECT_ID('MSG.Template') IS NULL
CREATE TABLE [MSG].[Template](
	[TemplateID] [int] NOT NULL,
	[TemplateGUID] [UNIQUEIDENTIFIER] NOT NULL,
	[IsSystemTemplate] [bit] NOT NULL DEFAULT(0),
	[TemplateVersion] [int] NOT NULL,
	[Title] [nvarchar](255) NOT NULL,
	[Body] [nvarchar](3000) NOT NULL,
	[ShowOutgoingMessage] [bit] NOT NULL DEFAULT(1),
	[MessageParameterInfoFullName] [varchar](200) NULL,
	[FilterMedianOperator] [int] NULL,	
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
IF NOT EXISTS (SELECT 1 FROM sys.objects WHERE name = 'PK_Template')
ALTER TABLE [MSG].[Template] ADD  CONSTRAINT [PK_Template] PRIMARY KEY CLUSTERED 
(
	[TemplateID] ASC
) ON [PRIMARY]
GO

--<< DEFAULTS CHECKS DEFINITION >>--

--<< RULES DEFINITION >>--

--<< INDEXES DEFINITION >>--
IF NOT EXISTS (SELECT 1 FROM sys.indexes where name = 'UIX_Template_Title')
CREATE UNIQUE NONCLUSTERED INDEX [UIX_Template_Title] ON [MSG].[Template] 
(
	[Title] ASC
) ON [PRIMARY]
GO

IF NOT EXISTS(SELECT 1 FROM SYS.Indexes WHERE name = 'UQ_Template_TemplateGUID')
BEGIN
	ALTER TABLE [MSG].[Template] 
	ADD CONSTRAINT [UQ_Template_TemplateGUID] UNIQUE NONCLUSTERED
		(
			[TemplateGUID]
		)
END
GO

--<< FOREIGNKEYS DEFINITION >>--
--<< DROP OBJECTS >>--
