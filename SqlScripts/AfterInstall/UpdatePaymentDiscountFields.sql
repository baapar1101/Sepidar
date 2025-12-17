update Rpa.PaymentHeader
Set DiscountRate = Rate
Where DiscountRate is null


update Rpa.PaymentHeader
Set DiscountInBaseCurrency = DiscountRate * Discount
Where DiscountInBaseCurrency is null