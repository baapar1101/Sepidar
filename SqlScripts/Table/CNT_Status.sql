--<<FileName:CNT_Status.sql>>--
--<< TABLE DEFINITION >>--

If Object_ID('CNT.Status') Is Null
CREATE TABLE [CNT].[Status](
    [StatusID]                  [int]                NOT NULL,
    [Nature]                    [int]                NOT NULL,
    [Established]               bit                  NOT NULL, 
    [Date]                      [datetime]           NOT NULL,
    [Number]                    [int]                NOT NULL,
    [InitialSettledValue]       [decimal](19,4)          NULL,
    [ContractRef]               [int]                NOT NULL,
    [PartyAddressRef]           [int]                    NULL,
    [Type]                      [int]                NOT NULL,
    [StatusRef]                 [int]                    NULL,
    [StatusRefType]             [int]                NOT NULL,
    [ConfirmedCost]             [Decimal](19,4)      NOT NULL,
    [CurrentCost]               [Decimal](19,4)      NOT NULL,
    [Material]                  [decimal](19, 4)     NOT NULL,
    [PreReceipt]                [decimal](19, 4)     NOT NULL,
    [VoucherRef]                [int]                    NULL,
    [SLRef]                     [int]                NOT NULL,
    [SLDebitCreditRef]          [int]                    NULL,
    [ConfirmationState]         [int]                NOT NULL,
    [ConfirmationDate]          [datetime]               NULL,
    [PreStatusPrice]            [decimal](19, 4)     NOT NULL,
    [Version]                   [int]                NOT NULL,
    [Creator]                   [int]                NOT NULL,
    [CreationDate]              [datetime]           NOT NULL,
    [LastModifier]              [int]                NOT NULL,
    [LastModificationDate]      [datetime]           NOT NULL,
    [FiscalYearRef]             [int]                NOT NULL,
    [BillSerial]                [int]                    NULL,
    [TaxPayerBillIssueDateTime] [datetime]               NULL,
	[SettlementType] [int] NOT NULL
) ON [PRIMARY]

--TEXTIMAGE_ON [SGBlob_Data]
--When a table has text, ntext, image, varchar(max), nvarchar(max), varbinary(max), xml or large user defined type columns uncomment above code
GO
--<< ADD CLOLUMNS >>--

--<<Sample>>--
/*if not exists (select 1 from sys.columns where object_id=object_id('CNT.Status') and
                [name] = 'ColumnName')
begin
    Alter table CNT.Status Add ColumnName DataType Nullable
end
GO*/

IF NOT EXISTS (SELECT 1 FROM sys.columns WHERE OBJECT_ID = OBJECT_ID('CNT.Status') AND
				[name] = 'SettlementType')
BEGIN
    ALTER TABLE CNT.[Status] ADD [SettlementType] [int] NULL
	EXEC('UPDATE CNT.[Status] SET SettlementType = 0')
    ALTER TABLE CNT.[Status] ALTER COLUMN [SettlementType] [int] NOT NULL
END
GO

IF NOT EXISTS (SELECT 1 FROM SYS.COLUMNS WHERE OBJECT_ID=OBJECT_ID('CNT.Status') AND
                [name] = 'PartyAddressRef')
BEGIN
    ALTER TABLE [CNT].[Status] ADD [PartyAddressRef] [int] NULL
END

IF NOT EXISTS (SELECT 1 FROM SYS.COLUMNS WHERE OBJECT_ID=OBJECT_ID('CNT.Status') AND
                [name] = 'TaxPayerBillIssueDateTime')
BEGIN
    ALTER TABLE [CNT].[Status] ADD [TaxPayerBillIssueDateTime] [datetime] NULL 
END

if not exists (select 1 from sys.columns where object_id=object_id('CNT.Status') and
                [name] = 'BillSerial')
begin
    Alter table CNT.Status Add [BillSerial] [int] NULL 
end

if not exists (select 1 from sys.columns where object_id=object_id('CNT.Status') and
                [name] = 'FiscalYearRef')
begin
    Alter table CNT.Status Add [FiscalYearRef] [int] NOT NULL DEFAULT 1
end

if not exists (select 1 from sys.columns where object_id=object_id('CNT.Status') and
                [name] = 'PreStatusPrice')
begin
    Alter table CNT.Status Add [PreStatusPrice] DECIMAL(19,4) NOT NULL DEFAULT 0
end
GO

IF NOT EXISTS (SELECT * FROM sys.columns WHERE object_id=object_id('CNT.Status') AND [name]='InitialSettledValue')
    ALTER TABLE CNT.Status ADD [InitialSettledValue] decimal(19,4) NULL

IF NOT EXISTS (SELECT * FROM sys.columns WHERE object_id=object_id('CNT.Status') AND [name]='SLRef')
    ALTER TABLE CNT.Status ADD [SLRef] [int] NOT NULL

IF NOT EXISTS (SELECT * FROM sys.columns WHERE object_id=object_id('CNT.Status') AND [name]='SLDebitCreditRef')
BEGIN
    ALTER TABLE CNT.Status ADD [SLDebitCreditRef] [int] NULL
END


IF NOT EXISTS (SELECT * FROM sys.columns WHERE object_id = object_id('CNT.Status') AND [name] = 'Duty')
    ALTER TABLE CNT.[Status] ADD [Duty] [decimal](19, 4) NOT NULL DEFAULT 0


IF NOT EXISTS (SELECT * FROM sys.columns WHERE object_id = object_id('CNT.Status') AND [name] = 'ConfirmationState')
    ALTER TABLE CNT.[Status] ADD [ConfirmationState] [int] NOT NULL DEFAULT 1

IF NOT EXISTS (SELECT * FROM sys.columns WHERE object_id = object_id('CNT.Status') AND [name] = 'ConfirmationDate')
    ALTER TABLE CNT.[Status] ADD [ConfirmationDate]   [datetime]   NULL

IF NOT EXISTS (SELECT 1 FROM sys.columns WHERE object_id=object_id('CNT.Status') AND
                [name] = 'Nature')
BEGIN
    ALTER TABLE CNT.Status ADD Nature [int] NOT NULL DEFAULT(1)
END
GO

--<< ALTER COLUMNS >>--

IF EXISTS (SELECT 1 FROM sys.columns where object_id=object_id('CNT.Status') and
                [name] = 'Tax')
begin
    Alter table CNT.[Status] ALTER COLUMN [Tax] [decimal](19, 4) NULL
end
GO


IF EXISTS (SELECT 1 FROM sys.columns where object_id=object_id('CNT.Status') and
                [name] = 'VAT')
begin
    Alter table CNT.[Status] ALTER COLUMN [VAT]  [decimal](19, 4) NULL
end
GO


IF EXISTS (SELECT 1 FROM sys.columns where object_id=object_id('CNT.Status') and
                [name] = 'Insurance')
begin
    Alter table CNT.[Status] ALTER COLUMN [Insurance]  [decimal](19, 4) NULL
end
GO


IF EXISTS (SELECT 1 FROM sys.columns where object_id=object_id('CNT.Status') and
                [name] = 'GoodJob')
begin
    Alter table CNT.[Status] ALTER COLUMN [GoodJob]   [decimal](19, 4)  NULL
end
GO


IF EXISTS (SELECT 1 FROM sys.columns where object_id=object_id('CNT.Status') and
                [name] = 'IncCoef')
begin
    Alter table CNT.[Status] ALTER COLUMN [IncCoef] [decimal](19, 4) NULL
end
GO


IF EXISTS (SELECT 1 FROM sys.columns where object_id=object_id('CNT.Status') and
                [name] = 'DecCoef')
begin
    Alter table CNT.[Status] ALTER COLUMN [DecCoef] [decimal](19, 4) NULL
end
GO

IF EXISTS (SELECT 1 FROM sys.columns where object_id=object_id('CNT.Status') and
                [name] = 'OnAccount')
begin
    Alter table CNT.[Status] ALTER COLUMN [OnAccount] [decimal](19, 4)  NULL
end
GO

--<< PRIMARYKEY DEFINITION >>--

If not Exists (select 1 from sys.objects where name = 'PK_Status')
ALTER TABLE [CNT].[Status] ADD  CONSTRAINT [PK_Status] PRIMARY KEY CLUSTERED 
(
    [StatusID] ASC
) ON [PRIMARY]
GO

--<< DEFAULTS CHECKS DEFINITION >>--

--<< RULES DEFINITION >>--

--<< INDEXES DEFINITION >>--
IF EXISTS(SELECT * FROM sys.indexes WHERE name = 'IX_BillSerial' and object_id = Object_ID('CNT.Status'))
BEGIN
    IF NOT EXISTS
    (
        SELECT * FROM sys.indexes I
            JOIN sys.index_columns IC ON I.index_id = IC.index_id
            JOIN sys.columns C ON IC.column_id = C.column_id AND C.object_id = OBJECT_ID('CNT.Status')
        WHERE I.name = 'IX_BillSerial' AND C.name = 'FiscalYearRef'
    )
    DROP INDEX IX_BillSerial ON CNT.Status
END

If not Exists (select 1 from sys.indexes where name = 'IX_BillSerial')
Begin
    If Not Exists(select 1 where cast(SERVERPROPERTY('ProductVersion') as varchar) like '1%')                            
    Begin
        CREATE UNIQUE NONCLUSTERED INDEX [IX_BillSerial] ON [CNT].[Status] 
        (
            [BillSerial] ASC, [FiscalYearRef] ASC
        )         
        ON [PRIMARY]
    End
    Else -- The Version  Of Sql Server Is 2008 Or More
    Begin
        Exec('CREATE UNIQUE NONCLUSTERED INDEX [IX_BillSerial] ON [CNT].[Status] 
                (
                    [BillSerial] ASC, [FiscalYearRef] ASC    
                ) 
                WHERE [BillSerial] IS Not NULL
                ON [PRIMARY]')
    End
End
GO





--<< FOREIGNKEYS DEFINITION >>--

If not Exists (select 1 from sys.objects where name = 'FK_Status_Contract')
ALTER TABLE [CNT].[Status]  ADD  CONSTRAINT [FK_Status_Contract] FOREIGN KEY([ContractRef])
REFERENCES [CNT].[Contract] ([ContractID])


GO
If not Exists (select 1 from sys.objects where name = 'FK_Status_Status')
ALTER TABLE [CNT].[Status]  ADD  CONSTRAINT [FK_Status_Status] FOREIGN KEY([StatusRef])
REFERENCES [CNT].[Status] ([StatusID])

GO
If not Exists (select 1 from sys.objects where name = 'FK_Status_VoucherRef')
ALTER TABLE [CNT].[Status]   ADD  CONSTRAINT [FK_Status_VoucherRef] FOREIGN KEY([VoucherRef])
REFERENCES [ACC].[Voucher] ([VoucherId])
Go

If not Exists (select 1 from sys.objects where name = 'FK_Status_FiscalYearRef')
ALTER TABLE [CNT].[Status]   ADD  CONSTRAINT [FK_Status_FiscalYearRef] FOREIGN KEY([FiscalYearRef])
REFERENCES [FMK].[FiscalYear] ([FiscalYearId])
Go

IF (EXISTS(SELECT 1 FROM sysconstraints WHERE OBJECT_NAME(constid) = 'FK_Status_Account' AND OBJECT_NAME(id) = 'StatusItem'))
    ALTER TABLE [CNT].[StatusItem]  DROP  CONSTRAINT [FK_Status_Account] 
GO

IF NOT EXISTS (select 1 from sys.objects where name = 'FK_Status_Account')
    ALTER TABLE [CNT].[Status]  ADD  CONSTRAINT [FK_Status_Account] FOREIGN KEY([SLRef]) REFERENCES [ACC].[Account] ([AccountId])
GO

IF NOT EXISTS (select 1 from sys.objects where name = 'FK_Status_BedBesAccount')
    ALTER TABLE [CNT].[Status]  ADD  CONSTRAINT [FK_Status_BedBesAccount] FOREIGN KEY([SLDebitCreditRef]) REFERENCES [ACC].[Account] ([AccountId])
GO

IF NOT EXISTS (select 1 from sys.objects where name = 'FK_Status_PartyAddress')
    ALTER TABLE [CNT].[Status]  ADD  CONSTRAINT [FK_Status_PartyAddress] FOREIGN KEY([PartyAddressRef]) REFERENCES [GNR].[PartyAddress] ([PartyAddressId]) ON DELETE SET NULL
GO

--<< DROP OBJECTS >>--

IF EXISTS (SELECT 1 FROM sys.columns WHERE object_id=object_id('CNT.Status') AND
            [name] = 'FulFillment')
    ALTER TABLE CNT.[Status] DROP COLUMN [FulFillment]
GO