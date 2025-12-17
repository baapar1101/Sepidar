If Object_ID('PAY.vwElementItem') Is Not Null
	Drop View PAY.vwElementItem
GO
CREATE VIEW PAY.vwElementItem
AS
SELECT EI.ElementItemId, EI.ElementRef, EI.RelatedElementRef, EI.Coefficient, EI.Type
FROM Pay.ElementItem EI 
	JOIN Pay.Element E ON EI.RelatedElementRef = E.ElementId AND E.IsActive = 1





