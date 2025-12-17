IF OBJECT_ID('DST.GetSaleLimitRamainders') IS NOT NULL
	DROP FUNCTION DST.GetSaleLimitRamainders
GO

IF OBJECT_ID('DST.fnGetSaleLimitRamainders') IS NOT NULL
	DROP FUNCTION DST.fnGetSaleLimitRamainders
GO

CREATE FUNCTION DST.fnGetSaleLimitRamainders(@Date DATETIME)
RETURNS TABLE
AS
RETURN 

SELECT
	PartyRef, ItemRef, TracingRef, MIN(Quantity - UsedQuantity) AS RemainderQuantity
FROM
(
	SELECT
		SLIP.PartyRef, 
		SLI.ItemRef, 
		SLI.TracingRef, 
		SLIP.Quantity,
		(
			SELECT ISNULL(SUM(ISNULL(CASE WHEN O.[State] = 2 THEN OI.Quantity ELSE OI.InvoicedQuantity END, 0)),0)
			FROM
				DST.OrderItem OI
				JOIN DST.[Order] O ON OI.OrderRef = O.OrderID
			WHERE
				(O.[State] = 2 OR O.[State] = 4) AND -- 2: approved, 4: dismissed  
				ISNULL(O.BrokerPartyRef, 0) = ISNULL(SLIP.PartyRef, 0) AND
				OI.ItemRef = SLI.ItemRef AND
				ISNULL(OI.TracingRef, 0) = ISNULL(SLI.TracingRef, ISNULL(OI.TracingRef, 0)) AND
				(
					(SL.ControlType = 1 AND O.[Date] = @Date) -- daily
					OR 
					(SL.ControlType = 2 AND O.[Date] <= @Date AND O.[Date] >= SL.[StartDate]) -- periodic
				) -- control type 1: daily, 2: periodic
		)AS UsedQuantity
	FROM 
		DST.SalesLimitItemParty SLIP
		JOIN DST.SalesLimitItem SLI ON SLIP.SalesLimitItemRef=SLI.SalesLimitItemId
		JOIN DST.SalesLimit SL ON SLI.SalesLimitRef=SL.SalesLimitId
	WHERE
		SL.IsActive = 1 AND
		SL.[StartDate]<=@Date AND
		SL.[EndDate]>=@Date
) AllUsedQuantities
GROUP BY
	PartyRef, ItemRef, TracingRef