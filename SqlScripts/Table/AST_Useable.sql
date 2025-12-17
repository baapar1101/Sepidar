--<<FileName:AST_UsingOperation.sql>>--
--<< TABLE DEFINITION >>--

If Object_ID('AST.Useable') Is Null
CREATE TABLE [AST].[Useable](
	[UseableId]					[INT]				NOT NULL,
	[Number]					[INT]				NOT NULL,
	[Date]						[DATETIME]			NOT NULL,
	[Description]				[NVARCHAR](4000)	NULL,
	[Description_En]			[NVARCHAR](4000)	NULL,
	[FiscalYearRef]				[INT]				NOT NULL,
	[Version]					[INT] 				NOT NULL,
	[Creator]					[INT] 				NOT NULL,
	[CreationDate]				[DATETIME]			NOT NULL,
	[LastModifier]				[INT]				NOT NULL,
	[LastModificationDate]		[DATETIME]			NOT NULL,
) ON [PRIMARY]

--TEXTIMAGE_ON [SGBlob_Data]
--When a table has text, ntext, image, varchar(max), nvarchar(max), varbinary(max), xml or large user defined type columns uncomment above code
GO
--<< ADD CLOLUMNS >>--

--<<Sample>>--

--<< ALTER COLUMNS >>--

--<< PRIMARYKEY DEFINITION >>--
If not Exists (select 1 from sys.objects where name = 'PK_Useable')
ALTER TABLE [AST].[Useable] ADD  CONSTRAINT [PK_Useable] 
PRIMARY KEY CLUSTERED 
(
	[UseableId] ASC
) ON [PRIMARY]
GO

--<< DEFAULTS CHECKS DEFINITION >>--

--<< RULES DEFINITION >>--

--<< INDEXES DEFINITION >>--

--<< FOREIGNKEYS DEFINITION >>--
GO
If not Exists (select 1 from sys.objects where name = 'FK_Useable_FiscalYearRef')
ALTER TABLE [AST].[Useable]  ADD  CONSTRAINT [FK_Useable_FiscalYearRef] FOREIGN KEY([FiscalYearRef])
REFERENCES [FMK].[FiscalYear] ([FiscalYearId])

GO
--GO

--<< DROP OBJECTS >>--
