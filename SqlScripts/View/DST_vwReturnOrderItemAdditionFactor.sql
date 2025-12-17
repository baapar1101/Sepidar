If Object_ID('DST.vwReturnOrderItemAdditionFactor') Is Not Null
	Drop View DST.vwReturnOrderItemAdditionFactor
GO
CREATE VIEW DST.vwReturnOrderItemAdditionFactor
AS
SELECT 
	ROIAF.[ReturnOrderItemAdditionFactorID], 
	ROIAF.[ReturnOrderItemRef], 
	ROIAF.[AdditionFactorRef],
	ROIAF.[Value],
	ROIAF.[ValueInBaseCurrency],
	AF.[Title] AS AdditionFactorTitle,
	AF.[IsEffectiveOnVat],
	AF.[SLRef]

FROM DST.ReturnOrderItemAdditionFactor ROIAF
--JOIN DST.ReturnOrderItem II  ON II.ReturnOrderItemID = ROIAF.ReturnOrderItemRef
JOIN SLS.AdditionFactor AF  ON AF.AdditionFactorID = ROIAF.AdditionFactorRef

