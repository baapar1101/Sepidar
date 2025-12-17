If Object_ID('GNR.vwLocationList') Is Not Null
	Drop View GNR.vwLocationList
GO
CREATE VIEW GNR.vwLocationList
AS
SELECT     TOP (100) PERCENT main.LocationId, 
                      CASE Main.Type WHEN 1 THEN Main.title WHEN 2 THEN level1.Title WHEN 3 THEN level2.Title WHEN 4 THEN level3.Title END AS country, 
                      CASE Main.Type WHEN 1 THEN Main.title_En WHEN 2 THEN level1.Title_En WHEN 3 THEN level2.Title_En WHEN 4 THEN level3.Title_En END AS country_En, 
                      CASE Main.Type WHEN 1 THEN Main.MinistryofFinanceCode WHEN 2 THEN level1.MinistryofFinanceCode WHEN 3 THEN level2.MinistryofFinanceCode WHEN 4 THEN level3.MinistryofFinanceCode END AS CountryMinistryofFinanceCode,
					  CASE Main.Type WHEN 1 THEN Main.TaxFileCode WHEN 2 THEN level1.TaxFileCode WHEN 3 THEN level2.TaxFileCode WHEN 4 THEN level3.TaxFileCode END AS CountryTaxFileCode,
                      CASE Main.Type WHEN 1 THEN '' WHEN 2 THEN Main.Title WHEN 3 THEN level1.Title WHEN 4 THEN level2.Title END AS State, 
                      CASE Main.Type WHEN 1 THEN '' WHEN 2 THEN Main.Title_En WHEN 3 THEN level1.Title_En WHEN 4 THEN level2.Title_En END AS State_En, 
                      CASE Main.Type WHEN 1 THEN '' WHEN 2 THEN Main.MinistryofFinanceCode WHEN 3 THEN level1.MinistryofFinanceCode WHEN 4 THEN level2.MinistryofFinanceCode END AS StateMinistryofFinanceCode, 
					  '' AS StateTaxFileCode, 
                      CASE Main.Type WHEN 1 THEN '' WHEN 2 THEN '' WHEN 3 THEN Main.Title WHEN 4 THEN level1.Title END AS City, 
                      CASE Main.Type WHEN 1 THEN '' WHEN 2 THEN '' WHEN 3 THEN Main.Title_En WHEN 4 THEN level1.Title_En END AS City_En, 
                      CASE Main.Type WHEN 1 THEN '' WHEN 2 THEN '' WHEN 3 THEN Main.MinistryofFinanceCode WHEN 4 THEN level1.MinistryofFinanceCode END AS CityMinistryofFinanceCode, 
					  '' AS CityTaxFileCode,
                      --CASE Main.Type WHEN 1 THEN '' WHEN 2 THEN '' WHEN 3 THEN Main.MinistryofFinanceCodeOfTownship WHEN 4 THEN level1.MinistryofFinanceCodeOfTownship END AS MinistryofFinanceCodeOfTownship, 
                      CASE Main.Type WHEN 1 THEN '' WHEN 2 THEN '' WHEN 3 THEN '' WHEN 4 THEN Main.Title END AS Village, 
                      CASE Main.Type WHEN 1 THEN '' WHEN 2 THEN '' WHEN 3 THEN '' WHEN 4 THEN Main.Title_En END AS Village_En, 
					  main.Title, main.Type, main.Code, main.MinistryofFinanceCode,main.TaxFileCode
FROM         GNR.Location AS main LEFT OUTER JOIN
                      GNR.Location AS level1 ON level1.LocationId = main.Parent LEFT OUTER JOIN
                      GNR.Location AS level2 ON level2.LocationId = level1.Parent LEFT OUTER JOIN
                      GNR.Location AS level3 ON level3.LocationId = level2.Parent
WHERE     (main.Type BETWEEN 1 AND 4)

