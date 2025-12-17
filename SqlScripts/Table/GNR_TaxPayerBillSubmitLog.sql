--<< TABLE DEFINITION >>--
IF Object_ID('GNR.TaxPayerBillSubmitLog') IS NULL
CREATE TABLE [GNR].[TaxPayerBillSubmitLog]
(
    [TaxPayerBillSubmitLogId] [INT]           NOT NULL,
    [TaxPayerBillRef]         [INT]           NULL,
    [TaxPayerBillId]          [INT]           NULL,
    [RelatedVoucherType]      [INT]           NULL,
    [RelatedVoucherId]        [INT]           NULL,
    [TaxId]                   [VARCHAR](250) NULL,
    [SubmitType]              [INT]           NOT NULL,
    [RequestType]             [INT]           NOT NULL,
    [Endpoint]                [NVARCHAR](250) NULL,
    [Request]                 [NVARCHAR](max) NULL,
    [ResponseHttpStatusCode]  [INT]           NULL,
    [Response]                [NVARCHAR](max) NULL,
    [Exception]               [NVARCHAR](max) NULL,
    [ResultMessage]           [NVARCHAR](max) NULL,
    [ResultState]             [INT]           NULL,
    [DateTime]                [datetime]      NULL
) ON [PRIMARY]

GO

--<< ADD CLOLUMNS >>--

--<< ALTER COLUMNS >>--

IF NOT EXISTS (select 1 from sys.columns where object_id=object_id('GNR.TaxPayerBillSubmitLog') and
    [name] = 'TaxPayerBillId')
BEGIN
    ALTER TABLE GNR.TaxPayerBillSubmitLog ADD TaxPayerBillId INT NULL
END

GO

IF NOT EXISTS (select 1 from sys.columns where object_id=object_id('GNR.TaxPayerBillSubmitLog') and
    [name] = 'TaxPayerBillRef' AND is_nullable = 1)
BEGIN
    UPDATE GNR.TaxPayerBillSubmitLog SET TaxPayerBillId = TaxPayerBillRef

    If Exists(select 1 from sys.objects where name = 'FK_TaxPayerBillSubmitLog_TaxPayerBillRef')
        ALTER TABLE [GNR].[TaxPayerBillSubmitLog] DROP CONSTRAINT [FK_TaxPayerBillSubmitLog_TaxPayerBillRef]

    ALTER TABLE GNR.TaxPayerBillSubmitLog ALTER COLUMN TaxPayerBillRef INT NULL
END

GO

IF NOT EXISTS (select 1 from sys.columns where object_id=object_id('GNR.TaxPayerBillSubmitLog') and
    [name] = 'RelatedVoucherType')
BEGIN
    ALTER TABLE GNR.TaxPayerBillSubmitLog ADD RelatedVoucherType INT NULL
END

GO

IF NOT EXISTS (select 1 from sys.columns where object_id=object_id('GNR.TaxPayerBillSubmitLog') and
    [name] = 'RelatedVoucherId')
BEGIN
    ALTER TABLE GNR.TaxPayerBillSubmitLog ADD RelatedVoucherId INT NULL
END

GO

IF NOT EXISTS (select 1 from sys.columns where object_id=object_id('GNR.TaxPayerBillSubmitLog') and
    [name] = 'TaxId')
BEGIN
    ALTER TABLE GNR.TaxPayerBillSubmitLog ADD TaxId [VARCHAR](250) NULL
END

GO

--<< PRIMARYKEY DEFINITION >>--

IF NOT EXISTS(SELECT 1 FROM sys.objects WHERE name = 'PK_TaxPayerBillSubmitLog')
ALTER TABLE [GNR].[TaxPayerBillSubmitLog] ADD CONSTRAINT [PK_TaxPayerBillSubmitLog] PRIMARY KEY CLUSTERED
        ([TaxPayerBillSubmitLogId] ASC)
    ON [PRIMARY]
GO

--<< DEFAULTS CHECKS DEFINITION >>--

--<< RULES DEFINITION >>--

--<< INDEXES DEFINITION >>--

--<< FOREIGNKEYS DEFINITION >>--

If not Exists(select 1 from sys.objects where name = 'FK_TaxPayerBillSubmitLog_TaxPayerBillRef')
ALTER TABLE [GNR].[TaxPayerBillSubmitLog] ADD CONSTRAINT [FK_TaxPayerBillSubmitLog_TaxPayerBillRef] FOREIGN KEY ([TaxPayerBillRef])
    REFERENCES [GNR].[TaxPayerBill] ([TaxPayerBillId])
    ON DELETE SET NULL
GO

--<< DROP OBJECTS >>--
