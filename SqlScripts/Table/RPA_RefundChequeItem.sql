--<<FileName:RPA_RefundChequeItem.sql>>--
--<< TABLE DEFINITION >>--

If Object_ID('RPA.RefundChequeItem') Is Null
CREATE TABLE [RPA].[RefundChequeItem](
	[RefundChequeItemID] [int] NOT NULL,
	[ReceiptChequeRef] [int] NULL,
	[PaymentChequeRef] [int] NULL,
	[RefundChequeRef] [int] NULL,
	[HeaderDate] [datetime] NULL,
	[HeaderNumber] [int] NULL, 
	[State] [int] NULL,
	[RefundDescription] [nvarchar](4000) NULL,
	[RefundDescription_En] [nvarchar](4000) NULL
) ON [PRIMARY]

--TEXTIMAGE_ON [SGBlob_Data]
--When a table has text, ntext, image, varchar(max), nvarchar(max), varbinary(max), xml or large user defined type columns uncomment above code
GO
--<< ADD CLOLUMNS >>--

--<<Sample>>--
/*if not exists (select 1 from sys.columns where object_id=object_id('RPA.RefundChequeItem') and
				[name] = 'ColumnName')
begin
    Alter table RPA.RefundChequeItem Add ColumnName DataType Nullable
end
GO*/
if not exists (select 1 from sys.columns where object_id=object_id('RPA.RefundChequeItem') and
				[name] = 'State')
begin
    Alter table RPA.RefundChequeItem Add State int Null
end
GO

if not exists (select 1 from sys.columns where object_id=object_id('RPA.RefundChequeItem') and
				[name] = 'RefundDescription')
begin
    Alter table RPA.RefundChequeItem Add [RefundDescription] [nvarchar](4000) Null
end
GO

if not exists (select 1 from sys.columns where object_id=object_id('RPA.RefundChequeItem') and
				[name] = 'RefundDescription_En')
begin
    Alter table RPA.RefundChequeItem Add [RefundDescription_En] [nvarchar](4000) Null
end
GO

--<< ALTER COLUMNS >>--

--<< PRIMARYKEY DEFINITION >>--

If not Exists (select 1 from sys.objects where name = 'PK_RefundChequeItem')
ALTER TABLE [RPA].[RefundChequeItem] ADD  CONSTRAINT [PK_RefundChequeItem] PRIMARY KEY CLUSTERED 
(
	[RefundChequeItemID] ASC
) ON [PRIMARY]
GO

--<< DEFAULTS CHECKS DEFINITION >>--

--<< RULES DEFINITION >>--

--<< INDEXES DEFINITION >>--

--<< FOREIGNKEYS DEFINITION >>--

If not Exists (select 1 from sys.objects where name = 'FK_RefundChequeItem_PaymentCheque')
ALTER TABLE [RPA].[RefundChequeItem]  ADD  CONSTRAINT [FK_RefundChequeItem_PaymentCheque] FOREIGN KEY([PaymentChequeRef])
REFERENCES [RPA].[PaymentCheque] ([PaymentChequeId])

GO
If not Exists (select 1 from sys.objects where name = 'FK_RefundChequeItem_ReceiptCheque')
ALTER TABLE [RPA].[RefundChequeItem]  ADD  CONSTRAINT [FK_RefundChequeItem_ReceiptCheque] FOREIGN KEY([ReceiptChequeRef])
REFERENCES [RPA].[ReceiptCheque] ([ReceiptChequeId])

GO
If not Exists (select 1 from sys.objects where name = 'FK_RefundChequeItem_RefundChequeRef')
ALTER TABLE [RPA].[RefundChequeItem]  ADD  CONSTRAINT [FK_RefundChequeItem_RefundChequeRef] FOREIGN KEY([RefundChequeRef])
REFERENCES [RPA].[RefundCheque] ([RefundChequeId])
ON DELETE CASCADE

GO

--<< DROP OBJECTS >>--
