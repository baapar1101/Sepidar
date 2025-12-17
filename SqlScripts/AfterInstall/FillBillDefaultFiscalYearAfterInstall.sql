Update B set B.FiscalYearRef = 
(select Top 1 FiscalYearId from FMK.FiscalYear where B.Date >= FMK.FiscalYear.StartDate AND B.Date <= FMK.FiscalYear.EndDate)
from GNR.Bill B
where FiscalYearRef is null

alter table GNR.Bill alter column FiscalYearRef int NOT NULL 

