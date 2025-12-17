exec FMK.spAddLookup 'PartySettlementType',1,'فاكتور فروش','Invoice',N'پسولەي فرۆش',N'فاتورة المبيعات','RPA',1,''
exec FMK.spAddLookup 'PartySettlementType',2,'محاسبه پورسانت','Commission Calculation',N'',N'محاسبة عمولة','RPA',2,''

exec FMK.spAddLookup 'PartyAccountSettlementType',1,'مشتري','Customer',N'',N'','RPA',1,''
exec FMK.spAddLookup 'PartyAccountSettlementType',2,'واسط','Broker',N'',N'','RPA',2,''
exec FMK.spAddLookup 'PartyAccountSettlementType',3,'تامين كننده','Vendor',N'',N'','RPA',3,''
exec FMK.spAddLookup 'PartyAccountSettlementType',4,'ساير','Other',N'',N'','RPA',4,''


exec FMK.spAddLookup 'PartyAccountSettlementItemDebitCreditEntityType',1,'فاكتور فروش','Invoice',N'',N'','RPA',1,''
exec FMK.spAddLookup 'PartyAccountSettlementItemDebitCreditEntityType',2,'اعلاميه پرداخت','Payment',N'',N'','RPA',2,''
exec FMK.spAddLookup 'PartyAccountSettlementItemDebitCreditEntityType',3,'برگشت رسيد انبار','InventoryReceiptReturn',N'',N'','RPA',3,''
exec FMK.spAddLookup 'PartyAccountSettlementItemDebitCreditEntityType',4,'فاكتور مرجوعي','PurchaseInvoiceReturn',N'',N'','RPA',4,''
exec FMK.spAddLookup 'PartyAccountSettlementItemDebitCreditEntityType',5,'مانده اول دوره بدهكار','DebitOpeningBalance',N'',N'','RPA',5,''
exec FMK.spAddLookup 'PartyAccountSettlementItemDebitCreditEntityType',6,'اعلاميه بدهكار','DebitNote',N'',N'','RPA',6,''
exec FMK.spAddLookup 'PartyAccountSettlementItemDebitCreditEntityType',7,'استرداد چك دريافتني','RefundReceiptCheque',N'',N'','RPA',7,''
exec FMK.spAddLookup 'PartyAccountSettlementItemDebitCreditEntityType',8,'بهره و جريمه قلم تقسيط فاكتور فروش','ShredInvoiceInterestAndPenaltyItem',N'',N'','RPA',8,''
exec FMK.spAddLookup 'PartyAccountSettlementItemDebitCreditEntityType',9,'وام كارمندي','ShredPersonelLoan',N'',N'','RPA',9,''
exec FMK.spAddLookup 'PartyAccountSettlementItemDebitCreditEntityType',10,'ساير دريافتني','ShredOtherReceivable',N'',N'','RPA',10,''

exec FMK.spAddLookup 'PartyAccountSettlementItemDebitCreditEntityType',21,'محاسبه پورسانت','CommissionCalculation',N'',N'','RPA',21,''
exec FMK.spAddLookup 'PartyAccountSettlementItemDebitCreditEntityType',22,'فاكتور برگشتي','ReturnedInvoice',N'',N'','RPA',22,''
exec FMK.spAddLookup 'PartyAccountSettlementItemDebitCreditEntityType',23,'رسيد دريافت','Receipt',N'',N'','RPA',23,''
exec FMK.spAddLookup 'PartyAccountSettlementItemDebitCreditEntityType',24,'مانده اول دوره بستانكار','CreditOpeningBalance',N'',N'','RPA',24,''
exec FMK.spAddLookup 'PartyAccountSettlementItemDebitCreditEntityType',25,'اعلاميه بستانكار','CreditNote',N'',N'','RPA',25,''
exec FMK.spAddLookup 'PartyAccountSettlementItemDebitCreditEntityType',26,'استرداد چك پرداختني','RefundPaymentCheque',N'',N'','RPA',26,''
exec FMK.spAddLookup 'PartyAccountSettlementItemDebitCreditEntityType',27,'برگشت چك خرج شده','ReturnChequeOther',N'',N'','RPA',27,''
exec FMK.spAddLookup 'PartyAccountSettlementItemDebitCreditEntityType',28,'رسيد انبار','InventoryReceipt',N'',N'','RPA',28,''
exec FMK.spAddLookup 'PartyAccountSettlementItemDebitCreditEntityType',29,'تسويه از مانده قبلي','SettlementByRemaining',N'',N'','RPA',29,''

EXEC FMK.spAddLookup 'PettyCashBillState', 0, N'',				'',						N'', N'', 'RPA', 0, ''
EXEC FMK.spAddLookup 'PettyCashBillState', 1, N'ثبت شده',		'Registered',			N'', N'', 'RPA', 1, ''
EXEC FMK.spAddLookup 'PettyCashBillState', 2, N'تاييد شده',	    'Approved',		    	N'', N'', 'RPA', 2, ''






