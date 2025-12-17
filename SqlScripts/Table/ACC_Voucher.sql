--<<FileName:ACC_Voucher.sql>>--
--<< TABLE DEFINITION >>--

If Object_ID('ACC.Voucher') Is Null
CREATE TABLE [ACC].[Voucher](
	[VoucherId] [int] NOT NULL,
	[Number] [int] NOT NULL,
	[Date] [datetime] NOT NULL,
	[ReferenceNumber] [int] NOT NULL,
	[SecondaryNumber] [int] NULL,
	[IsMerged] BIT NOT NULL,
	[State] [int] NOT NULL,
	[Type] [int] NOT NULL,
	[FiscalYearRef] [int] NOT NULL,
	[MergedIssuerSystem] INT NULL,
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

--DailyNumber
IF NOT EXISTS (SELECT 1 FROM sys.columns WHERE object_id=object_id('ACC.Voucher') AND [name] = 'DailyNumber')
	ALTER TABLE ACC.Voucher ADD [DailyNumber] [int] NULL
GO

IF EXISTS (SELECT 1 FROM sys.columns WHERE object_id=object_id('ACC.Voucher') AND [name] = 'DailyNumber' AND is_Nullable = 1)
BEGIN
	--fill DailyNumber
	UPDATE V
	SET DailyNumber = V1.DailyNum
	FROM ACC.Voucher V 
		JOIN (
			SELECT Number, Date, ROW_NUMBER() OVER(PARTITION BY Date ORDER BY Number) AS DailyNum
			FROM ACC.Voucher ) V1
			ON V.Number = V1.Number AND V.Date = V1.Date

	If Exists (select 1 from sys.indexes where name = 'IX_Voucher_Date_DailyNumber')
		drop index ACC.Voucher.IX_Voucher_Date_DailyNumber
		
	ALTER TABLE ACC.Voucher ALTER COLUMN [DailyNumber] [int] NOT NULL
END

GO

--IssuerSystem
IF NOT EXISTS (SELECT 1 FROM sys.columns WHERE object_id=object_id('ACC.Voucher') AND [name] = 'IssuerSystem')
	ALTER TABLE ACC.Voucher ADD [IssuerSystem] [int] NULL
GO
IF EXISTS (SELECT 1 FROM sys.columns WHERE object_id=object_id('ACC.Voucher') AND [name] = 'IssuerSystem' AND is_Nullable = 1)
BEGIN
	--fill IssuerSystem
	UPDATE ACC.Voucher 
	SET IssuerSystem = 3 --Accounting 
	WHERE IssuerSystem IS NULL

	ALTER TABLE ACC.Voucher ALTER COLUMN [IssuerSystem] [int] NOT NULL
END
Go

IF NOT EXISTS (SELECT 1 FROM sys.columns WHERE object_id=object_id('ACC.Voucher') AND [name] = 'IsMerged')
	ALTER TABLE ACC.Voucher ADD [IsMerged] BIT NOT NULL DEFAULT(0)
GO

IF NOT EXISTS (SELECT 1 FROM sys.columns WHERE object_id=object_id('ACC.Voucher') AND [name] = 'MergedIssuerSystem')
	ALTER TABLE ACC.Voucher ADD [MergedIssuerSystem] INT NULL

GO

--<< ALTER COLUMNS >>--

--<< PRIMARYKEY DEFINITION >>--

If not Exists (select 1 from sys.objects where name = 'PK_Voucher')
ALTER TABLE [ACC].[Voucher] ADD  CONSTRAINT [PK_Voucher] PRIMARY KEY CLUSTERED 
(
	[VoucherId] ASC
) ON [PRIMARY]
GO

--<< DEFAULTS CHECKS DEFINITION >>--

--<< RULES DEFINITION >>--

--<< INDEXES DEFINITION >>--

If not Exists (select 1 from sys.indexes where name = 'IX_Voucher')
CREATE NONCLUSTERED INDEX [IX_Voucher] ON [ACC].[Voucher] 
(
	[VoucherId] ASC
) ON [PRIMARY]

GO
--this index used in Reorder VoucherNumbers
If not Exists (select 1 from sys.indexes where name = 'IX_Voucher_Date')
CREATE NONCLUSTERED INDEX [IX_Voucher_Date] ON [ACC].[Voucher] 
(
	[Date] ASC
) ON [PRIMARY]

GO
If not Exists (select 1 from sys.indexes where name = 'IX_Voucher_FiscalYearRef')
CREATE NONCLUSTERED INDEX [IX_Voucher_FiscalYearRef] ON [ACC].[Voucher] 
(
	[FiscalYearRef] ASC
) ON [PRIMARY]

GO

If not Exists (select 1 from sys.indexes where name = 'IX_Voucher_Number_Date')
CREATE NONCLUSTERED INDEX [IX_Voucher_Number_Date] ON [ACC].[Voucher] 
(
	[Number] ASC,
	[Date] ASC
) ON [PRIMARY]

GO

If not Exists (select 1 from sys.indexes where name = 'IX_Voucher_Number_Type_FiscalYearRef')
CREATE NONCLUSTERED INDEX [IX_Voucher_Number_Type_FiscalYearRef]
ON [ACC].[Voucher] ([Type],[FiscalYearRef])
INCLUDE ([VoucherId])

GO

--drop previous index
If Exists (select 1 from sys.indexes where name = 'UIX_Voucher_ReferenceNumber')
DROP INDEX ACC.Voucher.UIX_Voucher_ReferenceNumber
GO
If not Exists (select 1 from sys.indexes where name = 'UIX_Voucher_ReferenceNumber_FiscalYearRef')
CREATE UNIQUE NONCLUSTERED INDEX [UIX_Voucher_ReferenceNumber_FiscalYearRef] ON [ACC].[Voucher] 
(
	[ReferenceNumber] ASC,
	[FiscalYearRef] ASC
) ON [PRIMARY]
GO

--this index used in Reorder VoucherNumbers
If not Exists (select 1 from sys.indexes where name = 'IX_Voucher_Date_DailyNumber')
CREATE NONCLUSTERED INDEX [IX_Voucher_Date_DailyNumber] ON [ACC].[Voucher] 
(
	[Date] ASC,
	[DailyNumber] ASC
) ON [PRIMARY]


--<< FOREIGNKEYS DEFINITION >>--

If not Exists (select 1 from sys.objects where name = 'FK_Voucher_FiscalYearRef')
ALTER TABLE [ACC].[Voucher]  ADD  CONSTRAINT [FK_Voucher_FiscalYearRef] FOREIGN KEY([FiscalYearRef])
REFERENCES [FMK].[FiscalYear] ([FiscalYearId])

GO

--<< DROP OBJECTS >>--
