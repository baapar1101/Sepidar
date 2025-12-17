--<<FileName:AST_UseableItem.sql>>--
--<< TABLE DEFINITION >>--
 
If Object_ID('AST.UseableItem') Is Null
CREATE TABLE [AST].[UseableItem](
	[UseableItemId]			[INT]	NOT NULL,
	[AssetRef]				[INT]	NOT NULL,
	[UseableRef]			[INT]	NOT NULL,
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

If not Exists (select 1 from sys.objects where name = 'PK_UseableItem')
ALTER TABLE [AST].[UseableItem] ADD  CONSTRAINT [PK_UseableItem] 
PRIMARY KEY CLUSTERED 
(
	[UseableItemId] ASC
) ON [PRIMARY]
GO
--<< DEFAULTS CHECKS DEFINITION >>--

--<< RULES DEFINITION >>--

--<< INDEXES DEFINITION >>--

--<< FOREIGNKEYS DEFINITION >>--

If not Exists (select 1 from sys.objects where name = 'FK_UseableItem_AssetRef')
ALTER TABLE [AST].[UseableItem]  ADD  CONSTRAINT [FK_UseableItem_AssetRef] 
FOREIGN KEY([AssetRef])
REFERENCES [AST].[Asset] ([AssetID])

GO

If not Exists (select 1 from sys.objects where name = 'FK_UseableItem_UseableRef')
ALTER TABLE [AST].[UseableItem]  ADD  CONSTRAINT [FK_UseableItem_UseableRef] 
FOREIGN KEY([UseableRef])
REFERENCES [AST].[Useable] ([UseableId])
ON DELETE  CASCADE 

GO

If not Exists (select 1 from sys.objects where name = 'FK_UseableItem_AssetTransactionRef')
ALTER TABLE [AST].[UseableItem]  ADD  CONSTRAINT [FK_UseableItem_AssetTransactionRef] 
FOREIGN KEY([AssetTransactionRef])
REFERENCES [AST].[AssetTransaction] ([AssetTransactionID])

GO

--GO

--<< DROP OBJECTS >>--
 