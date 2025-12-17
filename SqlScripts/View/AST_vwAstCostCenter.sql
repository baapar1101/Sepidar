if exists(select 1 from sys.views where name='vwAstCostCenter' and type='v')
BEGIN
DROP VIEW [AST].vwAstCostCenter	
END


GO

CREATE VIEW [AST].vwAstCostCenter
As
SELECT Distinct DL.Title AS DLTitle, DL.Title_En AS DLTitle_En, Dl.DLId DLRef, DL.Type AS DLType, DL.Code AS DLCode, CC.Type, DL.IsActive
FROM  ACC.DL AS DL
	LEFT OUTER JOIN GNR.CostCenter AS CC ON CC.DLRef = DL.DLId AND (DL.[Type] = 3)
	LEFT OUTER JOIN CNT.Contract CNT ON CNT.DLRef = DL.DLId AND (DL.[Type] = 7) 
WHERE  DL.[Type] in( 3, 7)
                         

						 