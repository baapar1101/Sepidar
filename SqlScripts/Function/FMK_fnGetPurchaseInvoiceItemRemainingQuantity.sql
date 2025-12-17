IF Object_ID('FMK.fnGetPurchaseInvoiceItemRemainingQuantity') IS NOT NULL
	DROP FUNCTION [FMK].[fnGetPurchaseInvoiceItemRemainingQuantity]
GO

CREATE FUNCTION [FMK].[fnGetPurchaseInvoiceItemRemainingQuantity] (@InventoryPurchaseInvoiceItemRef INT)
	Returns decimal(19, 4) AS 
	BEGIN
		DECLARE @RemainingQuantity decimal(19, 4)
		DECLARE @UsedQuantity decimal (19, 4)
		DECLARE @Quantity decimal (19, 4)

		-- Calculate UsedQuantity
		SELECT @UsedQuantity = ISNULL(SUM(RI.Quantity),0) from INV.InventoryReceiptItem AS RI
			WHERE RI.BasePurchaseInvoiceItemRef = @InventoryPurchaseInvoiceItemRef 

		-- Calculate Quantity
		SELECT @Quantity = ISNULL(PII.Quantity,0)
		FROM INV.InventoryPurchaseInvoiceItem AS PII
		WHERE PII.InventoryPurchaseInvoiceItemID = @InventoryPurchaseInvoiceItemRef

		-- Calculate RemainingQuantity
		SET @RemainingQuantity = @Quantity - @UsedQuantity

	RETURN @RemainingQuantity
	END
	
	GO