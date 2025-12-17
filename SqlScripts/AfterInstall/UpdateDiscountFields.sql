update Rpa.ReceiptHeader
Set DiscountRate = Rate
Where DiscountRate is null


update Rpa.ReceiptHeader
Set DiscountInBaseCurrency = DiscountRate * Discount
Where DiscountInBaseCurrency is null