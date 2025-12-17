update SLS.vwInvoice set CustomerRealName = CustomerPartyName  
where isnull(CustomerRealName, '') = ''

update SLS.vwInvoice set CustomerRealName_En = CustomerPartyName_En  
where isnull(CustomerRealName_En, '') = ''

Alter Table SLS.Invoice Alter Column CustomerRealName NVarChar(255) not null
Alter Table SLS.Invoice Alter Column CustomerRealName_En NVarChar(255) not null



