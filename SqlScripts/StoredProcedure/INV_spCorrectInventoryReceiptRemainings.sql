If Object_ID('INV.spCorrectInventoryReceiptRemainings') Is Not Null
	Drop Procedure INV.spCorrectInventoryReceiptRemainings
GO
CREATE PROCEDURE [INV].[spCorrectInventoryReceiptRemainings]
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
INV.InventoryReceiptItem I LEFT JOIN
(SELECT SUM(RI.Quantity) AS sumQty, SUM(RI.SecondaryQuantity) AS sumSecQty, ReturnBase
FROM INV.InventoryReceiptItem AS RI
WHERE RI.IsReturn=1 
group by ReturnBase) Sums ON Sums.ReturnBase=I.InventoryReceiptItemID
WHERE I.IsReturn=0

END

