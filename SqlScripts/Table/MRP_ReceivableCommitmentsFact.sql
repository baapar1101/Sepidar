--<<FileName:MRP_ReceivableCommitmentsFact.sql>>--
--<< file version: 1 >>--
--<< TABLE DEFINITION >>--

If Object_ID('MRP.ReceivableCommitmentsFact') IS NOT NULL
    DROP TABLE MRP.ReceivableCommitmentsFact

If Object_ID('MRP.ObjectHash') IS NOT NULL
    DELETE FROM MRP.ObjectHash WHERE ObjectName = 'MRP.ReceivableCommitmentsFact' OR BaseFactTableName = 'MRP.ReceivableCommitmentsFact'
GO

If Object_ID('MRP.ReceivableCommitmentsFact') IS Null
CREATE TABLE [MRP].[ReceivableCommitmentsFact](
    [Date]                  DATE    NULL,
    [Loan]                  DECIMAL(19, 4) NULL,
    [ContractRef]           INT     NULL,
    [ContractingStatus]     DECIMAL(19, 4) NULL,
    [BankAccountRef]        INT     NULL,
    [SubmitedToBankCheque]  DECIMAL(19, 4) NULL,
    [CashRef]               INT     NULL,
    [InCashCheque]          DECIMAL(19, 4) NULL,
    [ProtestedCheque]       DECIMAL(19, 4) NULL,
    [PartyRef]              INT     NULL,
    [CustomerRemaining]     DECIMAL(19, 4) NULL,
    [IsCustomerOpening]     INT     NULL
) ON [PRIMARY]
GO

--<< ADD CLOLUMNS >>--

--<< ALTER COLUMNS >>--

--<< PRIMARYKEY DEFINITION >>--

--<< DEFAULTS CHECKS DEFINITION >>--

--<< RULES DEFINITION >>--

--<< INDEXES DEFINITION >>--

BEGIN TRY
    EXEC SP_EXECUTESQL N'
        CREATE CLUSTERED COLUMNSTORE INDEX CCSI_ReceivableCommitmentsFact
            ON MRP.ReceivableCommitmentsFact
            ORDER ([Date])
            WITH (
                DATA_COMPRESSION = COLUMNSTORE
            )
    '
END TRY
BEGIN CATCH
    CREATE CLUSTERED INDEX [IX_ReceivableCommitmentsFact_Date] ON [MRP].[ReceivableCommitmentsFact] ([Date])
END CATCH
GO
--<< FOREIGNKEYS DEFINITION >>--
