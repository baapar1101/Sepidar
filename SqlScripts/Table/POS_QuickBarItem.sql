--<<FileName:POS_QuickBarItem.sql>>--
--<< TABLE DEFINITION >>--

If Object_ID('POS.QuickBarItem') Is Null
CREATE TABLE [POS].[QuickBarItem](
	[QuickBarItemID] [int] NOT NULL,
	[QuickBarRef] [int] NOT NULL,
	[ItemIndex] [int] NOT NULL,
	[ItemRef] [int] NOT NULL,
	[Shortcut] [int] NOT NULL
) ON [PRIMARY]

--TEXTIMAGE_ON [SGBlob_Data]
--When a table has text, ntext, image, varchar(max), nvarchar(max), varbinary(max), xml or large user defined type columns uncomment above code
GO
--<< ADD CLOLUMNS >>--

--<<Sample>>--
/*if not exists (select 1 from sys.columns where object_id=object_id('POS.QuickBarItem') and
				[name] = 'ColumnName')
begin
    Alter table POS.QuickBarItem Add ColumnName DataType Nullable
end
GO*/

--<< ALTER COLUMNS >>--

--<< PRIMARYKEY DEFINITION >>--

If not Exists (select 1 from sys.objects where name = 'PK_QuickBarItem')
ALTER TABLE [POS].[QuickBarItem] ADD  CONSTRAINT [PK_QuickBarItem] PRIMARY KEY CLUSTERED 
(
	[QuickBarItemID] ASC
) ON [PRIMARY]
GO

--<< DEFAULTS CHECKS DEFINITION >>--

--<< RULES DEFINITION >>--

--<< INDEXES DEFINITION >>--

--<< FOREIGNKEYS DEFINITION >>--

If not Exists (select 1 from sys.objects where name = 'FK_QuickBarItem_Item_ItemRef')
ALTER TABLE [POS].[QuickBarItem]  ADD  CONSTRAINT [FK_QuickBarItem_Item_ItemRef] FOREIGN KEY([ItemRef])
REFERENCES [INV].[Item] ([ItemID])

GO
If not Exists (select 1 from sys.objects where name = 'FK_QuickBarItem_QuickBar_QuickBarRef')
ALTER TABLE [POS].[QuickBarItem]  ADD  CONSTRAINT [FK_QuickBarItem_QuickBar_QuickBarRef] FOREIGN KEY([QuickBarRef])
REFERENCES [POS].[QuickBar] ([QuickBarID])
ON UPDATE CASCADE
ON DELETE CASCADE

--<< DROP OBJECTS >>--
