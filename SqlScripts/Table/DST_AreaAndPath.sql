--<<FileName:DST_AreaAndPath.sql>>--

--<< TABLE DEFINITION >>--
IF Object_ID('DST.AreaAndPath') IS NULL
CREATE TABLE [DST].[AreaAndPath](
	[AreaAndPathId]			[INT]			NOT NULL,
	[Type]					[INT]			NOT NULL,
	[Code]					[VARCHAR](40)	NOT NULL,
	[Title]					[NVARCHAR](250)	NOT NULL,
	[Title_En]				[NVARCHAR](250) NOT NULL,
	[IsActive]				[BIT]			NOT NULL,
	[ParentAreaAndPathRef]	[INT]			NULL,
	[Version]				[INT]			NOT NULL,
	[Creator]				[INT]			NOT NULL,
	[CreationDate]			[DATETIME]		NOT NULL,
	[LastModifier]			[INT]			NOT NULL,
	[LastModificationDate]	[DATETIME]		NOT NULL
) ON [PRIMARY]

--TEXTIMAGE_ON [SGBlob_Data]
--When a table has text, ntext, image, varchar(max), nvarchar(max), varbinary(max), xml or large user defined type columns uncomment above code
GO
--<< ADD CLOLUMNS >>--

--<<Sample>>--
/*if not exists (select 1 from sys.columns where object_id=object_id('DST.AreaAndPath') and
				[name] = 'ColumnName')
begin
    Alter table DST.AreaAndPath Add ColumnName DataType Nullable
end
GO*/

--<< ALTER COLUMNS >>--

--<< PRIMARYKEY DEFINITION >>--
IF NOT EXISTS (SELECT 1 FROM sys.objects WHERE NAME = 'PK_AreaAndPath')
ALTER TABLE [DST].[AreaAndPath] ADD CONSTRAINT [PK_AreaAndPath] PRIMARY KEY CLUSTERED 
(
	[AreaAndPathId] ASC
) ON [PRIMARY]
GO

--<< DEFAULTS CHECKS DEFINITION >>--

--<< RULES DEFINITION >>--

--<< INDEXES DEFINITION >>--
IF NOT EXISTS (SELECT 1 FROM sys.indexes WHERE NAME = 'UIX_AreaAndPath_Code_ParentAreaAndPathRef')
CREATE UNIQUE NONCLUSTERED INDEX [UIX_AreaAndPath_Code_ParentAreaAndPathRef] ON [DST].[AreaAndPath] 
(
	[Code] ASC,
	[ParentAreaAndPathRef] ASC
) ON [PRIMARY]

GO

IF NOT EXISTS (SELECT 1 FROM sys.indexes WHERE NAME = 'UIX_AreaAndPath_Title_ParentAreaAndPathRef')
CREATE UNIQUE NONCLUSTERED INDEX [UIX_AreaAndPath_Title_ParentAreaAndPathRef] ON [DST].[AreaAndPath] 
(
	[Title] ASC,
	[ParentAreaAndPathRef] ASC
) ON [PRIMARY]

GO

IF NOT EXISTS (SELECT 1 FROM sys.indexes WHERE NAME = 'UIX_AreaAndPath_TitleEn_ParentAreaAndPathRef')
CREATE UNIQUE NONCLUSTERED INDEX [UIX_AreaAndPath_TitleEn_ParentAreaAndPathRef] ON [DST].[AreaAndPath] 
(
	[Title_En] ASC,
	[ParentAreaAndPathRef] ASC
) ON [PRIMARY]

GO

--<< FOREIGNKEYS DEFINITION >>--
IF NOT EXISTS (SELECT 1 FROM sys.objects WHERE NAME = 'FK_AreaAndPath_ParentAreaAndPathRef')
ALTER TABLE [DST].[AreaAndPath]  ADD CONSTRAINT [FK_AreaAndPath_ParentAreaAndPathRef] FOREIGN KEY([ParentAreaAndPathRef])
REFERENCES [DST].[AreaAndPath] ([AreaAndPathId])

GO

--<< DROP OBJECTS >>--
IF EXISTS (SELECT 1 FROM sys.columns WHERE OBJECT_ID=OBJECT_ID('DST.AreaAndPath') AND [Name] = 'ActivityType')
	ALTER TABLE [DST].[AreaAndPath] DROP COLUMN [ActivityType]
GO