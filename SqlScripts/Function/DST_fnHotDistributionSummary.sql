
IF OBJECT_ID('DST.fnHotDistributionSummary') IS NOT NULL
	DROP FUNCTION [DST].fnHotDistributionSummary
GO


CREATE FUNCTION DST.fnHotDistributionSummary (@HotDistributionId INT)
RETURNS TABLE
AS
	RETURN

	SELECT
		[T].[ItemRef]
	   ,[T].[ItemCode]
	   ,[T].[ItemTitle]
	   ,[T].[ItemTitle_En]
	   ,[T].[TracingRef]
	   ,[T].[TracingTitle]
	   ,[T].[UnitRef]
	   ,[T].[UnitTitle]
	   ,[T].[SecondaryUnitRef]
	   ,[T].[SecondaryUnitTitle]

	   ,ISNULL([InventoryDelivery].[InitialInventoryDeliveryQuantity], 0) AS [InitialInventoryDeliveryQuantity]
	   ,ISNULL([InventoryDelivery].[InventoryDeliveryQuantity], 0) AS [InventoryDeliveryQuantity]
	   ,ISNULL([InvoiceItems].[InvoiceQuantity], 0) AS [InvoiceQuantity]
	   ,SUM([T].[ReturnedInvoiceQuantity]) AS [ReturnedInvoiceQuantity]
	   ,ISNULL([InventoryDeliveryReturn].[InventoryDeliveryReturnQuantity], 0) AS [InventoryDeliveryReturnQuantity]

	   ,ISNULL([InventoryDelivery].[InventoryDeliveryQuantity], 0)
		- ISNULL([InvoiceItems].[InvoiceQuantity], 0)
		- ISNULL([InventoryDeliveryReturn].[InventoryDeliveryReturnQuantity], 0)
		AS [RemainingQuantity]

	   ,ISNULL([InventoryDelivery].[InitialInventoryDeliverySecondaryQuantity], 0) AS [InitialInventoryDeliverySecondaryQuantity]
	   ,ISNULL([InventoryDelivery].[InventoryDeliverySecondaryQuantity], 0) AS [InventoryDeliverySecondaryQuantity]
	   ,ISNULL([InvoiceItems].[InvoiceSecondaryQuantity], 0) AS [InvoiceSecondaryQuantity]
	   ,SUM([T].[ReturnedInvoiceSecondaryQuantity]) AS [ReturnedInvoiceSecondaryQuantity]
	   ,ISNULL([InventoryDeliveryReturn].[InventoryDeliveryReturnSecondaryQuantity], 0) AS [InventoryDeliveryReturnSecondaryQuantity]

	   ,ISNULL([InventoryDelivery].[InventoryDeliverySecondaryQuantity], 0)
		- ISNULL([InvoiceItems].[InvoiceSecondaryQuantity], 0)
		- ISNULL([InventoryDeliveryReturn].[InventoryDeliveryReturnSecondaryQuantity], 0)
		AS [RemainingSecondaryQuantity]

	FROM (SELECT
			[HDI].[ItemRef]
		   ,[HDI].[ItemCode]
		   ,[HDI].[ItemTitle]
		   ,[HDI].[ItemTitle_En]
		   ,[HDI].[TracingRef]
		   ,[HDI].[TracingTitle]
		   ,[HDI].[UnitRef]
		   ,[HDI].[UnitTitle]
		   ,[HDI].[SecondaryUnitRef]
		   ,[HDI].[SecondaryUnitTitle]
		   ,NULL [ReturnedInvoiceItemID]
		   ,0 AS [ReturnedInvoiceQuantity]
		   ,0 AS [ReturnedInvoiceSecondaryQuantity]
		FROM [DST].[vwHotDistributionItem] AS [HDI]
		WHERE [HDI].[HotDistributionRef] = @HotDistributionId

		UNION

		SELECT
			[RII].[ItemRef]
		   ,[RII].[ItemCode]
		   ,[RII].[ItemTitle]
		   ,[RII].[ItemTitle_En]
		   ,[RII].[TracingRef]
		   ,[RII].[TracingTitle]
		   ,[RII].[ItemUnitRef] AS [UnitRef]
		   ,[RII].[UnitTitle]
		   ,[RII].[ItemSecondaryUnitRef] AS [SecondaryUnitRef]
		   ,[U].[Title] AS [SecondaryUnitTitle]
		   ,[RII].[ReturnedInvoiceItemID]
		   ,SUM([RII].[Quantity]) AS [ReturnedInvoiceQuantity]
		   ,SUM([RII].[SecondaryQuantity]) AS [ReturnedInvoiceSecondaryQuantity]
		FROM [DST].[HotDistributionSaleDocument] AS [HDSD]
		JOIN [SLS].[ReturnedInvoice] AS [RI]
			ON [HDSD].[ReturnedInvoiceRef] = [RI].[ReturnedInvoiceId]
		JOIN [SLS].[vwReturnedInvoiceItem] AS [RII]
			ON [RI].[ReturnedInvoiceId] = [RII].[ReturnedInvoiceRef]
		LEFT JOIN [INV].[Unit] AS [U]
			ON [RII].[ItemSecondaryUnitRef] = [U].[UnitID]
		WHERE [HDSD].[HotDistributionRef] = @HotDistributionId
		AND [RII].[ItemType] = 1 /*Product*/
		GROUP BY [RII].[ItemRef]
				,[RII].[TracingRef]
				,[RII].[ItemCode]
				,[RII].[ItemTitle]
				,[RII].[ItemTitle_En]
				,[RII].[TracingTitle]
				,[RII].[ItemUnitRef]
				,[RII].[UnitTitle]
				,[RII].[ItemSecondaryUnitRef]
				,[U].[Title]
				,[RII].[ReturnedInvoiceItemID]) AS [T]
	LEFT JOIN (SELECT
			[II].[ItemRef]
		   ,[II].[TracingRef]
		   ,SUM([II].[Quantity]) AS [InvoiceQuantity]
		   ,SUM([II].[SecondaryQuantity]) AS [InvoiceSecondaryQuantity]
		FROM [DST].[HotDistributionSaleDocument] AS [HDSD]
		JOIN [SLS].[Invoice] AS [I]
			ON [HDSD].[InvoiceRef] = [I].[InvoiceId]
		JOIN [SLS].[InvoiceItem] AS [II]
			ON [I].[InvoiceId] = [II].[InvoiceRef]
		WHERE [HDSD].[HotDistributionRef] = @HotDistributionId
		AND [I].[State] <> 2
		GROUP BY [II].[ItemRef]
				,[II].[TracingRef]) AS InvoiceItems
		ON [T].[ItemRef] = [InvoiceItems].[ItemRef]
			AND (([T].[TracingRef] IS NULL
					AND [InvoiceItems].[TracingRef] IS NULL)
				OR [T].[TracingRef] = [InvoiceItems].[TracingRef])

	LEFT JOIN (SELECT
			[IDI].[ItemRef]
		   ,[IDI].[TracingRef]
		   ,SUM([IDI].[Quantity]) AS [InventoryDeliveryReturnQuantity]
		   ,SUM([IDI].[SecondaryQuantity]) AS [InventoryDeliveryReturnSecondaryQuantity]
		FROM [DST].[HotDistributionInventoryDelivery] AS [HDID]
		JOIN [INV].[InventoryDelivery] AS [ID]
			ON [HDID].[InventoryDeliveryRef] = [ID].[InventoryDeliveryID]
		JOIN [INV].[InventoryDeliveryItem] AS [IDI]
			ON [ID].[InventoryDeliveryID] = [IDI].[InventoryDeliveryRef]
		WHERE [HDID].[HotDistributionRef] = @HotDistributionId
		AND [ID].[IsReturn] = 1
		GROUP BY [IDI].[ItemRef]
				,[IDI].[TracingRef]) AS [InventoryDeliveryReturn]
		ON [InventoryDeliveryReturn].[ItemRef] = [T].[ItemRef]
			AND (([InventoryDeliveryReturn].[TracingRef] IS NULL
					AND [T].[TracingRef] IS NULL)
				OR [InventoryDeliveryReturn].[TracingRef] = [T].[TracingRef])
	LEFT JOIN (SELECT
			[IDI].[ItemRef]
		   ,[IDI].[TracingRef]
		   ,SUM([IDI].[Quantity]) AS [InventoryDeliveryQuantity]
		   ,SUM([IDI].[SecondaryQuantity]) AS [InventoryDeliverySecondaryQuantity]
		   ,SUM([IDI].[Quantity] * [InventoryDeliveryIds].[IsInitialDelivery]) AS [InitialInventoryDeliveryQuantity]
		   ,SUM([IDI].[SecondaryQuantity] * [InventoryDeliveryIds].[IsInitialDelivery]) AS [InitialInventoryDeliverySecondaryQuantity]
		FROM (SELECT
				[HDID].[InventoryDeliveryRef]
			   ,CAST(0 AS BIT) AS [IsInitialDelivery]
			FROM [DST].[HotDistributionInventoryDelivery] AS [HDID]
			WHERE [HDID].[HotDistributionRef] = @HotDistributionId

			UNION

			SELECT
				[HD].[InventoryDeliveryRef]
			   ,CAST(1 AS BIT) AS [IsInitialDelivery]
			FROM [DST].[HotDistribution] AS [HD]
			WHERE [HD].[HotDistributionId] = @HotDistributionId) AS InventoryDeliveryIds
		JOIN [INV].[InventoryDelivery] AS [ID]
			ON [ID].[InventoryDeliveryID] = [InventoryDeliveryIds].[InventoryDeliveryRef]
		JOIN [INV].[InventoryDeliveryItem] AS [IDI]
			ON [ID].[InventoryDeliveryID] = [IDI].[InventoryDeliveryRef]
		WHERE [ID].[IsReturn] = 0
		GROUP BY [IDI].[ItemRef]
				,[IDI].[TracingRef]) [InventoryDelivery]
		ON [InventoryDelivery].[ItemRef] = [T].[ItemRef]
			AND (([InventoryDelivery].[TracingRef] IS NULL
					AND [T].[TracingRef] IS NULL)
				OR [InventoryDelivery].[TracingRef] = [T].[TracingRef])
	GROUP BY [T].[ItemRef]
			,[T].[ItemRef]
			,[T].[ItemCode]
			,[T].[ItemTitle]
			,[T].[ItemTitle_En]
			,[T].[TracingRef]
			,[T].[TracingTitle]
			,[T].[UnitRef]
			,[T].[UnitTitle]
			,[T].[SecondaryUnitRef]
			,[T].[SecondaryUnitTitle]
			,[InvoiceItems].[InvoiceQuantity]
			,[InvoiceItems].[InvoiceSecondaryQuantity]
			,[InventoryDeliveryReturn].[InventoryDeliveryReturnQuantity]
			,[InventoryDeliveryReturn].[InventoryDeliveryReturnSecondaryQuantity]
			,[InventoryDelivery].[InventoryDeliveryQuantity]
			,[InventoryDelivery].[InventoryDeliverySecondaryQuantity]
			,[InventoryDelivery].[InitialInventoryDeliveryQuantity]
			,[InventoryDelivery].[InitialInventoryDeliverySecondaryQuantity]