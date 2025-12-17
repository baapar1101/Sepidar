--<<FileName:DST_OrderingFailureItem.sql>>--

--<< TABLE DEFINITION >>--
IF Object_ID('DST.OrderingFailureItem') IS NULL
CREATE TABLE [DST].[OrderingFailureItem](
	[OrderingFailureItemId]		[INT]			NOT NULL,
	[OrderingFailureRef]		[INT]			NOT NULL,
	[AreaAndPathRef]			[INT]			NULL,
	[PartyAddressRef]			[INT]			NULL,
	[UnexecutedActReasonRef]	[INT]			NULL,
	[Description]				[NVARCHAR](250) NULL,
	[Description_En]			[NVARCHAR](250)	NULL,
	[Guid] 						[NVARCHAR](36)	NULL,
	[Creator]					[INT]		NOT NULL,
	[CreationDate]				[DATETIME]	NOT NULL,
	[LastModifier]				[INT]		NOT NULL,
	[LastModificationDate]		[DATETIME]	NOT NULL,
) ON [PRIMARY]

--TEXTIMAGE_ON [SGBlob_Data]
--When a table has text, ntext, image, varchar(max), nvarchar(max), varbinary(max), xml or large user defined type columns uncomment above code
GO
--<< ADD CLOLUMNS >>--
IF NOT EXISTS (SELECT 1 FROM sys.columns WHERE object_id=OBJECT_ID('DST.OrderingFailureItem') AND [name]='Guid')
BEGIN
	ALTER TABLE DST.[OrderingFailureItem] ADD [Guid] [NVARCHAR](36) NULL 
END
GO

IF NOT EXISTS (SELECT 1 FROM sys.columns WHERE [object_id] = OBJECT_ID('DST.OrderingFailureItem') AND [name]='Creator')
BEGIN
	ALTER TABLE [DST].[OrderingFailureItem] ADD [Creator] [INT] NOT NULL DEFAULT 1
END
GO

IF NOT EXISTS (SELECT 1 FROM sys.columns WHERE [object_id] = OBJECT_ID('DST.OrderingFailureItem') AND [name]='CreationDate')
BEGIN
	ALTER TABLE [DST].[OrderingFailureItem] ADD [CreationDate] [DATETIME] NOT NULL DEFAULT GETDATE()
END
GO

IF NOT EXISTS (SELECT 1 FROM sys.columns WHERE [object_id] = OBJECT_ID('DST.OrderingFailureItem') AND [name]='LastModifier')
BEGIN
	ALTER TABLE [DST].[OrderingFailureItem] ADD [LastModifier] [INT] NOT NULL DEFAULT 1
END
GO

IF NOT EXISTS (SELECT 1 FROM sys.columns WHERE [object_id] = OBJECT_ID('DST.OrderingFailureItem') AND [name]='LastModificationDate')
BEGIN
	ALTER TABLE [DST].[OrderingFailureItem] ADD [LastModificationDate] [DATETIME] NOT NULL DEFAULT GETDATE()
END
GO

--<<Sample>>--
/*if not exists (select 1 from sys.columns where object_id=object_id('DST.AreaAndPath') and
				[name] = 'ColumnName')
begin
    Alter table DST.AreaAndPath Add ColumnName DataType Nullable
end
GO*/

--<< ALTER COLUMNS >>--
IF EXISTS (SELECT 1 FROM sys.columns WHERE OBJECT_ID=OBJECT_ID('DST.OrderingFailureItem') AND
				[name] = 'UnexecutedActReasonRef')
BEGIN
    ALTER TABLE DST.[OrderingFailureItem] ALTER COLUMN [UnexecutedActReasonRef] [INT] NULL
END
GO

IF EXISTS (SELECT 1 FROM sys.columns WHERE OBJECT_ID=OBJECT_ID('DST.OrderingFailureItem') AND
				[name] = 'AreaAndPathRef'  AND [is_nullable] = 0)
BEGIN
	BEGIN TRANSACTION
		IF EXISTS (SELECT 1 FROM sys.indexes WHERE name = 'UIX_OrderingFailureItem_OrderingFailureRef_AreaAndPathRef_PartyAddressRef')
			DROP INDEX UIX_OrderingFailureItem_OrderingFailureRef_AreaAndPathRef_PartyAddressRef ON DST.[OrderingFailureItem]

		ALTER TABLE DST.[OrderingFailureItem] ALTER COLUMN AreaAndPathRef [INT] NULL

		CREATE UNIQUE NONCLUSTERED INDEX [UIX_OrderingFailureItem_OrderingFailureRef_AreaAndPathRef_PartyAddressRef] ON [DST].[OrderingFailureItem] 
		(
			[OrderingFailureRef] ASC,
			[AreaAndPathRef] ASC,
			[PartyAddressRef] ASC
		) 
		WHERE AreaAndPathRef IS NOT NULL
		ON [PRIMARY]

	COMMIT TRANSACTION
END
GO

--<< PRIMARYKEY DEFINITION >>--
IF NOT EXISTS (SELECT 1 FROM sys.objects WHERE NAME = 'PK_OrderingFailureItem')
ALTER TABLE [DST].[OrderingFailureItem] ADD CONSTRAINT [PK_OrderingFailureItem] PRIMARY KEY CLUSTERED 
(
	[OrderingFailureItemId] ASC
) ON [PRIMARY]
GO

--<< DEFAULTS CHECKS DEFINITION >>--

--<< RULES DEFINITION >>--

--<< INDEXES DEFINITION >>--
IF NOT EXISTS (SELECT 1 FROM sys.indexes WHERE NAME = 'UIX_OrderingFailureItem_OrderingFailureRef_AreaAndPathRef_PartyAddressRef')
CREATE UNIQUE NONCLUSTERED INDEX [UIX_OrderingFailureItem_OrderingFailureRef_AreaAndPathRef_PartyAddressRef] ON [DST].[OrderingFailureItem] 
(
	[OrderingFailureRef] ASC,
	[AreaAndPathRef] ASC,
	[PartyAddressRef] ASC
) 
WHERE AreaAndPathRef IS NOT NULL
ON [PRIMARY]

GO

IF NOT EXISTS (SELECT 1 FROM sys.indexes WHERE NAME = 'UIX_OrderingFailureItem_OrderingFailureRef_PartyAddressRef')
CREATE UNIQUE NONCLUSTERED INDEX [UIX_OrderingFailureItem_OrderingFailureRef_PartyAddressRef] ON [DST].[OrderingFailureItem] 
(
	[OrderingFailureRef] ASC,
	[PartyAddressRef] ASC
) 
WHERE AreaAndPathRef IS NULL
ON [PRIMARY]

GO

--<< FOREIGNKEYS DEFINITION >>--
IF EXISTS (SELECT 1 FROM sys.objects WHERE NAME = 'FK_OrderingFailureItem_OrderingFailureRef')
ALTER TABLE [DST].[OrderingFailureItem] DROP CONSTRAINT [FK_OrderingFailureItem_OrderingFailureRef]

GO

IF NOT EXISTS (SELECT 1 FROM sys.objects WHERE NAME = 'FK_OrderingFailureItem_OrderingFailureRef')
ALTER TABLE [DST].[OrderingFailureItem]  ADD CONSTRAINT [FK_OrderingFailureItem_OrderingFailureRef] FOREIGN KEY([OrderingFailureRef])
REFERENCES [DST].[OrderingFailure] ([OrderingFailureId])
ON DELETE CASCADE

GO



IF NOT EXISTS (SELECT 1 FROM sys.objects WHERE NAME = 'FK_OrderingFailureItem_AreaAndPathRef')
ALTER TABLE [DST].[OrderingFailureItem]  ADD CONSTRAINT [FK_OrderingFailureItem_AreaAndPathRef] FOREIGN KEY([AreaAndPathRef])
REFERENCES [DST].[AreaAndPath] ([AreaAndPathId])

GO
IF EXISTS (SELECT 1 
			FROM sys.foreign_keys
			where name = 'FK_OrderingFailureItem_PartyAddressRef' AND delete_referential_action_desc = 'SET_NULL')
BEGIN
	ALTER TABLE [DST].[OrderingFailureItem] DROP CONSTRAINT FK_OrderingFailureItem_PartyAddressRef;
END


IF NOT EXISTS (SELECT 1 FROM sys.objects WHERE NAME = 'FK_OrderingFailureItem_PartyAddressRef')
ALTER TABLE [DST].[OrderingFailureItem]  ADD CONSTRAINT [FK_OrderingFailureItem_PartyAddressRef] FOREIGN KEY([PartyAddressRef])
REFERENCES [GNR].[PartyAddress] ([PartyAddressId])

GO

IF NOT EXISTS (SELECT 1 FROM sys.objects WHERE NAME = 'FK_OrderingFailureItem_UnexecutedActReasonRef')
ALTER TABLE [DST].[OrderingFailureItem]  ADD CONSTRAINT [FK_OrderingFailureItem_UnexecutedActReasonRef] FOREIGN KEY([UnexecutedActReasonRef])
REFERENCES [DST].[UnexecutedActReason] ([UnexecutedActReasonId])

GO

--<< DROP OBJECTS >>--
IF EXISTS (SELECT 1 FROM sys.columns WHERE OBJECT_ID=OBJECT_ID('DST.OrderingFailureItem') AND [name] = 'IsCreatedByDevice')
BEGIN
    ALTER TABLE DST.[OrderingFailureItem] DROP COLUMN [IsCreatedByDevice]
END
GO