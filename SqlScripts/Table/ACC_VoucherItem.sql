--<<FileName:ACC_VoucherItem.sql>>--
--<< TABLE DEFINITION >>--

If Object_ID('ACC.VoucherItem') Is Null
CREATE TABLE [ACC].[VoucherItem](
	[VoucherItemId] [int] NOT NULL,
	[VoucherRef] [int] NOT NULL,
	[RowNumber] [int] NOT NULL,
	[AccountSLRef] [int] NOT NULL,
	[DLRef] [int] NULL,
	[Debit] [decimal](28, 4) NOT NULL,
	[Credit] [decimal](28, 4) NOT NULL,
	[CurrencyRef] [int] NULL,
	[CurrencyRate] [decimal](26, 16) NULL,
	[CurrencyDebit] [decimal](19, 4) NULL,
	[CurrencyCredit] [decimal](19, 4) NULL,
	[TrackingNumber] [nvarchar](40) NULL,
	[TrackingDate] [datetime] NULL,
	[IssuerEntityName] [varchar](400) NOT NULL,
	[IssuerEntityRef] [int] NOT NULL,
	[Description] [nvarchar](250) NOT NULL,
	[Description_En] [nvarchar](250) NOT NULL,
	[Version] [int] NOT NULL
) ON [PRIMARY]

--TEXTIMAGE_ON [SGBlob_Data]
--When a table has text, ntext, image, varchar(max), nvarchar(max), varbinary(max), xml or large user defined type columns uncomment above code
GO
--<< ADD CLOLUMNS >>--


--<<Sample>>--
/*if not exists (select 1 from sys.columns where object_id=object_id('ACC.VoucherItem') and
				[name] = 'ColumnName')
begin
    Alter table ACC.VoucherItem Add ColumnName DataType Nullable
end
GO*/

--<< ALTER COLUMNS >>--
--change decimal(19,4) to decimal(26,16)
IF EXISTS (
	select 1 from sys.columns
	where name = 'CurrencyRate'
		and object_name(object_id) = 'VoucherItem'
		and [precision] = 19
		and [scale] = 4)
BEGIN
	ALTER TABLE Acc.VoucherItem
		ALTER COLUMN CurrencyRate decimal(26, 16) NULL
END	
GO
--change decimal(19,4) to decimal(28,4)
IF EXISTS (
	select 1 from sys.columns
	where name = 'Debit'
		and object_name(object_id) = 'VoucherItem'
		and [precision] = 19
		and [scale] = 4)
BEGIN
	ALTER TABLE Acc.VoucherItem
		ALTER COLUMN Debit decimal(28, 4) NULL
END	
GO
--change decimal(19,4) to decimal(28,4)
IF EXISTS (
	select 1 from sys.columns
	where name = 'Credit'
		and object_name(object_id) = 'VoucherItem'
		and [precision] = 19
		and [scale] = 4)
BEGIN
	ALTER TABLE Acc.VoucherItem
		ALTER COLUMN Credit decimal(28, 4) NULL
END
GO

--<< PRIMARYKEY DEFINITION >>--

If not Exists (select 1 from sys.objects where name = 'PK_VoucherItem')
ALTER TABLE [ACC].[VoucherItem] ADD  CONSTRAINT [PK_VoucherItem] PRIMARY KEY CLUSTERED 
(
	[VoucherItemId] ASC
) ON [PRIMARY]
GO

--<< DEFAULTS CHECKS DEFINITION >>--

--<< RULES DEFINITION >>--

--<< INDEXES DEFINITION >>--

If not Exists (select 1 from sys.indexes where name = 'IX_VoucherItem_AccountSLRef')
CREATE NONCLUSTERED INDEX [IX_VoucherItem_AccountSLRef] ON [ACC].[VoucherItem] 
(
	[AccountSLRef] ASC
) ON [PRIMARY]

GO
If not Exists (select 1 from sys.indexes where name = 'IX_VoucherItem_DLRef')
CREATE NONCLUSTERED INDEX [IX_VoucherItem_DLRef] ON [ACC].[VoucherItem] 
(
	[DLRef] ASC
) ON [PRIMARY]

GO
If not Exists (select 1 from sys.indexes where name = 'IX_VoucherItem_VoucherRef')
CREATE NONCLUSTERED INDEX [IX_VoucherItem_VoucherRef] ON [ACC].[VoucherItem] 
(
	[VoucherRef] ASC
) ON [PRIMARY]

GO

If not Exists (select 1 from sys.indexes where name = 'IX_VoucherItem_AccountSLRef_DLRef')
CREATE NONCLUSTERED INDEX [IX_VoucherItem_AccountSLRef_DLRef] ON [ACC].[VoucherItem] 
(
	[AccountSLRef] ASC, [DLRef] ASC
) ON [PRIMARY]

GO

If not Exists (select 1 from sys.indexes where name = 'IX_VoucherItem_CurrencyRef')
CREATE NONCLUSTERED INDEX [IX_VoucherItem_CurrencyRef] ON [ACC].[VoucherItem] 
(
	[CurrencyRef] ASC
) ON [PRIMARY]


--<< FOREIGNKEYS DEFINITION >>--

If not Exists (select 1 from sys.objects where name = 'FK_VoucherItem_AccountSLRef')
ALTER TABLE [ACC].[VoucherItem]  ADD  CONSTRAINT [FK_VoucherItem_AccountSLRef] FOREIGN KEY([AccountSLRef])
REFERENCES [ACC].[Account] ([AccountId])

GO
If not Exists (select 1 from sys.objects where name = 'FK_VoucherItem_CurrencyRef')
ALTER TABLE [ACC].[VoucherItem]  ADD  CONSTRAINT [FK_VoucherItem_CurrencyRef] FOREIGN KEY([CurrencyRef])
REFERENCES [GNR].[Currency] ([CurrencyID])

GO
If not Exists (select 1 from sys.objects where name = 'FK_VoucherItem_DLRef')
ALTER TABLE [ACC].[VoucherItem]  ADD  CONSTRAINT [FK_VoucherItem_DLRef] FOREIGN KEY([DLRef])
REFERENCES [ACC].[DL] ([DLId])

GO
If not Exists (select 1 from sys.objects where name = 'FK_VoucherItem_VoucherRef')
ALTER TABLE [ACC].[VoucherItem]  ADD  CONSTRAINT [FK_VoucherItem_VoucherRef] FOREIGN KEY([VoucherRef])
REFERENCES [ACC].[Voucher] ([VoucherId])
ON UPDATE CASCADE
ON DELETE CASCADE

GO

--<< DROP OBJECTS >>--
