--<<FileName:AST_DepreciationMethod.sql>>--
--<< TABLE DEFINITION >>--
  
If Object_ID('AST.DepreciationRule') Is Null
CREATE TABLE [AST].[DepreciationRule](
	[DepreciationRuleID]		 [INT]				NOT NULL,
	[GroupNo]					 [INT]				NULL,
	[GroupTitle]				 [NVARCHAR](1000)	NULL,
	[DepreciationRate]			 [decimal] (5, 2)	NULL,
	[UsefulLife]				 [decimal] (5, 2)	NULL,
	[DepreciationMethod]		 [INT]				NOT NULL,
	[Description]				 [NVARCHAR](1000)	NULL,
	[Version]					 [INT]				NOT NULL,
	[Creator]					 [INT]				NOT NULL,
	[CreationDate]				 [DATETIME]			NOT NULL,
	[LastModifier]				 [INT]				NOT NULL,
	[LastModificationDate]		 [DATETIME]			NOT NULL
) ON [PRIMARY]

--TEXTIMAGE_ON [SGBlob_Data]
--When a table has text, ntext, image, varchar(max), nvarchar(max), varbinary(max), xml or large user defined type columns uncomment above code
GO
--<< ADD CLOLUMNS >>--

--<<Sample>>--

--<< ALTER COLUMNS >>--

--<< PRIMARYKEY DEFINITION >>--

--<< DEFAULTS CHECKS DEFINITION >>--

--<< RULES DEFINITION >>--

--<< INDEXES DEFINITION >>--

--<< FOREIGNKEYS DEFINITION >>--

--<< DROP OBJECTS >>--
