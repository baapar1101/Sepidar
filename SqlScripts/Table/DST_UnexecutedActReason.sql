--<<FileName:DST_UnexecutedActReason.sql>>--

--<< TABLE DEFINITION >>--
IF Object_ID('DST.UnexecutedActReason') IS NULL
CREATE TABLE [DST].[UnexecutedActReason](
	[UnexecutedActReasonId]		[INT]			NOT NULL,
	[Title]						[NVARCHAR](250)	NOT NULL,
	[Title_En]					[NVARCHAR](250) NOT NULL,
	[IsActive]					[BIT]			NOT NULL,
	[CanUseInOrder]         		[BIT]			NOT NULL,
	[CanUseInDebtCollectionList]	[BIT]			NOT NULL,
	[CanUseInHotDistribution]		[BIT]			NOT NULL,
	[CanUseInColdDistribution]		[BIT]			NOT NULL,
	[CheckLocation]				[BIT]			NOT NULL DEFAULT 0,
	[Version]					[INT]			NOT NULL,
	[Creator]					[INT]			NOT NULL,
	[CreationDate]				[DATETIME]		NOT NULL,
	[LastModifier]				[INT]			NOT NULL,
	[LastModificationDate]		[DATETIME]		NOT NULL
) ON [PRIMARY]

--TEXTIMAGE_ON [SGBlob_Data]
--When a table has text, ntext, image, varchar(max), nvarchar(max), varbinary(max), xml or large user defined type columns uncomment above code
GO

--<< ADD CLOLUMNS >>--

--< Types >--
if not exists (select 1 from sys.columns where object_id=object_id('DST.UnexecutedActReason') and
				[name] = 'CanUseInOrder' )
begin
    Alter table DST.UnexecutedActReason Add CanUseInOrder [BIT]
end
GO
if not exists (select 1 from sys.columns where object_id=object_id('DST.UnexecutedActReason') and
				[name] = 'CanUseInDebtCollectionList' )
begin
    Alter table DST.UnexecutedActReason Add CanUseInDebtCollectionList [BIT]
end
GO
if not exists (select 1 from sys.columns where object_id=object_id('DST.UnexecutedActReason') and
				[name] = 'CanUseInHotDistribution' )
begin
    Alter table DST.UnexecutedActReason Add CanUseInHotDistribution [BIT]
end
GO
if not exists (select 1 from sys.columns where object_id=object_id('DST.UnexecutedActReason') and
				[name] = 'CanUseInColdDistribution' )
begin
    Alter table DST.UnexecutedActReason Add CanUseInColdDistribution [BIT]
end
GO

if  exists (select 1 from sys.columns where object_id=object_id('DST.UnexecutedActReason') and
				[name] = 'CanUseInOrder' and  is_nullable=1)
begin
    UPDATE DST.UnexecutedActReason SET CanUseInOrder = 1 WHERE 1 = 1
    ALTER TABLE DST.UnexecutedActReason ALTER COLUMN CanUseInOrder [BIT] not null
end
GO
if exists (select 1 from sys.columns where object_id=object_id('DST.UnexecutedActReason') and
				[name] = 'CanUseInDebtCollectionList' and  is_nullable=1)
begin
    UPDATE DST.UnexecutedActReason SET CanUseInDebtCollectionList = 1 WHERE 1 = 1
    ALTER TABLE DST.UnexecutedActReason ALTER COLUMN CanUseInDebtCollectionList [BIT] not null
end
GO
if exists (select 1 from sys.columns where object_id=object_id('DST.UnexecutedActReason') and
				[name] = 'CanUseInHotDistribution' and  is_nullable=1)
begin
    UPDATE DST.UnexecutedActReason SET CanUseInHotDistribution = 1 WHERE 1 = 1
    ALTER TABLE DST.UnexecutedActReason ALTER COLUMN CanUseInHotDistribution [BIT] not null
end
GO
if exists (select 1 from sys.columns where object_id=object_id('DST.UnexecutedActReason') and
				[name] = 'CanUseInColdDistribution' and  is_nullable=1)
begin
    UPDATE DST.UnexecutedActReason SET CanUseInColdDistribution = 1 WHERE 1 = 1
    ALTER TABLE DST.UnexecutedActReason ALTER COLUMN CanUseInColdDistribution [BIT] not null
end
GO

------

if not exists (select 1 from sys.columns where object_id=object_id('DST.UnexecutedActReason') and
				[name] = 'CheckLocation' )
begin
    Alter table DST.UnexecutedActReason Add CheckLocation [BIT] not null default 0
end
GO

--<< ALTER COLUMNS >>--

--<< PRIMARYKEY DEFINITION >>--
IF NOT EXISTS (SELECT 1 FROM sys.objects WHERE NAME = 'PK_UnexecutedActReason')
ALTER TABLE [DST].[UnexecutedActReason] ADD CONSTRAINT [PK_UnexecutedActReason] PRIMARY KEY CLUSTERED
(
	[UnexecutedActReasonId] ASC
) ON [PRIMARY]
GO

--<< DEFAULTS CHECKS DEFINITION >>--

--<< RULES DEFINITION >>--

--<< INDEXES DEFINITION >>--
IF NOT EXISTS (SELECT 1 FROM sys.indexes WHERE NAME = 'UIX_UnexecutedActReason_Title')
CREATE UNIQUE NONCLUSTERED INDEX [UIX_UnexecutedActReason_Title] ON [DST].[UnexecutedActReason]
(
	[Title] ASC
) ON [PRIMARY]

GO

IF NOT EXISTS (SELECT 1 FROM sys.indexes WHERE NAME = 'UIX_UnexecutedActReason_TitleEn')
CREATE UNIQUE NONCLUSTERED INDEX [UIX_UnexecutedActReason_TitleEn] ON [DST].[UnexecutedActReason]
(
	[Title_En] ASC
) ON [PRIMARY]

GO

--<< FOREIGNKEYS DEFINITION >>--

--<< DROP OBJECTS >>--
