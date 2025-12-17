If Object_ID('DST.vwOrderItemAdditionFactor') Is Not Null
	Drop View DST.vwOrderItemAdditionFactor
GO
CREATE VIEW DST.vwOrderItemAdditionFactor
AS
SELECT 
	OIAF.[OrderItemAdditionFactorID], 
	OIAF.[OrderItemRef], 
	OIAF.[AdditionFactorRef],
	OIAF.[Value],
	OIAF.[ValueInBaseCurrency],
	AF.[Title] AS AdditionFactorTitle,
	AF.[IsEffectiveOnVat],
	AF.[SLRef]

FROM DST.OrderItemAdditionFactor OIAF
--JOIN DST.OrderItem II  ON II.OrderItemID = OIAF.OrderItemRef
JOIN SLS.AdditionFactor AF  ON AF.AdditionFactorID = OIAF.AdditionFactorRef

