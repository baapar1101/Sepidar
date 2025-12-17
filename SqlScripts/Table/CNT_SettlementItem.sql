--<<FileName:CNT_SettlementItem.sql>>--
--<< TABLE DEFINITION >>--
If Object_ID('CNT.SettlementItem') Is Null
CREATE TABLE [CNT].[SettlementItem](
	[SettlementItemID] [int] NOT NULL,
	[RowNumber] [int] NOT NULL,
	[StatusRef] [int] NOT NULL,
	[SettlementRef] [int] NOT NULL,
	[Remain] [decimal](19, 4) NOT NULL,
	[Amount] [decimal](19, 4) NOT NULL,
	[Description] [nvarchar](250) NULL,
	[Description_En] [nvarchar](250) NULL
) ON [PRIMARY]

--TEXTIMAGE_ON [SGBlob_Data]
--When a table has text, ntext, image, varchar(max), nvarchar(max), varbinary(max), xml or large user defined type columns uncomment above code
GO
--<< ADD CLOLUMNS >>--

--<<Sample>>--
/*if not exists (select 1 from sys.columns where object_id=object_id('CNT.SettlementItem') and
				[name] = 'ColumnName')
begin
    Alter table CNT.SettlementItem Add ColumnName DataType Nullable
end
GO*/
if not exists (select 1 from sys.columns where object_id=object_id('CNT.SettlementItem') and
				[name] = 'Description_En')
begin
    Alter table CNT.SettlementItem Add [Description_En] [nvarchar](250) NULL 
end
GO
if not exists (select 1 from sys.columns where object_id=object_id('CNT.SettlementItem') and
				[name] = 'Description')
begin
    Alter table CNT.SettlementItem Add [Description] [nvarchar](250) NULL 
end


--<< ALTER COLUMNS >>--

--<< PRIMARYKEY DEFINITION >>--

If not Exists (select 1 from sys.objects where name = 'PK_SettlementItem_1')
ALTER TABLE [CNT].[SettlementItem] ADD  CONSTRAINT [PK_SettlementItem_1] PRIMARY KEY CLUSTERED 
(
	[SettlementItemID] ASC
) ON [PRIMARY]
GO

--<< DEFAULTS CHECKS DEFINITION >>--

--<< RULES DEFINITION >>--

--<< INDEXES DEFINITION >>--

--<< FOREIGNKEYS DEFINITION >>--

If not Exists (select 1 from sys.objects where name = 'FK_Contract_SettlementItem_Settlement')
ALTER TABLE [CNT].[SettlementItem]  ADD  CONSTRAINT [FK_Contract_SettlementItem_Settlement] FOREIGN KEY([SettlementRef])
REFERENCES [CNT].[Settlement] ([SettlementID])
ON DELETE CASCADE

GO
If not Exists (select 1 from sys.objects where name = 'FK_SettlementItem_Status')
ALTER TABLE [CNT].[SettlementItem]  ADD  CONSTRAINT [FK_SettlementItem_Status] FOREIGN KEY([StatusRef])
REFERENCES [CNT].[Status] ([StatusID])

GO

--<< DROP OBJECTS >>--
