If Object_ID('GNR.vwClosingOperation') Is Not Null
	Drop View GNR.vwClosingOperation
GO
CREATE VIEW GNR.vwClosingOperation
AS

SELECT ClosingOperationId, ClosingGroup, ItemId, [State], FiscalYearRef, [Version], '' ItemTitle, '' ItemTitle_En, 0 PrerequreidCloseSystem, 0 PrerequreidOpenSystem
FROM GNR.[ClosingOperation]
