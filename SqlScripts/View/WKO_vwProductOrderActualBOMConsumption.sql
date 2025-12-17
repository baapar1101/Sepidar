IF Object_ID('WKO.vwProductOrderActualBOMConsumption') IS NOT NULL
	DROP VIEW WKO.vwProductOrderActualBOMConsumption
GO
CREATE VIEW [WKO].[vwProductOrderActualBOMConsumption]
AS
	--*** ProductOrder BOM Items ***
	WITH ProductOrderBOMItem(ProductOrderRef,ProductOrderBOMItemRef,AlternativeRatio,BOMItemRef,
							 ItemRef /*This Field For BOM Item Is BOM Item's Id 
													 And For BOM's Alternative Item Is Alternative Item's Id*/)
	AS
	(--ProductOrder's BOMItem
	 SELECT PBOMItem.ProductOrderRef,PBOMItem.ProductOrderBOMItemID ProductOrderBOMItemRef,
			1 AlternativeRatio,PBOMItem.ItemRef BOMItemRef,PBOMItem.ItemRef ItemRef
	 FROM WKO.ProductOrderBOMItem PBOMItem

	 UNION  

	 --  ProductOrderBOM's Alternative Items
	 SELECT PBOMItem.ProductOrderRef,PBOMItem.ProductOrderBOMItemID ProductOrderBOMItemRef,FBIA.AlternativeRatio,
			PBOMItem.ItemRef BOMItemRef,FBIA.ItemRef ItemRef			
	 FROM WKO.FormulaBomItemAlternative FBIA
		INNER JOIN WKO.ProductOrderBOMItem PBOMItem ON PBOMItem.FormulaBOMItemRef = FBIA.FormulaBomItemRef)				
	--*** ProductOrder Unpredicted BOM Items ***
	,ProductOrderUnpredictedBOMItem(ProductOrderRef,ProductOrderBOMItemRef,AlternativeRatio,BOMItemRef,ItemRef)
	AS
	(-- Items That Are Not In ProductOrder's BOMItem But "Be Used For Produce Product"
	 SELECT IDI.ProductOrderRef,NULL ProductOrderBOMItemRef,1 AlternativeRatio,IDI.ItemRef BOMItemRef,IDI.ItemRef ItemRef
	 FROM INV.InventoryDeliveryItem IDI
	 WHERE IDI.ItemRef NOT IN (SELECT PBOMItem.ItemRef /*This Field For BOM Item Is BOM Item's Id 
																	  And For BOM's Alternative Item Is Alternative Item's Id*/ 
								 FROM ProductOrderBOMItem PBOMItem
								 WHERE PBOMItem.ProductOrderRef = IDI.ProductOrderRef))
	--*** ProductOrder All BOM Items ***
	,ProductOrderAllBOMItem(ProductOrderRef,ProductOrderBOMItemRef,AlternativeRatio,BOMItemRef,ItemRef)
	AS
	(SELECT * FROM ProductOrderBOMItem
	
	 UNION
	 
	 SELECT * FROM ProductOrderUnpredictedBOMItem)
	--*** ProductOrder Inventory Delivery Item ***
	,ProductOrderInventoryDeliveryItem(ProductOrderRef,ItemRef,Quantity)
	AS
	(SELECT IDIQuantity.ProductOrderRef,IDIQuantity.ItemRef,SUM(IDIQuantity.Quantity) Quantity  
	 FROM(SELECT IDI.ProductOrderRef,IDI.ItemRef,(IDI.Quantity - SUM(ISNULL(RIDI.Quantity,0))) Quantity  
		  FROM INV.InventoryDeliveryItem IDI  
			LEFT OUTER JOIN INV.InventoryDeliveryItem RIDI ON RIDI.IsReturn = 1 AND   
									RIDI.BaseInventoryDeliveryItem = IDI.InventoryDeliveryItemID  
		  WHERE IDI.IsReturn = 0
		  GROUP BY IDI.InventoryDeliveryItemID,IDI.ProductOrderRef,IDI.ItemRef,IDI.Quantity) IDIQuantity
	 GROUP BY IDIQuantity.ProductOrderRef,IDIQuantity.ItemRef)
	 
	,ProductOrderItemRequestItem(ProductOrderRef,ItemRef,ApprovedQuantity,RegisteredQuantity)
	AS
	(
		SELECT PO.ProductOrderID ,
			IRI.ItemRef,
			SUM(CASE WHEN IR.State = 2 THEN IRI.RemainingQuantity ELSE 0 END) AS ApprovedQuantity,
			SUM(CASE WHEN IR.State = 1 THEN IRI.Quantity ELSE 0 END) AS RegisteredQuantity
		FROM WKO.ProductOrder PO 
		LEFT JOIN WKO.ProductOrder OldPO 
		    ON OldPO.ProductOrderID = PO.BaseProductOrderRef
		LEFT JOIN WKO.ProductOrder NextPO  
		    ON NextPO.BaseProductOrderRef = PO.ProductOrderID
		
		INNER JOIN 
		            POM.ItemRequest AS IR ON 
											PO.ProductOrderID = IR.ProductOrderRef
											OR OldPO.ProductOrderID = IR.ProductOrderRef
											OR NextPO.ProductOrderID = IR.ProductOrderRef
		INNER JOIN POM.vwItemRequestItem AS IRI ON IR.ItemRequestID = IRI.ItemRequestRef
		
		GROUP BY PO.ProductOrderID,ItemRef
	)


	--****************************************************
	--*** ProductOrder Actual BOM's Consumption(Final) ***
	SELECT PO.ProductOrderID ProductOrderRef,PAllBOMItem.ProductOrderBOMItemRef,PAllBOMItem.BOMItemRef,  
		   BOMItem.Code BOMItemCode,BOMItem.Title BOMItemTitle,BOMItem.Title_En BOMItemTitle_En,
		   PAllBOMItem.ItemRef,Item.Code ItemCode,Item.Title ItemTitle,
		   Item.Title_En ItemTitle_En,
		   PAllBOMItem.AlternativeRatio,POIDI.Quantity ItemConsumptionQuantity,  
		  (POIDI.Quantity / PAllBOMItem.AlternativeRatio) BOMItemConsumptionQuantity,
		  (POIRI.ApprovedQuantity / PAllBOMItem.AlternativeRatio) RemainingRequestedQuantity,
		  (POIRI.RegisteredQuantity / PAllBOMItem.AlternativeRatio) RegisteredRequestedQuantity

	FROM WKO.ProductOrder PO   
		INNER JOIN ProductOrderAllBOMItem PAllBOMItem ON PAllBOMItem.ProductOrderRef = PO.ProductOrderID	   
	    INNER JOIN INV.Item BOMItem ON BOMItem.ItemID = PAllBOMItem.BOMItemRef
	    INNER JOIN INV.Item Item ON Item.ItemID = PAllBOMItem.ItemRef
	    LEFT OUTER JOIN ProductOrderInventoryDeliveryItem POIDI ON PAllBOMItem.ProductOrderRef = POIDI.ProductOrderRef AND
																   PAllBOMItem.ItemRef = POIDI.ItemRef
		LEFT OUTER JOIN ProductOrderItemRequestItem POIRI ON PAllBOMItem.ProductOrderRef = POIRI.ProductOrderRef AND
																   PAllBOMItem.ItemRef = POIRI.ItemRef
GO