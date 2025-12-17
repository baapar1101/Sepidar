--<<FileName:ACC_GLVoucher.sql>>--
--<< TABLE DEFINITION >>--

If Object_ID('ACC.GLVoucher') Is Null
CREATE TABLE [ACC].[GLVoucher](
	[GLVoucherId] [int] NOT NULL,
	[Number] [int] NOT NULL,
	[Date] [datetime] NOT NULL,
	[FiscalYearRef] [int] NOT NULL,
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
/*if not exists (select 1 from sys.columns where object_id=object_id('ACC.GLVoucher') and
				[name] = 'ColumnName')
begin
    Alter table ACC.GLVoucher Add ColumnName DataType Nullable
end
GO*/

--<< ALTER COLUMNS >>--

--<< PRIMARYKEY DEFINITION >>--

If not Exists (select 1 from sys.objects where name = 'PK_GLVoucher')
ALTER TABLE [ACC].[GLVoucher] ADD  CONSTRAINT [PK_GLVoucher] PRIMARY KEY CLUSTERED 
(
	[GLVoucherId] ASC
) ON [PRIMARY]
GO

--<< DEFAULTS CHECKS DEFINITION >>--

--<< RULES DEFINITION >>--

--<< INDEXES DEFINITION >>--

--<< FOREIGNKEYS DEFINITION >>--

If not Exists (select 1 from sys.objects where name = 'FK_GLVoucher_FiscalYearRef')
ALTER TABLE [ACC].[GLVoucher]  ADD  CONSTRAINT [FK_GLVoucher_FiscalYearRef] FOREIGN KEY([FiscalYearRef])
REFERENCES [FMK].[FiscalYear] ([FiscalYearId])

GO

--<< DROP OBJECTS >>--
