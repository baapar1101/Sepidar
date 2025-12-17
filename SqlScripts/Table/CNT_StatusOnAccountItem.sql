
--<<FileName:CNT_StatusOnAccountItem.sql>>--
--<< TABLE DEFINITION >>--

If Object_ID('CNT.StatusOnAccountItem') Is Null
CREATE TABLE [CNT].[StatusOnAccountItem](
	[StatusOnAccountItemID]      [int]            NOT NULL,
	[StatusRef]                  [int]            NOT NULL,
	[ReceiptRef]				 [int]                NULL,
	[PaymentRef]				 [int]                NULL,
	[Date]                       [datetime]       NOT NULL,
	[Price]                      [decimal](19, 4) NOT NULL,
	[Type]                       [int]            NOT NULL,
	[Description]                [nvarchar](250)      NULL,
	[Description_En]             [nvarchar](250)      NULL
	) ON [PRIMARY]



--TEXTIMAGE_ON [SGBlob_Data]
--When a table has text, ntext, image, varchar(max), nvarchar(max), varbinary(max), xml or large user defined type columns uncomment above code
GO
--<< ADD CLOLUMNS >>--

--<<Sample>>--
/*if not exists (select 1 from sys.columns where object_id=object_id('CNT.StatusOnAccountItem') and
				[name] = 'ColumnName')
begin
    Alter table CNT.StatusCoefficientItem Add ColumnName DataType Nullable
end
GO*/

--<< ALTER COLUMNS >>--

     

--<< PRIMARYKEY DEFINITION >>--
If not Exists (select 1 from sys.objects where name = 'PK_StatusOnAccountItem')
ALTER TABLE [CNT].[StatusOnAccountItem] ADD  CONSTRAINT [PK_StatusOnAccountItem] PRIMARY KEY CLUSTERED 
(
	[StatusOnAccountItemID] ASC
) ON [PRIMARY]
GO

--<< DEFAULTS CHECKS DEFINITION >>--

--<< RULES DEFINITION >>--

--<< INDEXES DEFINITION >>--

--<< FOREIGNKEYS DEFINITION >>--

If not Exists (select 1 from sys.objects where name = 'FK_StatusOnAccountItem_Status')
ALTER TABLE [CNT].[StatusOnAccountItem]  Add  CONSTRAINT [FK_StatusOnAccountItem_Status] FOREIGN KEY([StatusRef])
REFERENCES [CNT].[Status] ([StatusId])
ON DELETE CASCADE

GO

If not Exists (select 1 from sys.objects where name = 'FK_StatusOnAccountItem_ReceiptHeader')
ALTER TABLE [CNT].[StatusOnAccountItem]  ADD  CONSTRAINT [FK_StatusOnAccountItem_ReceiptHeader] FOREIGN KEY([ReceiptRef])
REFERENCES [RPA].[ReceiptHeader] ([ReceiptHeaderId])

GO

If not Exists (select 1 from sys.objects where name = 'FK_StatusOnAccountItem_PaymentRef')
ALTER TABLE [CNT].[StatusOnAccountItem]  ADD  CONSTRAINT [FK_StatusOnAccountItem_PaymentRef] FOREIGN KEY([PaymentRef])
REFERENCES [RPA].[PaymentHeader] ([PaymentHeaderId])

GO


--<< DROP OBJECTS >>--


	