--<<FileName:SLS_CommissionCalculation.sql>>--
--<< TABLE DEFINITION >>--
if OBJECT_ID('SLS.CommissionCalculation') IS NULL
	Create Table SLS.CommissionCalculation(
        [CommissionCalculationID] [INT]      NOT NULL,
        [CommissionRef]           [INT]      NOT NULL,
        [BrokerPartyRef ]         [INT]      NOT NULL,
        [FromDate]                [DATETIME] NOT NULL,
        [ToDate]                  [DATETIME] NOT NULL,
		[SLRef]                   [INT]          NULL,
		[DLRef]                   [INT]          NULL,
       	[AccountingVoucherRef]    [INT]          NULL,
		[FiscalYearRef]           [INT]      NOT NULL,
       	[Version]                 [INT]      NOT NULL,
		[Creator]                 [INT]      NOT NULL, 
		[CreationDate]            [DATETIME] NOT NULL, 
		[LastModifier]            [INT]      NOT NULL,
		[LastModificationDate]    [DATETIME] NOT NULL
	) ON [PRIMARY]
--TEXTIMAGE_ON [SGBlob_Data]
--When a table has text, ntext, image, varchar(max), nvarchar(max), varbinary(max), xml or large user defined type columns uncomment above code
GO

-- Alter Table SLS.CommissionCalculation Add Version int not null
--<< ADD CLOLUMNS >>--

IF NOT EXISTS (SELECT 1 FROM sys.columns WHERE OBJECT_ID = OBJECT_ID('SLS.CommissionCalculation') AND
				[name] = 'DLRef')
BEGIN
    ALTER TABLE SLS.CommissionCalculation ADD [DLRef] [INT] NULL
END
GO


IF NOT EXISTS (SELECT 1 FROM sys.columns WHERE OBJECT_ID = OBJECT_ID('SLS.CommissionCalculation') AND
				[name] = 'SLRef')
BEGIN
    ALTER TABLE SLS.CommissionCalculation ADD [SLRef] [INT] NULL
END
GO

--<< ALTER COLUMNS >>--

--<< PRIMARYKEY DEFINITION >>--
IF OBJECT_ID('SLS.PK_CommissionCalculationID') IS NULL
	ALTER TABLE SLS.CommissionCalculation ADD CONSTRAINT [PK_CommissionCalculationID] PRIMARY KEY CLUSTERED
	(
		CommissionCalculationID ASC
	) ON [PRIMARY]
GO
--<< DEFAULTS CHECKS DEFINITION >>--

--<< RULES DEFINITION >>--

--<< INDEXES DEFINITION >>--

--<< FOREIGNKEYS DEFINITION >>--
IF OBJECT_ID('SLS.FK_CommissionCalculation_CommissionRef') IS NULL
	ALTER TABLE SLS.CommissionCalculation ADD CONSTRAINT [FK_CommissionCalculation_CommissionRef] 
		FOREIGN KEY ([CommissionRef]) REFERENCES [SLS].[Commission] ([CommissionID])
GO
IF OBJECT_ID('SLS.FK_CommissionCalculation_BrokerPartyRef') IS NULL
	ALTER TABLE SLS.CommissionCalculation ADD CONSTRAINT [FK_CommissionCalculation_BrokerPartyRef]
		FOREIGN KEY ([BrokerPartyRef]) REFERENCES [GNR].[Party]  ([PartyID])
GO

IF OBJECT_ID('SLS.FK_CommissionCalculation_Voucher') IS NULL
	ALTER TABLE SLS.CommissionCalculation ADD CONSTRAINT FK_CommissionCalculation_Voucher 
		FOREIGN KEY (AccountingVoucherRef) REFERENCES ACC.Voucher (VoucherId)
GO
IF OBJECT_ID('SLS.FK_CommissionCalculation_FiscalYear') IS NULL
	ALTER TABLE SLS.CommissionCalculation ADD CONSTRAINT FK_CommissionCalculation_FiscalYear 
		FOREIGN KEY([FiscalYearRef]) REFERENCES [FMK].[FiscalYear] ([FiscalYearId])

GO
--<< DROP OBJECTS >>--

