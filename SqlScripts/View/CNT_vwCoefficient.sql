If Object_ID('CNT.vwCoefficient') Is Not Null
	Drop View CNT.vwCoefficient
GO
CREATE VIEW [CNT].[vwCoefficient]
AS
SELECT C.CoefficientID,
	   C.Nature, 
       C.Code, 
	   C.Title, 
	   C.Title_En, 
	   C.[Percent], 
	   C.Type, 
	   C.SLRef,
	   A.FullCode AS SLCode,
	   A.Title AS SLTitle, 
	   A.Title_En AS SLTitle_En,
       C.Version, 
	   C.Creator, 
	   C.CreationDate,
	   C.LastModifier, 
	   C.LastModificationDate
	  
FROM
       CNT.Coefficient  C                               LEFT OUTER JOIN
       ACC.vwAccount    A  ON A.AccountId = C.SLRef

