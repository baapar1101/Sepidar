--drop view INV.vwInventoryWeighing
If Object_ID('INV.vwInventoryWeighbridgeConfuration') Is Not Null
	Drop View INV.vwInventoryWeighbridgeConfuration


If Object_ID('INV.vwInventoryWeighbridgeConfiguration') Is Not Null
	Drop View INV.vwInventoryWeighbridgeConfiguration
GO
CREATE VIEW INV.vwInventoryWeighbridgeConfiguration
AS
SELECT     WConf.InventoryWeighbridgeConfigurationID, WConf.InventoryWeighbridgeRef, WConf.Model, WConf.Port,
			WConf.UnitRef, U.Title AS UnitTitle, U.Title_En AS UnitTitle_En, WConf.BaudRate, WConf.DataBits, 
			WConf.StopBits, WConf.Parity, WConf.AutoClose, WConf.StabilityCheckTime, WConf.UseIncompleteWeighingInVoucher,
			WConf.Creator, WConf.CreationDate, WConf.LastModifier, WConf.LastModificationDate, WConf.Version 
FROM         INV.InventoryWeighbridgeConfiguration AS WConf 
				LEFT OUTER JOIN INV.InventoryWeighbridge AS WB ON WConf.InventoryWeighbridgeRef = WB.InventoryWeighbridgeID
				INNER JOIN INV.Unit AS U ON WConf.UnitRef = U.UnitID
				
