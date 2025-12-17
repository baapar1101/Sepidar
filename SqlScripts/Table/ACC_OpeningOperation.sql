--<<FileName:ACC_OpeningOperation.sql>>--
--<< TABLE DEFINITION >>--

If Object_ID('ACC.OpeningOperation') Is Null
CREATE TABLE [ACC].[OpeningOperation](
	[OpeningOperationId] [int] NOT NULL,
	[Date] [datetime] NOT NULL,
	[AccountSLRef] [int]  NULL,
	[VoucherRef] [int] NULL,
	[Description] [nvarchar](250) NULL,
	[Description_En] [nvarchar](250) NULL,
	[Version] [int] NOT NULL,
	[Creator] [int] NOT NULL,
	[CreationDate] [datetime] NOT NULL,
	[LastModifier] [int] NOT NULL,
	[LastModificationDate] [datetime] NOT NULL
) ON [PRIMARY]

--TEXTIMAGE_ON [SGBlob_Data]
--When a table has text, ntext, image, varchar(max), nvarchar(max), varbinary(max), xml or large user defined type columns uncomment above code
GO
--<< ADD CLOLUMNS >>--

--<<Sample>>--
/*if not exists (select 1 from sys.columns where object_id=object_id('ACC.OpeningOperation') and
				[name] = 'ColumnName')
begin
    Alter table ACC.OpeningOperation Add ColumnName DataType Nullable
end
GO*/

--<< ALTER COLUMNS >>--

Alter table ACC.OpeningOperation Alter column [AccountSLRef] [int]  NULL
Go
--<< PRIMARYKEY DEFINITION >>--

If not Exists (select 1 from sys.objects where name = 'PK_OpeningOperation')
ALTER TABLE [ACC].[OpeningOperation] ADD  CONSTRAINT [PK_OpeningOperation] PRIMARY KEY CLUSTERED 
(
	[OpeningOperationId] ASC
) ON [PRIMARY]
GO

--<< DEFAULTS CHECKS DEFINITION >>--

--<< RULES DEFINITION >>--

--<< INDEXES DEFINITION >>--

--<< FOREIGNKEYS DEFINITION >>--

If not Exists (select 1 from sys.objects where name = 'FK_OpeningOperation_AccountSLRef')
ALTER TABLE [ACC].[OpeningOperation]  ADD  CONSTRAINT [FK_OpeningOperation_AccountSLRef] FOREIGN KEY([AccountSLRef])
REFERENCES [ACC].[Account] ([AccountId])

GO
If not Exists (select 1 from sys.objects where name = 'FK_OpeningOperation_VoucherRef')
ALTER TABLE [ACC].[OpeningOperation]  ADD  CONSTRAINT [FK_OpeningOperation_VoucherRef] FOREIGN KEY([VoucherRef])
REFERENCES [ACC].[Voucher] ([VoucherId])

GO

--<< DROP OBJECTS >>--
