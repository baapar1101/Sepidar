/****** Object:  View [GNR].[vwTruck]    Script Date: 17/01/1398 12:47:01 È.Ù ******/
IF Object_ID('GNR.vwTruck') IS NOT NULL
	Drop View GNR.vwTruck
GO

CREATE VIEW [GNR].[vwTruck]
AS

SELECT   
 GC.[TruckID],  
 GC.[BrokerPartyRef],    
 IU1.[Title] AS WeightUnitTitle,  
 IU2.[Title] AS VolumeUnitTitle, 
 IU1.Title_En AS WeightUnitTitle_En,
 IU2.Title_En AS VolumeUnitTitle_En,
 GC.[Title],  
 GC.[Title_En],  
 GC.[VehicleNumber],  
 AD.Code AS BrokerPartyCode,  
 GP.[Name] + ' '+GP.[LastName] AS BrokerPartyDriver,  
 GP.[DLTitle]     AS [DriverDLTitle],  
 GP.[DLTitle_En]     AS [DriverDLTitle_En],  
 GC.[DrivingLicenseNumber],  
 GC.[MinimumWeight],  
 GC.[MaximumWeight],  
 GC.[MinimumVolumeCapacity],  
 GC.[MaximumVolumeCapacity],
 GC.IsActive,  
 GC.[Creator],  
 GC.[CreationDate],  
 GC.[LastModifier],  
 GC.[LastModificationDate],  
 GC.[Version]  
From  
 GNR.Truck GC  
LEFT JOIN  
 GNR.vwParty GP  
ON  
 GP.partyId=GC.[BrokerPartyRef]  
LEFT JOIN  
 INV.Unit IU1  
ON  
 IU1.UnitID = CAST((SELECT Top 1 [Value] FROM FMK.Configuration cc Where cc.[Key] = 'WeightUnit') AS INT )
LEFT JOIN  
 INV.Unit IU2  
ON  
 IU2.UnitID=CAST((SELECT Top 1 [Value] FROM FMK.Configuration cc Where cc.[Key] = 'VolumeUnit') AS INT ) 
LEFT JOIN  
 ACC.DL AD  
ON  
 AD.DLId=GP.DLRef