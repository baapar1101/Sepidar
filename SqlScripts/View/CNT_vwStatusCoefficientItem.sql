IF OBJECT_ID('CNT.vwStatusCoefficientItem') IS NOT NULL
	DROP VIEW CNT.vwStatusCoefficientItem
GO


CREATE VIEW CNT.vwStatusCoefficientItem
AS
SELECT 
		 SCI.[StatusCoefficientItemID]   
		,SCI.[StatusRef]                 
		,SCI.[ContractCoefficientItemRef]
		,SCI.[CoefficientRef]            
		,SCI.[Price]
		,CCI.CoefficientRef AS ContractCoefficientRef
		,DefaultPercent
		,ContractRef
		,CoefficientCode = CASE 
							WHEN SCI.ContractCoefficientItemRef IS NOT NULL 
							  THEN C2.Code
							ELSE
							       C.Code
						   END
		
		,CoefficientTitle = CASE 
							WHEN SCI.ContractCoefficientItemRef IS NOT NULL 
							  THEN C2.Title
							ELSE
							       C.Title
							END
							
		,CoefficientTitle_En = CASE 
							   WHEN SCI.ContractCoefficientItemRef IS NOT NULL 
							     THEN C2.Title_En
							   ELSE
							          C.Title_En
							   END
		
		,CofficientType =  CASE 
							   WHEN SCI.ContractCoefficientItemRef IS NOT NULL 
							     THEN C2.Type
							   ELSE
							          C.Type
							   END
		,CoefficientSlRef = CASE 
							   WHEN SCI.ContractCoefficientItemRef IS NOT NULL 
							     THEN C2.SLRef
							   ELSE
							          C.SLRef
							   END
							   
FROM CNT.StatusCoefficientItem SCI
  ---------------------
  /*One of the CoefficientRefs are occupied at the moment*/
  LEFT JOIN CNT.ContractCoefficientItem CCI ON SCI.ContractCoefficientItemRef = CCI.ContractCoefficientID
  LEFT JOIN CNT.Coefficient AS C2 ON C2.CoefficientID = CCI.CoefficientRef
  -------------------
  LEFT JOIN CNT.Coefficient AS C ON SCI.CoefficientRef = C.CoefficientID 
  