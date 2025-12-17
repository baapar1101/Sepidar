Update FMK.FiscalYear set Title_En = Title 
where Title_En is null

if exists (select 1 from sys.columns where object_id=object_id('FMK.FiscalYear') and
				[name] = 'Title_En' and is_nullable <> 0)
	Alter table FMK.FiscalYear Alter Column Title_En [nvarchar](10) Not NULL


