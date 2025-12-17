--<<FileName:AST_AssetGroup.sql>>--
--<< TABLE DEFINITION >>--

If Object_ID('AST.AssetGroup') Is Null
CREATE TABLE [AST].[AssetGroup](
	[AssetGroupID]				[INT] NOT NULL,
	[Code]						[NVARCHAR] (250)	NOT NULL,
	[Title]						[nvarchar](400)		NOT NULL,
	[Title_En]					[nvarchar](400)		NOT NULL,
	[DepreciationRate]			[decimal] (5, 2)	NOT NULL,
	[UsefulLife]				[decimal] (5, 2)	NOT NULL,
	[DepreciationMethod]		[int]				NOT NULL,
	[MaxDepreciableBookValue]	[decimal] (19,4)	NOT NULL,
	[SalvageValue]				[decimal] (19,4)	NOT NULL,
	[AssetClassRef]				[int]				NOT NULL,
	[Version]					[int]				NOT NULL,
	[Creator]					[int]				NOT NULL,
	[CreationDate]				[datetime]			NOT NULL,
	[LastModifier]				[int]				NOT NULL,
	[LastModificationDate]		[datetime]			NOT NULL
) ON [PRIMARY]

GO
--<< ADD CLOLUMNS >>--

--<<Sample>>--

--<< ALTER COLUMNS >>--

--<< PRIMARYKEY DEFINITION >>--

If not Exists (select 1 from sys.objects where name = 'PK_AssetGroup')
ALTER TABLE [AST].[AssetGroup] ADD  CONSTRAINT [PK_AssetGroup] PRIMARY KEY CLUSTERED 
(
	[AssetGroupID] ASC
) ON [PRIMARY]
GO

--<< DEFAULTS CHECKS DEFINITION >>--

--<< RULES DEFINITION >>--

--<< INDEXES DEFINITION >>--
If not Exists (select 1 from sys.indexes where name = 'UIX_AssetGroup_Code_AssetClassRef')
CREATE UNIQUE NONCLUSTERED INDEX [UIX_AssetGroup_Code_AssetClassRef] ON [AST].[AssetGroup] 
(
	[Code] ASC,
	[AssetClassRef] ASC
) ON [PRIMARY]

--<< FOREIGNKEYS DEFINITION >>--

IF NOT EXISTS (SELECT 1 FROM sys.objects WHERE name='FK_AssetGroup_AssetClassRef')
	ALTER TABLE [AST].[AssetGroup]
	ADD CONSTRAINT [FK_AssetGroup_AssetClassRef]
	FOREIGN KEY (AssetClassRef) REFERENCES [AST].[AssetClass] ([AssetClassID])
GO

--<< DROP OBJECTS >>--
