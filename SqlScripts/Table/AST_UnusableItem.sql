--<<FileName:AST_UnusableOperationItem.sql>>--
--<< TABLE DEFINITION >>--
 
If Object_ID('AST.UnuseableItem') Is Null
CREATE TABLE [AST].[UnuseableItem](
	[UnuseableItemId]		[INT]	NOT NULL,
	[AssetRef]				[INT]	NOT NULL,
	[UnuseableRef]			[INT]	NOT NULL,
	[RowNumber]				[INT]	NOT NULL,
	[AssetTransactionRef]	[INT]	NOT NULL
) ON [PRIMARY]

--TEXTIMAGE_ON [SGBlob_Data]
--When a table has text, ntext, image, varchar(max), nvarchar(max), varbinary(max), xml or large user defined type columns uncomment above code
GO
--<< ADD CLOLUMNS >>--

--<<Sample>>--

--<< ALTER COLUMNS >>--

--<< PRIMARYKEY DEFINITION >>--

If not Exists (select 1 from sys.objects where name = 'PK_UnuseableItem')
ALTER TABLE [AST].[UnuseableItem] ADD  CONSTRAINT [PK_UnuseableItem] 
PRIMARY KEY CLUSTERED 
(
	[UnuseableItemId] ASC
) ON [PRIMARY]
GO
--<< DEFAULTS CHECKS DEFINITION >>--

--<< RULES DEFINITION >>--

--<< INDEXES DEFINITION >>--

--<< FOREIGNKEYS DEFINITION >>--

If not Exists (select 1 from sys.objects where name = 'FK_UnuseableItem_AssetRef')
ALTER TABLE [AST].[UnuseableItem]  ADD  CONSTRAINT [FK_UnuseableItem_AssetRef] 
FOREIGN KEY([AssetRef])
REFERENCES [AST].[Asset] ([AssetID])

GO

If not Exists (select 1 from sys.objects where name = 'FK_UnuseableItem_UnuseableRef')
ALTER TABLE [AST].[UnuseableItem]  ADD  CONSTRAINT [FK_UnuseableItem_UnuseableRef] 
FOREIGN KEY([UnuseableRef])
REFERENCES [AST].[Unuseable] ([UnuseableId])
ON DELETE  CASCADE 

GO

If not Exists (select 1 from sys.objects where name = 'FK_UnuseableItem_AssetTransactionRef')
ALTER TABLE [AST].[UnuseableItem]  ADD  CONSTRAINT [FK_UnuseableItem_AssetTransactionRef] 
FOREIGN KEY([AssetTransactionRef])
REFERENCES [AST].[AssetTransaction] ([AssetTransactionID])

GO

--GO

--<< DROP OBJECTS >>--
