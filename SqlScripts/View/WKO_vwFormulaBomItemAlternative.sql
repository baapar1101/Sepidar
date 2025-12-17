IF Object_ID('WKO.vwFormulaBomItemAlternative') IS NOT NULL
	Drop View WKO.vwFormulaBomItemAlternative
GO
CREATE VIEW [WKO].[vwFormulaBomItemAlternative]
AS
	SELECT  FBIA.FormulaBomItemAlternativeID,
			FBIA.FormulaBomItemRef,
			FBIA.ItemRef,
			I.Code ItemCode,
			I.Title ItemTitle,
			I.Title_En ItemTitle_En,
			FBIA.AlternativeRatio,
			FBIA.ItemTracingRef,
			T.[Title] AS ItemTracingTitle,
			[I].[TracingCategoryRef] AS [ItemTracingCategoryRef]
	FROM WKO.FormulaBomItemAlternative FBIA
		INNER JOIN INV.Item I ON FBIA.ItemRef = I.ItemID
		LEFT JOIN INV.Tracing AS T ON FBIA.ItemTracingRef = T.TracingID
	
GO