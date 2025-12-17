--Moved from UpdatePaymentChequeOtherHeaderDate
--Update Different from history and headers
UPDATE PH
SET Date = H.Date  
FROM Rpa.ReceiptChequeHistory H
	INNER JOIN Rpa.PaymentChequeOther  O ON PaymentChequeOtherRef = PaymentChequeOtherId
	INNER JOIN Rpa.PaymentHeader PH ON PH.PaymentHeaderId = O.PaymentHeaderRef
WHERE H.Date <> PH.Date
-----------------

update item
Set item.HeaderDate = header.Date
from Rpa.ReceiptCheque item 
inner join Rpa.ReceiptHeader header on item.ReceiptHeaderRef = header.ReceiptHeaderId
Where  item.HeaderDate <> header.Date

update item
Set item.HeaderDate = header.Date
from Rpa.PaymentCheque item 
inner join Rpa.PaymentHeader header on item.PaymentHeaderRef = header.PaymentHeaderId
Where  item.HeaderDate <> header.Date

update item
Set item.HeaderDate = header.Date
from Rpa.PaymentChequeOther item 
inner join Rpa.PaymentHeader header on item.PaymentHeaderRef = header.PaymentHeaderId
Where  item.HeaderDate <> header.Date

update item
Set item.HeaderDate = header.Date
from Rpa.ReceiptChequeBankingItem item 
inner join Rpa.ReceiptChequeBanking header on item.ReceiptChequeBankingRef = header.ReceiptChequeBankingId
Where  item.HeaderDate <> header.Date


update item
Set item.HeaderDate = header.Date
from Rpa.RefundChequeItem item 
inner join Rpa.RefundCheque header on item.RefundChequeRef = header.RefundChequeId
Where  item.HeaderDate <> header.Date

update item
Set item.HeaderDate = header.Date
from Rpa.PaymentChequeBankingItem item 
inner join Rpa.PaymentChequeBanking header on item.PaymentChequeBankingRef = header.PaymentChequeBankingId
Where  item.HeaderDate <> header.Date


