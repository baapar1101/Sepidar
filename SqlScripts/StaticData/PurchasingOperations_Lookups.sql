exec FMK.spAddLookup 'PerformaContractType', 0, '', '', N'', N'', 'POM', 0, ''
exec FMK.spAddLookup 'PerformaContractType', 1, 'EXW', 'EXW', N'EXW', N'EXW', 'POM', 1, ''
exec FMK.spAddLookup 'PerformaContractType', 2, 'FCA', 'FCA', N'FCA', N'FCA', 'POM', 2, ''
exec FMK.spAddLookup 'PerformaContractType', 3, 'CPT', 'CPT', N'CPT', N'CPT', 'POM', 3, ''
exec FMK.spAddLookup 'PerformaContractType', 4, 'CIP', 'CIP', N'CIP', N'CIP', 'POM', 4, ''
exec FMK.spAddLookup 'PerformaContractType', 5, 'DAP', 'DAP', N'DAP', N'DAP', 'POM', 5, ''
exec FMK.spAddLookup 'PerformaContractType', 6, 'DPU', 'DPU', N'DPU', N'DPU', 'POM', 6, ''
exec FMK.spAddLookup 'PerformaContractType', 7, 'DDP', 'DDP', N'DDP', N'DDP', 'POM', 7, ''
exec FMK.spAddLookup 'PerformaContractType', 8, 'FAS', 'FAS', N'FAS', N'FAS', 'POM', 8, ''
exec FMK.spAddLookup 'PerformaContractType', 9, 'FOB', 'FOB', N'FOB', N'FOB', 'POM', 9, ''
exec FMK.spAddLookup 'PerformaContractType', 10, 'CFR', 'CFR', N'CFR', N'CFR', 'POM', 10, ''
exec FMK.spAddLookup 'PerformaContractType', 11, 'CIF', 'CIF', N'CIF', N'CIF', 'POM', 11, ''


exec FMK.spAddLookup 'PerformaState', 0, 'ثبت شده', 'Registered', N'Registered', N'Registered', 'POM', 0, ''
exec FMK.spAddLookup 'PerformaState', 1, 'خاتمه يافته', 'Closed', N'Closed', N'Closed', 'POM', 1, ''
exec FMK.spAddLookup 'PerformaState', 2, 'ثبت نشده', 'None', N'None', N'None', 'POM', 0, ''
exec FMK.spAddLookup 'PerformaState', 3, 'تاييد شده', 'Approved', N'Approved', N'Approved', 'POM', 1, ''
exec FMK.spAddLookup 'PerformaState', 4, 'رد شده', 'Rejected', N'Rejected', N'Rejected', 'POM', 1, ''

exec FMK.spAddLookup   'PurchaseOrderState', 0, 'ثبت شده', 'Registered', N'Registered', N'Registered', 'POM', 0, ''
exec FMK.spAddLookup 'PurchaseOrderState', 1, 'خاتمه يافته', 'Closed', N'Closed', N'Closed', 'POM', 1, ''

exec FMK.spAddLookup 'PurchaseCostState', 0, 'ثبت شده', 'Registered', N'Registered', N'Registered', 'POM', 0, ''
exec FMK.spAddLookup 'PurchaseCostState', 1, 'محاسبه شده', 'Calculated', N'Calculated', N'Calculated', 'POM', 1, ''

exec FMK.spAddLookup 'SharingMethod', 0, '', 'none', N'', N'', 'POM', 0, ''
exec FMK.spAddLookup 'SharingMethod', 1, 'مساوي', 'equal', N'equal', N'equal', 'POM', 1, ''
exec FMK.spAddLookup 'SharingMethod', 2, 'مقداري', 'amount', N'amount', N'amount', 'POM', 2, ''
exec FMK.spAddLookup 'SharingMethod', 3, 'مبلغي', 'quantity', N'quantity', N'quantity', 'POM', 3, ''

exec FMK.spAddLookup 'Foreignpurchaseinvoicestate', 0, N'',			'',				N'', N'', 'POM', 0, ''
exec FMK.spAddLookup 'ForeignPurchaseInvoiceState', 1, 'ثبت شده', 'Registered', N'Registered', N'Registered', 'POM', 1, ''
exec FMK.spAddLookup 'ForeignPurchaseInvoiceState', 2, 'خاتمه يافته', 'Closed', N'Closed', N'Closed', 'POM', 2, ''

exec FMK.spAddLookup 'AllotmentType', 0, '', 'none', N'', N'', 'POM', 0, ''
exec FMK.spAddLookup 'AllotmentType', 1, 'مقداري', 'Unit', N'Unit', N'Unit', 'POM', 1, ''
exec FMK.spAddLookup 'AllotmentType', 2, 'مبلغي', 'Price', N'Price', N'Price', 'POM', 2, ''
exec FMK.spAddLookup 'AllotmentType', 3, 'مساوي', 'Equal', N'Equal', N'Equal', 'POM', 3, ''
exec FMK.spAddLookup 'AllotmentType', 4, 'وزني', 'Weight', N'Weight', N'Weight', 'POM', 4, ''

exec FMK.spAddLookup 'InsuranceCoverType', 0, '', 'None', N'', N'', 'POM', 0, ''
exec FMK.spAddLookup 'InsuranceCoverType', 1, 'A ( ALL RISK )', 'A ( ALL RISK )', N'A ( ALL RISK )', N'A ( ALL RISK )', 'POM', 1, ''
exec FMK.spAddLookup 'InsuranceCoverType', 2, 'B ( W. A )', 'B ( W. A )', N'B ( W. A )', N'B ( W. A )', 'POM', 2, ''
exec FMK.spAddLookup 'InsuranceCoverType', 3, 'C ( F.P.A )', 'C ( F.P.A )', N'C ( F.P.A )', N'C ( F.P.A )', 'POM', 3, ''
exec FMK.spAddLookup 'InsuranceCoverType', 4, 'TOTAL LOSS', 'TOTAL LOSS', N'TOTAL LOSS', N'TOTAL LOSS', 'POM', 4, ''
exec FMK.spAddLookup 'InsuranceCoverType', 5, 'ساير', 'Other', N'Other', N'Other', 'POM', 5, ''

exec FMK.spAddLookup 'PurchasingOperationType',1,'پيش فاكتور خريد','Performa',N'Performa',N'Performa','POM',1,''
exec FMK.spAddLookup 'PurchasingOperationType',2,'سفارش خريد','PurchaseOrder',N'PurchaseOrder',N'PurchaseOrder','POM',2,''
exec FMK.spAddLookup 'PurchasingOperationType',3,'بيمه نامه','InsurancePolicy',N'InsurancePolicy',N'InsurancePolicy','POM',3,''
exec FMK.spAddLookup 'PurchasingOperationType',4,'سفارش بازرگاني','CommercialOrder',N'CommercialOrder',N'CommercialOrder','POM',4,''
exec FMK.spAddLookup 'PurchasingOperationType',5,'فاكتور خريد وارداتي','PurchaseInvoice',N'PurchaseInvoice',N'PurchaseInvoice','POM',5,''
exec FMK.spAddLookup 'PurchasingOperationType',6,'بارنامه','BillOfLoading',N'BillOfLoading',N'BillOfLoading','POM',6,''
exec FMK.spAddLookup 'PurchasingOperationType',7,'ترخيص','CustomsClearance',N'CustomsClearance',N'CustomsClearance ','POM',7,''
exec FMK.spAddLookup 'PurchasingOperationType',8,'محاسبه بهاي تمام شده','PurchaseCost',N'PurchaseCost',N'PurchaseCost','POM',8,''


exec FMK.spAddLookup 'ItemRequestState', 0, 'ثبت نشده', 'Not Saved', N'Not Saved', N'Not Saved', 'POM', 0, ''
exec FMK.spAddLookup 'ItemRequestState', 1, 'ثبت شده', 'Registered', N'Registered', N'Registered', 'POM', 1, ''
exec FMK.spAddLookup 'ItemRequestState', 2, 'تاييد شده', 'Approved', N'Approved', N'Approved', 'POM', 0, ''
exec FMK.spAddLookup 'ItemRequestState', 3, 'رد شده', 'Rejected', N'Rejected', N'Rejected', 'POM', 0, ''
exec FMK.spAddLookup 'ItemRequestState', 4, 'خاتمه يافته', 'Closed', N'Closed', N'Closed', 'POM', 1, ''

exec FMK.spAddLookup 'ItemRequestTrigger', 0, 'ثبت', 'Register', N'Register', N'Register', 'POM', 0, ''
exec FMK.spAddLookup 'ItemRequestTrigger', 1, 'تاييد', 'Approve', N'Approve', N'Approve', 'POM', 1, ''
exec FMK.spAddLookup 'ItemRequestTrigger', 2, 'برگشت از تاييد', 'Return From Approved', N'Return From Approved', N'Return From Approved', 'POM', 0, ''
exec FMK.spAddLookup 'ItemRequestTrigger', 3, 'رد', 'Reject', N'Reject', N'Reject', 'POM', 0, ''
exec FMK.spAddLookup 'ItemRequestTrigger', 4, 'برگشت از رد', 'Return From Rejected', N'Return From Rejected', N'Return From Rejected', 'POM', 1, ''
exec FMK.spAddLookup 'ItemRequestTrigger', 5, 'خاتمه دستي', 'Manual Close', N'Manual Close', N'Manual Close', 'POM', 0, ''
exec FMK.spAddLookup 'ItemRequestTrigger', 6, 'خاتمه', 'Close', N'Close', N'Close', 'POM', 0, ''
exec FMK.spAddLookup 'ItemRequestTrigger', 7, 'برگشت از خاتمه', 'Return From Closed', N'Return From Closed', N'Return From Closed', 'POM', 1, ''


exec FMK.spAddLookup 'ItemRequestType', 2, 'مصرف در خط توليد', 'Consume', N'Consume', N'Consume', 'POM', 0, ''
exec FMK.spAddLookup 'ItemRequestType', 3, 'ساير', 'Other', N'Other', N'Other', 'POM', 0, ''
exec FMK.spAddLookup 'ItemRequestType', 4, 'انتقال بين انبار', 'Inventory Transfer', N'Inventory Transfer', N'Inventory Transfer', 'POM', 1, ''

exec FMK.spAddLookup 'PurchaseRequestState', 0, 'ثبت نشده', 'Not Saved', N'Not Saved', N'Not Saved', 'POM', 0, ''
exec FMK.spAddLookup 'PurchaseRequestState', 1, 'ثبت شده', 'Registered', N'Registered', N'Registered', 'POM', 1, ''
exec FMK.spAddLookup 'PurchaseRequestState', 2, 'تاييد شده', 'Approved', N'Approved', N'Approved', 'POM', 0, ''
exec FMK.spAddLookup 'PurchaseRequestState', 3, 'رد شده', 'Rejected', N'Rejected', N'Rejected', 'POM', 0, ''
exec FMK.spAddLookup 'PurchaseRequestState', 4, 'خاتمه يافته', 'Closed', N'Closed', N'Closed', 'POM', 1, ''

exec FMK.spAddLookup 'PurchaseRequestTrigger', 0, 'ثبت', 'Register', N'Register', N'Register', 'POM', 0, ''
exec FMK.spAddLookup 'PurchaseRequestTrigger', 1, 'تاييد', 'Approve', N'Approve', N'Approve', 'POM', 1, ''
exec FMK.spAddLookup 'PurchaseRequestTrigger', 2, 'برگشت از تاييد', 'Return From Approved', N'Return From Approved', N'Return From Approved', 'POM', 0, ''
exec FMK.spAddLookup 'PurchaseRequestTrigger', 3, 'رد', 'Reject', N'Reject', N'Reject', 'POM', 0, ''
exec FMK.spAddLookup 'PurchaseRequestTrigger', 4, 'برگشت از رد', 'Return From Rejected', N'Return From Rejected', N'Return From Rejected', 'POM', 1, ''
exec FMK.spAddLookup 'PurchaseRequestTrigger', 5, 'خاتمه دستي', 'Manual Close', N'Manual Close', N'Manual Close', 'POM', 0, ''
exec FMK.spAddLookup 'PurchaseRequestTrigger', 6, 'خاتمه', 'Close', N'Close', N'Close', 'POM', 0, ''
exec FMK.spAddLookup 'PurchaseRequestTrigger', 7, 'برگشت از خاتمه', 'Return From Closed', N'Return From Closed', N'Return From Closed', 'POM', 1, ''


exec FMK.spAddLookup 'PurchasingProcedure', 0, '', 'none', N'', N'', 'POM', 0, ''
exec FMK.spAddLookup 'PurchasingProcedure', 1, 'خرد', 'Retail', N'Retail', N'Retail', 'POM', 0, ''
exec FMK.spAddLookup 'PurchasingProcedure', 2, 'استعلامي', 'Inquiry', N'Inquiry', N'Inquiry', 'POM', 1, ''

exec FMK.spAddLookup 'PurchaseRequestItemPriority', 1, 'عادي', 'Normal', N'Not Saved', N'Not Saved', 'POM', 0, ''
exec FMK.spAddLookup 'PurchaseRequestItemPriority', 2, 'ضروري', 'Emergency', N'Emergency', N'Emergency', 'POM', 1, ''

exec FMK.spAddLookup 'PurchasingType', 1, 'وارداتي', 'Import', N'Import', N'Import', 'POM', 1, ''
exec FMK.spAddLookup 'PurchasingType', 2, 'داخلي', 'Internal', N'Internal', N'Internal', 'POM', 0, ''

exec FMK.spAddLookup 'PerformaTrigger', 0, 'ثبت', 'Register', N'Register', N'Register', 'POM', 0, ''
exec FMK.spAddLookup 'PerformaTrigger', 1, 'تاييد', 'Approve', N'Approve', N'Approve', 'POM', 1, ''
exec FMK.spAddLookup 'PerformaTrigger', 2, 'برگشت از تاييد', 'Return From Approved', N'Return From Approved', N'Return From Approved', 'POM', 0, ''
exec FMK.spAddLookup 'PerformaTrigger', 3, 'رد', 'Reject', N'Reject', N'Reject', 'POM', 0, ''
exec FMK.spAddLookup 'PerformaTrigger', 4, 'برگشت از رد', 'Return From Rejected', N'Return From Rejected', N'Return From Rejected', 'POM', 1, ''
exec FMK.spAddLookup 'PerformaTrigger', 5, 'خاتمه دستي', 'Manual Close', N'Manual Close', N'Manual Close', 'POM', 0, ''
exec FMK.spAddLookup 'PerformaTrigger', 6, 'خاتمه', 'Close', N'Close', N'Close', 'POM', 0, ''
exec FMK.spAddLookup 'PerformaTrigger', 7, 'برگشت از خاتمه', 'Return From Closed', N'Return From Closed', N'Return From Closed', 'POM', 1, ''
exec FMK.spAddLookup 'PerformaTrigger', 8, 'برگشت از خاتمه', 'Return From Closed', N'Return From Closed', N'Return From Closed', 'POM', 1, ''


exec FMK.spAddLookup 'PurchaseInvoiceType', 1, 'فاكتور خريد', 'Internal Purchase Invoice', N'Internal Purchase Invoice', N'Internal Purchase Invoice', 'POM', 0, ''
exec FMK.spAddLookup 'PurchaseInvoiceType', 2, 'فاكتور خريد خدمت', 'Service Purchase Invoice', N'Service Purchase Invoice', N'Service Purchase Invoice', 'POM', 0, ''
exec FMK.spAddLookup 'PurchaseInvoiceType', 3, 'فاكتور خريد دارايي', 'Asset Purchase Invoice', N'Asset Purchase Invoice', N'Asset Purchase Invoice', 'POM', 0, ''
exec FMK.spAddLookup 'PurchaseInvoiceType', 4, 'فاكتور خريد وارداتي', 'Import Purchase Invoice', N'Import Purchase Invoice', N'Import Purchase Invoice', 'POM', 1, ''