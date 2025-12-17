--<<FileName:CNT_ChangeItem.sql>>--
--<< TABLE DEFINITION >>--

If Object_ID('CNT.ChangeItem') Is Null
CREATE TABLE [CNT].[ChangeItem](
	[ChangeID] [int] NOT NULL,
	[ContractRef] [int] NOT NULL,
	[RowNumber] [int] NOT NULL,
	[Date] [datetime] NOT NULL,
	[Type] [int] NOT NULL,
	[PrimaryFee] [decimal](19, 4) NOT NULL,
	[ChangeAmount] [decimal](19, 4) NOT NULL,
	[ChangeAmountType] [int] NOT NULL,
	[Description] [nvarchar](250) NULL,
	[Description_En] [nvarchar](250) NULL,
) ON [PRIMARY]

--TEXTIMAGE_ON [SGBlob_Data]
--When a table has text, ntext, image, varchar(max), nvarchar(max), varbinary(max), xml or large user defined type columns uncomment above code
GO
--<< ADD CLOLUMNS >>--

--<<Sample>>--
/*if not exists (select 1 from sys.columns where object_id=object_id('CNT.ChangeItem') and
				[name] = 'ColumnName')
begin
    Alter table CNT.ChangeItem Add ColumnName DataType Nullable
end
GO*/

if not exists (select 1 from sys.columns where object_id=object_id('CNT.ChangeItem') and
				[name] = 'Description')
begin
    Alter table CNT.ChangeItem Add [Description] [nvarchar](250) NULL
end
GO

if not exists (select 1 from sys.columns where object_id=object_id('CNT.ChangeItem') and
				[name] = 'Description_En')
begin
    Alter table CNT.ChangeItem Add [Description_En] [nvarchar](250) NULL
end
GO


--<< ALTER COLUMNS >>--

--<< PRIMARYKEY DEFINITION >>--

If not Exists (select 1 from sys.objects where name = 'PK_ChangeItem')
ALTER TABLE [CNT].[ChangeItem] ADD  CONSTRAINT [PK_ChangeItem] PRIMARY KEY CLUSTERED 
(
	[ChangeID] ASC
) ON [PRIMARY]
GO

--<< DEFAULTS CHECKS DEFINITION >>--

--<< RULES DEFINITION >>--

--<< INDEXES DEFINITION >>--

--<< FOREIGNKEYS DEFINITION >>--

If not Exists (select 1 from sys.objects where name = 'FK_ChangeItem_Contract')
ALTER TABLE [CNT].[ChangeItem]  ADD  CONSTRAINT [FK_ChangeItem_Contract] FOREIGN KEY([ContractRef])
REFERENCES [CNT].[Contract] ([ContractID])
ON DELETE CASCADE

GO

--<< DROP OBJECTS >>--
