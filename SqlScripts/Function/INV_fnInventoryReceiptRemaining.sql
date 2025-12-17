
IF OBJECT_ID('INV.fnInventoryReceiptRemaining') IS NOT NULL
	DROP FUNCTION INV.fnInventoryReceiptRemaining
GO

CREATE FUNCTION INV.fnInventoryReceiptRemaining()
RETURNS TABLE
RETURN
	(SELECT R.InventoryReceiptID, (ISNULL(SUM(RI.NetPrice), 0) - ISNULL(SUM(PSItem.SumAmount), 0)) RemainingAmount,
	(ISNULL(SUM(PSItem.SumAmount), 0)) TotalReceivedAmount
	 FROM INV.InventoryReceiptItem RI INNER JOIN  
		  INV.InventoryReceipt R ON RI.InventoryReceiptRef = R.InventoryReceiptID
		LEFT JOIN(SELECT SUM(PSI.Amount) SumAmount, psi.CreditEntityRef, PSI.CreditEntityType
					FROM rpa.PartyAccountSettlementItem PSI  
					INNER JOIN rpa.PartyAccountSettlement PS ON PS.PartyAccountSettlementID = PSI.PartyAccountSettlementRef 
					WHERE  PSI.CreditEntityType = 28  
					GROUP BY psi.CreditEntityRef, PSI.CreditEntityType
					)AS PSItem ON R.InventoryReceiptID = PSItem.CreditEntityRef AND PSItem.CreditEntityType = 28
					WHERE R.IsReturn = 0
					GROUP BY R.InventoryReceiptID )
					
		
GO
