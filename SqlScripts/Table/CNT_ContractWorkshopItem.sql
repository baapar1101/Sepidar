--<<FileName:CNT_ContractWorkshopItem.sql>>--
--<< TABLE DEFINITION >>--

If Object_ID('CNT.ContractWorkshopItem') Is Null
CREATE TABLE [CNT].[ContractWorkshopItem](
	[ContractWorkshopItemID] [int] NOT NULL,
	[RowNumber] [int] NOT NULL,
	[ContractRef] [int] NOT NULL,
	[WorkshopRef] [int] NOT NULL,
	[Description] [nvarchar](250) NULL,
	[Description_En] [nvarchar](250) NULL
) ON [PRIMARY]

--TEXTIMAGE_ON [SGBlob_Data]
--When a table has text, ntext, image, varchar(max), nvarchar(max), varbinary(max), xml or large user defined type columns uncomment above code
GO
--<< ADD CLOLUMNS >>--

--<<Sample>>--
/*if not exists (select 1 from sys.columns where object_id=object_id('CNT.ContractWorkshopItem') and
				[name] = 'ColumnName')
begin
    Alter table CNT.ContractWorkshopItem Add ColumnName DataType Nullable
end
GO*/

--<< ALTER COLUMNS >>--

--<< PRIMARYKEY DEFINITION >>--

If not Exists (select 1 from sys.objects where name = 'PK_ContractWorkshopItem')
ALTER TABLE [CNT].[ContractWorkshopItem] ADD  CONSTRAINT [PK_ContractWorkshopItem] PRIMARY KEY CLUSTERED 
(
	[ContractWorkshopItemID] ASC
) ON [PRIMARY]
GO

--<< DEFAULTS CHECKS DEFINITION >>--

--<< RULES DEFINITION >>--

--<< INDEXES DEFINITION >>--

--<< FOREIGNKEYS DEFINITION >>--

If not Exists (select 1 from sys.objects where name = 'FK_ContractWorkshopItem_Contract')
ALTER TABLE [CNT].[ContractWorkshopItem]  ADD  CONSTRAINT [FK_ContractWorkshopItem_Contract] FOREIGN KEY([ContractRef])
REFERENCES [CNT].[Contract] ([ContractID])
ON DELETE CASCADE
GO
If not Exists (select 1 from sys.objects where name = 'FK_ContractWorkshopItem_Workshop')
ALTER TABLE [CNT].[ContractWorkshopItem]  ADD  CONSTRAINT [FK_ContractWorkshopItem_Workshop] FOREIGN KEY([WorkshopRef])
REFERENCES [CNT].[Workshop] ([WorkshopID])

GO

--<< DROP OBJECTS >>--
