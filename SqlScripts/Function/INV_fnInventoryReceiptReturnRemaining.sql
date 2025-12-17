
IF OBJECT_ID('INV.fnInventoryReceiptReturnRemaining') IS NOT NULL
	DROP FUNCTION INV.fnInventoryReceiptReturnRemaining
GO

CREATE FUNCTION INV.fnInventoryReceiptReturnRemaining()
RETURNS TABLE
RETURN
	(SELECT R.InventoryReceiptID, (ISNULL(SUM(RI.ReturnedNetPrice), 0) - ISNULL(SUM(PSItem.SumAmount), 0)) RemainingAmount,
	(ISNULL(SUM(PSItem.SumAmount), 0)) TotalReceivedAmount
	 FROM INV.InventoryReceiptItem RI INNER JOIN  
		  INV.InventoryReceipt R ON RI.InventoryReceiptRef = R.InventoryReceiptID
		LEFT JOIN(SELECT SUM(PSI.Amount) SumAmount, psi.DebitEntityRef, PSI.DebitEntityType
					FROM rpa.PartyAccountSettlementItem PSI  
					INNER JOIN rpa.PartyAccountSettlement PS ON PS.PartyAccountSettlementID = PSI.PartyAccountSettlementRef 
					WHERE  PSI.DebitEntityType = 3 
					GROUP BY psi.DebitEntityRef, PSI.DebitEntityType
					)AS PSItem ON R.InventoryReceiptID = PSItem.DebitEntityRef AND PSItem.DebitEntityType = 3
					WHERE R.IsReturn = 1
					GROUP BY R.InventoryReceiptID)
					
		
GO

GO
