--<<FileName:ACC_MergedVoucherReferenceNumber.sql>>--
--<< TABLE DEFINITION >>--

If Object_ID('ACC.MergedVoucherReferenceNumber') Is Null
CREATE TABLE [ACC].[MergedVoucherReferenceNumber](
	[MergedVoucherReferenceNumberId] [int] NOT NULL,
	[VoucherRef] [int] NOT NULL,
	[ReferenceNumber] [int] NOT NULL
) ON [PRIMARY]

--TEXTIMAGE_ON [SGBlob_Data]
--When a table has text, ntext, image, varchar(max), nvarchar(max), varbinary(max), xml or large user defined type columns uncomment above code
GO
--<< ADD CLOLUMNS >>--

--<< ALTER COLUMNS >>--

--<< PRIMARYKEY DEFINITION >>--

If not Exists (select 1 from sys.objects where name = 'PK_MergedVoucherReferenceNumber')
ALTER TABLE [ACC].[MergedVoucherReferenceNumber] ADD  CONSTRAINT [PK_MergedVoucherReferenceNumber] PRIMARY KEY CLUSTERED 
(
	[MergedVoucherReferenceNumberId] ASC
) ON [PRIMARY]
GO

--<< DEFAULTS CHECKS DEFINITION >>--

--<< RULES DEFINITION >>--

--<< INDEXES DEFINITION >>--

If not Exists (select 1 from sys.indexes where name = 'IX_MergedVoucherReferenceNumber_VoucherRef')
CREATE NONCLUSTERED INDEX [IX_MergedVoucherReferenceNumber_VoucherRef] ON [ACC].[MergedVoucherReferenceNumber] 
(
	[VoucherRef] ASC
) ON [PRIMARY]

GO

--<< FOREIGNKEYS DEFINITION >>--

If not Exists (select 1 from sys.objects where name = 'FK_MergedVoucherReferenceNumber_VoucherRef')
ALTER TABLE [ACC].[MergedVoucherReferenceNumber]  ADD  CONSTRAINT [FK_MergedVoucherReferenceNumber_VoucherRef] FOREIGN KEY([VoucherRef])
REFERENCES [ACC].[Voucher] ([VoucherId])
ON DELETE CASCADE

GO

--<< DROP OBJECTS >>--
