--<<FileName:MSG_TemplateFilter.sql>>--
--<< TABLE DEFINITION >>--

IF OBJECT_ID('MSG.TemplateFilter') IS NULL
CREATE TABLE [MSG].[TemplateFilter](
	[TemplateFilterID] [int] NOT NULL,	
	[TemplateRef] [int] NOT NULL,
	[ParameterName] [varchar](100) NOT NULL,
	[FilterCondition] [int] NOT NULL,
	[Value] [sql_variant] NULL,
	[Operator] [int] NOT NULL -- AND , OR
) ON [PRIMARY]

--TEXTIMAGE_ON [SGBlob_Data]
--When a table has text, ntext, image, varchar(max), nvarchar(max), varbinary(max), xml or large user defined type columns uncomment above code
GO
--<< ADD CLOLUMNS >>--

--<< ALTER COLUMNS >>--
--<< PRIMARYKEY DEFINITION >>--
IF NOT EXISTS (SELECT 1 FROM sys.objects WHERE name = 'PK_TemplateFilter')
ALTER TABLE [MSG].[TemplateFilter] ADD  CONSTRAINT [PK_TemplateFilter] PRIMARY KEY CLUSTERED 
(
	[TemplateFilterID] ASC
) ON [PRIMARY]
GO

--<< DEFAULTS CHECKS DEFINITION >>--

--<< RULES DEFINITION >>--

--<< INDEXES DEFINITION >>--

--<< FOREIGNKEYS DEFINITION >>--

IF NOT EXISTS (SELECT 1 FROM sys.objects WHERE name = 'FK_TemplateFilter_TemplateRef')
ALTER TABLE [MSG].[TemplateFilter]  ADD  CONSTRAINT [FK_TemplateFilter_TemplateRef] FOREIGN KEY([TemplateRef])
REFERENCES [MSG].[Template] ([TemplateId])
ON UPDATE CASCADE
ON DELETE CASCADE
GO

--<< DROP OBJECTS >>--