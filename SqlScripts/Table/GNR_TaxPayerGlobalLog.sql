--<< TABLE DEFINITION >>--
IF Object_ID('GNR.TaxPayerGeneralLog') IS NULL
CREATE TABLE [GNR].[TaxPayerGeneralLog]
(
    [TaxPayerGeneralLogId]     [INT]           NOT NULL,
    [Type]                     [INT]           NOT NULL,
    [TaxPayerBillRef]          [INT]           NULL,
    [RelatedVoucherType]       [INT]           NULL,
    [RelatedVoucherId]         [INT]           NULL,
    [TaxId]                    [VARCHAR](250) NULL,
    [Creator]                  [INT]           NULL,
    [CreationDate]             [DATETIME]      NULL,
    [Value]                    [NVARCHAR](max) NULL

) ON [PRIMARY]

GO

--<< ADD CLOLUMNS >>--

--<< ALTER COLUMNS >>--

--<< PRIMARYKEY DEFINITION >>--

--<< DEFAULTS CHECKS DEFINITION >>--

--<< RULES DEFINITION >>--

--<< INDEXES DEFINITION >>--

--<< FOREIGNKEYS DEFINITION >>--

--<< DROP OBJECTS >>--
