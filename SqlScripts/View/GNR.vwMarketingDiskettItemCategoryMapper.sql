IF OBJECT_ID('GNR.vwMarketingDiskettItemCategoryMapper') IS NOT NULL
	DROP VIEW GNR.vwMarketingDiskettItemCategoryMapper
GO
CREATE VIEW GNR.vwMarketingDiskettItemCategoryMapper
AS
	SELECT   
		  M.[MarketingDiskettItemCategoryMapperID]
		, M.[ItemRef]
		, I.[Title] ItemTitle
		, I.[Code] ItemCode
		, I.ItemCategoryRef ItemCategory95Ref
		, C.[Title] ItemCategory95Title 
		, M.[ItemCategory96]
		, M.[Version]
		, M.[Creator]
		, M.[CreationDate]
		, M.[LastModifier]
		, M.[LastModificationDate]
		
	FROM GNR.MarketingDiskettItemCategoryMapper M	
		 LEFT JOIN INV.Item I on I.ItemID = M.ItemRef
		 LEFT JOIN INV.ItemCategory C on C.ItemCategoryID = I.ItemCategoryRef

 


 