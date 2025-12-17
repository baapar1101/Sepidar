 
IF OBJECT_ID('POM.fnAssetPurchaseInvoiceItem') IS NOT NULL
  DROP FUNCTION POM.fnAssetPurchaseInvoiceItem 
GO

CREATE FUNCTION POM.fnAssetPurchaseInvoiceItem( @ExcludeOperationRef INT, @AssetRelatedItemType INT )
RETURNS TABLE
AS
RETURN (

			SELECT   
				 PII.PurchaseInvoiceItemID AS PurchaseInvoiceItemRef
				 , ISNULL(Used.UsedPrice, 0) UsedPrice
				 , ISNULL(Used.UsedQuantity, 0)  UsedQuantity
				 , PII.CalculatedNetPriceInBaseCurrency - ISNULL(Used.UsedPrice, 0) RemainingPrice
				 , ISNULL(PII.Quantity, 0) - ISNULL(Used.UsedQuantity, 0) RemainingQuantity
			FROM POM.vwPurchaseInvoiceItem PII
				LEFT JOIN 
					(
						SELECT 
								ISNULL(SUM(ARP.Price), 0) UsedPrice
								, ISNULL(Count(ARP.AssetRelatedPurchaseInvoiceId), 0) UsedQuantity 
								, PurchaseInvoiceItemRef
						FROM  [AST].[vwAssetRelatedPurchaseInvoice] ARP
						WHERE  
								(
									(@assetRelatedItemType = 1/*Aquisition*/ AND ISNULL(ARP.AcquisitionReceiptRef , 0) <> @ExcludeOperationRef) OR
									(@assetRelatedItemType = 2/*Repair    */ AND ISNULL(ARP.RepairRef, 0) <> @ExcludeOperationRef)
								)
						GROUP BY PurchaseInvoiceItemRef

					)Used on Used.PurchaseInvoiceItemRef = PII.PurchaseInvoiceItemID
						
						
		    WHERE  ( PII.Quantity > ISNULL(Used.UsedQuantity, 0) AND ItemType = 3/*AssetProduct*/ ) 
       )    
GO       
 