If Object_ID('SLS.vwCommission') Is Not Null
	Drop View SLS.vwCommission
GO

CREATE VIEW SLS.vwCommission
AS
SELECT C.CommissionId,
	C.Number,
	C.Title,
	C.Title_En,
	C.FromDate,
	C.ToDate,
	C.CalculationBase,
	C.InvoiceSettlementState,
	C.SaleVolumeCalculationBase,
	C.CalculationType,
	C.[Type],
	C.ItemFilterType,
	C.SaleTypeRef,
	ST.Number SaleTypeNumber,
	ST.Title SaleTypeTitle,
	ST.Title_En SaleTypeTitle_En,
	C.Version,
	C.Creator,
	C.CreationDate,
	C.LastModifier,
	C.LastModificationDate
FROM SLS.Commission C
  LEFT JOIN SLS.SaleType ST
    ON ST.SaleTypeId = C.SaleTypeRef
					  

