If Object_ID('INV.vwItemPropertyAmount') Is Not Null
	Drop View INV.vwItemPropertyAmount
GO
CREATE VIEW INV.vwItemPropertyAmount
AS
SELECT IPA.ItemPropertyAmountID,
	   IPA.[ItemRef],          
	   IPA.[PropertyAmount1],  
	   IPA.[PropertyAmount2],  
	   IPA.[PropertyAmount3],  
	   IPA.[PropertyAmount4],  
	   IPA.[PropertyAmount5],  
	   IPA.[PropertyAmount6],  
	   IPA.[PropertyAmount7],  
	   IPA.[PropertyAmount8],  
	   IPA.[PropertyAmount9],  
	   IPA.[PropertyAmount10] 


FROM INV.ItemPropertyAmount IPA

