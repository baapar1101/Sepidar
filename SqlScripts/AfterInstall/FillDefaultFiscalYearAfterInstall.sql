Update SLS.Invoice set FiscalYearRef = (select Top 1 FiscalYearId from FMK.FiscalYear)
where FiscalYearRef is null

Update SLS.Quotation set FiscalYearRef = (select Top 1 FiscalYearId from FMK.FiscalYear)
where FiscalYearRef is null

Update SLS.ReturnedInvoice set FiscalYearRef = (select Top 1 FiscalYearId from FMK.FiscalYear)
where FiscalYearRef is null

alter table SLS.Invoice  alter column FiscalYearRef int NOT NULL 
alter table SLS.Quotation  alter column FiscalYearRef int NOT NULL 
alter table SLS.ReturnedInvoice  alter column FiscalYearRef int NOT NULL 

