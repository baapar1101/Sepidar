--<<FileName:ACC_GLVoucherItem.sql>>--
--<< TABLE DEFINITION >>--

If Object_ID('ACC.GLVoucherItem') Is Null
CREATE TABLE [ACC].[GLVoucherItem](
	[GLVoucherItemId] [int] NOT NULL,
	[GLVoucherRef] [int] NOT NULL,
	[VoucherRef] [int] NOT NULL,
	[Version] [int] NOT NULL
) ON [PRIMARY]

--TEXTIMAGE_ON [SGBlob_Data]
--When a table has text, ntext, image, varchar(max), nvarchar(max), varbinary(max), xml or large user defined type columns uncomment above code
GO
--<< ADD CLOLUMNS >>--

--<<Sample>>--
/*if not exists (select 1 from sys.columns where object_id=object_id('ACC.GLVoucherItem') and
				[name] = 'ColumnName')
begin
    Alter table ACC.GLVoucherItem Add ColumnName DataType Nullable
end
GO*/

--<< ALTER COLUMNS >>--

--<< PRIMARYKEY DEFINITION >>--

If not Exists (select 1 from sys.objects where name = 'PK_GLVoucherItem')
ALTER TABLE [ACC].[GLVoucherItem] ADD  CONSTRAINT [PK_GLVoucherItem] PRIMARY KEY CLUSTERED 
(
	[GLVoucherItemId] ASC
) ON [PRIMARY]
GO

--<< DEFAULTS CHECKS DEFINITION >>--

--<< RULES DEFINITION >>--

--<< INDEXES DEFINITION >>--
If not Exists (select 1 from sys.indexes where name = 'IX_GLVoucherItem_GLVouchreRef_VoucherRef')
	CREATE NONCLUSTERED INDEX [IX_GLVoucherItem_GLVouchreRef_VoucherRef] ON ACC.GLVoucherItem(GLVoucherref,VoucherRef)
GO

--<< FOREIGNKEYS DEFINITION >>--

If not Exists (select 1 from sys.objects where name = 'FK_GLVoucherItem_GLVoucherRef')
ALTER TABLE [ACC].[GLVoucherItem]  ADD  CONSTRAINT [FK_GLVoucherItem_GLVoucherRef] FOREIGN KEY([GLVoucherRef])
REFERENCES [ACC].[GLVoucher] ([GLVoucherId])
ON UPDATE CASCADE
ON DELETE CASCADE

GO
If not Exists (select 1 from sys.objects where name = 'FK_GLVoucherItem_VoucherRef')
ALTER TABLE [ACC].[GLVoucherItem]  ADD  CONSTRAINT [FK_GLVoucherItem_VoucherRef] FOREIGN KEY([VoucherRef])
REFERENCES [ACC].[Voucher] ([VoucherId])

GO

--<< DROP OBJECTS >>--
