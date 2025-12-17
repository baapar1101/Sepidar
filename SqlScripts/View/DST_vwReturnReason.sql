IF Object_ID('DST.vwReturnReason') IS NOT NULL
	DROP VIEW DST.vwReturnReason
GO


CREATE VIEW DST.vwReturnReason
AS
SELECT 
       R.ReturnReasonID
      ,R.Title
      ,R.Title_En
      ,R.IsActive
      ,R.Version
      ,R.Creator
      ,R.CreationDate
      ,R.LastModifier
      ,R.LastModificationDate
	  ,CU.Name CreatorName
      ,MU.Name LastModifierName
  FROM DST.ReturnReason R
   INNER JOIN FMk.[User] CU ON R.Creator = CU.UserID
   INNER JOIN FMk.[User] MU ON R.LastModifier = MU.UserID