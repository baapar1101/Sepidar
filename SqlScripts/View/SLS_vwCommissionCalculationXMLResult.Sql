IF OBJECT_ID('SLS.vwCommissionCalculationXMLResult') IS NOT NULL
	DROP VIEW SLS.vwCommissionCalculationXMLResult
GO

CREATE VIEW [SLS].[vwCommissionCalculationXMLResult]
AS
	SELECT  ccX.CommissionCalculationXMLResultID
		   ,ccX.CommissionCalculationRef
           ,ccX.Content		  
	FROM      SLS.CommissionCalculationXMLResult ccX
	

GO
