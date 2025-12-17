--<<FileName:MRP_SaleFacts.sql>>--
--<<FILE VERSION = 1 >>--
--<< TABLE DEFINITION >>--

If Object_ID('MRP.SaleFacts') IS NOT NULL
    DROP TABLE MRP.SaleFacts

If Object_ID('MRP.ObjectHash') IS NOT NULL
    DELETE FROM MRP.ObjectHash WHERE ObjectName = 'MRP.SaleFacts' OR BaseFactTableName = 'MRP.SaleFacts'
GO

If Object_ID('MRP.SaleFacts') IS Null
CREATE TABLE [MRP].[SaleFacts](
    [InvoiceId]                 int    NULL,
    [ReturnedInvoiceId]         int    NULL,
    [InvoiceItemID]             int    NULL,
    [ReturnedInvoiceItemID]     int    NULL,
    [FiscalYearRef]             int    NULL,
    [InvoiceState]              int    NULL,
    [InvoiceItemTracingRef]     int    NULL,
    [RIIInvoiceItemRef]         int    NULL,
    [InvoiceDiscount]           decimal(19,4)    NULL,
    [ReturnInvoiceDiscount]     decimal(19,4)    NULL,
    [NetPrice]                  decimal(19,4)    NULL,
    [ReturnedNetPrice]          decimal(19,4)    NULL,
    [SaleGroupRef]              int    NULL,
    [SaleTypeRef]               int    NULL,
    [Date]                      datetime    NULL,
    [SaleTypeMarket]            int    NULL,
    [StockRef]                  int    NULL,
    [CustomerPartyRef]          int    NULL,
    [PartyAddressRef]           int    NULL,
    [ItemRef]                   int    NULL,
    [Price]                     decimal(19,4)    NULL,
    [Fee]                       decimal(19,4)    NULL,
    [Quantity]                  decimal(19,4)    NULL,
    [ReturnPrice]               decimal(19,4)    NULL,
    [ReturnFee]                 decimal(19,4)    NULL,
    [ReturnQuantity]            decimal(19,4)    NULL,
    [SaleAdditionInBaseCurrency]                    decimal(19,4)    NULL,
    [SaleAdditionFactorInBaseCurrency]              decimal(19,4)    NULL,
    [SaleDiscountInBaseCurrency]                    decimal(19,4)    NULL,
    [ReturnedSaleAdditionInBaseCurrency]            decimal(19,4)    NULL,
    [TotalReturnedSaleAdditionFactorInBaseCurrency] decimal(19,4)    NULL,
    ReturnedSaleDiscountInBaseCurrency              decimal(19,4)    NULL
) ON [PRIMARY]

--<< ADD CLOLUMNS >>--

--<< ALTER COLUMNS >>--

--<< PRIMARYKEY DEFINITION >>--

--<< DEFAULTS CHECKS DEFINITION >>--

--<< RULES DEFINITION >>--

--<< INDEXES DEFINITION >>--

BEGIN TRY
    EXEC SP_EXECUTESQL N'
        CREATE CLUSTERED COLUMNSTORE INDEX CCSI_SaleFacts
            ON MRP.SaleFacts
            ORDER ([Date])
            WITH (
                DATA_COMPRESSION = COLUMNSTORE
            )
    '
END TRY
BEGIN CATCH
    CREATE CLUSTERED INDEX [IX_SaleFacts_Date] ON [MRP].[SaleFacts] ([Date])
END CATCH
GO
--<< FOREIGNKEYS DEFINITION >>--