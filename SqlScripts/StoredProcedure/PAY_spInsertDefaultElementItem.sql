IF OBJECT_ID('PAY.spInsertDefaultElementItem') IS NOT NULL 
	DROP PROCEDURE PAY.spInsertDefaultElementItem
GO
CREATE PROCEDURE PAY.spInsertDefaultElementItem @elementItemId int, @elementId int, @relatedElementRef int
												,@coefficient int,@type int
AS
BEGIN

IF	(EXISTS(SELECT * FROM PAY.Element WHERE ElementId = @elementId)
	AND NOT EXISTS(SELECT * FROM PAY.ElementItem WHERE ElementItemId = @elementItemId)
	AND	NOT EXISTS(SELECT * FROM PAY.ElementItem WHERE ElementRef = @elementId AND RelatedElementRef = @relatedElementRef))
	INSERT INTO PAY.ElementItem (ElementItemId, ElementRef, RelatedElementRef, Coefficient, [Type]) 
			VALUES (@elementItemId, @elementId, @relatedElementRef,@coefficient,@type)
END