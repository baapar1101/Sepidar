If Object_ID('PAY.vwPersonnelInitiateElement') Is Not Null
	Drop View PAY.vwPersonnelInitiateElement
GO
CREATE VIEW PAY.vwPersonnelInitiateElement
AS
SELECT     PAY.PersonnelInitiateElement.PersonnelInitiateElementId, PAY.PersonnelInitiateElement.ElementRef, PAY.Element.Title AS ElementTitle, 
                      PAY.Element.Title_En AS ElementTitle_En, PAY.PersonnelInitiateElement.Amount, PAY.PersonnelInitiateElement.PersonnelInitiateRef
FROM         PAY.PersonnelInitiateElement INNER JOIN
                      PAY.Element ON PAY.PersonnelInitiateElement.ElementRef = PAY.Element.ElementId

