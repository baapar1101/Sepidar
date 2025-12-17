If Object_ID('INV.spCorrectInventoryDeliveryRemainings') Is Not Null
	Drop Procedure INV.spCorrectInventoryDeliveryRemainings
GO
CREATE PROCEDURE [INV].[spCorrectInventoryDeliveryRemainings]
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

--	UPDATE INV.InventoryReceiptItem AS I SET
--		RemainingQuantity=Quantity,
--		RemainingSecondaryQuantity=SecondaryQuantity;
--	WHERE I.IsReturn=0

UPDATE I SET
RemainingQuantity=Quantity-ISNULL(sumQty,0),
RemainingSecondaryQuantity = SecondaryQuantity-ISNULL(sumSecQty,0)
FROM
INV.InventoryDeliveryItem I LEFT JOIN
(SELECT SUM(RI.Quantity) AS sumQty, SUM(RI.SecondaryQuantity) AS sumSecQty, BaseInventoryDeliveryItem
FROM INV.InventoryDeliveryItem AS RI
WHERE RI.IsReturn=1 
group by BaseInventoryDeliveryItem) Sums ON Sums.BaseInventoryDeliveryItem=I.InventoryDeliveryItemID
WHERE I.IsReturn=0

END

