IF OBJECT_ID('SCD.vwSchedulingItem') IS NOT NULL
	DROP VIEW SCD.vwSchedulingItem
GO
CREATE VIEW SCD.vwSchedulingItem
AS
SELECT  SchedulingItemId,SchedulingRef,	[DateTime]
FROM SCD.SchedulingItem