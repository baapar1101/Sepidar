--<<FileName:DST_Agreement.sql>>--
--<< TABLE DEFINITION >>--

If Object_ID('DST.Agreement') IS NULL
CREATE TABLE [DST].[Agreement]
(
	[AgreementId]			[int]			NOT NULL,
	[Title]					[nvarchar](256) NOT NULL,
	[Title_En]				[nvarchar](256) NOT NULL,
	[Creator]				[int]			NOT NULL,
	[CreationDate]			[datetime]		NOT NULL,
	[LastModifier]			[int]			NOT NULL,
	[LastModificationDate]	[datetime]		NOT NULL,
	[Version]				[int]			NOT NULL
) ON [PRIMARY]
--TEXTIMAGE_ON [SGBlob_Data]
--When a table has text, ntext, image, varchar(max), nvarchar(max), varbinary(max), xml or large user defined type columns uncomment above code
GO
--<< ADD CLOLUMNS >>--
--<< ALTER COLUMNS >>--
--<< PRIMARYKEY DEFINITION >>--
IF NOT EXISTS (SELECT 1 FROM sys.objects WHERE NAME = 'PK_DST_Agreement')
ALTER TABLE [DST].[Agreement] ADD CONSTRAINT [PK_DST_Agreement] PRIMARY KEY CLUSTERED 
(
	[AgreementId] ASC
) ON [PRIMARY]
GO
--<< DEFAULTS CHECKS DEFINITION >>--
--<< RULES DEFINITION >>--
--<< INDEXES DEFINITION >>--
--<< FOREIGNKEYS DEFINITION >>--
--<< DROP OBJECTS >>--