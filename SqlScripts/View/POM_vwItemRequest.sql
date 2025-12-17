If Object_ID('pom.vwItemRequest') Is Not Null
	Drop View pom.vwItemRequest
GO

CREATE VIEW [POM].[vwItemRequest]
AS

SELECT 
    [ItemRequestID],
	IR.[FiscalYearRef],

	[StockRef] ,
	Stock.Code AS StockCode, Stock.Title AS StockTitle, Stock.Title_En AS StockTitle_En, Stock.StockClerk AS StockClerk,
	ProductOrderRef, PO.Number AS ProductOrderNumber,
	[RequesterDepartmentDLRef] ,
	[RequesterStockRef] ,
	CASE
	    WHEN IR.RequesterDepartmentDLRef IS NOT NULL THEN DepartmentDL.Code
	    ELSE CAST(RequesterStock.Code AS nvarchar(40))
	END AS RequesterDepartmentCode,
    CASE
	    WHEN IR.RequesterDepartmentDLRef IS NOT NULL THEN DepartmentDL.Title
	    ELSE RequesterStock.Title
	END AS RequesterDepartmentTitle,
    CASE
	    WHEN IR.RequesterDepartmentDLRef IS NOT NULL THEN DepartmentDL.Title_En
	    ELSE RequesterStock.Title_En
	END AS RequesterDepartmentTitle_En,

	[RequesterDLRef] ,
	RequesterDL.Code AS RequesterDlCode, RequesterDL.Title AS RequesterDlTitle, RequesterDL.Title_En AS RequesterDlTitle_En,
	UC.Name AS CreatorTitle, ULM.Name AS LastModifierTitle, UA.Name AS LastAcceptorTitle,

	IR.[Number] ,
	IR.[Date] ,
	IR.[State] ,
	[RequestType],
	[Description],

	IR.[Creator],
	IR.[CreationDate] ,
	IR.[LastModifier] ,
	IR.[LastModificationDate] ,
	IR.[LastAcceptDate] ,
	IR.[LastAcceptor] ,
	IR.[Version]
	
   FROM POM.ItemRequest IR
  LEFT JOIN aCC.DL DepartmentDL ON IR.RequesterDepartmentDLRef = DepartmentDL.DLId
  LEFT JOIN aCC.DL RequesterDL ON IR.RequesterDLRef = RequesterDL.DLId
  
  LEFT JOIN INV.Stock Stock ON IR.StockRef = Stock.StockID
  LEFT JOIN INV.Stock RequesterStock ON IR.RequesterStockRef = RequesterStock.StockID
  LEFT JOIN WKO.ProductOrder PO ON IR.ProductOrderRef = PO.ProductOrderID
  
  LEFT OUTER JOIN 	  FMK.[User] AS UC ON IR.Creator = UC.UserID 
  LEFT OUTER JOIN	  FMK.[User] AS ULM ON IR.LastModifier = ULM.UserID
  LEFT OUTER JOIN	  FMK.[User] AS UA ON IR.LastAcceptor = UA.UserID


  