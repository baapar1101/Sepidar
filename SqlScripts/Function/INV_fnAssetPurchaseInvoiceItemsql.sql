 
IF OBJECT_ID('INV.fnAssetPurchaseInvoiceItem') IS NOT NULL
  DROP FUNCTION INV.fnAssetPurchaseInvoiceItem 
GO

CREATE FUNCTION INV.fnAssetPurchaseInvoiceItem( @ExcludeOperationRef INT, @AssetRelatedItemType INT )
RETURNS TABLE
AS
RETURN (

			SELECT   
				  AssetPurchaseInvoiceItemRef = API.InventoryPurchaseInvoiceItemID
				 , ISNULL(Used.UsedPrice, 0) UsedPrice
				 , ISNULL(Used.UsedQuantity, 0)  UsedQuantity
				 , API.Price + ISNULL(API.Addition, 0) - ISNULL(API.Discount, 0) - ISNULL(Used.UsedPrice, 0) RemainingPrice
				 , ISNULL(API.Quantity, 0) - ISNULL(Used.UsedQuantity, 0) RemainingQuantity
				 
			FROM INV.vwAssetPurchaseInvoiceItem API
				LEFT JOIN 
					(
						SELECT 
								ISNULL(SUM(ARP.Price), 0) UsedPrice
								, ISNULL(Count(ARP.AssetRelatedPurchaseInvoiceId), 0) UsedQuantity 
								, AssetPurchaseInvoiceItemRef

						FROM  [AST].[vwAssetRelatedPurchaseInvoice] ARP
						WHERE  
								(
									(@assetRelatedItemType = 1/*Aquisition*/ AND ISNULL(ARP.AcquisitionReceiptRef , 0) <> @ExcludeOperationRef) OR
									(@assetRelatedItemType = 2/*Repair    */ AND ISNULL(ARP.RepairRef, 0) <> @ExcludeOperationRef)
								)
						GROUP BY AssetPurchaseInvoiceItemRef

					)Used on Used.AssetPurchaseInvoiceItemRef = API.InventoryPurchaseInvoiceItemID
						
		    WHERE  
		    (
				 ( API.Quantity > ISNULL(Used.UsedQuantity, 0) AND ItemType = 3/*AssetProduct*/ ) OR
				 (( API.Price + ISNULL(API.Addition, 0) - ISNULL(API.Discount, 0)) > ISNULL(Used.UsedPrice, 0) AND ItemType = 2/*Service*/  )
			)

       )    
GO       
 