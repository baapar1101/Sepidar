 If Object_ID('pom.vwItemRequestItem') Is Not Null
	Drop View pom.vwItemRequestItem
GO

CREATE VIEW [POM].[vwItemRequestItem]
AS
SELECT
    [ItemRequestItemID],
	[ItemRequestRef],
	IR.[Number] AS ItemRequestNumber,
	IR.[Date] AS ItemRequestDate,
	IRI.[RowNumber] ,
	IRI.[ItemDescription] ,
	IRI.[ProductOrderBOMItemRef],
	IR.[ProductOrderRef],
	IRI.[ItemRef] ,
	It.Code AS ItemCode
	  ,	It.BarCode AS BarCode
	  , It.Title AS ItemTitle
	  , It.Title_En AS ItemTitle_En
	  , It.UnitRef
	  , It.UnitTitle
	  , It.SecondaryUnitRef
      , It.SecondaryUnitTitle
	  , It.UnitsRatio AS UnitsRatio
	  ,	It.IsUnitRatioConstant AS IsUnitRatioConstant, It.TracingCategoryRef
	  , CASE WHEN It.TracingCategoryRef IS NULL THEN 0 ELSE 1 END AS ItemHasTracing
	  , It.MaximumAmount AS ItemMaximumAmount
	  , It.MinimumAmount AS ItemMinimumAmount
	  , It.PurchaseFormulaRef AS CalculationFormulaRef
	  , It.SerialTracking,
    IRI.[TracingRef]
	  , T.Title AS TracingTitle,
	IRI.[Quantity],
	IRI.[SecondaryQuantity],
	IRI.[ApprovedQuantity],
	IRI.[ApprovedSecondaryQuantity] ,

	(IRI.[ApprovedQuantity] - ISNULL((Select SUM(Quantity) FROM INV.InventoryDeliveryItem Where ItemRequestItemRef=ItemRequestItemID),0)) AS [RemainingQuantity],
	(IRI.[ApprovedSecondaryQuantity] -  ISNULL((Select SUM(SecondaryQuantity) FROM INV.InventoryDeliveryItem Where ItemRequestItemRef=ItemRequestItemID),0)) AS [RemainingSecondaryQuantity],

	IRI.[DeliveryDate],
	IRI.[Description],
	IR.[State] AS HeaderState,
	Stock.StockID AS HeaderStockRef,
	Stock.Code AS HeaderStockCode,
	Stock.Title AS HeaderStockTitle,
	Stock.Title_En AS HeaderStockTitle_En,
    CASE
	    WHEN IR.RequesterDepartmentDLRef IS NOT NULL THEN DepartmentDL.Title
	    ELSE RequesterStock.Title
	END AS HeaderRequesterDepartmentTitle,
    CASE
	    WHEN IR.RequesterDepartmentDLRef IS NOT NULL THEN DepartmentDL.Title_En
	    ELSE RequesterStock.Title_En
	END AS HeaderRequesterDepartmentTitle_En,

    RequesterDL.Title AS HeaderRequesterDlTitle,
	RequesterDL.Title_En AS HeaderRequesterDlTitle_En,
    UA.Name AS HeaderLastAcceptorTitle,
	IR.LastAcceptDate AS HeaderLastAcceptDate,
	IR.RequestType AS HeaderRequestType,
    ChosenItemRef = ISNULL(IDI.ItemRef, PRI.ItemRef)

  FROM POM.ItemRequestItem IRI
	LEFT JOIN INV.vwItem AS It ON IRI.Itemref =It.ItemID
	INNER JOIN POM.ItemRequest AS IR ON IRI.ItemRequestRef =IR.ItemRequestID
	LEFT OUTER JOIN INV.TracingCategory AS TC ON It.TracingCategoryRef = TC.TracingCategoryID
	LEFT OUTER JOIN INV.Tracing AS T ON IRI.TracingRef = T.TracingID AND TC.TracingCategoryID = T.TracingCategoryRef

	LEFT JOIN aCC.DL DepartmentDL ON IR.RequesterDepartmentDLRef = DepartmentDL.DLId
    LEFT JOIN aCC.DL RequesterDL ON IR.RequesterDLRef = RequesterDL.DLId

	LEFT OUTER JOIN	  FMK.[User] AS UA ON IR.LastAcceptor = UA.UserID

    LEFT JOIN INV.Stock Stock ON IR.StockRef = Stock.StockID
    LEFT JOIN INV.Stock RequesterStock ON IR.RequesterStockRef = RequesterStock.StockID

    LEFT JOIN POM.PurchaseRequestItem PRI ON IRI.ItemRequestItemID = PRI.ItemRequestItemRef
	LEFT JOIN (SELECT DISTINCT ItemRequestItemRef, ItemRef FROM INV.InventoryDeliveryItem
	          ) IDI ON IRI.ItemRequestItemID = IDI.ItemRequestItemRef



