--<<FileName:CNT_StatusReceiptItem.sql>>--
--<< TABLE DEFINITION >>--

If Object_ID('CNT.StatusReceiptItem') Is Null
CREATE TABLE [CNT].[StatusReceiptItem](
	[StatusReceiptItemID] [int] NOT NULL,
	[RowNumber] [int] NOT NULL,
	[StatusRef] [int] NOT NULL,
	[Type] [int] NOT NULL,
	[Fee] [decimal](19, 4) NOT NULL,
	[ReceiptRef] [int] NULL
) ON [PRIMARY]

--TEXTIMAGE_ON [SGBlob_Data]
--When a table has text, ntext, image, varchar(max), nvarchar(max), varbinary(max), xml or large user defined type columns uncomment above code
GO
--<< ADD CLOLUMNS >>--

--<<Sample>>--
/*if not exists (select 1 from sys.columns where object_id=object_id('CNT.StatusReceiptItem') and
				[name] = 'ColumnName')
begin
    Alter table CNT.StatusReceiptItem Add ColumnName DataType Nullable
end
GO*/

--<< ALTER COLUMNS >>--

--<< PRIMARYKEY DEFINITION >>--

If not Exists (select 1 from sys.objects where name = 'PK_StatusReceiptItem')
ALTER TABLE [CNT].[StatusReceiptItem] ADD  CONSTRAINT [PK_StatusReceiptItem] PRIMARY KEY CLUSTERED 
(
	[StatusReceiptItemID] ASC
) ON [PRIMARY]
GO

--<< DEFAULTS CHECKS DEFINITION >>--

--<< RULES DEFINITION >>--

--<< INDEXES DEFINITION >>--

--<< FOREIGNKEYS DEFINITION >>--

If not Exists (select 1 from sys.objects where name = 'FK_StatusReceiptItem_ReceiptHeader')
ALTER TABLE [CNT].[StatusReceiptItem]  ADD  CONSTRAINT [FK_StatusReceiptItem_ReceiptHeader] FOREIGN KEY([ReceiptRef])
REFERENCES [RPA].[ReceiptHeader] ([ReceiptHeaderId])

GO
If not Exists (select 1 from sys.objects where name = 'FK_StatusReceiptItem_Status')
ALTER TABLE [CNT].[StatusReceiptItem]  ADD  CONSTRAINT [FK_StatusReceiptItem_Status] FOREIGN KEY([StatusRef])
REFERENCES [CNT].[Status] ([StatusID])

GO

--<< DROP OBJECTS >>--
