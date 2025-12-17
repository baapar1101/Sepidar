--<<FileName:MSG.CustomContact.sql>>--
--<< TABLE DEFINITION >>--

If Object_ID('MSG.CustomContact') Is Null
CREATE TABLE [MSG].[CustomContact](
	[CustomContactId] [int] NOT NULL,
	[FullName] [nvarchar](250) NOT NULL,
	[MarriageDate] [datetime] NULL,	
	[BirthDate] [datetime] NULL,	
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

--<<Sample>>--

--<< ALTER COLUMNS >>--

--<< PRIMARYKEY DEFINITION >>--

If NOT Exists (select 1 from sys.objects where name = 'PK_CustomContact')
ALTER TABLE [MSG].[CustomContact] ADD  CONSTRAINT [PK_CustomContact] PRIMARY KEY CLUSTERED 
(
	[CustomContactId] ASC
) ON [PRIMARY]
GO

--<< DEFAULTS CHECKS DEFINITION >>--

--<< RULES DEFINITION >>--

--<< INDEXES DEFINITION >>--
IF NOT EXISTS(SELECT 1 FROM SYS.Indexes WHERE name = 'UQ_CustomContact_FullName')
BEGIN
	ALTER TABLE [MSG].[CustomContact]
	ADD CONSTRAINT [UQ_CustomContact_FullName] UNIQUE NONCLUSTERED
		(
			[FullName]			
		)
END
GO
--<< FOREIGNKEYS DEFINITION >>--

--<< DROP OBJECTS >>--
