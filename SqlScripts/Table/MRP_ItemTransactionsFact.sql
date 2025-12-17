--<<FileName:MRP_ItemTransactionsFact.sql>>--
--<< file version: 2 >>--
--<< TABLE DEFINITION >>--

If Object_ID('MRP.ItemTransactionsFact') IS NOT NULL
    DROP TABLE MRP.ItemTransactionsFact

If Object_ID('MRP.ObjectHash') IS NOT NULL
    DELETE FROM MRP.ObjectHash WHERE ObjectName = 'MRP.ItemTransactionsFact' OR BaseFactTableName = 'MRP.ItemTransactionsFact'
GO

If Object_ID('MRP.ItemTransactionsFact') IS Null
CREATE TABLE [MRP].[ItemTransactionsFact](
    [Date]                  DATE            NULL,
    [Quantity]              DECIMAL(19, 4)  NULL,
    [Price]                 DECIMAL(19, 4)  NULL,
    [ItemId]                INT             NULL,
    [ItemPurchaseGroupRef]  INT             NULL,
    [UnitId]                INT             NULL,
    [VendorDlRef]           INT             NULL,
    IsOpening               BIT             NULL,
    StockRef                INT             NULL
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
        CREATE CLUSTERED COLUMNSTORE INDEX CCSI_ItemTransactionsFact
            ON MRP.ItemTransactionsFact
            ORDER ([Date])
            WITH (
                DATA_COMPRESSION = COLUMNSTORE
            )
    '
END TRY
BEGIN CATCH
    CREATE CLUSTERED INDEX [IX_ItemTransactionsFact_Date] ON [MRP].[ItemTransactionsFact] ([Date])
END CATCH
GO
--<< FOREIGNKEYS DEFINITION >>--
