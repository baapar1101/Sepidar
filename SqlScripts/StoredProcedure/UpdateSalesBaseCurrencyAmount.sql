If Object_ID('SLS.UpdateSalesBaseCurrencyAmount') Is Not Null
	Drop Procedure SLS.UpdateSalesBaseCurrencyAmount
GO
CREATE PROCEDURE SLS.UpdateSalesBaseCurrencyAmount
AS
BEGIN
	IF NOT EXISTS (SELECT * FROM FMK.[Version] WHERE Major * 100 + Minor * 10 + Build > 604)
    BEGIN

        UPDATE SLS.InvoiceItem SET PriceInBaseCurrency = [GNR].[fnCalcAmountInBaseCurrency](Price, Rate)
        UPDATE SLS.InvoiceItem SET DiscountInBaseCurrency = [GNR].[fnCalcAmountInBaseCurrency](Discount, Rate)
        UPDATE SLS.InvoiceItem SET AdditionInBaseCurrency = [GNR].[fnCalcAmountInBaseCurrency](Addition, Rate)
        UPDATE SLS.InvoiceItem SET TaxInBaseCurrency = [GNR].[fnCalcAmountInBaseCurrency](Tax, Rate)
        UPDATE SLS.InvoiceItem SET DutyInBaseCurrency = [GNR].[fnCalcAmountInBaseCurrency](Duty, Rate)
        UPDATE SLS.InvoiceItem SET NetPriceInBaseCurrency = 
            ISNULL(PriceInBaseCurrency, 0) + 
            ISNULL(AdditionInBaseCurrency, 0) + 
            ISNULL(TaxInBaseCurrency, 0) + 
            ISNULL(AdditionFactorInBaseCurrency_VatEffective, 0) +
            ISNULL(AdditionFactorInBaseCurrency_VatIneffective, 0) +
            ISNULL(DutyInBaseCurrency, 0) - 
            ISNULL(DiscountInBaseCurrency, 0)

        UPDATE SLS.Invoice SET PriceInBaseCurrency = ISNULL((Select sum(PriceInBaseCurrency) from SLS.InvoiceItem where Invoiceref = invoiceid), 0)
        UPDATE SLS.Invoice SET DiscountInBaseCurrency = ISNULL((Select sum(DiscountInBaseCurrency) from SLS.InvoiceItem where Invoiceref = invoiceid), 0)
        UPDATE SLS.Invoice SET AdditionInBaseCurrency = ISNULL((Select sum(AdditionInBaseCurrency) from SLS.InvoiceItem where Invoiceref = invoiceid), 0)
        UPDATE SLS.Invoice SET TaxInBaseCurrency = ISNULL((Select sum(TaxInBaseCurrency) from SLS.InvoiceItem where Invoiceref = invoiceid), 0)
        UPDATE SLS.Invoice SET DutyInBaseCurrency = ISNULL((Select sum(DutyInBaseCurrency) from SLS.InvoiceItem where Invoiceref = invoiceid), 0)
        UPDATE SLS.Invoice SET NetPriceInBaseCurrency = 
            ISNULL(PriceInBaseCurrency, 0) + 
            ISNULL(AdditionInBaseCurrency, 0) + 
            ISNULL(TaxInBaseCurrency, 0) + 
            ISNULL(AdditionFactorInBaseCurrency_VatEffective, 0) +
            ISNULL(AdditionFactorInBaseCurrency_VatIneffective, 0) +
            ISNULL(DutyInBaseCurrency, 0) - 
            ISNULL(DiscountInBaseCurrency, 0)

        UPDATE SLS.InvoiceBroker SET CommissionInBaseCurrency = [GNR].[fnCalcAmountInBaseCurrency](Commission, Rate)

        UPDATE SLS.ReturnedInvoiceItem SET PriceInBaseCurrency = [GNR].[fnCalcAmountInBaseCurrency](Price, Rate)
        UPDATE SLS.ReturnedInvoiceItem SET DiscountInBaseCurrency = [GNR].[fnCalcAmountInBaseCurrency](Discount, Rate)
        UPDATE SLS.ReturnedInvoiceItem SET AdditionInBaseCurrency = [GNR].[fnCalcAmountInBaseCurrency](Addition, Rate)
        UPDATE SLS.ReturnedInvoiceItem SET TaxInBaseCurrency = [GNR].[fnCalcAmountInBaseCurrency](Tax, Rate)
        UPDATE SLS.ReturnedInvoiceItem SET DutyInBaseCurrency = [GNR].[fnCalcAmountInBaseCurrency](Duty, Rate)
        UPDATE SLS.ReturnedInvoiceItem SET NetPriceInBaseCurrency = 
            ISNULL(PriceInBaseCurrency, 0) + 
            ISNULL(AdditionInBaseCurrency, 0) + 
            ISNULL(TaxInBaseCurrency, 0) + 
            ISNULL(AdditionFactorInBaseCurrency_VatEffective, 0) +
            ISNULL(AdditionFactorInBaseCurrency_VatIneffective, 0) +
            ISNULL(DutyInBaseCurrency, 0) - 
            ISNULL(DiscountInBaseCurrency, 0)

        UPDATE SLS.ReturnedInvoice SET PriceInBaseCurrency = ISNULL((Select sum(PriceInBaseCurrency) from SLS.ReturnedInvoiceItem where ReturnedInvoiceref = ReturnedInvoiceId), 0)
        UPDATE SLS.ReturnedInvoice SET DiscountInBaseCurrency = ISNULL((Select sum(DiscountInBaseCurrency) from SLS.ReturnedInvoiceItem where ReturnedInvoiceref = ReturnedInvoiceId), 0)
        UPDATE SLS.ReturnedInvoice SET AdditionInBaseCurrency = ISNULL((Select sum(AdditionInBaseCurrency) from SLS.ReturnedInvoiceItem where ReturnedInvoiceref = ReturnedInvoiceId), 0)
        UPDATE SLS.ReturnedInvoice SET TaxInBaseCurrency = ISNULL((Select sum(TaxInBaseCurrency) from SLS.ReturnedInvoiceItem where ReturnedInvoiceref = ReturnedInvoiceId), 0)
        UPDATE SLS.ReturnedInvoice SET DutyInBaseCurrency = ISNULL((Select sum(DutyInBaseCurrency) from SLS.ReturnedInvoiceItem where ReturnedInvoiceref = ReturnedInvoiceId), 0)
        UPDATE SLS.ReturnedInvoice SET NetPriceInBaseCurrency = 
            ISNULL(PriceInBaseCurrency, 0) + 
            ISNULL(AdditionInBaseCurrency, 0) + 
            ISNULL(TaxInBaseCurrency, 0) + 
            ISNULL(AdditionFactorInBaseCurrency_VatEffective, 0) +
            ISNULL(AdditionFactorInBaseCurrency_VatIneffective, 0) +
            ISNULL(DutyInBaseCurrency, 0) - 
            ISNULL(DiscountInBaseCurrency, 0)

        UPDATE SLS.ReturnedInvoiceBroker SET CommissionInBaseCurrency = [GNR].[fnCalcAmountInBaseCurrency](Commission, Rate)

        UPDATE SLS.QuotationItem SET PriceInBaseCurrency = [GNR].[fnCalcAmountInBaseCurrency](Price, Rate)
        UPDATE SLS.QuotationItem SET DiscountInBaseCurrency = [GNR].[fnCalcAmountInBaseCurrency](Discount, Rate)
        UPDATE SLS.QuotationItem SET AdditionInBaseCurrency = [GNR].[fnCalcAmountInBaseCurrency](Addition, Rate)
        UPDATE SLS.QuotationItem SET TaxInBaseCurrency = [GNR].[fnCalcAmountInBaseCurrency](Tax, Rate)
        UPDATE SLS.QuotationItem SET DutyInBaseCurrency = [GNR].[fnCalcAmountInBaseCurrency](Duty, Rate)
        UPDATE SLS.QuotationItem SET NetPriceInBaseCurrency = 
            ISNULL(PriceInBaseCurrency, 0) + 
            ISNULL(AdditionInBaseCurrency, 0) + 
            ISNULL(TaxInBaseCurrency, 0) + 
            ISNULL(AdditionFactorInBaseCurrency_VatEffective, 0) +
            ISNULL(AdditionFactorInBaseCurrency_VatIneffective, 0) +
            ISNULL(DutyInBaseCurrency, 0) - 
            ISNULL(DiscountInBaseCurrency, 0)

        UPDATE SLS.Quotation SET PriceInBaseCurrency = ISNULL((Select sum(PriceInBaseCurrency) from SLS.QuotationItem where QuotationRef = QuotationId), 0)
        UPDATE SLS.Quotation SET DiscountInBaseCurrency = ISNULL((Select sum(DiscountInBaseCurrency) from SLS.QuotationItem where QuotationRef = QuotationId), 0)
        UPDATE SLS.Quotation SET AdditionInBaseCurrency = ISNULL((Select sum(AdditionInBaseCurrency) from SLS.QuotationItem where QuotationRef = QuotationId), 0)
        UPDATE SLS.Quotation SET TaxInBaseCurrency = ISNULL((Select sum(TaxInBaseCurrency) from SLS.QuotationItem where QuotationRef = QuotationId), 0)
        UPDATE SLS.Quotation SET DutyInBaseCurrency = ISNULL((Select sum(DutyInBaseCurrency) from SLS.QuotationItem where QuotationRef = QuotationId), 0)
        UPDATE SLS.Quotation SET NetPriceInBaseCurrency = 
            ISNULL(PriceInBaseCurrency, 0) + 
            ISNULL(AdditionInBaseCurrency, 0) + 
            ISNULL(TaxInBaseCurrency, 0) + 
            ISNULL(AdditionFactorInBaseCurrency_VatEffective ,0) +
            ISNULL(AdditionFactorInBaseCurrency_VatIneffective, 0) +
            ISNULL(DutyInBaseCurrency, 0) - 
            ISNULL(DiscountInBaseCurrency, 0)

    END
    ELSE
    BEGIN
        RETURN
    END

END