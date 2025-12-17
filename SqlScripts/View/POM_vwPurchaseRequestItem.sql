
If Object_ID('pom.vwPurchaseRequestItem') Is Not Null
	Drop View pom.vwPurchaseRequestItem
GO

CREATE VIEW [POM].[vwPurchaseRequestItem]
AS
WITH PerformaData AS (
    SELECT
        PI.PurchaseRequestItemRef,
        Quantity = SUM(
            CASE
                WHEN P.PurchasingType = 1 AND P.State IN (0, 1) THEN PI.Quantity
                WHEN P.PurchasingType = 2 AND P.State IN (1, 3) THEN PI.Quantity
                ELSE 0
            END
        ),
        SecondaryQuantity = SUM(
            CASE
                WHEN P.PurchasingType = 1 AND P.State IN (0, 1) THEN PI.SecondaryQuantity
                WHEN P.PurchasingType = 2 AND P.State IN (1, 3) THEN PI.SecondaryQuantity
                ELSE 0
            END
        ),
		HasImportPerforma =
		CASE WHEN SUM (
			CASE
				WHEN P.PurchasingType=1 THEN 1
				ELSE 0
			END
		) = 0 THEN 0
		ELSE 1
		END,
		HasInternalPerforma =
		CASE WHEN SUM (
			CASE
				WHEN P.PurchasingType=2 THEN 1
				ELSE 0
			END
		) = 0 THEN 0
		ELSE 1
		END
    FROM
        POM.PerformaItem PI
    INNER JOIN POM.Performa P
        ON P.PerformaID = PI.PerformaRef
    GROUP BY
        PI.PurchaseRequestItemRef
),
PurchaseOrderData AS (
    SELECT
        POI.BasePurchaseRequestItemRef,
        SUM(POI.Quantity) AS Quantity,
        SUM(POI.SecondaryQuantity) AS SecondaryQuantity
    FROM
        POM.PurchaseOrderItem POI
    INNER JOIN POM.PurchaseOrder PO
        ON PO.PurchaseOrderID = POI.PurchaseOrderRef
        AND PO.State IN (0, 1)
    GROUP BY
        POI.BasePurchaseRequestItemRef
)
SELECT
    PRI.[PurchaseRequestItemID],
	[PurchaseRequestRef],
	PR.[Number] AS PurchaseRequestNumber,
	PR.[Date] AS PurchaseRequestDate,
	PRI.[RowNumber] ,
	PRI.[ItemRef] ,
	It.Type as ItemType,
	'' as ItemTypeTitle,
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
	  , PRI.ItemDescription
	  , It.MaximumAmount AS ItemMaximumAmount
	  , It.MinimumAmount AS ItemMinimumAmount
	  , It.PurchaseFormulaRef AS CalculationFormulaRef
	  , It.SerialTracking
	  , It.TaxRate AS ItemTaxRate
	  , It.DutyRate AS ItemDutyRate
	  , It.TaxExemptPurchase AS TaxExempt
	  , CASE WHEN It.TracingCategoryRef IS NULL THEN 0 ELSE 1 END AS ItemHasTracing,
    PRI.[TracingRef]
	  , T.Title AS TracingTitle,
	PRI.[Quantity],
	PRI.[SecondaryQuantity],
	PRI.[ApprovedQuantity],
	PRI.[ApprovedSecondaryQuantity] ,
    RemainingQuantity = PRI.[ApprovedQuantity] - ISNULL(
        CASE
            WHEN PR.PurchasingProcedure = 2 THEN PD.Quantity
            WHEN PR.PurchasingProcedure = 1 THEN POD.Quantity
            ELSE 0
        END
     ,0),
    RemainingSecondaryQuantity = PRI.[ApprovedSecondaryQuantity] - ISNULL(
        CASE
            WHEN PR.PurchasingProcedure = 2 THEN PD.SecondaryQuantity
            WHEN PR.PurchasingProcedure = 1 THEN POD.SecondaryQuantity
            ELSE 0
        END
    , 0),
	ISNULL(PD.HasImportPerforma,0) AS HasImportPerforma,
	ISNULL(PD.HasInternalPerforma,0) AS HasInternalPerforma,
	PRI.[Priority],
		(
		SELECT STUFF((
			SELECT ',' + VendorDlCode
			FROM POM.vwPurchaseRequestItemVendor
			WHERE PurchaseRequestItemRef = PurchaseRequestItemID
			FOR XML PATH('')
		), 1, 1, '') AS Vendors
	)AS Vendors,
	PRI.[DeliveryDate],
	PRI.[Description],
	PRI.ItemRequestItemRef,
    IRI.ItemRequestNumber,
	PR.[State] AS HeaderState,
	PR.StockCode AS HeaderStockCode,
	PR.StockTitle AS HeaderStockTitle,
	PR.StockTitle_En AS HeaderStockTitle_En,
	PR.RequesterDepartmentDlTitle AS HeaderRequesterDepartmentDlTitle,
	PR.RequesterDepartmentDlTitle_En AS HeaderRequesterDepartmentDlTitle_En,
	PR.RequesterDlTitle AS HeaderRequesterDlTitle,
	PR.RequesterDlTitle_En AS HeaderRequesterDlTitle_En,
	PR.PurchasingAgentDlCode AS HeaderPurchasingAgentDlCode,
	PR.PurchasingAgentDlTitle AS HeaderPurchasingAgentDlTitle,
	PR.PurchasingAgentDlTitle_En AS HeaderPurchasingAgentDlTitle_En,
	PR.PurchasingProcedure AS HeaderPurchasingProcedure,
	PR.LastAcceptDate AS HeaderLastAcceptDate,
	PR.LastAcceptorTitle AS HeaderLastAcceptorTitle



  FROM POM.PurchaseRequestItem PRI
	INNER JOIN POM.vwPurchaseRequest AS PR ON PRI.PurchaseRequestRef =PR.PurchaseRequestID
	LEFT OUTER JOIN INV.vwItem AS It ON PRI.Itemref =It.ItemID
	LEFT OUTER JOIN INV.TracingCategory AS TC ON It.TracingCategoryRef = TC.TracingCategoryID
	LEFT OUTER JOIN INV.Tracing AS T ON PRI.TracingRef = T.TracingID AND TC.TracingCategoryID = T.TracingCategoryRef
	LEFT OUTER JOIN POM.vwItemRequestItem AS IRI ON PRI.ItemRequestItemRef = IRI.ItemRequestItemID
	LEFT OUTER JOIN PerformaData PD ON PD.PurchaseRequestItemRef = PRI.PurchaseRequestItemID  --Guaranteed That Each PurchaseItem has used in Future Docs Based On Purchasing Procedure
    LEFT OUTER JOIN PurchaseOrderData POD ON POD.BasePurchaseRequestItemRef = PRI.PurchaseRequestItemID --Guaranteed That Each PurchaseItem has used in Future Docs Based On Purchasing Procedure

