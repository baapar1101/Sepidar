If Object_ID('PAY.vwPayrollConfigurationElement') Is Not Null
	Drop View PAY.vwPayrollConfigurationElement
GO
CREATE VIEW PAY.vwPayrollConfigurationElement
AS
SELECT     PAY.PayrollConfigurationElement.PayrollConfigurationElementId, PAY.PayrollConfigurationElement.ElementRef, 
                      PAY.PayrollConfigurationElement.Coefficient, PAY.PayrollConfigurationElement.Type, PAY.PayrollConfigurationElement.PayrollConfigurationRef, 
                      PAY.Element.Title AS ElementTitle, PAY.Element.Title_En AS ElementTitle_En
FROM         PAY.PayrollConfigurationElement INNER JOIN
                      PAY.Element ON PAY.PayrollConfigurationElement.ElementRef = PAY.Element.ElementId

