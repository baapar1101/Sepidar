--<< TABLE DEFINITION >>--
IF Object_ID('RPA.PettyCashBill') IS NULL
CREATE TABLE [RPA].[PettyCashBill]
(
    [PettyCashBillId]           [int]            NOT NULL,
    [Number]                    [int]            NOT NULL,
    [Date]                      [datetime]       NOT NULL,
    [State]                     [int]            NOT NULL,
    [TotalAmount]               [decimal](19, 4) NOT NULL,
    [TotalAmountInBaseCurrency] [decimal](19, 4) NOT NULL,
    [Description]               [nvarchar](4000) NULL,
    [Description_En]            [nvarchar](4000) NULL,

    [PettyCashRef]              [int]            NOT NULL,
    [VoucherRef]                [int]            NULL,
    [FiscalYearRef]             [int]            NOT NULL,

    [Version]                   [int]            NOT NULL,
    [Creator]                   [int]            NOT NULL,
    [CreationDate]              [datetime]       NOT NULL,
    [LastModifier]              [int]            NOT NULL,
    [LastModificationDate]      [datetime]       NOT NULL
) ON [PRIMARY]

GO

--<< ADD CLOLUMNS >>--

--<< ALTER COLUMNS >>--

--<< PRIMARYKEY DEFINITION >>--

IF NOT EXISTS (SELECT 1 FROM sys.objects WHERE name = 'PK_PettyCashBill')
ALTER TABLE [RPA].[PettyCashBill] ADD CONSTRAINT [PK_PettyCashBill] PRIMARY KEY CLUSTERED
(
	[PettyCashBillId] ASC
) ON [PRIMARY]
GO

--<< DEFAULTS CHECKS DEFINITION >>--

--<< RULES DEFINITION >>--

--<< INDEXES DEFINITION >>--

--<< FOREIGNKEYS DEFINITION >>--

IF NOT EXISTS (SELECT 1	FROM sys.objects WHERE name = 'FK_PettyCashBill_PettyCashRef')
ALTER TABLE [RPA].[PettyCashBill] ADD CONSTRAINT [FK_PettyCashBill_PettyCashRef] FOREIGN KEY ([PettyCashRef])
REFERENCES [RPA].[PettyCash] ([PettyCashId])

GO

IF NOT EXISTS (SELECT 1	FROM sys.objects WHERE name = 'FK_PettyCashBill_FiscalYearRef')
ALTER TABLE [RPA].[PettyCashBill] ADD CONSTRAINT [FK_PettyCashBill_FiscalYearRef] FOREIGN KEY ([FiscalYearRef])
REFERENCES [FMK].[FiscalYear] ([FiscalYearId])

GO

If not Exists (select 1 from sys.objects where name = 'FK_PettyCashBill_VoucherRef')
ALTER TABLE [RPA].[PettyCashBill]  ADD  CONSTRAINT [FK_PettyCashBill_VoucherRef] FOREIGN KEY([VoucherRef])
REFERENCES [ACC].[Voucher] ([VoucherId])

GO

--<< DROP OBJECTS >>--
