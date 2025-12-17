IF object_id(N'AST.fnGetAccumulatedDepreciation', N'FN') IS NOT NULL
	DROP FUNCTION AST.fnGetAccumulatedDepreciation
GO
CREATE FUNCTION AST.fnGetAccumulatedDepreciation(@AssetRef  INT, @Date DATETIME)
RETURNS DECIMAL(19,4) 
BEGIN
    RETURN ISNULL((
		SELECT SUM(cpt.DepreciationValue) 
		FROM AST.CostPartTransaction cpt
		JOIN AST.AssetTransaction at ON CPT.AssetTransactionRef = AT.AssetTransactionID
		WHERE AT.TransactionType = 99 --??
		AND   cpt.EffectiveDate <= @Date
		AND   at.AssetRef = @AssetRef
	), 0)
END
