update a
Set BankAccountRef = b.BankAccountRef
from Rpa.ReceiptChequeBankingItem  a 
inner join Rpa.ReceiptChequeBankingItem b on b.ReceiptChequeBankingItemId = a.ReceiptChequeBankingItemRef
Where a.State in (4, 8) 
and b.State = 2
and a.BankAccountRef is null

